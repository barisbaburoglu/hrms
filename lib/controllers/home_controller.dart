import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/widgets/no_qr_event_popup.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../api/api_provider.dart';
import '../api/models/event_type_model.dart';
import '../api/models/qr_code_setting_model.dart';
import '../api/models/users_entry_exit_event_model.dart';
import '../api/models/work_entry_exit_event_model.dart';
import '../constants/colors.dart';
import '../widgets/custom_snack_bar.dart';
import '../widgets/qr_view.dart';

class HomeController extends GetxController {
  var currentTime = ''.obs;
  var currentDate = ''.obs;

  final DateFormat timeFormat = DateFormat('hh:mm a', 'tr');
  final DateFormat dateFormat = DateFormat('dd MMMM yyyy', 'tr');

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  RxString result = ''.obs;
  RxBool isProcessing = false.obs;
  RxBool savingEntryExit = false.obs;

  RxString entryTime = ''.obs;
  RxString exitTime = ''.obs;
  RxString workingHours = ''.obs;

  var qrCodeSettings = <QRCodeSetting>[].obs;

  var eventTypes = <EventType>[].obs;

  Rxn<int> selectedEventTypeId = Rxn<int>();

  Rxn<QRCodeSetting> selectedLocation = Rxn<QRCodeSetting>();

  Rx<UsersEntryExitEvent> lastEntryExit = UsersEntryExitEvent().obs;

  @override
  void onInit() {
    super.onInit();

    initEventTypes();

    _updateTime();
    _updateDate();
    getLastEntryExit();
    fetchQrCodeSettings();
  }

  @override
  void onClose() {
    controller?.dispose();
    super.onClose();
  }

  void initEventTypes() {
    eventTypes.add(EventType(id: 1, typeName: "Giriş"));

    eventTypes.add(EventType(id: 2, typeName: "Çıkış"));
  }

  void fetchQrCodeSettings() async {
    try {
      var qrCodeSettingModel =
          await ApiProvider().qrCodeSettingService.fetchQRCodeSettings();
      qrCodeSettings.value = qrCodeSettingModel.qrCodeSettings ?? [];
      update();
    } catch (e) {
      print("Hata: $e");
    }
  }

  void getLastEntryExit() async {
    try {
      var body = {
        "limit": 1,
        "orders": [
          {
            "fieldName": "Id",
            "direction": "ASC",
          }
        ],
        "filters": []
      };
      var lastEntryExitModel = await ApiProvider()
          .usersEntryExitEventService
          .getLastEntryExitEvents(body);

      lastEntryExit.value = lastEntryExitModel.results!.first;

      DateTime parsedEntryDateTime =
          DateTime.parse(lastEntryExit.value.entry!.eventTime.toString());

      entryTime.value =
          "${parsedEntryDateTime.hour.toString().padLeft(2, '0')}:${parsedEntryDateTime.minute.toString().padLeft(2, '0')}";

      DateTime parsedExitDateTime =
          DateTime.parse(lastEntryExit.value.exit!.eventTime.toString());

      exitTime.value =
          "${parsedExitDateTime.hour.toString().padLeft(2, '0')}:${parsedExitDateTime.minute.toString().padLeft(2, '0')}";

      Duration workingDuration =
          parsedExitDateTime.difference(parsedEntryDateTime);

      workingHours.value =
          "${workingDuration.inHours}:${(workingDuration.inMinutes % 60).toString().padLeft(2, '0')}";
    } catch (e) {
      print("Hata: $e");
    }
  }

  Future<void> saveNoQREntryExitEvent(String uniqueKey) async {
    if (selectedEventTypeId.value != null && selectedLocation.value != null) {
      await saveWorkEntryExitEvent(uniqueKey);
    } else {
      Get.showSnackbar(
        CustomGetBar(
          textColor: AppColor.secondaryText,
          message: "Lütfen Tüm Alanları Seçin!",
          duration: const Duration(seconds: 3),
          iconData: Icons.check,
          backgroundColor: AppColor.primaryGreen,
        ),
      );
    }
  }

  Future<void> saveWorkEntryExitEvent(String uniqueKey) async {
    try {
      await ApiProvider()
          .workEntryExitEventService
          .createWorkEntryExitEvent(WorkEntryExitEvent(
            uniqueKey: uniqueKey,
            locationLatitude: 36.8,
            locationLongitude: 37.8,
          ));
      savingEntryExit.value = false;

      Get.showSnackbar(
        CustomGetBar(
          textColor: AppColor.secondaryText,
          message: "İşlem Başarılı!",
          duration: const Duration(seconds: 3),
          iconData: Icons.check,
          backgroundColor: AppColor.primaryGreen,
        ),
      );
    } catch (e) {
      savingEntryExit.value = false;

      Get.showSnackbar(
        CustomGetBar(
          textColor: AppColor.secondaryText,
          message: "Hatalı işlem yöneticiniz ile görüşün!",
          duration: const Duration(seconds: 3),
          iconData: Icons.error,
          backgroundColor: AppColor.primaryRed,
        ),
      );
    }
  }

  void openNoQRPopup(String title) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: NoQrEventPopup(
          title: title,
        ),
      ),
    );
  }

  void clearEventFields() {
    selectedEventTypeId.value = null;
    selectedLocation.value = null;
  }

  void setEventTypeId(int? id) {
    selectedEventTypeId.value = id!;
  }

  void setLocationId(QRCodeSetting? qrCodeSetting) {
    selectedLocation.value = qrCodeSetting!;
  }

  void _updateTime() {
    final DateTime now = DateTime.now();
    final String formattedTime = timeFormat.format(now);
    currentTime.value = formattedTime;
  }

  void _updateDate() {
    final DateTime now = DateTime.now();
    final String formattedDate = dateFormat.format(now);
    currentDate.value = formattedDate;
  }

  void onQRViewCreated(QRViewController qrController) {
    result.value = "";
    controller = qrController;
    controller?.scannedDataStream.listen((scanData) {
      if (isProcessing.value) return;

      result.value = scanData.code ?? '';
      if (result.isNotEmpty) {
        isProcessing.value = true;
        controller?.pauseCamera();
        savingEntryExit.value = true;

        Get.back(result: true);
      }
    });

    controller?.pauseCamera();
    controller?.resumeCamera();
  }

  void onPermissionSet(QRViewController qrController, bool permissionGranted) {
    if (!permissionGranted) {
      Get.snackbar(
        'Permission Denied',
        'No Camera Permission',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void showQrScannerDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.transparent,
        content: SizedBox(
          width: Get.width < 400 ? 250.0 : 400.0,
          height: Get.width < 400 ? 250.0 : 400.0,
          child: QrScannerView(),
        ),
      ),
    ).then((value) async {
      isProcessing.value = false;
      if (result.value.isNotEmpty) {
        await saveWorkEntryExitEvent(result.value);
      }
    });
  }
}

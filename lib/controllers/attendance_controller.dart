import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../api/api_provider.dart';
import '../api/models/work_entry_exit_event_model.dart';
import '../constants/colors.dart';
import '../widgets/custom_snack_bar.dart';
import '../widgets/qr_view.dart';

class AttendanceController extends GetxController {
  var currentTime = ''.obs;
  var currentDate = ''.obs;

  RxInt touchedIndex = RxInt(0);

  final DateFormat timeFormat = DateFormat('hh:mm a', 'tr');
  final DateFormat dateFormat = DateFormat('dd MMMM yyyy', 'tr');

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  RxString result = ''.obs;
  RxBool isProcessing = false.obs;
  RxBool savingEntryExit = false.obs;

  @override
  void onInit() {
    super.onInit();
    _updateTime();
    _updateDate();
  }

  @override
  void onClose() {
    controller?.dispose();
    super.onClose();
  }

  Future<void> saveWorkEntryExitEvent() async {
    try {
      await ApiProvider()
          .workEntryExitEventService
          .createWorkEntryExitEvent(WorkEntryExitEvent(
            uniqueKey: result.value,
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
        await saveWorkEntryExitEvent();
      }
    });
  }
}

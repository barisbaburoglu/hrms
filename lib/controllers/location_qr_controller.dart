import 'dart:math';
import 'package:universal_html/html.dart' as html;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hrms/api/models/event_type_model.dart';
import 'package:hrms/api/models/qr_code_setting_model.dart';
import 'package:hrms/constants/colors.dart';
import 'package:hrms/widgets/edit_form_qrcode_settings.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';

import '../api/api_provider.dart';
import '../api/models/place_google.dart';
import '../api/services/api_service.dart';
import '../widgets/custom_snack_bar.dart';

class LocationQRController extends GetxController {
  RxBool loader = false.obs;

  var selectedLocation = Rxn<LatLng>();
  var circles = <Circle>{}.obs;

  var places = <Place>[].obs;
  var isLoading = false.obs;

  final ApiService apiService = ApiService("");

  RxBool isOutOfLoc = false.obs;

  final qrCodeData = Rxn<String>();

  final ScrollController scrollController = ScrollController();

  TextEditingController searchController = TextEditingController();
  TextEditingController coordinatesController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationRadiusController =
      TextEditingController(text: '0');

  var eventTypes = <EventType>[].obs;

  RxInt eventTypeId = RxInt(1);

  var qrCodeSettings = <QRCodeSetting>[].obs;

  GoogleMapController? mapController;

  @override
  void onInit() {
    super.onInit();

    fetchQrCodeSettings();

    initEventTypes();
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
    } catch (e) {
      print("Hata: $e");
    }
  }

  void deleteQRCodeSetting(QRCodeSetting qrCodeSetting) async {
    try {
      await ApiProvider()
          .qrCodeSettingService
          .deleteQRCodeSetting(qrCodeSetting);

      fetchQrCodeSettings();
    } catch (e) {
      print("Hata: $e");
    }
  }

  Future<void> saveQRCodeSetting({QRCodeSetting? qrCodeSetting}) async {
    try {
      if (qrCodeSetting == null) {
        await ApiProvider().qrCodeSettingService.createQRCodeSetting(
              QRCodeSetting(
                name: nameController.text,
                companyId: 1,
                locationRadius: int.parse(locationRadiusController.text),
                locationLatitude:
                    double.parse(coordinatesController.text.split(",")[0]),
                locationLongitude:
                    double.parse(coordinatesController.text.split(",")[1]),
                eventType: eventTypeId.value,
                uniqueKey: qrCodeData.value,
              ),
            );
      } else {
        await ApiProvider().qrCodeSettingService.updateEmployeeType(
              QRCodeSetting(
                id: qrCodeSetting.id,
                name: nameController.text,
                companyId: 1,
                locationRadius: int.parse(locationRadiusController.text),
                locationLatitude:
                    double.parse(coordinatesController.text.split(",")[0]),
                locationLongitude:
                    double.parse(coordinatesController.text.split(",")[1]),
                eventType: eventTypeId.value,
                uniqueKey: qrCodeData.value,
              ),
            );
      }
      fetchQrCodeSettings();
      loader.value = false;
      Get.back();
    } catch (e) {
      print("Hata: $e");
    }
  }

  void setEventTypeId(int? id) {
    eventTypeId.value = id!;
  }

  void scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void searchPlaces(String input) async {
    isLoading.value = true;
    try {
      places.value = await apiService.fetchPlaces(input);
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void selectPlace(Place place) async {
    try {
      final details = await apiService.fetchPlaceDetails(place.placeId);
      final LatLng newLocation = LatLng(details['lat']!, details['lng']!);
      selectedLocation.value = newLocation;
      searchController.text = place.description;
      places.clear(); // Hide results when a place is selected

      // Update coordinates text field
      updateCoordinates(newLocation);

      // Move the map camera to the selected location
      if (mapController != null) {
        mapController!.animateCamera(
          CameraUpdate.newLatLng(newLocation),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void updateCircle() {
    if (selectedLocation.value == null || locationRadiusController.text.isEmpty)
      return;

    double area = double.parse(locationRadiusController.text);
    double radius = sqrt(area / pi);

    circles.assignAll({
      Circle(
        circleId: const CircleId('selectedCircle'),
        center: selectedLocation.value!,
        radius: radius,
        strokeColor: AppColor.mapPolylineColor,
        fillColor: AppColor.mapPolylineColor.withOpacity(0.1),
        strokeWidth: 2,
      ),
    });
  }

  void generateQRCode() {
    if (selectedLocation.value == null ||
        nameController.text.isEmpty ||
        int.parse(locationRadiusController.text) <= 0) {
      // İstemciye tüm alanların doldurulması gerektiğini bildirin

      Get.showSnackbar(
        CustomGetBar(
          textColor: AppColor.secondaryText,
          message: "Lütfen tüm alanları doldurun ve bir konum seçin",
          duration: const Duration(seconds: 3),
          iconData: Icons.warning,
          backgroundColor: AppColor.primaryOrange,
        ),
      );

      return;
    }

    final data = const Uuid().v1();

    qrCodeData.value = data; // QR kod verisini güncelleyin

    scrollToEnd();
  }

  Future<void> downloadColorfulQRCode() async {
    try {
      final qrValidationImage = await _generateColorfulQrImage(
        data: qrCodeData.value!,
        color: eventTypeId.value == 1
            ? AppColor.primaryGreen
            : AppColor.primaryRed,
        size: 256,
      );

      final byteData =
          await qrValidationImage.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      if (GetPlatform.isWeb) {
        // Web platformu için
        final blob = html.Blob([pngBytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        html.AnchorElement(href: url)
          ..setAttribute("download",
              "${eventTypeId.value == 1 ? "entry-qr" : "exit-qr"}.png")
          ..click();
        html.Url.revokeObjectUrl(url);
      } else {
        // Mobil platform için
        if (await _requestPermission(Permission.storage)) {
          final result = await ImageGallerySaver.saveImage(
            pngBytes,
            quality: 100,
            name: qrCodeData.value,
          );

          if (result['isSuccess']) {
            Get.showSnackbar(
              CustomGetBar(
                textColor: AppColor.secondaryText,
                message: "QR kod başarıyla kaydedildi",
                duration: const Duration(seconds: 3),
                iconData: Icons.download_done,
                backgroundColor: AppColor.primaryOrange,
              ),
            );
          } else {
            throw Exception('Kaydedilemedi');
          }
        }
      }
    } catch (e) {
      Get.showSnackbar(
        CustomGetBar(
          textColor: AppColor.secondaryText,
          message: "QR kod indirilemedi: $e",
          duration: const Duration(seconds: 3),
          iconData: Icons.error,
          backgroundColor: AppColor.primaryOrange,
        ),
      );
    }
  }

  Future<ui.Image> _generateColorfulQrImage({
    required String data,
    required Color color,
    required double size,
  }) async {
    final qrPainter = QrPainter(
      data: data,
      version: QrVersions.auto,
      gapless: false,
      eyeStyle: QrEyeStyle(
        eyeShape: QrEyeShape.square,
        color: color,
      ),
      dataModuleStyle: QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.square,
        color: color,
      ),
    );

    final picData = await qrPainter.toImageData(size);
    final codec = await ui.instantiateImageCodec(picData!.buffer.asUint8List());
    final frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      final result = await permission.request();
      return result == PermissionStatus.granted;
    }
  }

  void onMapTap(LatLng latLng) {
    selectedLocation.value = latLng;
    updateCircle();
    // Update coordinates text field
    updateCoordinates(latLng);
    qrCodeData.value = null;
  }

  void updateCoordinates(LatLng location) {
    coordinatesController.text = '${location.latitude}, ${location.longitude}';
  }

  void setEmployeeFields(QRCodeSetting qrCodeSetting) {
    nameController.text = qrCodeSetting.name ?? '';
    coordinatesController.text =
        '${qrCodeSetting.locationLatitude} , ${qrCodeSetting.locationLongitude}';
    locationRadiusController.text = qrCodeSetting.locationRadius.toString();
    eventTypeId.value = qrCodeSetting.eventType!;
    isOutOfLoc.value = qrCodeSetting.enableOutOfLocation ?? false;
    qrCodeData.value = qrCodeSetting.uniqueKey;
    selectedLocation.value = LatLng(
        qrCodeSetting.locationLatitude!, qrCodeSetting.locationLongitude!);
    updateCircle();
  }

  void clearEmployeeFields() {
    nameController.clear();
    coordinatesController.clear();
    locationRadiusController.clear();
    eventTypeId.value = 1;
    isOutOfLoc.value = false;
  }

  void openEditPopup(String title, QRCodeSetting? qrCodeSetting) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          // Ekran genişliği kontrolü
          double screenWidth = constraints.maxWidth;

          return EditFormQRCodeSetting(
            isWeb: screenWidth > 980,
            title: title,
            qrCodeSetting: qrCodeSetting,
          );
        }),
      ),
    );
  }
}

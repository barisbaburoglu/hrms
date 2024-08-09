import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hrms/constants/colors.dart';

import '../api/models/place_google.dart';
import '../api/services/api_service.dart';
import '../widgets/custom_snack_bar.dart';

class LocationQRController extends GetxController {
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
  TextEditingController areaController = TextEditingController(text: '0');

  GoogleMapController? mapController;

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
    if (selectedLocation.value == null || areaController.text.isEmpty) return;

    double area = double.parse(areaController.text);
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
        int.parse(areaController.text) <= 0) {
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

    final data = 'Konum Adı: ${nameController.text}\n'
        'Konum m²: ${areaController.text}\n'
        'Koordinatlar: ${selectedLocation.value!.latitude}, ${selectedLocation.value!.longitude}';

    qrCodeData.value = data; // QR kod verisini güncelleyin

    scrollToEnd();
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
}

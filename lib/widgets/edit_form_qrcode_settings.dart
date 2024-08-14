import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hrms/controllers/location_qr_controller.dart';
import 'package:hrms/widgets/base_button.dart';
import 'package:hrms/widgets/base_input.dart';
import 'package:hrms/widgets/qr_code_colorful.dart';

import '../api/models/qr_code_setting_model.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';

class EditFormQRCodeSetting extends StatelessWidget {
  final String title;
  final QRCodeSetting? qrCodeSetting;
  final LocationQRController controller = Get.find<LocationQRController>();

  EditFormQRCodeSetting({
    super.key,
    required this.title,
    this.qrCodeSetting,
  });

  @override
  Widget build(BuildContext context) {
    if (qrCodeSetting != null) {
      controller.setEmployeeFields(qrCodeSetting!);
    } else {
      controller.clearEmployeeFields();
    }

    return Stack(
      children: [
        Card(
          color: AppColor.cardBackgroundColor,
          shadowColor: AppColor.cardShadowColor,
          margin: const EdgeInsets.all(AppDimension.kSpacing),
          child: Padding(
            padding: const EdgeInsets.all(AppDimension.kSpacing),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BaseButton(
                          width: 200,
                          label: "Kaydet ve QR Oluştur",
                          onPressed: () {
                            controller.loader.value = true;
                            controller.generateQRCode();
                            controller.saveQRCodeSetting(
                                qrCodeSetting: qrCodeSetting);
                          },
                          icon: const Icon(
                            Icons.qr_code,
                            color: AppColor.secondaryText,
                          ),
                        ),
                        SizedBox(
                          width: AppDimension.kSpacing,
                        ),
                        BaseButton(
                          width: 125,
                          backgroundColor: AppColor.primaryRed,
                          label: "Kapat",
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: AppColor.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(AppDimension.kSpacing),
                  child: Divider(
                    height: 1,
                    color: AppColor.primaryAppColor.withOpacity(0.25),
                  ),
                ),
                Expanded(
                  child: kIsWeb ? webLayout(context) : mobileLayout(context),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: controller.loader.value,
          child: SizedBox.expand(
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget webLayout(BuildContext context) {
    return Row(
      children: [
        // Left side: Google Map
        Expanded(
          flex: 1,
          child: Card(
            color: AppColor.cardBackgroundColor,
            shadowColor: AppColor.cardShadowColor,
            margin: const EdgeInsets.all(AppDimension.kSpacing),
            child: Padding(
              padding: const EdgeInsets.all(AppDimension.kSpacing),
              child: Obx(() => GoogleMap(
                    onMapCreated: controller.onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: controller.selectedLocation.value ??
                          const LatLng(39.914450395953565, 32.84726686473151),
                      zoom: 18,
                    ),
                    onTap: controller.onMapTap,
                    markers: controller.selectedLocation.value == null
                        ? {}
                        : {
                            Marker(
                              markerId: const MarkerId('selectedLocation'),
                              position: controller.selectedLocation.value!,
                            ),
                          },
                    circles: controller.circles.toSet(),
                  )),
            ),
          ),
        ),
        // Right side: Form and buttons
        Expanded(
          flex: 1,
          child: Card(
            color: AppColor.cardBackgroundColor,
            shadowColor: AppColor.cardShadowColor,
            margin: const EdgeInsets.all(AppDimension.kSpacing),
            child: Padding(
              padding: const EdgeInsets.all(AppDimension.kSpacing),
              child: SingleChildScrollView(
                controller: controller.scrollController,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: AppDimension.kSpacing,
                    spacing: AppDimension.kSpacing,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: BaseInput(
                          isLabel: true,
                          errorRequired: false,
                          label: "Konum Ara",
                          controller: controller.searchController,
                          margin: EdgeInsets.zero,
                          textInputType: TextInputType.text,
                          inputFormatters: const [],
                          onChanged: (value) {
                            controller.searchPlaces(value);
                          },
                        ),
                      ),
                      Obx(() => controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : Column(
                              children: controller.places
                                  .map((place) => ListTile(
                                        title: Text(place.description),
                                        onTap: () {
                                          controller.selectPlace(place);
                                        },
                                      ))
                                  .toList(),
                            )),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: BaseInput(
                          isLabel: true,
                          label: "Konum Adı *",
                          controller: controller.nameController,
                          margin: EdgeInsets.zero,
                          textInputType: TextInputType.text,
                          inputFormatters: const [],
                          onChanged: (p0) async {},
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: BaseInput(
                          isLabel: true,
                          label: "Alan m² *",
                          controller: controller.locationRadiusController,
                          margin: EdgeInsets.zero,
                          textInputType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (value) {
                            if (controller.selectedLocation.value != null) {
                              controller.updateCircle();
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: BaseInput(
                          readOnly: true,
                          errorRequired: false,
                          isLabel: true,
                          label: "Kordinatlar",
                          controller: controller.coordinatesController,
                          margin: EdgeInsets.zero,
                          textInputType: TextInputType.text,
                          inputFormatters: const [],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Konum Dışı Okutma",
                          ),
                          Obx(
                            () => Checkbox(
                              value: controller.isOutOfLoc.value,
                              checkColor: Colors.green,
                              onChanged: (bool? value) {
                                controller.isOutOfLoc.value = value ?? false;
                              },
                            ),
                          ),
                        ],
                      ),
                      Obx(() => SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: _buildQRTypeDropdown())),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => ColorfulQrCode(
                              data: controller.qrCodeData.value,
                              eventTypeId: controller.eventTypeId.value,
                            ),
                          ),
                          const SizedBox(
                            height: AppDimension.kSpacing,
                          ),
                          Obx(
                            () => Visibility(
                              visible: controller.qrCodeData.value != null,
                              child: BaseButton(
                                width: 250,
                                backgroundColor: AppColor.primaryGreen,
                                label: "QR Kod İndir",
                                onPressed: controller.downloadColorfulQRCode,
                                icon: const Icon(
                                  Icons.download,
                                  color: AppColor.secondaryText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget mobileLayout(BuildContext context) {
    return Column(
      children: [
        // Card widget'ını en üste koyuyoruz
        Card(
          color: AppColor.cardBackgroundColor,
          margin: const EdgeInsets.all(AppDimension.kSpacing),
          child: SizedBox(
            height: 250,
            child: Obx(() => GoogleMap(
                  onMapCreated: controller.onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: controller.selectedLocation.value ??
                        const LatLng(39.914450395953565, 32.84726686473151),
                    zoom: 15,
                  ),
                  onTap: controller.onMapTap,
                  markers: controller.selectedLocation.value == null
                      ? {}
                      : {
                          Marker(
                            markerId: const MarkerId('selectedLocation'),
                            position: controller.selectedLocation.value!,
                          ),
                        },
                  circles: controller.circles.toSet(),
                )),
          ),
        ),
        // SingleChildScrollView widget'ı altında diğer içerikler
        Flexible(
          child: SingleChildScrollView(
            controller: controller.scrollController,
            child: Padding(
              padding: const EdgeInsets.all(AppDimension.kSpacing),
              child: Wrap(
                alignment: WrapAlignment.center,
                runSpacing: AppDimension.kSpacing,
                spacing: AppDimension.kSpacing,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: BaseInput(
                      isLabel: true,
                      errorRequired: false,
                      label: "Konum Ara",
                      controller: controller.searchController,
                      margin: EdgeInsets.zero,
                      textInputType: TextInputType.text,
                      inputFormatters: const [],
                      onChanged: (value) {
                        controller.searchPlaces(value);
                      },
                    ),
                  ),
                  Obx(() => controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : Column(
                          children: controller.places
                              .map((place) => ListTile(
                                    title: Text(place.description),
                                    onTap: () {
                                      controller.selectPlace(place);
                                    },
                                  ))
                              .toList(),
                        )),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: BaseInput(
                      isLabel: true,
                      label: "Konum Adı *",
                      controller: controller.nameController,
                      margin: EdgeInsets.zero,
                      textInputType: TextInputType.text,
                      inputFormatters: const [],
                      onChanged: (p0) async {},
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: BaseInput(
                      isLabel: true,
                      label: "Alan m² *",
                      controller: controller.locationRadiusController,
                      margin: EdgeInsets.zero,
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        if (controller.selectedLocation.value != null) {
                          controller.updateCircle();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: BaseInput(
                      readOnly: true,
                      errorRequired: false,
                      isLabel: true,
                      label: "Kordinatlar",
                      controller: controller.coordinatesController,
                      margin: EdgeInsets.zero,
                      textInputType: TextInputType.text,
                      inputFormatters: const [],
                    ),
                  ),
                  Obx(() => SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: _buildQRTypeDropdown())),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Konum Dışı Okutma",
                      ),
                      Obx(
                        () => Checkbox(
                          value: controller.isOutOfLoc.value,
                          checkColor: Colors.green,
                          onChanged: (bool? value) {
                            controller.isOutOfLoc.value = value ?? false;
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BaseButton(
                        width: 250,
                        label: "Kaydet ve QR Oluştur",
                        onPressed: () {
                          controller.generateQRCode();
                          controller.saveQRCodeSetting(
                              qrCodeSetting: qrCodeSetting);
                        },
                        icon: const Icon(
                          Icons.qr_code,
                          color: AppColor.secondaryText,
                        ),
                      ),
                      const SizedBox(
                        height: AppDimension.kSpacing,
                      ),
                      Obx(() => ColorfulQrCode(
                            data: controller.qrCodeData.value,
                            eventTypeId: 1,
                          )),
                      const SizedBox(
                        height: AppDimension.kSpacing,
                      ),
                      Obx(
                        () => Visibility(
                          visible: controller.qrCodeData.value != null,
                          child: BaseButton(
                            width: 250,
                            backgroundColor: AppColor.primaryGreen,
                            label: "QR Kod İndir",
                            onPressed: () {},
                            icon: const Icon(
                              Icons.download,
                              color: AppColor.secondaryText,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: AppDimension.kSpacing,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQRTypeDropdown() {
    // Sample data for companies; replace with actual data
    final eventTypes = controller.eventTypes;

    return DropdownButtonFormField<int>(
      decoration: const InputDecoration(
        labelText: 'QR Türü',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.primaryGrey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.primaryAppColor,
          ),
        ),
      ),
      value: controller.eventTypeId.value,
      items: eventTypes.map((eventType) {
        return DropdownMenuItem<int>(
          value: eventType.id,
          child: Text(
            eventType.typeName,
            style: const TextStyle(
              fontSize: 12,
              color: AppColor.primaryText,
              fontWeight: FontWeight.normal,
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        controller.setEventTypeId(value);
      },
    );
  }
}

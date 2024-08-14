import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hrms/widgets/page_title.dart';
import 'package:sidebarx/sidebarx.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../controllers/location_qr_controller.dart';
import '../widgets/base_button.dart';
import '../widgets/base_input.dart';
import '../widgets/qr_code_colorful.dart';
import '../widgets/qr_code_display.dart';
import 'master_scaffold.dart';

class LocationQRPage extends StatelessWidget {
  final LocationQRController controller = Get.put(LocationQRController());
  final SidebarXController sidebarController =
      SidebarXController(selectedIndex: 5, extended: true);

  LocationQRPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MasterScaffold(
      sidebarController: sidebarController,
      body: Column(
        children: [
          const SizedBox(
            width: double.infinity,
            child: PageTitleWidget(title: "Konum ve QR Oluşturma"),
          ),
          Expanded(
            child: kIsWeb ? webLayout(context) : mobileLayout(context),
          ),
        ],
      ),
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
              child: SizedBox(
                height: MediaQuery.of(Get.context!).size.height - 250,
                child: Obx(() => GoogleMap(
                      onMapCreated: controller.onMapCreated,
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(39.914450395953565, 32.84726686473151),
                        zoom: 5.5,
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
              child: SizedBox(
                height: MediaQuery.of(Get.context!).size.height - 250,
                child: SingleChildScrollView(
                  controller: controller.scrollController,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: AppDimension.kSpacing * 2,
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
                          BaseButton(
                            width: 250,
                            label: "Kaydet ve QR Oluştur",
                            onPressed: () => controller.generateQRCode(),
                            icon: const Icon(
                              Icons.qr_code,
                              color: AppColor.secondaryText,
                            ),
                          ),
                          const SizedBox(
                            height: AppDimension.kSpacing,
                          ),
                          Obx(
                            () => ColorfulQrCode(
                              data: controller.qrCodeData.value ?? "",
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
                                onPressed: () {},
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
            child: Obx(
              () => GoogleMap(
                onMapCreated: controller.onMapCreated,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(39.914450395953565, 32.84726686473151),
                  zoom: 5,
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
              ),
            ),
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
                        onPressed: () => controller.generateQRCode(),
                        icon: const Icon(
                          Icons.qr_code,
                          color: AppColor.secondaryText,
                        ),
                      ),
                      const SizedBox(
                        height: AppDimension.kSpacing,
                      ),
                      Obx(() =>
                          QRCodeDisplay(data: controller.qrCodeData.value)),
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
      value: controller.eventTypeId?.value,
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

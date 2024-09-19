import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/api/models/qr_code_setting_model.dart';

import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../controllers/home_controller.dart';
import 'base_button.dart';
import 'custom_snack_bar.dart';

class NoQrEventPopup extends StatelessWidget {
  final String title;
  final HomeController controller = Get.put(HomeController());

  NoQrEventPopup({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    controller.clearEventFields();
    double screenWidth = MediaQuery.of(Get.context!).size.width;
    double inputWidth = screenWidth > 1280 ? 310 : double.infinity;

    return SizedBox(
      width: screenWidth > 1280 ? 740 : double.infinity,
      height: 500,
      child: Card(
        color: AppColor.cardBackgroundColor,
        shadowColor: AppColor.cardShadowColor,
        margin: const EdgeInsets.all(AppDimension.kSpacing),
        child: Padding(
          padding: const EdgeInsets.all(AppDimension.kSpacing),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppDimension.kSpacing),
                    child: Divider(
                      height: 1,
                      color: AppColor.primaryAppColor.withOpacity(0.25),
                    ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: AppDimension.kSpacing,
                    runSpacing: AppDimension.kSpacing,
                    children: [
                      SizedBox(
                        width: inputWidth,
                        height: 60,
                        child: _buildEventTypeDropdown(),
                      ),
                      SizedBox(
                        width: inputWidth,
                        height: 60,
                        child: _buildLocationDropdown(),
                      ),
                    ],
                  ),
                ],
              ),
              Wrap(
                alignment: WrapAlignment.center,
                runSpacing: AppDimension.kSpacing,
                spacing: AppDimension.kSpacing,
                children: [
                  BaseButton(
                    width: screenWidth < 360 ? double.infinity : 125,
                    backgroundColor: AppColor.primaryRed,
                    label: "Vazgeç",
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: AppColor.secondaryText,
                    ),
                  ),
                  BaseButton(
                    width: screenWidth < 360 ? double.infinity : 125,
                    label: "Gönder",
                    onPressed: () async {
                      if (controller.selectedEventTypeId.value != null &&
                          controller.selectedLocation.value != null) {
                        await controller.saveWorkEntryExitEvent(
                            controller.selectedLocation.value!.uniqueKey!);
                      } else {
                        Get.showSnackbar(
                          CustomGetBar(
                            textColor: AppColor.secondaryText,
                            message: "Lütfen Tüm Alanları Seçin!",
                            duration: const Duration(seconds: 3),
                            iconData: Icons.check,
                            backgroundColor: AppColor.primaryOrange,
                          ),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.save,
                      color: AppColor.secondaryText,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventTypeDropdown() {
    final eventTypes = controller.eventTypes;

    return DropdownButtonFormField<int>(
      decoration: const InputDecoration(
        labelText: "Hareket Türü",
        labelStyle: TextStyle(fontSize: 12),
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
      value: controller.selectedEventTypeId.value,
      items: eventTypes.isNotEmpty
          ? eventTypes.map((eventType) {
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
            }).toList()
          : [],
      onChanged: (value) {
        controller.setEventTypeId(value);
      },
    );
  }

  Widget _buildLocationDropdown() {
    final locations = controller.qrCodeSettings;

    return DropdownButtonFormField<QRCodeSetting>(
      decoration: const InputDecoration(
        labelText: "Konum",
        labelStyle: TextStyle(fontSize: 12),
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
      value: controller.selectedLocation.value,
      items: locations.isNotEmpty
          ? locations.map((location) {
              return DropdownMenuItem<QRCodeSetting>(
                value: location,
                child: Text(
                  location.name ?? "",
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColor.primaryText,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              );
            }).toList()
          : [],
      onChanged: (value) {
        controller.setLocationId(value);
      },
    );
  }
}

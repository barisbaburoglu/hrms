import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/models/notification_model.dart' as notif;
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../controllers/notification_controller.dart';
import 'base_button.dart';
import 'base_input.dart';

class EditFormNotification extends StatelessWidget {
  final String title;
  final notif.Notification? notification;
  final NotificationController controller = Get.find<NotificationController>();

  EditFormNotification({
    super.key,
    required this.title,
    this.notification,
  });

  @override
  Widget build(BuildContext context) {
    double inputWidth = kIsWeb ? 310 : double.infinity;
    double screenWidth = MediaQuery.of(Get.context!).size.width;
    double screenHeight = MediaQuery.of(Get.context!).size.height;

    if (notification != null) {
      controller.setNotificationFields(notification!);
    } else {
      controller.clearNotificationFields();
    }

    return SizedBox(
      width: kIsWeb ? 740 : double.infinity,
      height: screenHeight,
      child: Card(
        color: AppColor.cardBackgroundColor,
        shadowColor: AppColor.cardShadowColor,
        margin: const EdgeInsets.all(AppDimension.kSpacing),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
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
                  SizedBox(
                    height: screenHeight * .6,
                    child: SingleChildScrollView(
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        spacing: AppDimension.kSpacing,
                        runSpacing: AppDimension.kSpacing / 2,
                        children: [
                          Obx(() => SizedBox(
                              width: inputWidth,
                              height: 50,
                              child: _buildDepartmentDropdown())),
                          SizedBox(
                            width: inputWidth,
                            height: 50,
                            child: BaseInput(
                              controller: controller.titleController,
                              label: "Bildirim Başlığı",
                              isLabel: true,
                              errorRequired: false,
                              margin: EdgeInsets.zero,
                              textInputType: TextInputType.text,
                              inputFormatters: const [],
                              onChanged: (value) {},
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 250,
                            child: BaseInput(
                              controller: controller.bodyController,
                              label: "Bildirim Metni",
                              isLabel: true,
                              maxLines: 10,
                              minLines: 10,
                              errorRequired: false,
                              margin: EdgeInsets.zero,
                              textInputType: TextInputType.text,
                              inputFormatters: const [],
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                    ),
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
                    label: "Kaydet",
                    onPressed: () {
                      controller.saveNotification(notification: notification);
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

  Widget _buildDepartmentDropdown() {
    // Sample data for departments; replace with actual data
    final departments = controller.departments;

    return DropdownButtonFormField<int>(
      decoration: const InputDecoration(
        labelText: "Bildirim Grubu",
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
      value: controller.departmentId.value,
      items: departments.map((department) {
        return DropdownMenuItem<int>(
          value: department.id,
          child: Text(
            department.name ?? "",
            style: const TextStyle(
              fontSize: 12,
              color: AppColor.primaryText,
              fontWeight: FontWeight.normal,
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        controller.setDepartmentId(value);
      },
    );
  }
}

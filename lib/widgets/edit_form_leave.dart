import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../api/models/leave_model.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../controllers/leave_controller.dart';
import 'base_button.dart';
import 'base_input.dart';

class EditFormLeave extends StatelessWidget {
  final String title;
  final Leave? leave;
  final LeaveController controller = Get.put(LeaveController());

  EditFormLeave({
    super.key,
    required this.title,
    this.leave,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(Get.context!).size.width;
    double inputWidth = screenWidth > 1280 ? 310 : double.infinity;

    if (leave != null) {
      controller.setLeaveFields(leave!);
    } else {
      controller.clearLeaveFields();
    }

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
                        height: 40,
                        child: _buildLeaveTypeDropdown(),
                      ),
                      SizedBox(
                          width: inputWidth,
                          height: 40,
                          child: _buildStartDatePicker()),
                      SizedBox(
                          width: inputWidth,
                          height: 40,
                          child: _buildEndDatePicker()),
                      SizedBox(
                        width: inputWidth,
                        height: 40,
                        child: BaseInput(
                          isLabel: true,
                          errorRequired: false,
                          label: "Sebep / Açıklama Giriniz",
                          controller: controller.leaveReasonController,
                          margin: EdgeInsets.zero,
                          textInputType: TextInputType.text,
                          inputFormatters: const [],
                          onChanged: (value) {},
                        ),
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
                    onPressed: () {
                      controller.saveLeave(leave: leave);
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

  Widget _buildLeaveTypeDropdown() {
    // List of LeaveTypes for the dropdown
    final leaveTypes = LeaveType.values;

    return DropdownButtonFormField<LeaveType>(
      decoration: const InputDecoration(
        labelText: "İzin Türü",
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
      value: controller.selectedLeaveType.value, // Default selected LeaveType
      items: leaveTypes.map((leaveType) {
        return DropdownMenuItem<LeaveType>(
          value: leaveType,
          child: Text(
            controller.leaveTypeNames[leaveType] ?? "",
            style: const TextStyle(
              fontSize: 12,
              color: AppColor.primaryText,
              fontWeight: FontWeight.normal,
            ),
          ),
        );
      }).toList(),
      onChanged: (LeaveType? value) {
        if (value != null) {
          controller.setSelectedLeaveType(value); // Handle change
        }
      },
    );
  }

  Widget _buildStartDatePicker() {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: Get.context!,
          initialDate: controller.startDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (pickedDate != null) {
          controller.setStartDate(pickedDate);
          // `TextEditingController`'ı güncellemiyoruz çünkü widget yeniden oluşturulduğunda tarih görünür olacak.
          controller.update(); // GetX'de durumu güncellemek için.
        }
      },
      child: AbsorbPointer(
        child: GetBuilder<LeaveController>(
          builder: (_) {
            return BaseInput(
              label: "İzin Başlama Tarihi",
              controller: TextEditingController(
                text: controller.startDate != null
                    ? DateFormat('dd/MM/yyyy').format(controller.startDate!)
                    : '',
              ),
              isLabel: true,
              errorRequired: false,
              margin: EdgeInsets.zero,
              textInputType: TextInputType.text,
              inputFormatters: const [],
              onChanged: (value) {
                if (value.isNotEmpty) {
                  controller
                      .setStartDate(DateFormat('dd/MM/yyyy').parse(value));
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildEndDatePicker() {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: Get.context!,
          initialDate: controller.endDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (pickedDate != null) {
          controller.setEndDate(pickedDate);
          // `TextEditingController`'ı güncellemiyoruz çünkü widget yeniden oluşturulduğunda tarih görünür olacak.
          controller.update(); // GetX'de durumu güncellemek için.
        }
      },
      child: AbsorbPointer(
        child: GetBuilder<LeaveController>(
          builder: (_) {
            return BaseInput(
              label: "İzin Bitiş Tarihi",
              controller: TextEditingController(
                text: controller.endDate != null
                    ? DateFormat('dd/MM/yyyy').format(controller.endDate!)
                    : '',
              ),
              isLabel: true,
              errorRequired: false,
              margin: EdgeInsets.zero,
              textInputType: TextInputType.text,
              inputFormatters: const [],
              onChanged: (value) {
                if (value.isNotEmpty) {
                  controller.setEndDate(DateFormat('dd/MM/yyyy').parse(value));
                }
              },
            );
          },
        ),
      ),
    );
  }
}

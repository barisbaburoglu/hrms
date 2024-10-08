import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/api/models/qr_code_setting_model.dart';
import 'package:hrms/api/models/work_entry_exit_event_exception_model.dart';
import 'package:intl/intl.dart';

import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../controllers/request_controller.dart';
import 'base_button.dart';
import 'base_input.dart';

class EditFormEventRequest extends StatelessWidget {
  final String title;
  final WorkEntryExitEventException? workEntryExitEventException;
  final RequestController controller = Get.put(RequestController());

  EditFormEventRequest({
    super.key,
    required this.title,
    this.workEntryExitEventException,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(Get.context!).size.width;
    double inputWidth = screenWidth > 1280 ? 310 : double.infinity;

    if (workEntryExitEventException != null) {
      controller.setEventFields(workEntryExitEventException!);
    } else {
      controller.clearEventFields();
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
                    alignment: WrapAlignment.center,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppDimension.kSpacing / 2),
                        child: SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: BaseInput(
                            minLines: 1,
                            maxLines: null,
                            isLabel: true,
                            errorRequired: false,
                            label: "Sebep / Açıklama",
                            controller: controller.leaveReasonController,
                            margin: EdgeInsets.zero,
                            textInputType: TextInputType.text,
                            inputFormatters: const [],
                            onChanged: (value) {},
                          ),
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
                      controller.saveEvent(
                          eventException: workEntryExitEventException);
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
      value: controller.selectedLocation.value, // Default selected LeaveType
      items: locations.map((location) {
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
      }).toList(),
      onChanged: (QRCodeSetting? value) {
        if (value != null) {
          controller.setLocationId(value); // Handle change
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
        child: GetBuilder<RequestController>(
          builder: (_) {
            return BaseInput(
              label: "Tarih",
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
}

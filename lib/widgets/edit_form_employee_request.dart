import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/api/models/qr_code_setting_model.dart';
import 'package:intl/intl.dart';

import '../api/models/employee_request_model.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../controllers/request_controller.dart';
import 'base_button.dart';
import 'base_input.dart';

class EditFormEmployeeRequest extends StatelessWidget {
  final String title;
  final EmployeeRequest? employeeRequest;
  final RequestController controller = Get.put(RequestController());

  EditFormEmployeeRequest({
    super.key,
    required this.title,
    this.employeeRequest,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(Get.context!).size.width;
    double inputWidth = screenWidth > 1280 ? 310 : double.infinity;

    if (employeeRequest != null) {
      controller.setEmployeeRequestFields(employeeRequest!);
    } else {
      controller.clearEmployeeRequestFields();
    }

    return SizedBox(
      width: inputWidth,
      height: 500,
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
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: AppDimension.kSpacing,
                    runSpacing: AppDimension.kSpacing,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: BaseInput(
                          isLabel: true,
                          errorRequired: false,
                          label: "Konu",
                          controller: controller.subjectController,
                          margin: EdgeInsets.zero,
                          textInputType: TextInputType.text,
                          inputFormatters: const [],
                          onChanged: (value) {},
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: BaseInput(
                          minLines: 1,
                          maxLines: null,
                          isLabel: true,
                          errorRequired: false,
                          label: "Detay",
                          controller: controller.detailController,
                          margin: EdgeInsets.zero,
                          textInputType: TextInputType.multiline,
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
                      controller.saveEmployeeRequest(
                          employeeRequest: employeeRequest);
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

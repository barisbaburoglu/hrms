import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/api/models/employee_type_model.dart';
import 'package:hrms/controllers/employee_type_controller.dart';
import 'package:hrms/widgets/base_button.dart';
import 'package:hrms/widgets/base_input.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';

class EditFormEmployeeType extends StatelessWidget {
  final String title;
  final EmployeeType? employeeType;
  final EmployeeTypeController controller = Get.put(EmployeeTypeController());

  EditFormEmployeeType({
    super.key,
    required this.title,
    this.employeeType,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(Get.context!).size.width;
    double inputWidth = screenWidth > 360 ? 310 : double.infinity;
    double width = screenWidth < 1280 ? double.infinity : 740;

    if (employeeType != null) {
      controller.setEmployeeTypeFields(employeeType!);
    } else {
      controller.clearEmployeeTypeFields();
    }

    return SizedBox(
      width: width,
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
                    alignment: WrapAlignment.start,
                    spacing: AppDimension.kSpacing,
                    runSpacing: AppDimension.kSpacing,
                    children: [
                      SizedBox(
                        width: inputWidth,
                        height: 40,
                        child: BaseInput(
                          isLabel: true,
                          errorRequired: false,
                          label: "Tür Adı",
                          controller: controller.nameController,
                          margin: EdgeInsets.zero,
                          textInputType: TextInputType.text,
                          inputFormatters: const [],
                          onChanged: (value) {},
                        ),
                      ),
                      SizedBox(
                        width: inputWidth,
                        height: 40,
                        child: BaseInput(
                          label: "Açıklama",
                          isLabel: true,
                          errorRequired: false,
                          controller: controller.descriptionController,
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
                    label: "Kaydet",
                    onPressed: () {
                      controller.saveEmployeeType(employeType: employeeType);
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
}

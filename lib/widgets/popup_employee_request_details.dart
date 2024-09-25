import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../api/models/employee_request_model.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../controllers/request_controller.dart';
import 'base_button.dart';
import 'base_input.dart';

class PopupEmployeeRequestDetails extends StatelessWidget {
  final String title;
  final EmployeeRequest? employeeRequest;
  final RequestController controller = Get.put(RequestController());

  PopupEmployeeRequestDetails({
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
                        width: double.infinity,
                        height: 40,
                        child: BaseInput(
                          readOnly: true,
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
                        height: 40,
                        child: BaseInput(
                          readOnly: true,
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
                      if (employeeRequest != null)
                        SizedBox(
                          width: inputWidth,
                          height: 40,
                          child: BaseInput(
                            readOnly: true,
                            isLabel: true,
                            errorRequired: false,
                            label: "Tarih",
                            controller: TextEditingController(
                              text: DateFormat('yyyy.MM.dd HH:mm')
                                  .format(DateTime.parse(
                                      employeeRequest!.createdAt!))
                                  .toString(),
                            ),
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
              BaseButton(
                backgroundColor: AppColor.primaryOrange,
                width: screenWidth < 360 ? double.infinity : 125,
                label: "Sil",
                onPressed: () {
                  controller.deleteEmployeeRequest(employeeRequest!.id!);
                },
                icon: const Icon(
                  Icons.delete,
                  color: AppColor.secondaryText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

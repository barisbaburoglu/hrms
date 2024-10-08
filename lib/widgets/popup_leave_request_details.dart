import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/models/leave_model.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../controllers/request_controller.dart';
import 'base_button.dart';
import 'base_input.dart';

class PopupLeaveRequestDetails extends StatelessWidget {
  final String title;
  final Leave? leave;
  final RequestController controller = Get.put(RequestController());

  PopupLeaveRequestDetails({
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
                        child: BaseInput(
                          readOnly: true,
                          isLabel: true,
                          errorRequired: false,
                          label: "İzin Türü",
                          controller: TextEditingController(
                            text: controller.leaveTypeNames[controller
                                .leaveTypeFromJson[leave!.leaveType]]!,
                          ),
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
                          readOnly: true,
                          isLabel: true,
                          errorRequired: false,
                          label: "İzin Başlama Tarihi",
                          controller: TextEditingController(
                            text: leave!.startDate ?? "",
                          ),
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
                          readOnly: true,
                          isLabel: true,
                          errorRequired: false,
                          label: "İzin Bitiş Tarihi",
                          controller: TextEditingController(
                            text: leave!.endDate ?? "",
                          ),
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
                          readOnly: true,
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
                    ],
                  ),
                ],
              ),
              leave!.status != 0
                  ? Wrap(
                      alignment: WrapAlignment.center,
                      runSpacing: AppDimension.kSpacing,
                      spacing: AppDimension.kSpacing,
                      children: [
                        BaseButton(
                          width: 200,
                          backgroundColor: AppColor.canvasColor,
                          textColor: leave!.status == 1
                              ? AppColor.primaryGreen
                              : AppColor.primaryRed,
                          label:
                              leave!.status == 1 ? "Onaylandı" : "Reddedildi",
                          onPressed: () {},
                          icon: Icon(
                            leave!.status == 1 ? Icons.check : Icons.block,
                            color: leave!.status == 1
                                ? AppColor.primaryGreen
                                : AppColor.primaryRed,
                          ),
                        ),
                        BaseButton(
                          backgroundColor: leave!.status == 1
                              ? AppColor.primaryRed
                              : AppColor.primaryGreen,
                          width: screenWidth < 360 ? double.infinity : 125,
                          label: leave!.status == 1 ? "Red" : "Onay",
                          onPressed: () {
                            controller.patchStatusLeave(
                              leave!.id!,
                              leave!.status == 1 ? 2 : 1,
                            );
                          },
                          icon: Icon(
                            leave!.status == 1 ? Icons.block : Icons.check,
                            color: AppColor.secondaryText,
                          ),
                        ),
                      ],
                    )
                  : Wrap(
                      alignment: WrapAlignment.center,
                      runSpacing: AppDimension.kSpacing,
                      spacing: AppDimension.kSpacing,
                      children: [
                        BaseButton(
                          width: screenWidth < 360 ? double.infinity : 125,
                          backgroundColor: AppColor.primaryRed,
                          label: "Red",
                          onPressed: () {
                            controller.patchStatusLeave(leave!.id!, 2);
                          },
                          icon: const Icon(
                            Icons.block,
                            color: AppColor.secondaryText,
                          ),
                        ),
                        BaseButton(
                          backgroundColor: AppColor.primaryGreen,
                          width: screenWidth < 360 ? double.infinity : 125,
                          label: "Onay",
                          onPressed: () {
                            controller.patchStatusLeave(leave!.id!, 1);
                          },
                          icon: const Icon(
                            Icons.check,
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

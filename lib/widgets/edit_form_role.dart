import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../api/models/role_action_model.dart';
import '../api/models/role_model.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../controllers/role_controller.dart';
import 'base_button.dart';
import 'base_input.dart';

class EditFormRole extends StatelessWidget {
  final String title;
  final Role? role;
  final RoleController controller = Get.put(RoleController());

  EditFormRole({
    super.key,
    required this.title,
    this.role,
  });

  @override
  Widget build(BuildContext context) {
    double inputWidth = kIsWeb ? 310 : double.infinity;

    double screenWidth = MediaQuery.of(Get.context!).size.width;
    double screenHeight = MediaQuery.of(Get.context!).size.height;

    if (role != null) {
      controller.setRoleFields(role!);
    } else {
      controller.clearRoleFields();
    }

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
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
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Divider(
                height: 1,
                color: AppColor.primaryAppColor.withOpacity(0.25),
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
                      label: "Rol Adı",
                      controller: controller.nameController,
                      margin: EdgeInsets.zero,
                      textInputType: TextInputType.text,
                      inputFormatters: const [],
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppDimension.kSpacing / 2),
                child: Wrap(
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
                        controller.saveRole(role: role);
                      },
                      icon: const Icon(
                        Icons.save,
                        color: AppColor.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              if (role != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 30,
                      child: BaseInput(
                        errorRequired: false,
                        isLabel: true,
                        label: "Yetki Ara",
                        controller: TextEditingController(),
                        margin: EdgeInsets.zero,
                        textInputType: TextInputType.text,
                        inputFormatters: const [],
                        onChanged: (value) {
                          controller.searchAction(value);
                        },
                      ),
                    ),
                  ],
                ),
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: screenHeight - 360,
                  child: SingleChildScrollView(
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      spacing: AppDimension.kSpacing,
                      runSpacing: AppDimension.kSpacing,
                      children: List.generate(
                        controller.filteredRoleActions.length,
                        (index) => SizedBox(
                          width: 250,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Switch(
                                value:
                                    controller.filteredRoleActions[index].id !=
                                        null,
                                onChanged: (value) async {
                                  RoleActionModel action =
                                      controller.filteredRoleActions[index];
                                  action.roleId = role!.id;
                                  if (action.id == null) {
                                    RoleActionModel? result =
                                        await controller.saveRoleAction(action);

                                    if (result.actionGroup != null) {
                                      controller.toggleAction(index);
                                    }
                                  } else {
                                    int result = await controller
                                        .deleteRoleAction(action);
                                    if (result > 0) {
                                      controller.toggleAction(index);
                                    }
                                  }
                                },
                                activeColor: AppColor.primaryGreen,
                              ),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 150,
                                child: Text(
                                  controller
                                      .filteredRoleActions[index].actionName!,
                                  maxLines: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';

import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../controllers/employee_controller.dart';
import '../controllers/profile_controller.dart';
import '../widgets/base_button.dart';
import '../widgets/base_input.dart';
import '../widgets/page_title.dart';
import 'master_scaffold.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  final EmployeeController controllerEmployee = Get.put(EmployeeController());

  final SidebarXController sidebarController =
      SidebarXController(selectedIndex: 99, extended: true);

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    controllerEmployee.nameController.text = "BARIŞ BABÜROĞLU";
    controllerEmployee.emailController.text = "barisbaburoglu@gmail.com";
    controllerEmployee.phoneController.text = "+905427268652";
    return MasterScaffold(
      sidebarController: sidebarController,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Ekran genişliği kontrolü
          double screenWidth = constraints.maxWidth;
          double width = screenWidth < 1280 ? double.infinity : 1280;

          double inputWidth = screenWidth > 1280 ? 310 : double.infinity;

          return SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: width,
                    child: PageTitleWidget(
                      title: "Profile Bilgileri",
                      rightWidgets: BaseButton(
                        backgroundColor: AppColor.primaryOrange,
                        width: screenWidth < 360 ? double.infinity : 140,
                        label: "Güncelle",
                        onPressed: () {
                          //controllerEmployee.saveEmployee(employee: employee);
                        },
                        icon: const Icon(
                          Icons.save,
                          color: AppColor.secondaryText,
                        ),
                      ),
                    )),
                Expanded(
                  child: SizedBox(
                    width: width,
                    child: Card(
                      color: AppColor.cardBackgroundColor,
                      shadowColor: AppColor.cardShadowColor,
                      margin: const EdgeInsets.all(AppDimension.kSpacing),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(AppDimension.kSpacing),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.all(AppDimension.kSpacing),
                                child: Center(
                                  child: Column(
                                    children: [
                                      const CircleAvatar(
                                        radius: 50,
                                        backgroundImage: AssetImage(
                                          'assets/images/avatar.png',
                                        ),
                                        backgroundColor: AppColor.primaryGrey,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: BaseButton(
                                          backgroundColor:
                                              AppColor.scaffoldBackgroundColor,
                                          width: 150,
                                          label: "Değiştir",
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.camera_alt,
                                            color: AppColor.secondaryText,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                    child: BaseInput(
                                      readOnly: true,
                                      controller:
                                          controllerEmployee.nameController,
                                      label: "Adı",
                                      isLabel: true,
                                      errorRequired: false,
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
                                      controller:
                                          controllerEmployee.emailController,
                                      label: "E-mail",
                                      isLabel: true,
                                      errorRequired: false,
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
                                      controller:
                                          controllerEmployee.phoneController,
                                      label: "Telefon",
                                      isLabel: true,
                                      errorRequired: false,
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
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

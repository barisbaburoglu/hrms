import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/widgets/base_button.dart';
import 'package:hrms/widgets/page_title.dart';
import 'package:sidebarx/sidebarx.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../controllers/employee_type_controller.dart';
import 'master_scaffold.dart';

class EmployeeTypePage extends StatelessWidget {
  final EmployeeTypeController controller = Get.put(EmployeeTypeController());
  final SidebarXController sidebarController =
      SidebarXController(selectedIndex: 103, extended: true);

  EmployeeTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MasterScaffold(
      sidebarController: sidebarController,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Ekran genişliği kontrolü
          double screenWidth = constraints.maxWidth;
          double width = screenWidth < 1280 ? double.infinity : 1280;

          return Obx(
            () => SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: width,
                      child: PageTitleWidget(
                        title: "Çalışan Türü Oluşturma",
                        rightWidgets: BaseButton(
                          label: "Yeni",
                          icon: const Icon(
                            Icons.add,
                            color: AppColor.secondaryText,
                          ),
                          onPressed: () {
                            controller.openEditPopup(
                                "Yeni Çalışan Türü Oluşturma", null);
                          },
                        ),
                      )),
                  SizedBox(width: width, child: titleCardWidget()),
                  Expanded(
                      child: controller.employeeTypes.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : SizedBox(width: width, child: itemsCardWidget())),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget titleCardWidget() {
    return Card(
      color: AppColor.cardBackgroundColor,
      shadowColor: AppColor.cardShadowColor,
      margin: const EdgeInsets.symmetric(horizontal: AppDimension.kSpacing),
      child: Padding(
        padding: const EdgeInsets.all(AppDimension.kSpacing),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 30,
              child: Text(
                "#",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: 150,
              child: Text(
                "Tür Adı",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Visibility(
              visible: MediaQuery.of(Get.context!).size.width > 1280,
              child: const SizedBox(
                width: 150,
                child: Text(
                  "Açıklama",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(
              width: 100,
              child: Text(
                "Düzenle",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemsCardWidget() {
    return Card(
      color: AppColor.cardBackgroundColor,
      shadowColor: AppColor.cardShadowColor,
      margin: const EdgeInsets.symmetric(
          horizontal: AppDimension.kSpacing,
          vertical: AppDimension.kSpacing / 2),
      child: Padding(
        padding: const EdgeInsets.all(AppDimension.kSpacing),
        child: Obx(() {
          return ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.employeeTypes.length,
            itemBuilder: (context, index) {
              final employeeType = controller.employeeTypes[index];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppDimension.kSpacing / 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 30,
                          child: Text(
                            "${index + 1}",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: 150,
                            child: Text(
                              employeeType.name ?? "",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Visibility(
                          visible:
                              MediaQuery.of(Get.context!).size.width > 1280,
                          child: SizedBox(
                            width: 150,
                            child: Text(
                              employeeType.description ?? "",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.openEditPopup(
                                      "Çalışan Türü Düzenleme", employeeType);
                                },
                                icon: const Icon(
                                  Icons.edit_square,
                                  color: AppColor.primaryOrange,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.deleteEmployeeType(employeeType);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: AppColor.primaryRed,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: AppColor.primaryAppColor.withOpacity(0.25),
                  )
                ],
              );
            },
          );
        }),
      ),
    );
  }
}

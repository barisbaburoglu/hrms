import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';

import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../controllers/employee_controller.dart';
import '../widgets/base_button.dart';
import '../widgets/base_input.dart';
import '../widgets/page_title.dart';
import 'master_scaffold.dart';

class EmployeePage extends StatelessWidget {
  final EmployeeController controller = Get.put(EmployeeController());
  final SidebarXController sidebarController =
      SidebarXController(selectedIndex: 104, extended: true);

  EmployeePage({super.key});

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
                      title: "Çalışan Oluşturma",
                      rightWidgets: BaseButton(
                        label: "Yeni",
                        icon: const Icon(
                          Icons.add,
                          color: AppColor.secondaryText,
                        ),
                        onPressed: () {
                          controller.openEditPopup(
                              "Yeni Çalışan Oluşturma", null);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    height: 40,
                    child: BaseInput(
                      errorRequired: false,
                      isLabel: true,
                      label: "Çalışan Ara",
                      controller: controller.searchController,
                      margin: EdgeInsets.zero,
                      textInputType: TextInputType.text,
                      inputFormatters: const [],
                      onChanged: (value) {
                        controller.searchEmployees(value);
                      },
                    ),
                  ),
                  Expanded(
                      child: SizedBox(
                          width: width,
                          child: Column(
                            children: [
                              SizedBox(
                                width: width,
                                child: titleCardWidget(),
                              ),
                              controller.filteredEmployees.isEmpty
                                  ? const SizedBox.shrink()
                                  : Expanded(child: itemsCardWidget()),
                            ],
                          ))),
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
      margin: const EdgeInsets.symmetric(
          horizontal: AppDimension.kSpacing,
          vertical: AppDimension.kSpacing / 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimension.kSpacing / 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 20,
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
              width: 50,
              child: Text(
                "Sicil No",
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
                  "Adı",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(
              width: 125,
              child: Text(
                "Soyadı",
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
                  "E-mail",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Visibility(
              visible: MediaQuery.of(Get.context!).size.width > 1280,
              child: const SizedBox(
                width: 150,
                child: Text(
                  "Telefon",
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Obx(
        () {
          return ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.filteredEmployees.length,
            itemBuilder: (context, index) {
              final employee = controller.filteredEmployees[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimension.kSpacing / 2),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppDimension.kSpacing / 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 20,
                              child: Text("${index + 1}",
                                  textAlign: TextAlign.center)),
                          SizedBox(
                              width: 50,
                              child: Text(employee.employeeNumber.toString(),
                                  textAlign: TextAlign.center)),
                          Visibility(
                            visible:
                                MediaQuery.of(Get.context!).size.width > 1280,
                            child: SizedBox(
                                width: 150,
                                child: Text(employee.name ?? "",
                                    textAlign: TextAlign.center)),
                          ),
                          SizedBox(
                              width: 125,
                              child: Text(employee.surname ?? "",
                                  textAlign: TextAlign.center)),
                          Visibility(
                            visible:
                                MediaQuery.of(Get.context!).size.width > 1280,
                            child: SizedBox(
                              width: 150,
                              child: Text(employee.email ?? "",
                                  textAlign: TextAlign.center),
                            ),
                          ),
                          Visibility(
                              visible:
                                  MediaQuery.of(Get.context!).size.width > 1280,
                              child: SizedBox(
                                  width: 150,
                                  child: Text(employee.phone ?? "",
                                      textAlign: TextAlign.center))),
                          SizedBox(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    controller.openEditPopup(
                                        "Çalışan Düzenleme", employee);
                                  },
                                  icon: const Icon(
                                    Icons.edit_square,
                                    color: AppColor.primaryOrange,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    controller.deleteEmployee(employee);
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}

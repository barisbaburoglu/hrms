import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hrms/controllers/role_controller.dart';
import 'package:hrms/views/master_scaffold.dart';
import 'package:hrms/widgets/card_title.dart';
import 'package:sidebarx/sidebarx.dart';

import '../api/models/employee_model.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../widgets/base_button.dart';
import '../widgets/base_input.dart';
import '../widgets/page_title.dart';

class EmployeeRolePage extends StatelessWidget {
  final RoleController controller = Get.put(RoleController());

  final SidebarXController sidebarController =
      SidebarXController(selectedIndex: 202, extended: true);

  EmployeeRolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MasterScaffold(
      sidebarController: sidebarController,
      body: LayoutBuilder(builder: (context, constraints) {
        // Ekran genişliği kontrolü
        double screenWidth = constraints.maxWidth;
        double width = screenWidth < 1280 ? double.infinity : 1280;

        return Column(
          children: [
            SizedBox(
                width: width,
                child: PageTitleWidget(
                  title: "Çalışan Rol Atama",
                  rightWidgets: BaseButton(
                    label: "Kaydet",
                    icon: const Icon(
                      Icons.assignment,
                      color: AppColor.secondaryText,
                    ),
                    onPressed: () {
                      controller.roleAssign(
                          controller.employeesController.selectedEmployees);
                    },
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimension.kSpacing * 4),
              child: SizedBox(
                width: width,
                child: const Text(
                  "* Listeden çalışanları seçerek rol ataması yapabilirsiniz. Bir veya birden fazla seçim yaparak atama işlemini gerçekleştirebilirsiniz!",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppDimension.kSpacing),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppDimension.kSpacing / 2,
                      horizontal: AppDimension.kSpacing * 2),
                  child: StaggeredGrid.count(
                    crossAxisCount: 12,
                    mainAxisSpacing: AppDimension.kSpacing,
                    crossAxisSpacing: AppDimension.kSpacing,
                    children: [
                      StaggeredGridTile.extent(
                        crossAxisCellCount: 8,
                        mainAxisExtent: 400,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: SizedBox(
                            height: 400,
                            child: Column(
                              children: [
                                CardTitle(
                                  title: "Çalışanlar",
                                  rightWidgets: Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            controller.employeesController
                                                .openEditPopup(
                                                    "Yeni Çalışan Oluşturma",
                                                    null);
                                          },
                                          icon: const Icon(
                                            Icons.add,
                                            color: AppColor.primaryAppColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 200,
                                          height: 30,
                                          child: BaseInput(
                                            errorRequired: false,
                                            isLabel: true,
                                            label: "Çalışan Ara",
                                            controller: controller
                                                .employeesController
                                                .searchController,
                                            margin: EdgeInsets.zero,
                                            textInputType: TextInputType.text,
                                            inputFormatters: const [],
                                            onChanged: (value) {
                                              controller.employeesController
                                                  .searchEmployees(value);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 75,
                                          child: Obx(
                                            () => CheckboxListTile(
                                              value: controller
                                                  .employeesController
                                                  .isAllEmployeesSelected
                                                  .value,
                                              onChanged: (bool? value) {
                                                controller.employeesController
                                                    .selectAllEmployees(
                                                        value ?? false);
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Obx(() => ListView.builder(
                                        itemCount: controller
                                            .employeesController
                                            .filteredEmployees
                                            .length,
                                        itemBuilder: (context, index) {
                                          final employee = controller
                                              .employeesController
                                              .filteredEmployees[index];
                                          return Obx(() => Column(
                                                children: [
                                                  CheckboxListTile(
                                                    title: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                            width: 50,
                                                            child: Text(
                                                                employee
                                                                    .employeeNumber
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            14),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center)),
                                                        Visibility(
                                                          visible: MediaQuery.of(
                                                                      Get.context!)
                                                                  .size
                                                                  .width >
                                                              1280,
                                                          child: SizedBox(
                                                              width: 150,
                                                              child: Text(
                                                                  (employee.name ??
                                                                          "")
                                                                      .toUpperCase(),
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          14),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center)),
                                                        ),
                                                        SizedBox(
                                                            width: 125,
                                                            child: Text(
                                                                (employee.surname ??
                                                                        "")
                                                                    .toUpperCase(),
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            14),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center)),
                                                      ],
                                                    ),
                                                    value: controller
                                                        .employeesController
                                                        .selectedEmployees
                                                        .contains(employee.id),
                                                    onChanged: (bool? value) {
                                                      controller
                                                          .employeesController
                                                          .toggleEmployeeSelection(
                                                              employee.id!);
                                                      controller
                                                          .updateRolesBasedOnSelectedEmployees();
                                                    },
                                                  ),
                                                  const Divider(
                                                    height: 5,
                                                    thickness: 1,
                                                    color: AppColor.canvasColor,
                                                  ),
                                                ],
                                              ));
                                        },
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      StaggeredGridTile.extent(
                        crossAxisCellCount: 4,
                        mainAxisExtent: 400,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: SizedBox(
                            height: 400,
                            child: Column(
                              children: [
                                CardTitle(
                                  title: "Roller",
                                  rightWidgets: Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            controller.openEditPopup(
                                                "Yeni Rol Oluşturma", null);
                                          },
                                          icon: const Icon(
                                            Icons.add,
                                            color: AppColor.primaryAppColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 75,
                                          child: Obx(
                                            () => CheckboxListTile(
                                              value: controller
                                                  .isAllRolesSelected.value,
                                              onChanged: (bool? value) {
                                                controller.selectAllRoles(
                                                    value ?? false);
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Obx(() => ListView.builder(
                                        itemCount: controller.roles.length,
                                        itemBuilder: (context, index) {
                                          final role = controller.roles[index];
                                          return Obx(
                                            () {
                                              bool isRoleSelected = false;
                                              if (controller
                                                  .selectedRoles.isNotEmpty) {
                                                isRoleSelected = controller
                                                    .selectedRoles
                                                    .contains(role.id);
                                              }
                                              return Column(
                                                children: [
                                                  ListTile(
                                                    title: Text(role.name!),
                                                    trailing: (controller
                                                                    .employeesController
                                                                    .selectedEmployees
                                                                    .length ==
                                                                1 &&
                                                            controller
                                                                .employeesController
                                                                .employees
                                                                .firstWhere(
                                                                  (e) =>
                                                                      e.id ==
                                                                      controller
                                                                          .employeesController
                                                                          .selectedEmployees
                                                                          .first,
                                                                  orElse: () =>
                                                                      Employee(
                                                                          id: -1,
                                                                          identityUserRoles: []),
                                                                )
                                                                .identityUserRoles!
                                                                .any((identityRole) =>
                                                                    identityRole
                                                                        .roleId ==
                                                                    role.id))
                                                        ? IconButton(
                                                            icon: const Icon(
                                                                Icons.delete,
                                                                color:
                                                                    Colors.red),
                                                            onPressed: () {
                                                              controller
                                                                  .removeRoleFromSelectedRoles(
                                                                      role.id!);
                                                            },
                                                          )
                                                        : Checkbox(
                                                            value:
                                                                isRoleSelected,
                                                            onChanged:
                                                                (isSelected) {
                                                              controller
                                                                  .toggleRoleSelection(
                                                                      role.id!);
                                                            },
                                                          ),
                                                  ),
                                                  const Divider(
                                                    height: 5,
                                                    thickness: 1,
                                                    color: AppColor.canvasColor,
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

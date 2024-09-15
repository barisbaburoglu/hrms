import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';

import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../controllers/shift_employee_controller.dart';
import '../widgets/page_title.dart';
import 'master_scaffold.dart';

class ShiftEmployeePage extends StatelessWidget {
  final ShiftEmployeeController controller = Get.put(ShiftEmployeeController());
  final SidebarXController sidebarController =
      SidebarXController(selectedIndex: 8, extended: true);

  ShiftEmployeePage({super.key});

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
                      title: "Tatil Günü Girişi",
                      rightWidgets: SizedBox(
                        width: 250,
                        child: _buildShiftDropdown(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: controller.employees.isEmpty
                        ? const SizedBox.shrink()
                        : titleCardWidget(),
                  ),
                  Expanded(
                      child: controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : controller.employees.isEmpty
                              ? const SizedBox.shrink()
                              : SizedBox(
                                  width: width, child: itemsCardWidget())),
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
            const SizedBox(
              width: 100,
              child: Text(
                "Adı",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: 100,
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
                width: 350,
                child: Text(
                  "Tatil Günleri",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
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
      child: Obx(
        () {
          return ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.employees.length,
            itemBuilder: (context, index) {
              final employee = controller.employees[index];

              // Çalışanın izin günlerini al (dayOfWeek ile eşleşecek şekilde)
              final offDays = employee.employeeShiftDayOffs!
                  .map((offDay) => offDay.dayOfWeek)
                  .toList();

              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimension.kSpacing / 2),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppDimension.kSpacing / 2),
                      child: SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runSpacing: 20,
                          children: [
                            SizedBox(
                              width: 20,
                              child: Text("${index + 1}",
                                  textAlign: TextAlign.center),
                            ),
                            SizedBox(
                              width: 50,
                              child: Text(employee.employeeNumber.toString(),
                                  textAlign: TextAlign.center),
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(employee.name ?? "",
                                  textAlign: TextAlign.center),
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(employee.surname ?? "",
                                  textAlign: TextAlign.center),
                            ),
                            SizedBox(
                              width: 350,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children:
                                    controller.weekDays.entries.map((day) {
                                  // İzin günlerini kontrol et
                                  bool isOffDay = offDays.contains(day.key);

                                  if (employee.employeeShiftDayOffs!.isEmpty) {
                                    isOffDay = controller.shiftDays
                                        .firstWhere(
                                            (x) => x.dayOfWeek == day.key)
                                        .isOffDay!;
                                  }

                                  return InkWell(
                                    mouseCursor: SystemMouseCursors.click,
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: isOffDay
                                            ? AppColor.primaryRed
                                            : AppColor
                                                .lightGreen, // Arka plan rengi
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          day.value,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      if (isOffDay) {
                                        // Eğer gün izinli ise, silme işlemi yapılır
                                        controller.deleteOffDay(employee
                                            .employeeShiftDayOffs!
                                            .firstWhere(
                                              (offDay) =>
                                                  offDay.dayOfWeek == day.key,
                                            )
                                            .id!);
                                      } else {
                                        // Eğer gün izinli değilse, ekleme işlemi yapılır
                                        controller.createOffDay(
                                            employee.id!, day.key);
                                      }
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
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

  Widget _buildShiftDropdown() {
    final shifts = controller.shifts;

    return DropdownButtonFormField<int>(
      decoration: const InputDecoration(
        labelText: "Çalışma Takvimi",
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
      value: controller.shiftId.value,
      items: shifts.isNotEmpty
          ? shifts.map((shift) {
              return DropdownMenuItem<int>(
                value: shift.id,
                child: Text(
                  shift.name ?? "",
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColor.primaryText,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              );
            }).toList()
          : [],
      onChanged: (value) {
        controller.setShiftId(value);
      },
    );
  }
}

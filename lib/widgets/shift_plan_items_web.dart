// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/models/shift_model.dart';
import '../api/models/weekly_shift_grouped_model.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../controllers/shift_plan_controller.dart';
import 'base_button.dart';

class ShiftPlanItemsWeb extends StatelessWidget {
  final ShiftPlanController controller;

  const ShiftPlanItemsWeb({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      margin: const EdgeInsets.symmetric(
          horizontal: AppDimension.kSpacing,
          vertical: AppDimension.kSpacing / 2),
      color: AppColor.cardBackgroundColor,
      shadowColor: AppColor.cardShadowColor,
      child: Obx(
        () {
          return ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.weeklyShiftGroupedList.length,
            itemBuilder: (context, index) {
              final employee = controller.weeklyShiftGroupedList[index];

              final totalCount = controller.getTotalDuration(employee.days!);
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimension.kSpacing / 2),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runSpacing: 20,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  AppDimension.kSpacing / 2),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/male.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: SizedBox(
                              height: 50,
                              child: VerticalDivider(
                                width: 1,
                                color:
                                    AppColor.primaryAppColor.withOpacity(0.25),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            child: Text(employee.employeeNumber.toString(),
                                textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: SizedBox(
                              height: 50,
                              child: VerticalDivider(
                                width: 1,
                                color:
                                    AppColor.primaryAppColor.withOpacity(0.25),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: Text(
                              employee.employeeName.toString().toUpperCase(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: SizedBox(
                              height: 50,
                              child: VerticalDivider(
                                width: 1,
                                color:
                                    AppColor.primaryAppColor.withOpacity(0.25),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 840,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:
                                  employee.days!.asMap().entries.map((entry) {
                                final day = entry.value;
                                final cellId =
                                    entry.value.weeklyEmployeeShiftId!;

                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MouseRegion(
                                      onEnter: (_) =>
                                          controller.setHovering(cellId, true),
                                      onExit: (_) =>
                                          controller.setHovering(cellId, false),
                                      child: Obx(
                                        () => Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
                                            child: Container(
                                              width: 100,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: day.shiftDayType == 2
                                                    ? (controller
                                                            .isHovering(cellId)
                                                        ? Colors.white
                                                        : AppColor.primaryRed)
                                                    : day.shiftDayType == 3
                                                        ? AppColor.primaryOrange
                                                        : day.shiftDayType == 4
                                                            ? AppColor
                                                                .primaryGrey
                                                            : Colors
                                                                .white, // Arka plan rengi
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: controller
                                                          .isHovering(cellId) &&
                                                      (day.shiftDayType == 1)
                                                  ? SizedBox(
                                                      width: 50,
                                                      height: 40,
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            IconButton(
                                                              icon: const Icon(
                                                                Icons
                                                                    .add_circle,
                                                                color: AppColor
                                                                    .primaryOrange,
                                                              ),
                                                              onPressed: () {
                                                                showAddConfirmDialog(
                                                                    day);
                                                              },
                                                            ),
                                                            IconButton(
                                                              icon: const Icon(
                                                                Icons
                                                                    .change_circle,
                                                                color: AppColor
                                                                    .accentCanvasColor,
                                                              ),
                                                              onPressed: () {
                                                                showShiftSelectionDialog(
                                                                  employee
                                                                      .employeeName,
                                                                  day,
                                                                );
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : controller.isHovering(
                                                              cellId) &&
                                                          (day.shiftDayType ==
                                                              2)
                                                      ? SizedBox(
                                                          width: 50,
                                                          height: 40,
                                                          child: Center(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                IconButton(
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .cancel,
                                                                    color: AppColor
                                                                        .primaryRed,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    showDeleteConfirmDialog(
                                                                        day);
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      : SizedBox(
                                                          width: 50,
                                                          height: 40,
                                                          child: Center(
                                                            child: Text(
                                                                day.shiftDayType ==
                                                                        2
                                                                    ? "Hafta Tatili"
                                                                    : day.shiftDayType ==
                                                                            3
                                                                        ? "İzinli"
                                                                        : day.shiftDayType ==
                                                                                4
                                                                            ? "Resmi Tatil"
                                                                            : "${day.shiftStartTime.toString().substring(0, 5)} - ${day.shiftEndTime.toString().substring(0, 5)}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                          ),
                                                        ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: SizedBox(
                                        height: 50,
                                        child: VerticalDivider(
                                          width: 1,
                                          color: AppColor.primaryAppColor
                                              .withOpacity(0.25),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            child: Text(totalCount.toString(),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: AppColor.primaryAppColor.withOpacity(0.25),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void showAddConfirmDialog(Days day) {
    Get.dialog(
      AlertDialog(
        alignment: Alignment.center,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.warning,
              color: AppColor.primaryOrange,
              size: 40,
            ),
            const SizedBox(
              width: 10,
            ),
            Text("${controller.weekLongDays[day.shiftDayOfWeek]} Günü"),
          ],
        ),
        content: const Text("Hafta tatili eklemek istediğinize emin misiniz?"),
        actions: [
          BaseButton(
            width: 100,
            label: "Hayır",
            backgroundColor: AppColor.primaryRed,
            textColor: Colors.white,
            icon: const Icon(Icons.cancel),
            onPressed: () {
              Get.back();
            },
          ),
          BaseButton(
            width: 100,
            label: "Evet",
            backgroundColor: AppColor.primaryGreen,
            textColor: Colors.white,
            icon: const Icon(Icons.check),
            onPressed: () {
              var filter = {"DayType": 2};
              controller.patchWeeklyEmployeeShift(
                day.weeklyEmployeeShiftId!,
                filter,
              );
            },
          )
        ],
      ),
    );
  }

  void showDeleteConfirmDialog(Days day) {
    Get.dialog(
      AlertDialog(
        alignment: Alignment.center,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.warning,
              color: AppColor.primaryOrange,
              size: 40,
            ),
            const SizedBox(
              width: 10,
            ),
            Text("${controller.weekLongDays[day.shiftDayOfWeek]} Günü"),
          ],
        ),
        content: const Text("Hafta tatilini silmek istediğinize emin misiniz?"),
        actions: [
          BaseButton(
            width: 110,
            label: "Vazgeç",
            backgroundColor: AppColor.primaryRed,
            textColor: Colors.white,
            icon: const Icon(Icons.cancel),
            onPressed: () {
              Get.back();
            },
          ),
          BaseButton(
            width: 100,
            label: "Evet",
            backgroundColor: AppColor.primaryGreen,
            textColor: Colors.white,
            icon: const Icon(Icons.check),
            onPressed: () {
              var filter = {"DayType": 1};
              controller.patchWeeklyEmployeeShift(
                day.weeklyEmployeeShiftId!,
                filter,
              );
            },
          )
        ],
      ),
    );
  }

  void showShiftSelectionDialog(String? employeeName, Days day) async {
    await controller.fetchShiftsDaysByDayOfWeek(
        day.shiftId, day.shiftDayOfWeek);

    final List<Shift> shifts =
        controller.shifts.where((x) => x.id != day.shiftId).toList();

    Get.dialog(
      AlertDialog(
        titlePadding:
            const EdgeInsets.symmetric(horizontal: AppDimension.kSpacing),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  employeeName.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.cancel,
                    color: AppColor.primaryRed,
                    size: 25,
                  ),
                  onPressed: () => Get.back(),
                )
              ],
            ),
            Divider(
              height: 1,
              color: AppColor.primaryAppColor.withOpacity(0.25),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.change_circle,
                  color: AppColor.accentCanvasColor,
                  size: 40,
                ),
              ],
            ),
            SizedBox(
              width: 350,
              child: Text(
                "${controller.weekLongDays[day.shiftDayOfWeek].toString()} günü saatini değiştirmek için\naşağıdaki uygula butonu ile seçim yapınız!",
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
          ],
        ),
        content: Obx(() {
          return SizedBox(
            height: controller.weekofDayGroupedList.length > 4
                ? 320
                : (controller.weekofDayGroupedList.length * 80),
            width: 350,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.weekofDayGroupedList.length,
              itemBuilder: (context, index) {
                final shiftDay = controller.weekofDayGroupedList[index];

                final shift = shifts.firstWhere(
                  (s) => s.id == shiftDay.shiftId,
                  orElse: () => Shift(id: -1, name: "Tanımsız"),
                );

                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        shift.name.toString().toUpperCase(),
                        style: const TextStyle(fontSize: 12),
                      ),
                      subtitle: Text(
                        "${controller.weekLongDays[shiftDay.dayOfWeek]}: (${shiftDay.startTime.toString().substring(0, 5)} - ${shiftDay.endTime.toString().substring(0, 5)})",
                        style: const TextStyle(fontSize: 12),
                      ),
                      trailing: BaseButton(
                        backgroundColor: AppColor.primaryGreen,
                        label: "Uygula",
                        icon: const Icon(Icons.check),
                        onPressed: () {
                          var filter = {
                            "ShiftId": shift.id,
                          };
                          controller.patchWeeklyEmployeeShift(
                            day.weeklyEmployeeShiftId!,
                            filter,
                          );
                        },
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: AppColor.primaryAppColor.withOpacity(0.25),
                    ),
                  ],
                );
              },
            ),
          );
        }),
      ),
    );
  }
}

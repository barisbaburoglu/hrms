// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/models/shift_model.dart';
import '../api/models/weekly_shift_grouped_model.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../controllers/shift_plan_controller.dart';
import 'base_button.dart';

class ShiftPlanItemsMobile extends StatelessWidget {
  final ShiftPlanController controller;

  const ShiftPlanItemsMobile({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
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
            itemCount: controller.weeklyShiftGroupedList.length,
            itemBuilder: (context, index) {
              final employee = controller.weeklyShiftGroupedList[index];

              final totalCount = controller.getTotalDuration(employee.days!);

              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimension.kSpacing / 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 65,
                            width: 65,
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
                          SizedBox(
                            width: 40,
                            child: Text(employee.employeeNumber.toString(),
                                textAlign: TextAlign.center),
                          ),
                          SizedBox(
                            width: 150,
                            child: Text(
                              employee.employeeName.toString().toUpperCase(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            width: 40,
                            child: Text(totalCount.toString(),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: employee.days!.asMap().entries.map((entry) {
                          final day = entry.value;

                          return Column(
                            children: [
                              InkWell(
                                mouseCursor: SystemMouseCursors.click,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: day.shiftDayType == 2
                                        ? AppColor.primaryRed
                                        : day.shiftDayType == 3
                                            ? AppColor.primaryOrange
                                            : day.shiftDayType == 4
                                                ? AppColor.primaryGrey
                                                : AppColor
                                                    .lightGreen, // Arka plan rengi
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      controller
                                          .weekShortDays[day.shiftDayOfWeek]
                                          .toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  showShiftSelectionDialogMobile(
                                      employee.employeeName, day);
                                },
                              ),
                              SizedBox(
                                width: 40,
                                child: Text(
                                    day.shiftDayType == 2
                                        ? "Hafta\nTatili"
                                        : day.shiftDayType == 3
                                            ? "İzinli"
                                            : day.shiftDayType == 4
                                                ? "Resmi\nTatil"
                                                : "${day.shiftStartTime.toString().substring(0, 5)}\n${day.shiftEndTime.toString().substring(0, 5)}",
                                    style: const TextStyle(fontSize: 11),
                                    textAlign: TextAlign.center),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                      height: AppDimension.kSpacing / 2,
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

  void showShiftSelectionDialogMobile(String? employeeName, Days day) async {
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
          ],
        ),
        content: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.beach_access,
                  color: AppColor.primaryOrange,
                  size: 40,
                ),
              ],
            ),
            day.shiftDayType != 2
                ? Column(
                    children: [
                      Text(
                        "${controller.weekLongDays[day.shiftDayOfWeek].toString()} günü\ntatil yapmak için tatil butonuna basınız!",
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.all(AppDimension.kSpacing / 2),
                        child: BaseButton(
                          backgroundColor: AppColor.primaryOrange,
                          label: "Tatil",
                          icon: const Icon(Icons.check),
                          onPressed: () {
                            var filter = {"DayType": 2};
                            controller.patchWeeklyEmployeeShift(
                              day.weeklyEmployeeShiftId!,
                              filter,
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Text(
                        "${controller.weekLongDays[day.shiftDayOfWeek].toString()} günü tatili\niptal etmek için iptal butonuna basınız!",
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.all(AppDimension.kSpacing / 2),
                        child: BaseButton(
                          backgroundColor: AppColor.primaryOrange,
                          label: "İptal",
                          icon: const Icon(Icons.check),
                          onPressed: () {
                            var filter = {"DayType": 1};
                            controller.patchWeeklyEmployeeShift(
                              day.weeklyEmployeeShiftId!,
                              filter,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
            const SizedBox(
              height: AppDimension.kSpacing / 2,
            ),
            Divider(
              height: 1,
              color: AppColor.primaryAppColor.withOpacity(0.25),
            ),
            const SizedBox(
              height: AppDimension.kSpacing / 2,
            ),
            if (day.shiftDayType != 2) ...[
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
              const SizedBox(
                height: AppDimension.kSpacing / 2,
              ),
              Divider(
                height: 1,
                color: AppColor.primaryAppColor.withOpacity(0.25),
              ),
              const SizedBox(
                height: AppDimension.kSpacing / 2,
              ),
              Obx(() {
                return SizedBox(
                  height: 500,
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
            ],
          ],
        ),
      ),
    );
  }
}

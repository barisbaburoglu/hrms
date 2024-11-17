import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/controllers/shift_plan_controller.dart';
import 'package:sidebarx/sidebarx.dart';

import '../api/models/shift_model.dart';
import '../api/models/weekly_shift_grouped_model.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../widgets/base_button.dart';
import '../widgets/page_title.dart';
import '../widgets/shift_plan_items_mobile.dart';
import '../widgets/shift_plan_items_web.dart';
import '../widgets/shift_plan_title.dart';
import 'master_scaffold.dart';

class ShiftPlanPage extends StatelessWidget {
  final ShiftPlanController controller = Get.put(ShiftPlanController());

  final SidebarXController sidebarController =
      SidebarXController(selectedIndex: 9, extended: true);

  ShiftPlanPage({super.key});

  //DayType = (byte)(isPublicHoliday ? 4 : (isLeaveRequest ? 3 : ((isEmployeeShiftDayOff || isDayOff) ? 2 : 1))),
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
                      title: "Vardiya Planı",
                      rightWidgets: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runSpacing: 10,
                        spacing: 10,
                        children: [
                          SizedBox(
                            width: 250,
                            child: _buildWeeksDropdown(),
                          ),
                          SizedBox(
                            height: 40,
                            child: BaseButton(
                              label: "Getir",
                              icon: const Icon(
                                Icons.calendar_month,
                                color: AppColor.secondaryText,
                              ),
                              onPressed: () {
                                controller.createShiftPlan();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (screenWidth >= 1280)
                    SizedBox(
                      width: width,
                      child: controller.weeklyShiftGroupedList.isEmpty
                          ? const SizedBox.shrink()
                          : ShiftPlanTitle(controller: controller),
                    ),
                  Expanded(
                    child: controller.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : controller.weeklyShiftGroupedList.isEmpty
                            ? const SizedBox.shrink()
                            : SizedBox(
                                width: width,
                                child: screenWidth >= 1280
                                    ? ShiftPlanItemsWeb(controller: controller)
                                    : ShiftPlanItemsMobile(
                                        controller: controller),
                              ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWeeksDropdown() {
    final weeks = controller.weeks;

    return DropdownButtonFormField<int>(
      decoration: const InputDecoration(
        labelText: "Hafta Seçimi",
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
      value: controller.weekId.value,
      items: weeks.isNotEmpty
          ? weeks.map((week) {
              return DropdownMenuItem<int>(
                value: week.weekId,
                child: Text(
                  "${week.weekId}.Hafta (${controller.formatDateRange(week.startDate!, week.endDate!)})",
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
        controller.setWeekId(value);
      },
    );
  }
}

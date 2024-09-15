import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';

import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../controllers/shift_controller.dart';
import '../widgets/base_button.dart';
import '../widgets/page_title.dart';
import 'master_scaffold.dart';

class ShiftCalendarPage extends StatelessWidget {
  final ShiftController controller = Get.put(ShiftController());
  final SidebarXController sidebarController =
      SidebarXController(selectedIndex: 7, extended: true);

  ShiftCalendarPage({super.key});

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
                        title: "Çalışma Takvimleri",
                        rightWidgets: BaseButton(
                          label: "Yeni",
                          icon: const Icon(
                            Icons.add,
                            color: AppColor.secondaryText,
                          ),
                          onPressed: () {
                            controller.openEditPopup(
                                "Yeni Takvim Oluşturma", null);
                          },
                        ),
                      )),
                  SizedBox(width: width, child: titleCardWidget()),
                  Expanded(
                    child: controller.shiftCalendars.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(width: width, child: itemsCardWidget()),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget titleCardWidget() {
    return const Card(
      color: AppColor.cardBackgroundColor,
      shadowColor: AppColor.cardShadowColor,
      margin: EdgeInsets.symmetric(horizontal: AppDimension.kSpacing),
      child: Padding(
        padding: EdgeInsets.all(AppDimension.kSpacing / 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
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
            SizedBox(
              width: 150,
              child: Text(
                "Takvim Adı",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
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
        padding: const EdgeInsets.all(AppDimension.kSpacing / 2),
        child: Obx(() {
          return controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  controller: controller.scrollController,
                  itemCount: controller.shiftCalendars.length,
                  itemBuilder: (context, index) {
                    final shift = controller.shiftCalendars[index];
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
                              SizedBox(
                                width: 150,
                                child: Text(
                                  shift.name ?? "",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        controller.openEditPopup(
                                            "Çalışma Takvimi Düzenleme", shift);
                                      },
                                      icon: const Icon(
                                        Icons.edit_square,
                                        color: AppColor.primaryOrange,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        controller
                                            .deleteShiftCalendar(shift.id!);
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

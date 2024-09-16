import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../controllers/leave_controller.dart';
import '../widgets/base_button.dart';
import '../widgets/page_title.dart';
import 'master_scaffold.dart';

class LeavePage extends StatelessWidget {
  final LeaveController controller = Get.put(LeaveController());
  final SidebarXController sidebarController =
      SidebarXController(selectedIndex: 1, extended: true);

  LeavePage({super.key});

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
                        title: "İzin Talepleri",
                        rightWidgets: BaseButton(
                          label: "Yeni",
                          icon: const Icon(
                            Icons.add,
                            color: AppColor.secondaryText,
                          ),
                          onPressed: () {
                            controller.openEditPopup("Yeni İzin Talebi", null);
                          },
                        ),
                      )),
                  SizedBox(width: width, child: titleCardWidget()),
                  Expanded(
                    child: controller.leaves.isEmpty
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
    return Card(
      color: AppColor.cardBackgroundColor,
      shadowColor: AppColor.cardShadowColor,
      margin: const EdgeInsets.symmetric(horizontal: AppDimension.kSpacing),
      child: Padding(
        padding: const EdgeInsets.all(AppDimension.kSpacing / 2),
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
                "Başlama Tarihi",
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
                  "Bitiş Tarihi",
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
                  "İzin türü",
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
                  "Sebep",
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
                "Durumu",
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
          return ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.leaves.length,
            itemBuilder: (context, index) {
              final leave = controller.leaves[index];
              return Column(
                children: [
                  Container(
                    color: leave.status == 1
                        ? AppColor.primaryGreen
                        : leave.status == 2
                            ? AppColor.primaryRed
                            : AppColor.primaryOrange,
                    child: Padding(
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
                              leave.startDate ?? "",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Visibility(
                            visible:
                                MediaQuery.of(Get.context!).size.width > 1280,
                            child: SizedBox(
                              width: 150,
                              child: Text(
                                leave.endDate ?? "",
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
                                controller.leaveTypeNames[controller
                                    .leaveTypeFromJson[leave.leaveType]]!,
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
                                leave.reason ?? "",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: Text(
                              leave.status == 1
                                  ? "Onaylandı"
                                  : leave.status == 2
                                      ? "Reddedildi"
                                      : "Onay Bekliyor",
                              textAlign: TextAlign.center,
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
              );
            },
          );
        }),
      ),
    );
  }
}

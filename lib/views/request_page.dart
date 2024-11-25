import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sidebarx/sidebarx.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../controllers/request_controller.dart';
import '../widgets/base_button.dart';
import '../widgets/page_title.dart';
import 'master_scaffold.dart';

class LeavePage extends StatelessWidget {
  final RequestController controller = Get.put(RequestController());
  final SidebarXController sidebarController =
      SidebarXController(selectedIndex: 6, extended: true);

  LeavePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MasterScaffold(
      sidebarController: sidebarController,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Ekran genişliği kontrolü
          double screenHeight = constraints.maxHeight;
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
                    child: const PageTitleWidget(
                      title: "Talep Oluşturma",
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: DefaultTabController(
                      length: 3,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppDimension.kSpacing),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: const TabBar(
                                indicatorColor: Colors.transparent,
                                dividerColor: Colors.transparent,
                                indicator: UnderlineTabIndicator(
                                  borderSide: BorderSide(
                                      color: AppColor.primaryAppColor,
                                      width: 4),
                                ),
                                indicatorSize: TabBarIndicatorSize.tab,
                                tabs: [
                                  Tab(
                                    child: Text(
                                      "Giriş/Çıkış Talepleri",
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      "İzin Talepleri",
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      "Diğer Talepler",
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: AppDimension.kSpacing / 2),
                          SizedBox(
                            height: screenHeight - 200,
                            child: TabBarView(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      width: width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal:
                                                    AppDimension.kSpacing),
                                            child: BaseButton(
                                              label: "Yeni",
                                              icon: const Icon(
                                                Icons.add,
                                                color: AppColor.secondaryText,
                                              ),
                                              onPressed: () {
                                                controller.openEventEditPopup(
                                                    "Yeni Giriş/Çıkış Talebi",
                                                    null);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: AppDimension.kSpacing / 2,
                                    ),
                                    SizedBox(
                                        width: width,
                                        child: titleEventCardWidget()),
                                    Expanded(
                                      child: controller.leaves.isEmpty
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : SizedBox(
                                              width: width,
                                              child:
                                                  itemsEntryExitEventExceptionsWidget()),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      width: width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal:
                                                    AppDimension.kSpacing),
                                            child: BaseButton(
                                              label: "Yeni",
                                              icon: const Icon(
                                                Icons.add,
                                                color: AppColor.secondaryText,
                                              ),
                                              onPressed: () {
                                                controller.openEditPopup(
                                                    "Yeni İzin Talebi", null);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: AppDimension.kSpacing / 2,
                                    ),
                                    SizedBox(
                                        width: width, child: titleCardWidget()),
                                    Expanded(
                                      child: controller.leaves.isEmpty
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : SizedBox(
                                              width: width,
                                              child:
                                                  itemsLeaveRequestsWidget()),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      width: width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal:
                                                    AppDimension.kSpacing),
                                            child: BaseButton(
                                              label: "Yeni",
                                              icon: const Icon(
                                                Icons.add,
                                                color: AppColor.secondaryText,
                                              ),
                                              onPressed: () {
                                                controller
                                                    .openEditEmployeeRequestPopup(
                                                        "Talep Oluşturma",
                                                        null);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: AppDimension.kSpacing / 2,
                                    ),
                                    SizedBox(
                                        width: width,
                                        child:
                                            titleEmployeeRequestCardWidget()),
                                    Expanded(
                                      child: controller.leaves.isEmpty
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : SizedBox(
                                              width: width,
                                              child:
                                                  itemsEmployeeRequestsWidget()),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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

  Widget titleCardWidget() {
    return Card(
      color: AppColor.cardBackgroundColor,
      shadowColor: AppColor.cardShadowColor,
      margin: const EdgeInsets.symmetric(horizontal: AppDimension.kSpacing),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
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
                "İzin türü",
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
                  "Başlama Tarihi",
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

  Widget itemsLeaveRequestsWidget() {
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
        child: Obx(() {
          return ListView.builder(
            controller: controller.scrollControllerLeave,
            itemCount: controller.leaves.length,
            itemBuilder: (context, index) {
              final leave = controller.leaves[index];
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      controller.openLeaveRequestApprovalPopup(
                          "Talep Detayları", leave);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: leave.status == 1
                                ? AppColor.primaryGreen
                                : leave.status == 2
                                    ? AppColor.primaryRed
                                    : AppColor.primaryOrange,
                            width: 8.0,
                          ),
                        ),
                      ),
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
                                controller.leaveTypeNames[controller
                                    .leaveTypeFromJson[leave.leaveType]]!,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Visibility(
                              visible:
                                  MediaQuery.of(Get.context!).size.width > 1280,
                              child: SizedBox(
                                width: 150,
                                child: Text(
                                  leave.startDate ?? "",
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
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: leave.status == 1
                                      ? AppColor.primaryGreen
                                      : leave.status == 2
                                          ? AppColor.primaryRed
                                          : AppColor.primaryOrange,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
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

  Widget titleEventCardWidget() {
    return Card(
      color: AppColor.cardBackgroundColor,
      shadowColor: AppColor.cardShadowColor,
      margin: const EdgeInsets.symmetric(horizontal: AppDimension.kSpacing),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
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
                "Konum",
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
                  "Tarih",
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

  Widget itemsEntryExitEventExceptionsWidget() {
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
        child: Obx(() {
          return ListView.builder(
            controller: controller.scrollControllerEvent,
            itemCount: controller.eventExceptions.length,
            itemBuilder: (context, index) {
              final eventException = controller.eventExceptions[index];
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      controller.openEventRequestApprovalPopup(
                          "Talep Detayları", eventException);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: eventException.status == 1
                                ? AppColor.primaryGreen
                                : eventException.status == 2
                                    ? AppColor.primaryRed
                                    : AppColor.primaryOrange,
                            width: 8.0,
                          ),
                        ),
                      ),
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
                                controller.qrCodeSettings
                                        .firstWhere((x) =>
                                            x.id ==
                                            eventException.qrCodeSettingId)
                                        .name ??
                                    "",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Visibility(
                              visible:
                                  MediaQuery.of(Get.context!).size.width > 1280,
                              child: SizedBox(
                                width: 150,
                                child: Text(
                                  DateFormat('yyyy.MM.dd HH:mm')
                                      .format(DateTime.parse(
                                          eventException.eventTime!))
                                      .toString(),
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
                                  eventException.reason ?? "",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                eventException.status == 1
                                    ? "Onaylandı"
                                    : eventException.status == 2
                                        ? "Reddedildi"
                                        : "Onay Bekliyor",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: eventException.status == 1
                                      ? AppColor.primaryGreen
                                      : eventException.status == 2
                                          ? AppColor.primaryRed
                                          : AppColor.primaryOrange,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
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

  Widget titleEmployeeRequestCardWidget() {
    return Card(
      color: AppColor.cardBackgroundColor,
      shadowColor: AppColor.cardShadowColor,
      margin: const EdgeInsets.symmetric(horizontal: AppDimension.kSpacing),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
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
                "Konu",
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
                "Detay",
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
                  "Tarih",
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

  Widget itemsEmployeeRequestsWidget() {
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
        child: Obx(() {
          return ListView.builder(
            controller: controller.scrollControllerEmployeeRequest,
            itemCount: controller.employeeRequests.length,
            itemBuilder: (context, index) {
              final employeeRequest = controller.employeeRequests[index];
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      controller.openEmployeeRequestPopup(
                          "Talep Detayları", employeeRequest);
                    },
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
                              employeeRequest.subject ?? "",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: Text(
                              employeeRequest.detail ?? "",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Visibility(
                            visible:
                                MediaQuery.of(Get.context!).size.width > 1280,
                            child: SizedBox(
                              width: 150,
                              child: Text(
                                DateFormat('yyyy.MM.dd HH:mm')
                                    .format(DateTime.parse(
                                        employeeRequest.createdAt!))
                                    .toString(),
                                textAlign: TextAlign.center,
                              ),
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

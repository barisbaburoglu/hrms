import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hrms/widgets/card_title.dart';
import 'package:sidebarx/sidebarx.dart';

import '../api/models/dash_record_model.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../controllers/auth_controller.dart';
import '../controllers/dashboard_controller.dart';
import '../controllers/request_controller.dart';
import '../controllers/shift_plan_controller.dart';
import '../widgets/arrow_bordered_card.dart';
import '../widgets/base_button.dart';
import '../widgets/brief_card.dart';
import '../widgets/shift_plan_items_mobile.dart';
import '../widgets/shift_plan_items_web_dash.dart';
import 'master_scaffold.dart';

class DashboardPage extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());
  final RequestController controllerRequest = Get.put(RequestController());
  final AuthController controllerAuth = Get.put(AuthController());
  final ShiftPlanController controllerShiftPlan =
      Get.put(ShiftPlanController());

  final SidebarXController sidebarController =
      SidebarXController(selectedIndex: 0, extended: true);

  DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    controllerShiftPlan.setWeekId(45);
    return MasterScaffold(
      sidebarController: sidebarController,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Ekran genişliği kontrolü
          double screenWidth = constraints.maxWidth;
          double width = screenWidth < 1400 ? double.infinity : 1400;

          return Center(
            child: controller.userNameSurname.value.isEmpty
                ? const CircularProgressIndicator()
                : Obx(() {
                    return SizedBox(
                      width: width,
                      height: double.infinity,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppDimension.kSpacing),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: AppDimension.kSpacing,
                                  top: AppDimension.kSpacing,
                                ),
                                child: SizedBox(
                                  width: width,
                                  child: Text(
                                    "${controller.userNameSurname} Hoşgeldiniz!",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: AppDimension.kSpacing / 2,
                                    horizontal: AppDimension.kSpacing),
                                child: StaggeredGrid.count(
                                  crossAxisCount: screenWidth <= 600
                                      ? 1
                                      : (screenWidth > 600 &&
                                              screenWidth <= 890)
                                          ? 2
                                          : 4,
                                  mainAxisSpacing: AppDimension.kSpacing,
                                  crossAxisSpacing: AppDimension.kSpacing,
                                  children: [
                                    StaggeredGridTile.extent(
                                      crossAxisCellCount: 1,
                                      mainAxisExtent: 100,
                                      child: BriefCard(
                                        backgroundColor: AppColor.primaryPink,
                                        title: "Çalışanlar".toUpperCase(),
                                        value:
                                            controller.dashRecords.value == null
                                                ? '0'
                                                : controller.dashRecords.value!
                                                    .presentEmployees!.length
                                                    .toString(),
                                        icon: const Icon(
                                          Icons.check,
                                          color: AppColor.canvasColor,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    StaggeredGridTile.extent(
                                      crossAxisCellCount: 1,
                                      mainAxisExtent: 100,
                                      child: BriefCard(
                                        backgroundColor: AppColor.primaryPurple,
                                        title: "Geç Gelenler".toUpperCase(),
                                        value:
                                            controller.dashRecords.value == null
                                                ? '0'
                                                : controller.dashRecords.value!
                                                    .lateEmployees!.length
                                                    .toString(),
                                        icon: const Icon(
                                          Icons.watch_later,
                                          color: AppColor.canvasColor,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    StaggeredGridTile.extent(
                                      crossAxisCellCount: 1,
                                      mainAxisExtent: 100,
                                      child: BriefCard(
                                        backgroundColor: AppColor.primaryBlue,
                                        title: "İzinliler".toUpperCase(),
                                        value:
                                            controller.dashRecords.value == null
                                                ? '0'
                                                : controller.dashRecords.value!
                                                    .employeesOnLeave!.length
                                                    .toString(),
                                        icon: const Icon(
                                          Icons.flight,
                                          color: AppColor.canvasColor,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    StaggeredGridTile.extent(
                                      crossAxisCellCount: 1,
                                      mainAxisExtent: 100,
                                      child: BriefCard(
                                        backgroundColor:
                                            AppColor.primaryTurquoise,
                                        title: "Gelmeyenler".toUpperCase(),
                                        value:
                                            controller.dashRecords.value == null
                                                ? '0'
                                                : controller.dashRecords.value!
                                                    .absentEmployees!.length
                                                    .toString(),
                                        icon: const Icon(
                                          Icons.block,
                                          color: AppColor.canvasColor,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppDimension.kSpacing),
                                child: StaggeredGrid.count(
                                  crossAxisCount: 12,
                                  mainAxisSpacing: AppDimension.kSpacing,
                                  crossAxisSpacing: AppDimension.kSpacing,
                                  children: [
                                    StaggeredGridTile.extent(
                                      crossAxisCellCount:
                                          screenWidth < 1360 ? 12 : 8,
                                      mainAxisExtent: 400,
                                      child: screenWidth < 1200
                                          ? ShiftPlanItemsMobile(
                                              controller: controllerShiftPlan)
                                          : ShiftPlanItemsWebDash(
                                              controller: controllerShiftPlan),
                                    ),
                                    StaggeredGridTile.extent(
                                      crossAxisCellCount: screenWidth < 720
                                          ? 12
                                          : screenWidth < 1360
                                              ? 7
                                              : 4,
                                      mainAxisExtent: 300,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Obx(
                                          () => SizedBox(
                                            width: double.infinity,
                                            child: SizedBox(
                                              width: width,
                                              child: DefaultTabController(
                                                length: 3,
                                                child: Column(
                                                  children: [
                                                    const TabBar(
                                                      indicatorColor:
                                                          Colors.transparent,
                                                      dividerColor:
                                                          Colors.transparent,
                                                      indicator:
                                                          UnderlineTabIndicator(
                                                        borderSide: BorderSide(
                                                            color: AppColor
                                                                .primaryAppColor,
                                                            width: 4),
                                                      ),
                                                      indicatorSize:
                                                          TabBarIndicatorSize
                                                              .tab,
                                                      tabs: [
                                                        Tab(
                                                          child: Text(
                                                            "Giriş/Çıkış Talepleri",
                                                            textAlign: TextAlign
                                                                .center,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        Tab(
                                                          child: Text(
                                                            "İzin Talepleri",
                                                            textAlign: TextAlign
                                                                .center,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        Tab(
                                                          child: Text(
                                                            "Diğer Talepler",
                                                            textAlign: TextAlign
                                                                .center,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                        height: AppDimension
                                                                .kSpacing /
                                                            2),
                                                    SizedBox(
                                                      height: 200,
                                                      child: TabBarView(
                                                        children: [
                                                          Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: AppDimension
                                                                        .kSpacing /
                                                                    2,
                                                              ),
                                                              SizedBox(
                                                                  width: width,
                                                                  child:
                                                                      titleEventCardWidget()),
                                                              Expanded(
                                                                child: controllerRequest
                                                                        .leaves
                                                                        .isEmpty
                                                                    ? const Center(
                                                                        child:
                                                                            CircularProgressIndicator())
                                                                    : SizedBox(
                                                                        width:
                                                                            width,
                                                                        child:
                                                                            itemsEntryExitEventExceptionsWidget()),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: AppDimension
                                                                        .kSpacing /
                                                                    2,
                                                              ),
                                                              SizedBox(
                                                                  width: width,
                                                                  child:
                                                                      titleCardWidget()),
                                                              Expanded(
                                                                child: controllerRequest
                                                                        .leaves
                                                                        .isEmpty
                                                                    ? const Center(
                                                                        child:
                                                                            CircularProgressIndicator())
                                                                    : SizedBox(
                                                                        width:
                                                                            width,
                                                                        child:
                                                                            itemsLeaveRequestsWidget()),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: AppDimension
                                                                        .kSpacing /
                                                                    2,
                                                              ),
                                                              SizedBox(
                                                                  width: width,
                                                                  child:
                                                                      titleEmployeeRequestCardWidget()),
                                                              Expanded(
                                                                child: controllerRequest
                                                                        .leaves
                                                                        .isEmpty
                                                                    ? const Center(
                                                                        child:
                                                                            CircularProgressIndicator())
                                                                    : SizedBox(
                                                                        width:
                                                                            width,
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
                                          ),
                                        ),
                                      ),
                                    ),
                                    StaggeredGridTile.extent(
                                      crossAxisCellCount: screenWidth < 720
                                          ? 12
                                          : screenWidth < 1360
                                              ? 5
                                              : 4,
                                      mainAxisExtent: 80,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: BaseButton(
                                          label: "MANUEL GİRİŞ/ÇIKIŞ EKLE",
                                          icon: const Icon(
                                            Icons.add,
                                            color: AppColor.secondaryText,
                                          ),
                                          onPressed: () {
                                            controller.openEditEvent(
                                                "Giriş/Çıkış Kaydı Oluşturma");
                                          },
                                        ),
                                      ),
                                    ),
                                    StaggeredGridTile.extent(
                                      crossAxisCellCount:
                                          screenWidth < 1360 ? 12 : 4,
                                      mainAxisExtent: 250,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CardTitle(title: "Duyurular"),
                                              SizedBox(
                                                  height:
                                                      AppDimension.kSpacing /
                                                          2),
                                            ]),
                                      ),
                                    ),
                                    _buildTile(
                                      title: "Çalışanlar",
                                      isShowEventTime: true,
                                      employees: controller
                                          .dashRecords.value!.presentEmployees,
                                      crossAxisCellCount:
                                          screenWidth < 1360 ? 12 : 4,
                                      icon: Icons.person,
                                      iconColor: AppColor.lightGreen,
                                    ),
                                    _buildTile(
                                      title: "Geç Gelenler",
                                      isShowEventTime: true,
                                      employees: controller
                                          .dashRecords.value!.lateEmployees,
                                      crossAxisCellCount:
                                          screenWidth < 1360 ? 12 : 4,
                                      icon: Icons.watch_later,
                                      iconColor: AppColor.primaryOrange,
                                    ),
                                    _buildTile(
                                      title: "Gelmeyenler",
                                      isShowEventTime: false,
                                      employees: controller
                                          .dashRecords.value!.absentEmployees,
                                      crossAxisCellCount:
                                          screenWidth < 1360 ? 12 : 4,
                                      icon: Icons.person_off,
                                      iconColor: AppColor.primaryRed,
                                    ),
                                    _buildTile(
                                      title: "İzinliler",
                                      isShowEventTime: false,
                                      employees: controller
                                          .dashRecords.value!.employeesOnLeave,
                                      crossAxisCellCount:
                                          screenWidth < 1360 ? 12 : 4,
                                      icon: Icons.flight,
                                      iconColor: AppColor.primaryBlue,
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(
                                  height: AppDimension
                                      .kSpacing), // Araya boşluk eklemek için
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
          );
        },
      ),
    );
  }

  Widget _buildTile({
    required String title,
    required List<RecordEmployees>? employees,
    required int crossAxisCellCount,
    required Color iconColor,
    required IconData icon,
    required bool isShowEventTime,
  }) {
    return StaggeredGridTile.fit(
      crossAxisCellCount: crossAxisCellCount,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardTitle(
              title: title,
              leftWidgets: IconButton(
                icon: const Icon(
                  Icons.fullscreen,
                  color: AppColor.primaryAppColor,
                ),
                onPressed: () {},
              ),
              rightWidgets: Row(
                children: [
                  Text(
                    "${employees!.length} kişi",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimension.kSpacing),
                    child: Icon(
                      icon,
                      color: iconColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimension.kSpacing / 2),
            for (var i = 0; i < employees.length; i++)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Container(
                  color: i % 2 == 0 ? Colors.grey.shade100 : Colors.transparent,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppDimension.kSpacing / 2,
                            vertical: AppDimension.kSpacing / 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              employees[i].employee.toString(),
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              '${isShowEventTime ? employees[i].eventTime.toString() : ''} (${employees[i].shiftStart.toString()} - ${employees[i].shiftEnd.toString()})',
                              style: const TextStyle(fontSize: 14),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: AppColor.primaryAppColor.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: AppDimension.kSpacing / 2),
          ],
        ),
      ),
    );
  }

  Widget titleCardWidget() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimension.kSpacing / 2),
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
              "İzin Türü",
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
    );
  }

  Widget itemsLeaveRequestsWidget() {
    return Obx(() {
      return ListView.builder(
        controller: controllerRequest.scrollControllerLeave,
        itemCount: controllerRequest.leaves.length,
        itemBuilder: (context, index) {
          final leave = controllerRequest.leaves[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimension.kSpacing / 2),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    controllerRequest.openLeaveRequestApprovalPopup(
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
                              controllerRequest.leaveTypeNames[controllerRequest
                                  .leaveTypeFromJson[leave.leaveType]]!,
                              textAlign: TextAlign.center,
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
            ),
          );
        },
      );
    });
  }

  Widget titleEventCardWidget() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimension.kSpacing / 2),
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
              "Konum",
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
    );
  }

  Widget itemsEntryExitEventExceptionsWidget() {
    return Obx(() {
      return ListView.builder(
        controller: controllerRequest.scrollControllerEvent,
        itemCount: controllerRequest.eventExceptions.length,
        itemBuilder: (context, index) {
          final eventException = controllerRequest.eventExceptions[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimension.kSpacing / 2),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    controllerRequest.openEventRequestApprovalPopup(
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
                              controllerRequest.qrCodeSettings
                                      .firstWhere((x) =>
                                          x.id ==
                                          eventException.qrCodeSettingId)
                                      .name ??
                                  "",
                              textAlign: TextAlign.center,
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
            ),
          );
        },
      );
    });
  }

  Widget titleEmployeeRequestCardWidget() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimension.kSpacing / 2),
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
              "Konu",
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
              "Detay",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget itemsEmployeeRequestsWidget() {
    return Obx(() {
      return ListView.builder(
        controller: controllerRequest.scrollControllerEmployeeRequest,
        itemCount: controllerRequest.employeeRequests.length,
        itemBuilder: (context, index) {
          final employeeRequest = controllerRequest.employeeRequests[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimension.kSpacing / 2),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    controllerRequest.openEmployeeRequestPopup(
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
    });
  }
}

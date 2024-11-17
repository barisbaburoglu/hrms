import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sidebarx/sidebarx.dart';

import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../controllers/auth_controller.dart';
import '../controllers/dashboard_controller.dart';
import '../controllers/request_controller.dart';
import '../controllers/shift_plan_controller.dart';
import '../widgets/base_button.dart';
import '../widgets/brief_card.dart';
import '../widgets/shift_plan_items_mobile.dart';
import '../widgets/shift_plan_items_web.dart';
import '../widgets/shift_plan_title.dart';
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
                : SizedBox(
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
                                    : (screenWidth > 600 && screenWidth <= 890)
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
                                      value: controller.attendanceSummary.value!
                                          .present.totalCount
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
                                      value: controller.attendanceSummary.value!
                                          .late.totalCount
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
                                      value: controller.attendanceSummary.value!
                                          .onLeave.totalCount
                                          .toString(),
                                      icon: const Icon(
                                        Icons.beach_access_outlined,
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
                                      value: controller.attendanceSummary.value!
                                          .absent.totalCount
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
                                  vertical: AppDimension.kSpacing / 2,
                                  horizontal: AppDimension.kSpacing),
                              child: StaggeredGrid.count(
                                crossAxisCount: 12,
                                mainAxisSpacing: AppDimension.kSpacing,
                                crossAxisSpacing: AppDimension.kSpacing,
                                children: [
                                  StaggeredGridTile.count(
                                    crossAxisCellCount: 8,
                                    mainAxisCellCount: 4,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: ShiftPlanItemsMobile(
                                          controller: controllerShiftPlan),
                                    ),
                                  ),
                                  StaggeredGridTile.count(
                                    crossAxisCellCount: 4,
                                    mainAxisCellCount: 3,
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
                                                        TabBarIndicatorSize.tab,
                                                    tabs: [
                                                      Tab(
                                                        child: Text(
                                                          "Giriş/Çıkış Talepleri",
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Tab(
                                                        child: Text(
                                                          "İzin Talepleri",
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Tab(
                                                        child: Text(
                                                          "Diğer Talepler",
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
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
                                  StaggeredGridTile.count(
                                    crossAxisCellCount: 4,
                                    mainAxisCellCount: 1,
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
                                  StaggeredGridTile.count(
                                    crossAxisCellCount: 4,
                                    mainAxisCellCount: 3,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                  StaggeredGridTile.count(
                                    crossAxisCellCount: 8,
                                    mainAxisCellCount: 3,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // const SizedBox(
                            //     height: AppDimension
                            //         .kSpacing), // Araya boşluk eklemek için
                            // Obx(
                            //   () {
                            //     if (controller.attendanceSummary.value ==
                            //         null) {
                            //       return const Center(
                            //           child: CircularProgressIndicator());
                            //     }
                            //     final summary =
                            //         controller.attendanceSummary.value!;
                            //     return MasonryGridView.count(
                            //       shrinkWrap: true,
                            //       physics: const NeverScrollableScrollPhysics(),
                            //       padding: const EdgeInsets.all(
                            //           AppDimension.kSpacing),
                            //       crossAxisCount: screenWidth <= 600
                            //           ? 1
                            //           : (screenWidth > 600 &&
                            //                   screenWidth <= 1190)
                            //               ? 2
                            //               : 4,
                            //       mainAxisSpacing:
                            //           AppDimension.dashContentSpacing,
                            //       crossAxisSpacing:
                            //           AppDimension.dashContentSpacing,
                            //       itemCount: 5,
                            //       itemBuilder: (context, index) {
                            //         final category = [
                            //           'present',
                            //           'late',
                            //           'absent',
                            //           'onLeave',
                            //           'leftEarly'
                            //         ][index];
                            //         final categoryData =
                            //             summary.toJson()[category];
                            //         final employees =
                            //             (categoryData['employees'] as List)
                            //                 .map((e) => e['name'] as String)
                            //                 .toList();

                            //         return ArrowBorderedCard(
                            //           backgroundColor: AppColor.gradientWhite,
                            //           body: Column(
                            //             crossAxisAlignment:
                            //                 CrossAxisAlignment.start,
                            //             children: [
                            //               Text(
                            //                 controller.getTitle(category),
                            //                 style: const TextStyle(
                            //                   fontWeight: FontWeight.bold,
                            //                   fontSize: 16,
                            //                 ),
                            //               ),
                            //               Padding(
                            //                 padding: const EdgeInsets.all(
                            //                     AppDimension.kSpacing),
                            //                 child: Column(
                            //                   crossAxisAlignment:
                            //                       CrossAxisAlignment.start,
                            //                   children: [
                            //                     ...employees
                            //                         .map((name) => Column(
                            //                               crossAxisAlignment:
                            //                                   CrossAxisAlignment
                            //                                       .start,
                            //                               children: [
                            //                                 Text(name),
                            //                                 Divider(
                            //                                   color: AppColor
                            //                                       .primaryAppColor
                            //                                       .withOpacity(
                            //                                           0.25),
                            //                                 ),
                            //                               ],
                            //                             )),
                            //                   ],
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         );
                            //       },
                            //     );
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        },
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

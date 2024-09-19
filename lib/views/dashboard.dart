import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sidebarx/sidebarx.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../controllers/auth_controller.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/arrow_bordered_card.dart';
import '../widgets/base_button.dart';
import '../widgets/page_title.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'master_scaffold.dart';

class DashboardPage extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());
  final AuthController controllerAuth = Get.put(AuthController());

  final SidebarXController sidebarController =
      SidebarXController(selectedIndex: 0, extended: true);

  DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MasterScaffold(
      sidebarController: sidebarController,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Ekran genişliği kontrolü
          double screenWidth = constraints.maxWidth;
          double width = screenWidth < 1280 ? double.infinity : 1280;

          return Center(
            child: SizedBox(
              width: width,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDimension.kSpacing),
                  child: Column(
                    children: [
                      SizedBox(
                        width: width,
                        child: const PageTitleWidget(
                          title: "Hoşgeldiniz Barış Babüroğlu,",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppDimension.kSpacing),
                        child: StaggeredGrid.count(
                          crossAxisCount: screenWidth <= 600
                              ? 1
                              : (screenWidth > 600 && screenWidth <= 1190)
                                  ? 2
                                  : 4,
                          mainAxisSpacing: AppDimension.dashContentSpacing,
                          crossAxisSpacing: AppDimension.dashContentSpacing,
                          children: [
                            StaggeredGridTile.count(
                              crossAxisCellCount: 3,
                              mainAxisCellCount: screenWidth <= 600
                                  ? 2 / 3
                                  : (screenWidth > 600 && screenWidth <= 1190)
                                      ? 2 / 3
                                      : 1,
                              child: ArrowBorderedCard(
                                body: Column(
                                  children: [
                                    const Text(
                                      'Çalışan Bilgisi',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 5),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: LineChart(
                                          LineChartData(
                                            lineTouchData: LineTouchData(
                                              touchTooltipData:
                                                  LineTouchTooltipData(
                                                getTooltipColor:
                                                    (touchedSpot) =>
                                                        Colors.green,
                                                getTooltipItems:
                                                    (List<LineBarSpot>
                                                        touchedBarSpots) {
                                                  return touchedBarSpots
                                                      .map((barSpot) {
                                                    final flSpot = barSpot;
                                                    return LineTooltipItem(
                                                      flSpot.y.toString(),
                                                      const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                      textAlign:
                                                          TextAlign.center,
                                                    );
                                                  }).toList();
                                                },
                                              ),
                                            ),
                                            gridData:
                                                const FlGridData(show: true),
                                            titlesData: FlTitlesData(
                                              rightTitles: const AxisTitles(
                                                  sideTitles: SideTitles(
                                                      showTitles: false)),
                                              topTitles: const AxisTitles(
                                                  sideTitles: SideTitles(
                                                      showTitles: false)),
                                              bottomTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                  showTitles: true,
                                                  reservedSize: 25,
                                                  interval: 1,
                                                  getTitlesWidget:
                                                      (value, meta) {
                                                    int index = value.toInt();
                                                    if (index >= 0 &&
                                                        index <
                                                            controller
                                                                .attendanceSummary
                                                                .value!
                                                                .weeklyWorkCount
                                                                .length) {
                                                      return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 5.0),
                                                          child: Text(
                                                            DateFormat('d MMM')
                                                                .format(
                                                              DateTime.parse(
                                                                controller
                                                                    .attendanceSummary
                                                                    .value!
                                                                    .weeklyWorkCount[
                                                                        index]
                                                                    .date,
                                                              ),
                                                            ),
                                                          ));
                                                    } else {
                                                      return const SizedBox
                                                          .shrink();
                                                    }
                                                  },
                                                ),
                                              ),
                                              leftTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                  showTitles: true,
                                                  reservedSize: 20,
                                                  getTitlesWidget: (value, _) {
                                                    return Text(
                                                        '${value.toInt()}');
                                                  },
                                                ),
                                              ),
                                            ),
                                            borderData:
                                                FlBorderData(show: false),
                                            minX: 0,
                                            maxX: 6,
                                            minY: 0,
                                            maxY: 15,
                                            lineBarsData: [
                                              LineChartBarData(
                                                spots: controller
                                                    .attendanceSummary
                                                    .value!
                                                    .weeklyWorkCount
                                                    .asMap()
                                                    .entries
                                                    .map((entry) {
                                                  int index = entry.key;
                                                  int count = entry
                                                      .value.numberOfEmployees;
                                                  return FlSpot(
                                                      index.toDouble(),
                                                      count.toDouble());
                                                }).toList(),
                                                isCurved: true,
                                                color: Colors.green,
                                                barWidth: 4,
                                                dotData:
                                                    const FlDotData(show: true),
                                                belowBarData: BarAreaData(
                                                  show: true,
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.green
                                                          .withOpacity(0.3),
                                                      Colors.lightGreen
                                                          .withOpacity(0.3)
                                                    ],
                                                  ),
                                                ),
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
                            StaggeredGridTile.count(
                              crossAxisCellCount: screenWidth <= 600
                                  ? 1
                                  : (screenWidth > 600 && screenWidth <= 1190)
                                      ? 2
                                      : 1,
                              mainAxisCellCount: screenWidth <= 600
                                  ? 1
                                  : (screenWidth > 600 && screenWidth <= 1190)
                                      ? 4 / 5
                                      : 1,
                              child: ArrowBorderedCard(
                                body: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Toplam Çalışan',
                                          style: TextStyle(
                                            color: AppColor.primaryAppColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 2,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Obx(() => Text(
                                              '${(controller.attendanceSummary.value?.totalEmployees.totalMen ?? 0) + (controller.attendanceSummary.value?.totalEmployees.totalWomen ?? 0)} ',
                                              style: const TextStyle(
                                                color: AppColor.primaryAppColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 2,
                                              ),
                                              textAlign: TextAlign.center,
                                            )),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Obx(
                                      () => Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              AppDimension.kSpacing),
                                          child: PieChart(
                                            PieChartData(
                                              pieTouchData: PieTouchData(
                                                touchCallback:
                                                    (FlTouchEvent event,
                                                        pieTouchResponse) {
                                                  if (!event
                                                          .isInterestedForInteractions ||
                                                      pieTouchResponse ==
                                                          null ||
                                                      pieTouchResponse
                                                              .touchedSection ==
                                                          null) {
                                                    controller.touchedIndex
                                                        .value = -1;
                                                    return;
                                                  }
                                                  controller
                                                          .touchedIndex.value =
                                                      pieTouchResponse
                                                          .touchedSection!
                                                          .touchedSectionIndex;
                                                },
                                              ),
                                              borderData:
                                                  FlBorderData(show: false),
                                              sectionsSpace: 0,
                                              centerSpaceRadius: 0,
                                              sections:
                                                  controller.showingSections(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppDimension.kSpacing),
                        child: StaggeredGrid.count(
                          crossAxisCount: screenWidth <= 600
                              ? 1
                              : (screenWidth > 600 && screenWidth <= 1190)
                                  ? 2
                                  : 4,
                          mainAxisSpacing: AppDimension.dashContentSpacing,
                          crossAxisSpacing: AppDimension.dashContentSpacing,
                          children: [
                            StaggeredGridTile.count(
                              crossAxisCellCount: 1,
                              mainAxisCellCount: screenWidth <= 600
                                  ? 1 / 2
                                  : (screenWidth > 600 && screenWidth <= 1190)
                                      ? 2 / 5
                                      : 1 / 2,
                              child: ArrowBorderedCard(
                                backgroundColor: AppColor.colorGreenDarkGreen,
                                body: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Icon(
                                      Icons.check_circle,
                                      color: AppColor.canvasColor,
                                      size: 30,
                                    ),
                                    const Text(
                                      "İşe Gelenler",
                                      style: TextStyle(
                                        color: AppColor.canvasColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      controller.attendanceSummary.value!
                                          .present.totalCount
                                          .toString(),
                                      style: const TextStyle(
                                          color: AppColor.secondaryText,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            StaggeredGridTile.count(
                              crossAxisCellCount: 1,
                              mainAxisCellCount: screenWidth <= 600
                                  ? 1 / 2
                                  : (screenWidth > 600 && screenWidth <= 1190)
                                      ? 2 / 5
                                      : 1 / 2,
                              child: ArrowBorderedCard(
                                backgroundColor: AppColor.gradientGreen,
                                body: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Icon(
                                      Icons.watch_later,
                                      color: AppColor.canvasColor,
                                      size: 30,
                                    ),
                                    const Text(
                                      "İşe Geç Gelenler",
                                      style: TextStyle(
                                        color: AppColor.canvasColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      controller.attendanceSummary.value!.late
                                          .totalCount
                                          .toString(),
                                      style: const TextStyle(
                                          color: AppColor.secondaryText,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            StaggeredGridTile.count(
                              crossAxisCellCount: 1,
                              mainAxisCellCount: screenWidth <= 600
                                  ? 1 / 2
                                  : (screenWidth > 600 && screenWidth <= 1190)
                                      ? 2 / 5
                                      : 1 / 2,
                              child: ArrowBorderedCard(
                                backgroundColor: AppColor.gradientBlue,
                                body: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Icon(
                                      Icons.block,
                                      color: AppColor.canvasColor,
                                      size: 30,
                                    ),
                                    const Text(
                                      "İşe Gelmeyenler",
                                      style: TextStyle(
                                        color: AppColor.canvasColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      controller.attendanceSummary.value!.absent
                                          .totalCount
                                          .toString(),
                                      style: const TextStyle(
                                          color: AppColor.secondaryText,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            StaggeredGridTile.count(
                              crossAxisCellCount: 1,
                              mainAxisCellCount: screenWidth <= 600
                                  ? 1 / 2
                                  : (screenWidth > 600 && screenWidth <= 1190)
                                      ? 2 / 5
                                      : 1 / 2,
                              child: ArrowBorderedCard(
                                backgroundColor: AppColor.gradientOrange,
                                body: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Icon(
                                      Icons.beach_access_outlined,
                                      color: AppColor.canvasColor,
                                      size: 30,
                                    ),
                                    const Text(
                                      "İzinli",
                                      style: TextStyle(
                                        color: AppColor.canvasColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      controller.attendanceSummary.value!
                                          .onLeave.totalCount
                                          .toString(),
                                      style: const TextStyle(
                                          color: AppColor.secondaryText,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                          height: AppDimension
                              .kSpacing), // Araya boşluk eklemek için
                      Obx(
                        () {
                          if (controller.attendanceSummary.value == null) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          final summary = controller.attendanceSummary.value!;
                          return MasonryGridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding:
                                const EdgeInsets.all(AppDimension.kSpacing),
                            crossAxisCount: screenWidth <= 600
                                ? 1
                                : (screenWidth > 600 && screenWidth <= 1190)
                                    ? 2
                                    : 4,
                            mainAxisSpacing: AppDimension.dashContentSpacing,
                            crossAxisSpacing: AppDimension.dashContentSpacing,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              final category = [
                                'present',
                                'late',
                                'absent',
                                'onLeave',
                                'leftEarly'
                              ][index];
                              final categoryData = summary.toJson()[category];
                              final employees =
                                  (categoryData['employees'] as List)
                                      .map((e) => e['name'] as String)
                                      .toList();

                              return ArrowBorderedCard(
                                backgroundColor: AppColor.gradientWhite,
                                body: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.getTitle(category),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(
                                          AppDimension.kSpacing),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ...employees.map((name) => Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(name),
                                                  Divider(
                                                    color: AppColor
                                                        .primaryAppColor
                                                        .withOpacity(0.25),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
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
}

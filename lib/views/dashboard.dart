import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/constants/colors.dart';
import 'package:hrms/constants/dimensions.dart';
import 'package:hrms/controllers/auth_controller.dart';
import 'package:hrms/views/master_scaffold.dart';
import 'package:hrms/widgets/base_button.dart';
import 'package:sidebarx/sidebarx.dart';
import '../controllers/attendance_controller.dart';
import '../widgets/arrow_bordered_card.dart';
import '../widgets/page_title.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DashboardPage extends StatelessWidget {
  final AttendanceController controller = Get.put(AttendanceController());
  final AuthController controllerAuth = Get.put(AuthController());

  final SidebarXController sidebarController =
      SidebarXController(selectedIndex: 0, extended: true);

  final List<int> employeeCounts = [
    5,
    7,
    8,
    10,
    6,
    9,
    7,
    8,
    9,
    10
  ]; // Sample data

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
                        child: PageTitleWidget(
                          title: "Hoşgeldiniz Barış Babüroğlu,",
                          rightWidgets: BaseButton(
                            label: "Çıkış Yap",
                            onPressed: controllerAuth.logout,
                            icon: const Icon(Icons.logout),
                          ),
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
                                        color: AppColor.primaryAppColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(
                                            AppDimension.kSpacing / 2),
                                        child: LineChart(
                                          LineChartData(
                                            lineTouchData: LineTouchData(
                                              touchTooltipData:
                                                  LineTouchTooltipData(
                                                getTooltipColor:
                                                    (touchedSpot) =>
                                                        AppColor.primaryGreen,
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
                                                          color: AppColor
                                                              .canvasColor),
                                                      textAlign:
                                                          TextAlign.center,
                                                    );
                                                  }).toList();
                                                },
                                              ),
                                            ),
                                            gridData: const FlGridData(
                                              show: true,
                                            ),
                                            titlesData: FlTitlesData(
                                              rightTitles: const AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: false),
                                              ),
                                              topTitles: const AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: false),
                                              ),
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
                                                            employeeCounts
                                                                .length) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5.0),
                                                        child: Text(
                                                            'Aug ${index + 1}'),
                                                      );
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
                                            borderData: FlBorderData(
                                              show: false,
                                            ),
                                            minX: 0,
                                            maxX: 9,
                                            minY: 0,
                                            maxY: 10,
                                            lineBarsData: [
                                              LineChartBarData(
                                                spots: employeeCounts
                                                    .asMap()
                                                    .entries
                                                    .map((entry) {
                                                  int index = entry.key;
                                                  int count = entry.value;
                                                  return FlSpot(
                                                      index.toDouble(),
                                                      count.toDouble());
                                                }).toList(),
                                                isCurved: true,
                                                color: AppColor.lightGreen,
                                                barWidth: 4,
                                                dotData: const FlDotData(
                                                  show: true,
                                                ),
                                                belowBarData: BarAreaData(
                                                  show: true,
                                                  gradient: LinearGradient(
                                                    colors: AppColor
                                                        .gradientGreen
                                                        .map((color) => color
                                                            .withOpacity(0.3))
                                                        .toList(),
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
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Toplam Çalışan',
                                          style: TextStyle(
                                            color: AppColor.primaryAppColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 2,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          '77',
                                          style: TextStyle(
                                            color: AppColor.primaryAppColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 2,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
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
                                              borderData: FlBorderData(
                                                show: false,
                                              ),
                                              sectionsSpace: 0,
                                              centerSpaceRadius: 0,
                                              sections: showingSections(),
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
                              child: const ArrowBorderedCard(
                                backgroundColor: AppColor.colorGreenDarkGreen,
                                body: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: AppColor.canvasColor,
                                      size: 30,
                                    ),
                                    Text(
                                      "İşe Gelenler",
                                      style: TextStyle(
                                        color: AppColor.canvasColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "50",
                                      style: TextStyle(
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
                              child: const ArrowBorderedCard(
                                backgroundColor: AppColor.gradientGreen,
                                body: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.watch_later,
                                      color: AppColor.canvasColor,
                                      size: 30,
                                    ),
                                    Text(
                                      "İşe Geç Gelenler",
                                      style: TextStyle(
                                        color: AppColor.canvasColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "12",
                                      style: TextStyle(
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
                              child: const ArrowBorderedCard(
                                backgroundColor: AppColor.gradientBlue,
                                body: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.block,
                                      color: AppColor.canvasColor,
                                      size: 30,
                                    ),
                                    Text(
                                      "İşe Gelmeyenler",
                                      style: TextStyle(
                                        color: AppColor.canvasColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "5",
                                      style: TextStyle(
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
                              child: const ArrowBorderedCard(
                                backgroundColor: AppColor.gradientOrange,
                                body: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.beach_access_outlined,
                                      color: AppColor.canvasColor,
                                      size: 30,
                                    ),
                                    Text(
                                      "İzinli",
                                      style: TextStyle(
                                        color: AppColor.canvasColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "10",
                                      style: TextStyle(
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
                      MasonryGridView.count(
                        shrinkWrap:
                            true, // MasonryGridView'in boyutunu içerik kadar sınırlamak için
                        physics:
                            const NeverScrollableScrollPhysics(), // MasonryGridView'in kaydırılabilirliğini devre dışı bırakmak için
                        padding: const EdgeInsets.all(AppDimension.kSpacing),
                        crossAxisCount: screenWidth <= 600
                            ? 1
                            : (screenWidth > 600 && screenWidth <= 1190)
                                ? 2
                                : 4,
                        mainAxisSpacing: AppDimension.dashContentSpacing,
                        crossAxisSpacing: AppDimension.dashContentSpacing,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return ArrowBorderedCard(
                            backgroundColor: AppColor.gradientWhite,
                            body: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'İşe Gelenler',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(
                                      AppDimension.kSpacing),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (var i = 0; i < index + 1; i++)
                                        const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Barış Babüroğlu'),
                                            Divider(
                                              color: AppColor.canvasColor,
                                            ),
                                            Text('Abdulkadir Dağaoturan'),
                                            Divider(
                                              color: AppColor.canvasColor,
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == controller.touchedIndex.value;
      final fontSize = isTouched ? 14.0 : 12.0;
      final radius = isTouched ? 70.0 : 65.0;
      final widgetSize = isTouched ? 55.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColor.primaryBlue,
            value: 84,
            title: '84%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              'male.png',
              size: widgetSize,
              borderColor: AppColor.primaryGreen,
            ),
            badgePositionPercentageOffset: 1.25,
          );
        case 1:
          return PieChartSectionData(
            color: AppColor.primaryRed,
            value: 16,
            title: '16%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              'female.png',
              size: widgetSize,
              borderColor: AppColor.primaryGreen,
            ),
            badgePositionPercentageOffset: 1.25,
          );
        default:
          throw Exception('Oh no');
      }
    });
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.assetName, {
    required this.size,
    required this.borderColor,
  });
  final String assetName;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: ClipOval(
          child: Image.asset(
            'assets/images/$assetName',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

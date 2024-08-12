import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/constants/colors.dart';
import 'package:hrms/constants/dimensions.dart';
import 'package:hrms/views/master_scaffold.dart';
import 'package:sidebarx/sidebarx.dart';
import '../controllers/attendance_controller.dart';
import '../widgets/arrow_bordered_card.dart';
import '../widgets/page_title.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DashboardPage extends StatelessWidget {
  final AttendanceController controller = Get.put(AttendanceController());

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
              child: Column(
                children: [
                  SizedBox(
                    width: width,
                    child: const PageTitleWidget(
                      title: "Hoşgeldiniz Barış Babüroğlu,",
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimension.kSpacing),
                      child: MasonryGridView.count(
                        padding: const EdgeInsets.all(AppDimension.kSpacing),
                        crossAxisCount: screenWidth <= 600
                            ? 1
                            : (screenWidth > 600 && screenWidth <= 980)
                                ? 2
                                : 3,
                        mainAxisSpacing: AppDimension.dashContentSpacing,
                        crossAxisSpacing: AppDimension.dashContentSpacing,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return ArrowBorderedCard(
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
                                              color: AppColor.background,
                                            ),
                                            Text('Abdulkadir Dağaoturan'),
                                            Divider(
                                              color: AppColor.background,
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
}

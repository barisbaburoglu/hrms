import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/widgets/base_button.dart';
import 'package:hrms/widgets/page_title.dart';
import 'package:sidebarx/sidebarx.dart';
import '../api/models/users_entry_exit_event_model.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../controllers/events_entry_exit_controller.dart';
import 'master_scaffold.dart';

class EventsEntryExitPage extends StatelessWidget {
  final EventsEntryExitController controller =
      Get.put(EventsEntryExitController());
  final SidebarXController sidebarController =
      SidebarXController(selectedIndex: 6, extended: true);

  EventsEntryExitPage({super.key});

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
                      title: "Giriş & Çıkışlar",
                      rightWidgets: BaseButton(
                        label: "Yeni",
                        icon: const Icon(
                          Icons.add,
                          color: AppColor.secondaryText,
                        ),
                        onPressed: () {
                          controller
                              .openEditEvent("Giriş/Çıkış Kaydı Oluşturma");
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: width, child: titleCardWidget()),
                  Expanded(
                    child: controller.lastEntryExit.isEmpty
                        ? const Center(
                            child: Text("Data Not Found"),
                          )
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
              width: 100,
              child: Text(
                "Giriş",
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
                "Çıkış",
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
                "Konum",
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
            itemCount: controller.lastEntryExit.length,
            itemBuilder: (context, index) {
              final UsersEntryExitEvent events =
                  controller.lastEntryExit[index];
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
                          width: 100,
                          child: Text(
                            "${events.entry!.eventTime}",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            "${events.exit!.eventTime}",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            "${events.entry!.qrCodeSetting!.name}",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 2,
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

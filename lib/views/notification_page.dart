import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';

import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../controllers/notification_controller.dart';
import '../widgets/base_button.dart';
import '../widgets/base_input.dart';
import '../widgets/page_title.dart';
import 'master_scaffold.dart';

class NotificationPage extends StatelessWidget {
  final NotificationController controller = Get.put(NotificationController());
  final SidebarXController sidebarController =
      SidebarXController(selectedIndex: 104, extended: true);

  NotificationPage({super.key});

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
                      title: "Bildirim Oluşturma",
                      rightWidgets: BaseButton(
                        label: "Yeni",
                        icon: const Icon(
                          Icons.add,
                          color: AppColor.secondaryText,
                        ),
                        onPressed: () {
                          controller.openEditPopup(
                              "Yeni Bildirim Oluşturma", null);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: titleCardWidget(),
                  ),
                  Expanded(
                      child: SizedBox(
                          width: width,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 300,
                                height: 40,
                                child: BaseInput(
                                  errorRequired: false,
                                  isLabel: true,
                                  label: "Bildirim Ara",
                                  controller: controller.searchController,
                                  margin: EdgeInsets.zero,
                                  textInputType: TextInputType.text,
                                  inputFormatters: const [],
                                  onChanged: (value) {
                                    controller.searchNotification(value);
                                  },
                                ),
                              ),
                              controller.filteredNotifications.isEmpty
                                  ? const SizedBox.shrink()
                                  : Expanded(child: itemsCardWidget()),
                            ],
                          ))),
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
      margin: const EdgeInsets.symmetric(
          horizontal: AppDimension.kSpacing,
          vertical: AppDimension.kSpacing / 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimension.kSpacing / 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 20,
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
              width: 125,
              child: Text(
                "Başlık",
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
                  "İçerik",
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Obx(
        () {
          return ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.filteredNotifications.length,
            itemBuilder: (context, index) {
              final notification = controller.filteredNotifications[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimension.kSpacing / 2),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppDimension.kSpacing / 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 20,
                              child: Text("${index + 1}",
                                  textAlign: TextAlign.center)),
                          SizedBox(
                              width: 50,
                              child: Text(notification.title.toString(),
                                  textAlign: TextAlign.center)),
                          Visibility(
                            visible:
                                MediaQuery.of(Get.context!).size.width > 1280,
                            child: SizedBox(
                                width: 150,
                                child: Text(notification.body ?? "",
                                    textAlign: TextAlign.center)),
                          ),
                          SizedBox(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    controller.openEditPopup(
                                        "Bildirim Düzenleme", notification);
                                  },
                                  icon: const Icon(
                                    Icons.edit_square,
                                    color: AppColor.primaryOrange,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    controller.deleteNotification(notification);
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}

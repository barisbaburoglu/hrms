import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/controllers/location_qr_controller.dart';
import 'package:hrms/widgets/base_button.dart';
import 'package:hrms/widgets/page_title.dart';
import 'package:hrms/widgets/qr_code_colorful.dart';
import 'package:sidebarx/sidebarx.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import 'master_scaffold.dart';

class QRCodeListPage extends StatelessWidget {
  final LocationQRController controller = Get.put(LocationQRController());
  final SidebarXController sidebarController =
      SidebarXController(selectedIndex: 400, extended: true);

  QRCodeListPage({super.key});

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
                      title: "Lokasyon &\nQR Oluşturma",
                      rightWidgets: BaseButton(
                        label: "Yeni",
                        icon: const Icon(
                          Icons.add,
                          color: AppColor.secondaryText,
                        ),
                        onPressed: () {
                          controller.openEditPopup(
                              "Lokasyon & QR Düzenleme", null);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: titleCardWidget(),
                  ),
                  Expanded(
                      child: controller.qrCodeSettings.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : SizedBox(width: width, child: itemsCardWidget())),
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
        padding: const EdgeInsets.symmetric(
            vertical: AppDimension.kSpacing,
            horizontal: AppDimension.kSpacing / 2),
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
            Visibility(
              visible: MediaQuery.of(Get.context!).size.width > 1280,
              child: const SizedBox(
                width: 100,
                child: Text(
                  "QR",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(
              width: 125,
              child: Text(
                "Lokasyon",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: 70,
              child: Text(
                "QR Türü",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
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
            controller: ScrollController(),
            itemCount: controller.qrCodeSettings.length,
            itemBuilder: (context, index) {
              final qrCodeSettings = controller.qrCodeSettings[index];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppDimension.kSpacing,
                        horizontal: AppDimension.kSpacing / 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 20,
                            child: Text(
                              "${index + 1}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            )),
                        Visibility(
                          visible:
                              MediaQuery.of(Get.context!).size.width > 1280,
                          child: SizedBox(
                            width: 100,
                            child: ColorfulQrCode(
                              data: qrCodeSettings.uniqueKey!,
                              eventTypeId: qrCodeSettings.eventType!,
                              size: 75,
                            ),
                          ),
                        ),
                        SizedBox(
                            width: 125,
                            child: Text(qrCodeSettings.name ?? "",
                                textAlign: TextAlign.center)),
                        SizedBox(
                          width: 70,
                          child: Text(
                              controller.eventTypes
                                  .where(
                                      (x) => x.id == qrCodeSettings.eventType!)
                                  .first
                                  .typeName,
                              textAlign: TextAlign.center),
                        ),
                        SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.openEditPopup(
                                      "Lokasyon ve QR Düzenleme",
                                      qrCodeSettings);
                                },
                                icon: const Icon(
                                  Icons.edit_square,
                                  color: AppColor.primaryOrange,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller
                                      .deleteQRCodeSetting(qrCodeSettings);
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
        },
      ),
    );
  }
}

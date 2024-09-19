import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/constants/colors.dart';
import 'package:hrms/constants/dimensions.dart';
import 'package:hrms/views/master_scaffold.dart';
import 'package:hrms/widgets/arrow_bordered_card.dart';
import 'package:hrms/widgets/base_button.dart';
import 'package:intl/intl.dart';
import 'package:sidebarx/sidebarx.dart';
import '../controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  final SidebarXController sidebarController =
      SidebarXController(selectedIndex: 0, extended: true);

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MasterScaffold(
      sidebarController: sidebarController,
      body: Obx(
        () => Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          DateFormat('EEEE', 'tr')
                              .format(DateTime.now())
                              .toUpperCase(),
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          controller.currentTime.value,
                          style: const TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Digital',
                          ),
                        ),
                        Text(
                          controller.currentDate.value.toUpperCase(),
                          style: const TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimension.dashContentSpacing),
                  const Text(
                    "GİRİŞ / ÇIKIŞ\nQR TARA",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppDimension.kSpacing),
                  InkWell(
                    onTap: () {
                      controller.showQrScannerDialog();
                    },
                    child: const ArrowBorderedCard(
                      body: Column(
                        children: [
                          Icon(
                            Icons.qr_code,
                            size: 150,
                            color: AppColor.primaryAppColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 200,
                    child: BaseButton(
                      label: "Karekodsuz Giriş/Çıkış",
                      onPressed: () {
                        controller.openNoQRPopup("Karekodsuz Giriş/Çıkış Ekle");
                      },
                    ),
                  ),
                  const Spacer(),
                  Container(
                    color: Colors.grey[200],
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Column(
                            children: [
                              controller.entryTime.isEmpty
                                  ? const Icon(Icons.timer)
                                  : Text(
                                      controller.entryTime.value,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                              const Text(
                                'Giriş',
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Column(
                            children: [
                              controller.exitTime.isEmpty
                                  ? const Icon(Icons.timer_off)
                                  : Text(
                                      controller.exitTime.value,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                              const Text(
                                'Çıkış',
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Column(
                            children: [
                              controller.workingHours.isEmpty
                                  ? const Icon(Icons.access_time)
                                  : Text(
                                      controller.workingHours.value,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                              const Text(
                                'Çalışma Saati',
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: controller.savingEntryExit.value,
              child: SizedBox.expand(
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

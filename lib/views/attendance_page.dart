import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/views/master_scaffold.dart';
import 'package:intl/intl.dart';
import 'package:sidebarx/sidebarx.dart';
import '../controllers/attendance_controller.dart';

class AttendancePage extends StatelessWidget {
  final AttendanceController controller = Get.put(AttendanceController());

  final SidebarXController sidebarController =
      SidebarXController(selectedIndex: 0, extended: true);

  AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MasterScaffold(
      sidebarController: sidebarController,
      body: Padding(
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
                  Obx(() => Text(
                        controller.currentTime.value,
                        style: const TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Digital',
                        ),
                      )),
                  Obx(() => Text(
                        controller.currentDate.value.toUpperCase(),
                        style: const TextStyle(fontSize: 24),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Spacer(),
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(16),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: Column(
                      children: [
                        Text(
                          '10:12',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
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
                        Icon(Icons.timer_off),
                        Text(
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
                        Icon(Icons.access_time),
                        Text(
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
    );
  }
}

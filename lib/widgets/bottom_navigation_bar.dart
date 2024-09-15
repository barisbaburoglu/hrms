import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../controllers/bottom_navigation_controller.dart';

class CustomConvexAppBar extends StatelessWidget {
  final BottomNavigationController controller =
      Get.put(BottomNavigationController());

  CustomConvexAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? const SizedBox()
        : Obx(() => ConvexAppBar(
              height: 65,
              backgroundColor: AppColor.primaryAppColor,
              style: TabStyle.reactCircle,
              items: const [
                TabItem(icon: Icons.event, title: "Hareket"),
                TabItem(icon: Icons.qr_code, title: "QR"),
                TabItem(icon: Icons.home, title: "Anasayfa"),
                TabItem(icon: Icons.notifications, title: "Duyuru"),
                TabItem(icon: Icons.person, title: "Profil"),
              ],
              initialActiveIndex: controller.currentIndex.value,
              onTap: (index) {
                controller.changePage(index);
              },
            ));
  }
}

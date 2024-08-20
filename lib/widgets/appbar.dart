import 'package:flutter/material.dart';
import '../constants/colors.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.appBarColor,
      centerTitle: true,
      toolbarHeight: 50,
      title: const Text(
        "LOGO",
        style: TextStyle(
          color: AppColor.primaryAppColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 0, // AppBar'ın altındaki gölgeyi kaldırmak için
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}

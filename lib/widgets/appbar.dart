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
      title: Image.asset(
        'assets/images/logolight.png',
        fit: BoxFit.cover,
        width: 150,
      ),
      scrolledUnderElevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}

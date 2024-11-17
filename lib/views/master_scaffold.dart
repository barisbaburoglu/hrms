import 'package:flutter/material.dart';
import 'package:hrms/constants/colors.dart';
import 'package:sidebarx/sidebarx.dart';

import '../widgets/appbar.dart';
import '../widgets/sidebar.dart';
import '../widgets/bottom_navigation_bar.dart';

class MasterScaffold extends StatelessWidget {
  final SidebarXController sidebarController;
  final Widget? body;

  const MasterScaffold({
    super.key,
    required this.body,
    required this.sidebarController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.canvasColor,
      appBar: const TopAppBar(),
      drawer: LeftSidebarX(controller: sidebarController),
      body: body,
      bottomNavigationBar: CustomConvexAppBar(),
    );
  }
}

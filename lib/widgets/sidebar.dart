import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../controllers/sidebar_controller.dart'; // Controller'ı içe aktarın

class LeftSidebarX extends StatelessWidget {
  const LeftSidebarX({
    super.key,
    required SidebarXController controller,
  }) : _controller = controller;

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    final SidebarController sidebarController = Get.put(SidebarController());

    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColor.canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: AppColor.scaffoldBackgroundColor,
        textStyle: const TextStyle(
          color: AppColor.primaryAppColor,
          fontWeight: FontWeight.bold,
        ),
        selectedTextStyle: const TextStyle(color: Colors.white),
        hoverTextStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColor.darkGreen.withOpacity(0.37),
          ),
          gradient: LinearGradient(
            colors: [
              AppColor.primaryAppColor,
              AppColor.primaryAppColor.withOpacity(0.5),
              AppColor.canvasColor
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: const IconThemeData(
          color: AppColor.primaryAppColor,
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: AppColor.canvasColor,
        ),
      ),
      footerDivider: Divider(
        color: AppColor.primaryAppColor.withOpacity(0.3),
        height: 1,
      ),
      headerBuilder: (context, extended) {
        return Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SizedBox(
            height: 100,
            width: 100, // Width ve height eşit olmalı ki daire oluşsun
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/avatar.png',
                  fit: BoxFit.cover, // Resmin tamamının görünmesini sağlar
                ),
              ),
            ),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.home,
          label: 'Anasayfa',
          onTap: () {
            sidebarController.navigateTo('/', 0); // Navigate to the home page
          },
        ),
        // SidebarXItem(
        //   icon: Icons.qr_code,
        //   label: 'Hasarlı Binalar',
        //   onTap: () {
        //     sidebarController.navigateTo(
        //         '/damaged', 1); // Navigate to the QR page
        //   },
        // ),
        // SidebarXItem(
        //   icon: Icons.qr_code,
        //   label: 'Parsel Görüntüle',
        //   onTap: () {
        //     sidebarController.navigateTo(
        //         '/parcel', 2); // Navigate to the QR page
        //   },
        // ),
        // SidebarXItem(
        //   icon: Icons.qr_code,
        //   label: 'Giriş/Çıkış',
        //   onTap: () {
        //     sidebarController.navigateTo('/', 3); // Navigate to the QR page
        //   },
        // ),
        // SidebarXItem(
        //   icon: Icons.date_range,
        //   label: 'İzinler',
        //   onTap: () {
        //     sidebarController.navigateTo(
        //         '/', 4); // Navigate to the permissions page
        //   },
        // ),
        // SidebarXItem(
        //   icon: Icons.notifications,
        //   label: 'Duyurular',
        //   onTap: () {
        //     sidebarController.navigateTo(
        //         '/', 5); // Navigate to the notifications page
        //   },
        // ),
        // SidebarXItem(
        //   icon: Icons.map,
        //   label: 'Map',
        //   onTap: () {
        //     sidebarController.navigateTo('/map', 6); // Navigate to the map page
        //   },
        // ),
        // SidebarXItem(
        //   icon: Icons.location_pin,
        //   label: 'Location-QR',
        //   onTap: () {
        //     sidebarController.navigateTo(
        //         '/location-qr', 7); // Navigate to the home page
        //   },
        // ),
        SidebarXItem(
          icon: Icons.work,
          label: 'Şirket Bilgileri',
          onTap: () {
            sidebarController.navigateTo(
                '/company', 8); // Navigate to the home page
          },
        ),
        SidebarXItem(
          icon: Icons.type_specimen,
          label: 'Çalışan Türleri',
          onTap: () {
            sidebarController.navigateTo(
                '/employee-types', 9); // Navigate to the home page
          },
        ),
        SidebarXItem(
          icon: Icons.group_work_outlined,
          label: 'Bölümler',
          onTap: () {
            sidebarController.navigateTo(
                '/departments', 10); // Navigate to the home page
          },
        ),
        SidebarXItem(
          icon: Icons.people,
          label: 'Çalışanlar',
          onTap: () {
            sidebarController.navigateTo(
                '/employee', 10); // Navigate to the home page
          },
        ),
      ],
    );
  }
}

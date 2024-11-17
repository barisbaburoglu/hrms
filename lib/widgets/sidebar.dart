import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrms/constants/dimensions.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../controllers/sidebar_controller.dart';
import 'base_button.dart';

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
        hoverColor: AppColor.primaryAppColor,
        textStyle: const TextStyle(
          color: AppColor.primaryAppColor,
          fontWeight: FontWeight.bold,
        ),
        selectedTextStyle: const TextStyle(color: Colors.white),
        hoverTextStyle: const TextStyle(
          color: AppColor.secondaryText,
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
      ),
      footerBuilder: (context, extended) {
        return _controller.extended
            ? Padding(
                padding: const EdgeInsets.all(AppDimension.kSpacing / 2),
                child: BaseButton(
                  backgroundColor: AppColor.cardBackgroundColor,
                  textColor: AppColor.primaryText,
                  label: "Çıkış",
                  onPressed: () {
                    sidebarController.logout();
                  },
                  icon: const Icon(Icons.logout),
                ),
              )
            : IconButton(
                onPressed: () {
                  sidebarController.logout();
                },
                icon: const Icon(
                  Icons.logout,
                  color: AppColor.primaryAppColor,
                ),
              );
      },
      headerBuilder: (context, extended) {
        return Column(
          children: [
            SizedBox(
              height: _controller.extended ? 100 : 75,
              width: _controller.extended ? 100 : 75,
              child: Padding(
                padding: const EdgeInsets.all(AppDimension.kSpacing / 2),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/avatar.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            _controller.extended
                ? BaseButton(
                    backgroundColor: AppColor.cardBackgroundColor,
                    textColor: AppColor.primaryText,
                    width: 125,
                    label: "Profile",
                    onPressed: () {
                      sidebarController.navigateTo('/profile', 99);
                    },
                    icon: const Icon(
                      Icons.person,
                      color: AppColor.primaryText,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      sidebarController.navigateTo('/profile', 99);
                    },
                    icon: const Icon(
                      Icons.person,
                      color: AppColor.primaryAppColor,
                    ),
                  ),
            const Padding(
              padding:
                  EdgeInsets.symmetric(vertical: AppDimension.kSpacing / 4),
              child: Divider(
                color: AppColor.primaryAppColor,
              ),
            )
          ],
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.home,
          label: 'Anasayfa',
          onTap: () {
            sidebarController.navigateTo(kIsWeb ? '/index' : '/home', 0);
          },
        ),
        SidebarXItem(
          icon: Icons.work,
          label: 'Şirket Bilgileri',
          onTap: () {
            sidebarController.navigateTo('/company', 1);
          },
        ),
        SidebarXItem(
          icon: Icons.type_specimen,
          label: 'Çalışan Türleri',
          onTap: () {
            sidebarController.navigateTo('/employee-types', 2);
          },
        ),
        SidebarXItem(
          icon: Icons.group_work_outlined,
          label: 'Bölümler',
          onTap: () {
            sidebarController.navigateTo('/departments', 3);
          },
        ),
        SidebarXItem(
          icon: Icons.people,
          label: 'Çalışanlar',
          onTap: () {
            sidebarController.navigateTo('/employee', 4);
          },
        ),
        SidebarXItem(
          icon: Icons.location_pin,
          label: 'Lokasyon ve QR',
          onTap: () {
            sidebarController.navigateTo('/qrcode-list', 5);
          },
        ),
        SidebarXItem(
          icon: Icons.door_sliding_outlined,
          label: 'Giriş Çıkışlar',
          onTap: () {
            sidebarController.navigateTo('/events', 6);
          },
        ),
        SidebarXItem(
          icon: Icons.calendar_month_outlined,
          label: 'Çalışma Takvimi',
          onTap: () {
            sidebarController.navigateTo('/shifts', 7);
          },
        ),
        SidebarXItem(
          icon: Icons.beach_access,
          label: 'Tatil Girişi',
          onTap: () {
            sidebarController.navigateTo('/shift-employee', 8);
          },
        ),
        SidebarXItem(
          icon: Icons.settings,
          label: 'Vardiya Planı',
          onTap: () {
            sidebarController.navigateTo('/shift-plan', 9);
          },
        ),
        SidebarXItem(
          icon: Icons.request_page,
          label: 'Talep Oluştur',
          onTap: () {
            sidebarController.navigateTo('/leave', 10);
          },
        ),
        SidebarXItem(
          icon: Icons.settings,
          label: 'Şirket Ayarları',
          onTap: () {
            sidebarController.navigateTo('/company-settigs-details', 11);
          },
        ),
      ],
    );
  }
}

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
      collapseIcon: Icons.arrow_back,
      controller: _controller,
      theme: SidebarXTheme(
        itemPadding: const EdgeInsets.all(0),
        itemMargin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        selectedItemMargin: const EdgeInsets.only(left: 10),
        selectedItemPadding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: AppColor.canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        textStyle: const TextStyle(
          fontSize: 12,
          color: AppColor.primaryAppColor,
          fontWeight: FontWeight.bold,
        ),
        hoverColor: Colors.transparent,
        hoverTextStyle: const TextStyle(
          fontSize: 13,
          color: AppColor.primaryText,
          fontWeight: FontWeight.bold,
        ),
        selectedTextStyle: const TextStyle(
          fontSize: 13,
          color: AppColor.primaryText,
          fontWeight: FontWeight.bold,
        ),
        itemTextPadding: const EdgeInsets.only(left: 15),
        selectedItemTextPadding: const EdgeInsets.only(left: 25),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          border: Border.all(color: AppColor.canvasColor),
        ),
        iconTheme: const IconThemeData(
          color: AppColor.primaryAppColor,
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.black,
          size: 20,
        ),
      ),
      showToggleButton: false,
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
        if (sidebarController.hasPermission('CompanyService'))
          SidebarXItem(
            selectable: false,
            iconBuilder: (context, selected) => MouseRegion(
              onEnter: (_) {
                sidebarController.setGroupHover(true, 'company');
              },
              onExit: (_) {
                sidebarController.setGroupHover(false, 'company');
              },
              child: SizedBox(
                width: !_controller.extended ? 60 : 170,
                child: Obx(() {
                  return ExpansionTile(
                    initiallyExpanded: (_controller.selectedIndex >= 101 &&
                        _controller.selectedIndex <= 199),
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    minTileHeight: 20,
                    backgroundColor: Colors.transparent,
                    collapsedBackgroundColor: Colors.transparent,
                    enabled: true,
                    leading: Icon(Icons.business,
                        size: 20,
                        color: (sidebarController.isGroupHovered("company") ||
                                (_controller.selectedIndex >= 101 &&
                                    _controller.selectedIndex <= 199))
                            ? Colors.black
                            : AppColor.primaryAppColor),
                    collapsedIconColor:
                        (sidebarController.isGroupHovered("company") ||
                                (_controller.selectedIndex >= 101 &&
                                    _controller.selectedIndex <= 199))
                            ? Colors.black
                            : AppColor.primaryAppColor,
                    iconColor: (sidebarController.isGroupHovered("company") ||
                            (_controller.selectedIndex >= 101 &&
                                _controller.selectedIndex <= 199))
                        ? Colors.black
                        : AppColor.primaryAppColor,
                    title: SizedBox(
                      height: 20,
                      child: Text(
                        !_controller.extended ? ' ' : 'Şirket İşlemleri',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color:
                                (sidebarController.isGroupHovered("company") ||
                                        (_controller.selectedIndex >= 101 &&
                                            _controller.selectedIndex <= 199))
                                    ? Colors.black
                                    : AppColor.primaryAppColor),
                      ),
                    ),
                    collapsedShape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    children: [
                      ListTile(
                        minTileHeight: 20,
                        leading: Icon(Icons.work,
                            size: !_controller.extended ? 17 : 20,
                            color: (_controller.selectedIndex == 101)
                                ? Colors.black
                                : AppColor.primaryAppColor),
                        title: Text(
                          !_controller.extended ? ' ' : 'Şirketler',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: (_controller.selectedIndex == 101)
                                  ? Colors.black
                                  : AppColor.primaryAppColor),
                        ),
                        onTap: () {
                          sidebarController.navigateTo('/company', 101);
                        },
                      ),
                      ListTile(
                        minTileHeight: 20,
                        leading: Icon(Icons.group_work_outlined,
                            size: !_controller.extended ? 17 : 20,
                            color: (_controller.selectedIndex == 102)
                                ? Colors.black
                                : AppColor.primaryAppColor),
                        title: Text(
                          !_controller.extended ? ' ' : 'Bölümler',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: (_controller.selectedIndex == 102)
                                  ? Colors.black
                                  : AppColor.primaryAppColor),
                        ),
                        onTap: () {
                          sidebarController.navigateTo('/departments', 102);
                        },
                      ),
                      ListTile(
                        minTileHeight: 20,
                        leading: Icon(Icons.type_specimen,
                            size: !_controller.extended ? 17 : 20,
                            color: (_controller.selectedIndex == 103)
                                ? Colors.black
                                : AppColor.primaryAppColor),
                        title: Text(
                          !_controller.extended ? ' ' : 'Çalışan Türleri',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: (_controller.selectedIndex == 103)
                                  ? Colors.black
                                  : AppColor.primaryAppColor),
                        ),
                        onTap: () {
                          sidebarController.navigateTo('/employee-types', 103);
                        },
                      ),
                      ListTile(
                        minTileHeight: 20,
                        leading: Icon(Icons.people,
                            size: !_controller.extended ? 17 : 20,
                            color: (_controller.selectedIndex == 104)
                                ? Colors.black
                                : AppColor.primaryAppColor),
                        title: Text(
                          !_controller.extended ? ' ' : 'Çalışanlar',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: (_controller.selectedIndex == 104)
                                  ? Colors.black
                                  : AppColor.primaryAppColor),
                        ),
                        onTap: () {
                          sidebarController.navigateTo('/employee', 104);
                        },
                      ),
                      ListTile(
                        minTileHeight: 20,
                        leading: Icon(Icons.settings,
                            size: !_controller.extended ? 17 : 20,
                            color: (_controller.selectedIndex == 105)
                                ? Colors.black
                                : AppColor.primaryAppColor),
                        title: Text(
                          !_controller.extended ? ' ' : 'Ayarlar',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: (_controller.selectedIndex == 105)
                                  ? Colors.black
                                  : AppColor.primaryAppColor),
                        ),
                        onTap: () {
                          sidebarController.navigateTo(
                              '/company-settigs-details', 105);
                        },
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        if (sidebarController.hasPermission('UserRoleService'))
          SidebarXItem(
            selectable: false,
            iconBuilder: (context, selected) => MouseRegion(
              onEnter: (_) {
                sidebarController.setGroupHover(true, 'role');
              },
              onExit: (_) {
                sidebarController.setGroupHover(false, 'role');
              },
              child: SizedBox(
                width: !_controller.extended ? 60 : 170,
                child: Obx(() {
                  return ExpansionTile(
                    initiallyExpanded: (_controller.selectedIndex >= 201 &&
                        _controller.selectedIndex <= 299),
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    minTileHeight: 20,
                    backgroundColor: Colors.transparent,
                    collapsedBackgroundColor: Colors.transparent,
                    enabled: true,
                    leading: Icon(Icons.settings_accessibility,
                        size: 20,
                        color: (sidebarController.isGroupHovered("role") ||
                                (_controller.selectedIndex >= 201 &&
                                    _controller.selectedIndex <= 299))
                            ? Colors.black
                            : AppColor.primaryAppColor),
                    collapsedIconColor:
                        (sidebarController.isGroupHovered("role") ||
                                (_controller.selectedIndex >= 201 &&
                                    _controller.selectedIndex <= 299))
                            ? Colors.black
                            : AppColor.primaryAppColor,
                    iconColor: (sidebarController.isGroupHovered("role") ||
                            (_controller.selectedIndex >= 201 &&
                                _controller.selectedIndex <= 299))
                        ? Colors.black
                        : AppColor.primaryAppColor,
                    title: Text(
                      !_controller.extended ? ' ' : 'Rol İşlemleri',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: (sidebarController.isGroupHovered("role") ||
                                  (_controller.selectedIndex >= 201 &&
                                      _controller.selectedIndex <= 299))
                              ? Colors.black
                              : AppColor.primaryAppColor),
                    ),
                    collapsedShape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    children: [
                      ListTile(
                        minTileHeight: 20,
                        leading: Icon(Icons.edit,
                            size: !_controller.extended ? 17 : 20,
                            color: (_controller.selectedIndex == 201)
                                ? Colors.black
                                : AppColor.primaryAppColor),
                        title: Text(
                          !_controller.extended ? ' ' : 'Rol / Yetki',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: (_controller.selectedIndex == 201)
                                  ? Colors.black
                                  : AppColor.primaryAppColor),
                        ),
                        onTap: () {
                          sidebarController.navigateTo('/roles', 201);
                        },
                      ),
                      ListTile(
                        minTileHeight: 20,
                        leading: Icon(Icons.add_moderator,
                            size: !_controller.extended ? 17 : 20,
                            color: (_controller.selectedIndex == 202)
                                ? Colors.black
                                : AppColor.primaryAppColor),
                        title: Text(
                          !_controller.extended ? ' ' : 'Rol Atama',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: (_controller.selectedIndex == 202)
                                  ? Colors.black
                                  : AppColor.primaryAppColor),
                        ),
                        onTap: () {
                          sidebarController.navigateTo('/employee-roles', 202);
                        },
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        if (sidebarController.hasPermission('ShiftService'))
          SidebarXItem(
            selectable: false,
            iconBuilder: (context, selected) => MouseRegion(
              onEnter: (_) {
                sidebarController.setGroupHover(true, 'shift');
              },
              onExit: (_) {
                sidebarController.setGroupHover(false, 'shift');
              },
              child: SizedBox(
                width: !_controller.extended ? 60 : 170,
                child: Obx(() {
                  return ExpansionTile(
                    initiallyExpanded: (_controller.selectedIndex == 301 ||
                        (_controller.selectedIndex >= 301 &&
                            _controller.selectedIndex <= 399)),
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    minTileHeight: 20,
                    backgroundColor: Colors.transparent,
                    collapsedBackgroundColor: Colors.transparent,
                    enabled: true,
                    leading: Icon(Icons.calendar_month,
                        size: 20,
                        color: (sidebarController.isGroupHovered("shift") ||
                                (_controller.selectedIndex >= 301 &&
                                    _controller.selectedIndex <= 399))
                            ? Colors.black
                            : AppColor.primaryAppColor),
                    collapsedIconColor:
                        (sidebarController.isGroupHovered("shift") ||
                                (_controller.selectedIndex >= 301 &&
                                    _controller.selectedIndex <= 399))
                            ? Colors.black
                            : AppColor.primaryAppColor,
                    iconColor: (sidebarController.isGroupHovered("shift") ||
                            (_controller.selectedIndex >= 301 &&
                                _controller.selectedIndex <= 399))
                        ? Colors.black
                        : AppColor.primaryAppColor,
                    title: Text(
                      !_controller.extended ? ' ' : 'Vardiya İşlemleri',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: (sidebarController.isGroupHovered("shift") ||
                                  (_controller.selectedIndex >= 301 &&
                                      _controller.selectedIndex <= 399))
                              ? Colors.black
                              : AppColor.primaryAppColor),
                    ),
                    collapsedShape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    children: [
                      ListTile(
                        minTileHeight: 20,
                        leading: Icon(Icons.calendar_month_outlined,
                            size: !_controller.extended ? 17 : 20,
                            color: (_controller.selectedIndex == 301)
                                ? Colors.black
                                : AppColor.primaryAppColor),
                        title: Text(
                          !_controller.extended ? ' ' : 'Çalışma Takvimi',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: (_controller.selectedIndex == 301)
                                  ? Colors.black
                                  : AppColor.primaryAppColor),
                        ),
                        onTap: () {
                          sidebarController.navigateTo('/shifts', 301);
                        },
                      ),
                      ListTile(
                        minTileHeight: 20,
                        leading: Icon(Icons.beach_access,
                            size: !_controller.extended ? 17 : 20,
                            color: (_controller.selectedIndex == 302)
                                ? Colors.black
                                : AppColor.primaryAppColor),
                        title: Text(
                          !_controller.extended ? ' ' : 'Tatil Girişi',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: (_controller.selectedIndex == 302)
                                  ? Colors.black
                                  : AppColor.primaryAppColor),
                        ),
                        onTap: () {
                          sidebarController.navigateTo('/shift-employee', 302);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.add_moderator,
                            size: !_controller.extended ? 17 : 20,
                            color: (_controller.selectedIndex == 303)
                                ? Colors.black
                                : AppColor.primaryAppColor),
                        title: Text(
                          !_controller.extended ? ' ' : 'Vardiya Planı',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: (_controller.selectedIndex == 303)
                                  ? Colors.black
                                  : AppColor.primaryAppColor),
                        ),
                        onTap: () {
                          sidebarController.navigateTo('/shift-plan', 303);
                        },
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        if (sidebarController.hasPermission('QRCodeSettingService'))
          SidebarXItem(
            iconBuilder: (context, selected) => MouseRegion(
              onEnter: (_) {
                sidebarController.setGroupHover(true, 'location');
              },
              onExit: (_) {
                sidebarController.setGroupHover(false, 'location');
              },
              child: SizedBox(
                width: !_controller.extended ? 60 : 170,
                child: ListTile(
                  minTileHeight: 20,
                  minVerticalPadding: 5,
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.location_on,
                      size: !_controller.extended ? 17 : 20,
                      color: (sidebarController.isGroupHovered("location") ||
                              (_controller.selectedIndex == 400))
                          ? Colors.black
                          : AppColor.primaryAppColor),
                  title: Text(
                    !_controller.extended ? ' ' : 'Lokasyon ve QR',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: (sidebarController.isGroupHovered("location") ||
                                (_controller.selectedIndex == 400))
                            ? Colors.black
                            : AppColor.primaryAppColor),
                  ),
                  onTap: () {
                    sidebarController.navigateTo('/qrcode-list', 400);
                  },
                ),
              ),
            ),
          ),
        if (sidebarController.hasPermission('WorkEntryExitEventService'))
          SidebarXItem(
            iconBuilder: (context, selected) => MouseRegion(
              onEnter: (_) {
                sidebarController.setGroupHover(true, 'event');
              },
              onExit: (_) {
                sidebarController.setGroupHover(false, 'event');
              },
              child: SizedBox(
                width: !_controller.extended ? 60 : 170,
                child: ListTile(
                  minTileHeight: 20,
                  minVerticalPadding: 5,
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.door_sliding_outlined,
                      size: !_controller.extended ? 17 : 20,
                      color: (sidebarController.isGroupHovered("event") ||
                              (_controller.selectedIndex == 500))
                          ? Colors.black
                          : AppColor.primaryAppColor),
                  title: Text(
                    !_controller.extended ? ' ' : 'Girişler ve Çıkışlar',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: (sidebarController.isGroupHovered("event") ||
                                (_controller.selectedIndex == 500))
                            ? Colors.black
                            : AppColor.primaryAppColor),
                  ),
                  onTap: () {
                    sidebarController.navigateTo('/events', 500);
                  },
                ),
              ),
            ),
          ),
        if (sidebarController.hasPermission('LeaveRequestService'))
          SidebarXItem(
            iconBuilder: (context, selected) => MouseRegion(
              onEnter: (_) {
                sidebarController.setGroupHover(true, 'request');
              },
              onExit: (_) {
                sidebarController.setGroupHover(false, 'request');
              },
              child: SizedBox(
                width: !_controller.extended ? 60 : 170,
                child: ListTile(
                  minTileHeight: 20,
                  minVerticalPadding: 5,
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.note_alt,
                      size: !_controller.extended ? 17 : 20,
                      color: (sidebarController.isGroupHovered("request") ||
                              (_controller.selectedIndex == 600))
                          ? Colors.black
                          : AppColor.primaryAppColor),
                  title: Text(
                    !_controller.extended ? ' ' : 'Talep Oluştur',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: (sidebarController.isGroupHovered("request") ||
                                (_controller.selectedIndex == 600))
                            ? Colors.black
                            : AppColor.primaryAppColor),
                  ),
                  onTap: () {
                    sidebarController.navigateTo('/leave', 600);
                  },
                ),
              ),
            ),
          ),
        if (sidebarController.hasPermission('NotificationService'))
          SidebarXItem(
            iconBuilder: (context, selected) => MouseRegion(
              onEnter: (_) {
                sidebarController.setGroupHover(true, 'notif');
              },
              onExit: (_) {
                sidebarController.setGroupHover(false, 'notif');
              },
              child: SizedBox(
                width: !_controller.extended ? 60 : 170,
                child: ListTile(
                  minTileHeight: 20,
                  minVerticalPadding: 5,
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.note_alt,
                      size: !_controller.extended ? 17 : 20,
                      color: (sidebarController.isGroupHovered("notif") ||
                              (_controller.selectedIndex == 600))
                          ? Colors.black
                          : AppColor.primaryAppColor),
                  title: Text(
                    !_controller.extended ? ' ' : 'Bildirim Oluştur',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: (sidebarController.isGroupHovered("notif") ||
                                (_controller.selectedIndex == 600))
                            ? Colors.black
                            : AppColor.primaryAppColor),
                  ),
                  onTap: () {
                    sidebarController.navigateTo('/notifications', 600);
                  },
                ),
              ),
            ),
          ),
      ],
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hrms/constants/colors.dart';
import 'package:hrms/views/attendance_page.dart';
import 'package:hrms/views/company_page.dart';
import 'package:hrms/views/damaged_page.dart';
import 'package:hrms/views/department_page.dart';
import 'package:hrms/views/employee_type_page.dart';
import 'package:hrms/views/map_page.dart';
import 'package:hrms/views/parcel_page.dart';
import 'package:hrms/views/qrCode_list_page.dart';
import 'package:hrms/views/sign_in_page.dart';

import 'package:intl/date_symbol_data_local.dart';

import 'themes/checkbox_theme.dart';
import 'themes/scrollbar_theme.dart';
import 'views/dashboard.dart';
import 'views/employee_page.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:universal_html/html.dart' as html;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await initializeDateFormatting('tr_TR', null);
  await DefaultCacheManager().emptyCache();
  if (kIsWeb) clearCookiesAndSiteData();
  runApp(const MyApp());
}

void clearCookiesAndSiteData() {
  // Clear all cookies
  var cookies = html.document.cookie?.split('; ') ?? [];
  for (var cookie in cookies) {
    var key = cookie.split('=').first;
    html.document.cookie =
        '$key=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;';
  }

  // Optionally clear local storage and session storage
  html.window.localStorage.clear();
  html.window.sessionStorage.clear();

  print("cache temizlendi");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget loadPage(Widget page) {
    return GetStorage().read('accessToken') == null ? SignInPage() : page;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HRMS',
      theme: ThemeData(
        primarySwatch: AppColor.createMaterialColor(AppColor.primaryAppColor),
        checkboxTheme: customCheckboxTheme,
        scrollbarTheme: customScrollbarTheme,
        colorScheme: const ColorScheme.light(
          primary: AppColor.primaryAppColor,
        ),
        buttonTheme: const ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      initialRoute: GetStorage().read('accessToken') == null ? '/' : '/index',
      getPages: [
        GetPage(name: '/', page: () => SignInPage()),
        GetPage(
            name: '/employee-types', page: () => loadPage(EmployeeTypePage())),
        GetPage(name: '/employee', page: () => loadPage(EmployeePage())),
        GetPage(name: '/departments', page: () => loadPage(DepartmentPage())),
        GetPage(name: '/company', page: () => loadPage(CompanyPage())),
        GetPage(name: '/qrcode-list', page: () => loadPage(QRCodeListPage())),
        GetPage(name: '/index', page: () => loadPage(DashboardPage())),
        GetPage(name: '/home', page: () => loadPage(AttendancePage())),
        GetPage(name: '/damaged', page: () => loadPage(const DamagedPage())),
        GetPage(name: '/parcel', page: () => loadPage(ParcelPage())),
        GetPage(name: '/map', page: () => loadPage(MapPage())),
      ],
    );
  }
}

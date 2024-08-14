import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/constants/colors.dart';
import 'package:hrms/views/attendance_page.dart';
import 'package:hrms/views/company_page.dart';
import 'package:hrms/views/damaged_page.dart';
import 'package:hrms/views/dashboard.dart';
import 'package:hrms/views/department_page.dart';
import 'package:hrms/views/employee_type_page.dart';
import 'package:hrms/views/location_qr_page.dart';
import 'package:hrms/views/map_page.dart';
import 'package:hrms/views/parcel_page.dart';
import 'package:hrms/views/qrCode_list_page.dart';

import 'package:intl/date_symbol_data_local.dart';

import 'themes/checkbox_theme.dart';
import 'themes/scrollbar_theme.dart';
import 'views/employee_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('tr_TR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
      initialRoute: '/',
      getPages: [
        GetPage(
            name: '/', page: () => kIsWeb ? DashboardPage() : AttendancePage()),
        GetPage(name: '/employee-types', page: () => EmployeeTypePage()),
        GetPage(name: '/employee', page: () => EmployeePage()),
        GetPage(name: '/departments', page: () => DepartmentPage()),
        GetPage(name: '/company', page: () => CompanyPage()),
        GetPage(name: '/damaged', page: () => const DamagedPage()),
        GetPage(name: '/parcel', page: () => ParcelPage()),
        GetPage(name: '/map', page: () => MapPage()),
        GetPage(name: '/qrcode-list', page: () => QRCodeListPage()),
        GetPage(name: '/location-qr', page: () => LocationQRPage()),
        GetPage(name: '/attendance', page: () => AttendancePage()),
      ],
    );
  }
}

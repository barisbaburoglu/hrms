import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:universal_html/html.dart' as html;

import 'package:hrms/api/models/user_role_actions_model.dart';

import 'constants/colors.dart';
import 'themes/checkbox_theme.dart';
import 'themes/scrollbar_theme.dart';
import 'views/company_page.dart';
import 'views/company_settings_details_page.dart';
import 'views/dashboard.dart';
import 'views/department_page.dart';
import 'views/employee_page.dart';
import 'views/employee_role_page.dart';
import 'views/employee_type_page.dart';
import 'views/events_entry_exit_page.dart';
import 'views/home_page.dart';
import 'views/notification_page.dart';
import 'views/profile_page.dart';
import 'views/qrCode_list_page.dart';
import 'views/request_page.dart';
import 'views/role_page.dart';
import 'views/shift_calendar_page.dart';
import 'views/shift_employee_page.dart';
import 'views/shift_plan_page.dart';
import 'views/sign_in_page.dart';
import 'widgets/custom_snack_bar.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Burada bildirim verisini işleyebilirsiniz
  print("Arka planda gelen bildirim: ${message.messageId}");
  // Bildirim verisini işleyin veya kaydedin
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  // if (kIsWeb) {
  //   await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //       apiKey: "AIzaSyCTzuq7-2NRP6NJ0YYxFQXv1LaqRPnbqQc",
  //       authDomain: "devin-hrms.firebaseapp.com",
  //       projectId: "devin-hrms",
  //       storageBucket: "devin-hrms.firebasestorage.app",
  //       messagingSenderId: "871586996697",
  //       appId: "1:871586996697:web:bd6445f3f9ec09fd4d79c8",
  //       measurementId: "G-DZT1Y5V342",
  //     ),
  //   );

  //   if (html.window.navigator.serviceWorker != null) {
  //     await html.window.navigator.serviceWorker!
  //         .register('/firebase-messaging-sw.js');
  //   }
  // } else {
  //   await Firebase.initializeApp();
  // }

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await initializeDateFormatting('tr_TR', null);

  // NotificationService notificationService = NotificationService();
  // await notificationService.initialize();

  await DefaultCacheManager().emptyCache();

  // if (kIsWeb) clearCookiesAndSiteData();

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
      initialRoute: GetStorage().read('accessToken') == null
          ? '/'
          : kIsWeb
              ? '/index'
              : '/home',
      getPages: [
        if (!kIsWeb) GetPage(name: '/home', page: () => loadPage(HomePage())),
        if (kIsWeb)
          GetPage(name: '/index', page: () => loadPage(DashboardPage())),
        GetPage(name: '/', page: () => SignInPage()),
        GetPage(
          name: '/notifications',
          page: () => loadPage(NotificationPage()),
          // middlewares: [
          //   AuthMiddleware(
          //     requiredGrups: [
          //       'NotificationService',
          //     ],
          //   ),
          // ],
        ),
        GetPage(
          name: '/employee-types',
          page: () => loadPage(EmployeeTypePage()),
          middlewares: [
            AuthMiddleware(
              requiredGrups: [
                'EmployeeTypeService',
              ],
            ),
          ],
        ),
        GetPage(
          name: '/employee',
          page: () => loadPage(EmployeePage()),
          middlewares: [
            AuthMiddleware(
              requiredGrups: [
                'EmployeeService',
              ],
            ),
          ],
        ),
        GetPage(
          name: '/employee-roles',
          page: () => loadPage(EmployeeRolePage()),
        ),
        GetPage(
          name: '/roles',
          page: () => loadPage(RolePage()),
          middlewares: [
            AuthMiddleware(
              requiredGrups: [
                'UserRoleService',
              ],
            ),
          ],
        ),
        GetPage(
          name: '/departments',
          page: () => loadPage(DepartmentPage()),
          middlewares: [
            AuthMiddleware(
              requiredGrups: [
                'DepartmentService',
              ],
            ),
          ],
        ),
        GetPage(
          name: '/company',
          page: () => loadPage(CompanyPage()),
          middlewares: [
            AuthMiddleware(
              requiredGrups: [
                'CompanyService',
              ],
            ),
          ],
        ),
        GetPage(
          name: '/qrcode-list',
          page: () => loadPage(QRCodeListPage()),
          middlewares: [
            AuthMiddleware(
              requiredGrups: [
                'QRCodeSettingService',
              ],
            ),
          ],
        ),
        GetPage(
          name: '/events',
          page: () => loadPage(EventsEntryExitPage()),
          middlewares: [
            AuthMiddleware(
              requiredGrups: [
                'WorkEntryExitEventExceptionService',
              ],
            ),
          ],
        ),
        GetPage(
          name: '/shifts',
          page: () => loadPage(ShiftCalendarPage()),
          middlewares: [
            AuthMiddleware(
              requiredGrups: [
                'ShiftService',
              ],
            ),
          ],
        ),
        GetPage(
          name: '/shift-employee',
          page: () => loadPage(ShiftEmployeePage()),
          middlewares: [
            AuthMiddleware(
              requiredGrups: [
                'EmployeeService',
                'ShiftService',
                'ShiftDayService',
                'EmployeeShiftDayOffService',
              ],
            ),
          ],
        ),
        GetPage(
          name: '/shift-plan',
          page: () => loadPage(ShiftPlanPage()),
          middlewares: [
            AuthMiddleware(
              requiredGrups: [
                'EmployeeService',
                'ShiftService',
                'ShiftDayService',
                'EmployeeShiftDayOffService',
              ],
            ),
          ],
        ),
        GetPage(
          name: '/profile',
          page: () => loadPage(ProfilePage()),
          middlewares: [
            AuthMiddleware(
              requiredGrups: [
                'UserRoleService',
              ],
            ),
          ],
        ),
        GetPage(
          name: '/leave',
          page: () => loadPage(LeavePage()),
          middlewares: [
            AuthMiddleware(
              requiredGrups: [
                'LeaveRequestService',
              ],
            ),
          ],
        ),
        GetPage(
          name: '/company-settigs-details',
          page: () => loadPage(CompanySettingsDetailsPage()),
          middlewares: [
            AuthMiddleware(
              requiredGrups: [
                'CompanyService',
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class AuthMiddleware extends GetMiddleware {
  final List<String> requiredGrups;

  AuthMiddleware({
    required this.requiredGrups,
  });

  final box = GetStorage();

  @override
  RouteSettings? redirect(String? route) {
    List<UserRoleActionsModel> actions = getUserRoleActionsFromStorage();

    // Gerekli grupların hepsinin izinlere sahip olup olmadığını kontrol et
    final hasAllPermissions = requiredGrups
        .every((requiredGrup) => actions.any((e) => e.grup == requiredGrup));

    if (!hasAllPermissions) {
      Get.showSnackbar(
        CustomGetBar(
          textColor: AppColor.secondaryText,
          message: "Bu sayfaya erişim izniniz yok.",
          duration: const Duration(seconds: 3),
          iconData: Icons.block,
          backgroundColor: AppColor.primaryOrange,
        ),
      );
      if (route == '/index' && !hasAllPermissions) {
        box.erase();
        return const RouteSettings(name: '/');
      } else {
        return const RouteSettings(name: '/index');
      }
    }

    return null; // Erişim izni varsa yönlendirme yapma
  }

  List<UserRoleActionsModel> getUserRoleActionsFromStorage() {
    final box = GetStorage();
    List<dynamic>? jsonList = box.read('userRoleActions');
    if (jsonList != null) {
      return jsonList
          .map((item) => UserRoleActionsModel.fromJson(item))
          .toList();
    }
    return [];
  }
}

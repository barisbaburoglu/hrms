import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/widgets/edit_form_notification.dart';

import '../api/api_provider.dart';
import '../api/models/department_model.dart';
import '../api/models/notification_model.dart' as notif;

class NotificationController extends GetxController {
  final ScrollController scrollController = ScrollController();

  TextEditingController searchController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  var notifications = <notif.Notification>[].obs;

  var departments = <Department>[].obs;

  Rxn<int> departmentId = Rxn<int>();

  var filteredNotifications = <notif.Notification>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDepartments();
  }

  void fetchNotifications() async {
    try {
      var notificationModel =
          await ApiProvider().notificationService.fetchNotifications();
      notifications.value = notificationModel.notifications ?? [];
    } catch (e) {
      print("Hata: $e");
    }
  }

  void fetchDepartments() async {
    try {
      var departmentModel =
          await ApiProvider().departmentService.fetchDepartments();
      departments.value = departmentModel.departments ?? [];
      departments.add(Department(
        id: -1,
        name: "Tümü",
      ));
    } catch (e) {
      print("Hata: $e");
    }
  }

  void deleteNotification(notif.Notification notification) async {
    try {
      await ApiProvider().notificationService.deleteNotification(notification);

      fetchNotifications();
    } catch (e) {
      print("Hata: $e");
    }
  }

  void searchNotification(String query) {
    searchController.text = query;
    if (query.isEmpty) {
      filteredNotifications.value = notifications;
    } else {
      filteredNotifications.value = notifications
          .where((notification) =>
              '${notification.title?.toLowerCase()} ${notification.body?.toLowerCase()}'
                  .contains(query.toLowerCase()))
          .toList();
    }
  }

  Future<void> saveNotification({notif.Notification? notification}) async {
    try {
      if (notification == null) {
        await ApiProvider()
            .notificationService
            .createNotification(notif.Notification(
              departmentId: departmentId.value,
              title: titleController.text,
              body: bodyController.text,
            ));
      } else {
        await ApiProvider()
            .notificationService
            .updateNotification(notif.Notification(
              id: notification.id,
              departmentId: departmentId.value,
              title: titleController.text,
              body: bodyController.text,
            ));
      }
      fetchNotifications();
      Get.back();
    } catch (e) {
      print("Hata: $e");
    }
  }

  void setNotificationFields(notif.Notification notification) {
    titleController.text = notification.title ?? '';
    bodyController.text = notification.body ?? '';

    departmentId.value = notification.departmentId!;
  }

  void clearNotificationFields() {
    titleController.clear();
    bodyController.clear();

    departmentId.value = null;
  }

  void openEditPopup(String title, notif.Notification? notification) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: EditFormNotification(
          title: title,
          notification: notification,
        ),
      ),
    );
  }

  void setDepartmentId(int? id) {
    departmentId.value = id!;
  }
}

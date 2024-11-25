import 'dart:convert';

import '../models/notification_model.dart';
import 'api_service.dart';

class NotificationService {
  final ApiService apiService;

  NotificationService(this.apiService);

  Future<NotificationModel> fetchNotifications() async {
    final response = await apiService.postRequest(
        'NotificationService',
        'PostAllNotification',
        '/NotificationServices/All',
        {"orders": [], "filters": []});
    return NotificationModel.fromJson(json.decode(response.body));
  }

  Future<Notification> fetchNotificationById(int id) async {
    final response = await apiService.getRequest(
        'NotificationService', 'GetNotification', '/NotificationServices/$id');
    return Notification.fromJson(json.decode(response.body));
  }

  Future<void> createNotification(Notification notification) async {
    await apiService.postRequest('NotificationService', 'AddNotification',
        '/NotificationServices', notification.toJson());
  }

  Future<void> updateNotification(Notification notification) async {
    await apiService.putRequest('NotificationService', 'UpdateNotification',
        '/NotificationServices', notification.toJson());
  }

  Future<void> deleteNotification(Notification notification) async {
    await apiService.deleteRequest('NotificationService', 'DeleteNotification',
        '/NotificationServices?Id=${notification.id}');
  }
}

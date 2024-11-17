import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const String serverKey = "YOUR_SERVER_KEY";
  static const String fcmUrl = "https://fcm.googleapis.com/fcm/send";

  Future<void> initialize() async {
    await _firebaseMessaging.requestPermission();
    await getFCMToken();

    String? token = await _firebaseMessaging.getToken();

    // Bildirim kanalı oluştur
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.high,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Local notification ayarları
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Gelen mesajları dinle ve ekranda göster
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showInAppDialog(message);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> getFCMToken() async {
    String? token = await _firebaseMessaging.getToken();
    if (token != null) {
      print("FCM Token: $token");
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await NotificationService()._showNotification(message);
  }

  // Uygulama açıkken bildirim geldiğinde dialog gösterme
  void _showInAppDialog(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    if (notification != null) {
      Get.defaultDialog(
        title: notification.title ?? "Bildirim",
        middleText: notification.body ?? "Yeni bir bildirim aldınız",
        confirm: ElevatedButton(
          onPressed: () => Get.back(),
          child: const Text("Tamam"),
        ),
      );
    }
  }

  // Arka planda gelen bildirimleri gösterme
  Future<void> _showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
      );
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      await _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        platformChannelSpecifics,
      );
    }
  }

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}

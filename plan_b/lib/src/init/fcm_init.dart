import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';

import 'package:permission_handler/permission_handler.dart'; // 딜레이를 위해 추가

class FlutterLocalNotification {
  // 싱글톤 패턴으로 클래스 인스턴스를 생성
  FlutterLocalNotification._();
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // 초기화 메서드
  static Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/launcher_icon');

    const DarwinInitializationSettings iosInitializationSettings =
    DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // 채널 ID
      'High Importance Notifications', // 채널 이름
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    // Android에서 알림 채널 생성
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // 초기화 설정
    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    // 플러그인 초기화
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    if (Platform.isAndroid) {
      var status = await Permission.notification.status;
      if (!status.isGranted) {
        status = await Permission.notification.request();
        if (status.isGranted) {
          print('알림 권한이 부여되었습니다.');
        } else {
          print('알림 권한이 거부되었습니다.');
        }
      }
    }
  }

  // iOS 권한 요청
  static Future<void> requestNotificationPermission() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // 알림 표시 메서드
  static Future<void> showNotification(String title, String body) async {
    // 2초 딜레이 추가
    await Future.delayed(const Duration(seconds: 2));

    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'high_importance_channel', // 채널 ID
      'High Importance Notifications', // 채널 이름
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.max,
      showWhen: false,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: DarwinNotificationDetails(badgeNumber: 1),
    );

    await flutterLocalNotificationsPlugin.show(
      0, // 알림 ID
      title,
      body,
      notificationDetails,
    );
  }
}

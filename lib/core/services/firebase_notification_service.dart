import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:untitled/routes/app_routes.dart';

class FirebaseNotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    await _messaging.requestPermission();

    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
    InitializationSettings(android: androidSettings);

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        final payload = response.payload;
        if (payload != null && payload.isNotEmpty) {
          Get.toNamed(AppRoutes.carDetail, arguments: payload);
        }
      },
    );

    // Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });

    // Background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final carId = message.data['carId'];
      if (carId != null && carId.isNotEmpty) {
        Get.toNamed(AppRoutes.carDetail, arguments: carId);
      }
    });

    // ❄️ Cold start
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      final carId = initialMessage.data['carId'];
      if (carId != null && carId.isNotEmpty) {
        // Delay just to ensure GetX is ready
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.toNamed(AppRoutes.carDetail, arguments: carId);
        });
      }
    }

    final token = await _messaging.getToken();
    print('FCM Token: $token');
  }



  void _showNotification(RemoteMessage message) {
    final notification = message.notification;
    final data = message.data;

    if (notification == null) return;

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    final carId = data['carId'];

    _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      details,
      payload: carId,
    );
  }
}

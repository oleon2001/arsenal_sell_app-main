import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../config/logger.dart';

class FCMService {
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Request permission
    await FirebaseMessaging.instance.requestPermission(
      badge: true,
    );

    // Get FCM token
    final token = await FirebaseMessaging.instance.getToken();
    logger.i('FCM Token: $token');

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle notification taps
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    // Handle initial message if app opened from notification
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }
  }

  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    logger.i('Foreground message: ${message.messageId}');

    // Show local notification
    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default Channel',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title ?? 'Arsenal Sell',
      message.notification?.body ?? '',
      details,
      payload: message.data.toString(),
    );
  }

  static Future<void> _handleNotificationTap(RemoteMessage message) async {
    logger.i('Notification tapped: ${message.messageId}');

    // Handle navigation based on message data
    final data = message.data;
    if (data.containsKey('route')) {
      // Navigate to specific route
      // AppRouter.navigateTo(data['route']);
    }
  }

  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    logger.i('Background message: ${message.messageId}');
    // Handle background processing if needed
  }

  static Future<void> showLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'local_channel',
      'Local Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title,
      body,
      details,
      payload: payload,
    );
  }
}

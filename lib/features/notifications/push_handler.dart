import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/logger.dart';
import '../../data/local/preferences.dart';
import 'local_notifications.dart';

class PushNotificationHandler {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final StreamController<PushNotificationData>
      _notificationStreamController =
      StreamController<PushNotificationData>.broadcast();

  static Stream<PushNotificationData> get notificationStream =>
      _notificationStreamController.stream;

  static Future<void> initialize() async {
    try {
      // Request permission for notifications
      final settings = await _firebaseMessaging.requestPermission(
        badge: true,
      );

      logger.i(
          'Push notification permission status: ${settings.authorizationStatus}');

      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        // Get FCM token
        final token = await _firebaseMessaging.getToken();
        if (token != null) {
          logger.i('FCM Token obtained: ${token.substring(0, 20)}...');
          await _saveFCMToken(token);
        }

        // Listen for token refresh
        _firebaseMessaging.onTokenRefresh.listen(_handleTokenRefresh);

        // Handle foreground messages
        FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

        // Handle notification taps when app is in background
        FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

        // Handle notification when app is opened from terminated state
        final initialMessage = await _firebaseMessaging.getInitialMessage();
        if (initialMessage != null) {
          _handleNotificationTap(initialMessage);
        }

        logger.i('Push notification handler initialized successfully');
      } else {
        logger.w('Push notification permission denied');
      }
    } catch (e) {
      logger.e('Push notification initialization error: $e');
    }
  }

  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    try {
      logger.i('Foreground message received: ${message.messageId}');

      final notificationData = _parseNotificationData(message);

      // Add to notification stream
      _notificationStreamController.add(notificationData);

      // Show local notification
      await LocalNotificationsService().showNotification(
        id: message.hashCode,
        title: message.notification?.title ?? notificationData.title,
        body: message.notification?.body ?? notificationData.body,
        payload: jsonEncode(notificationData.toJson()),
        notificationType: notificationData.type.name,
      );

      // Handle specific notification actions
      await _handleNotificationAction(notificationData);
    } catch (e) {
      logger.e('Handle foreground message error: $e');
    }
  }

  static Future<void> _handleNotificationTap(RemoteMessage message) async {
    try {
      logger.i('Notification tapped: ${message.messageId}');

      final notificationData = _parseNotificationData(message);

      // Add to notification stream
      _notificationStreamController.add(notificationData);

      // Navigate based on notification type
      await _navigateFromNotification(notificationData);

      // Handle specific notification actions
      await _handleNotificationAction(notificationData);
    } catch (e) {
      logger.e('Handle notification tap error: $e');
    }
  }

  static Future<void> _handleTokenRefresh(String token) async {
    try {
      logger.i('FCM token refreshed');
      await _saveFCMToken(token);
    } catch (e) {
      logger.e('Handle token refresh error: $e');
    }
  }

  static Future<void> _saveFCMToken(String token) async {
    try {
      // Save token to preferences
      await AppPreferences.init();
      // TODO: Add FCM token to preferences

      // Send token to server
      await _sendTokenToServer(token);
    } catch (e) {
      logger.e('Save FCM token error: $e');
    }
  }

  static Future<void> _sendTokenToServer(String token) async {
    try {
      // TODO: Send FCM token to your backend server
      // This would typically be done through your API
      logger
          .i('FCM token would be sent to server: ${token.substring(0, 20)}...');
    } catch (e) {
      logger.e('Send token to server error: $e');
    }
  }

  static PushNotificationData _parseNotificationData(RemoteMessage message) {
    final data = message.data;

    return PushNotificationData(
      id: message.messageId ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: message.notification?.title ?? data['title'] ?? 'Arsenal Sell',
      body: message.notification?.body ?? data['body'] ?? '',
      type: _parseNotificationType(data['type']),
      priority: _parseNotificationPriority(data['priority']),
      data: data,
      receivedAt: DateTime.now(),
      imageUrl: message.notification?.android?.imageUrl ??
          message.notification?.apple?.imageUrl,
    );
  }

  static NotificationType _parseNotificationType(String? type) {
    switch (type?.toLowerCase()) {
      case 'visit_reminder':
        return NotificationType.visitReminder;
      case 'new_order':
        return NotificationType.newOrder;
      case 'order_approved':
        return NotificationType.orderApproved;
      case 'order_rejected':
        return NotificationType.orderRejected;
      case 'delivery_assigned':
        return NotificationType.deliveryAssigned;
      case 'payment_reminder':
        return NotificationType.paymentReminder;
      case 'team_message':
        return NotificationType.teamMessage;
      case 'route_updated':
        return NotificationType.routeUpdated;
      case 'promotion_alert':
        return NotificationType.promotionAlert;
      case 'system_maintenance':
        return NotificationType.systemMaintenance;
      default:
        return NotificationType.general;
    }
  }

  static NotificationPriority _parseNotificationPriority(String? priority) {
    switch (priority?.toLowerCase()) {
      case 'high':
        return NotificationPriority.high;
      case 'normal':
        return NotificationPriority.normal;
      case 'low':
        return NotificationPriority.low;
      default:
        return NotificationPriority.normal;
    }
  }

  static Future<void> _navigateFromNotification(
      PushNotificationData notification) async {
    try {
      // TODO: Get proper context for navigation
      // For now, skip navigation from push notifications
      // final context = GoRouter.of(navigatorKey.currentContext!);

      // TODO: Implement navigation when proper context is available
      logger.i(
          'Navigation requested for notification type: ${notification.type}');
    } catch (e) {
      logger.e('Navigate from notification error: $e');
    }
  }

  static Future<void> _handleNotificationAction(
      PushNotificationData notification) async {
    try {
      switch (notification.type) {
        case NotificationType.visitReminder:
          await _handleVisitReminder(notification);
          break;

        case NotificationType.newOrder:
          await _handleNewOrder(notification);
          break;

        case NotificationType.orderApproved:
          await _handleOrderApproved(notification);
          break;

        case NotificationType.orderRejected:
          await _handleOrderRejected(notification);
          break;

        case NotificationType.deliveryAssigned:
          await _handleDeliveryAssigned(notification);
          break;

        case NotificationType.paymentReminder:
          await _handlePaymentReminder(notification);
          break;

        case NotificationType.teamMessage:
          await _handleTeamMessage(notification);
          break;

        case NotificationType.routeUpdated:
          await _handleRouteUpdated(notification);
          break;

        case NotificationType.promotionAlert:
          await _handlePromotionAlert(notification);
          break;

        case NotificationType.systemMaintenance:
          await _handleSystemMaintenance(notification);
          break;

        default:
          logger.i(
              'No specific action for notification type: ${notification.type}');
          break;
      }
    } catch (e) {
      logger.e('Handle notification action error: $e');
    }
  }

  static Future<void> _handleVisitReminder(
      PushNotificationData notification) async {
    // TODO: Update visit reminder in local database
    logger.i('Handling visit reminder: ${notification.data}');
  }

  static Future<void> _handleNewOrder(PushNotificationData notification) async {
    // TODO: Refresh orders list or show order details
    logger.i('Handling new order: ${notification.data}');
  }

  static Future<void> _handleOrderApproved(
      PushNotificationData notification) async {
    // TODO: Update order status in local database
    logger.i('Handling order approved: ${notification.data}');
  }

  static Future<void> _handleOrderRejected(
      PushNotificationData notification) async {
    // TODO: Update order status and show rejection reason
    logger.i('Handling order rejected: ${notification.data}');
  }

  static Future<void> _handleDeliveryAssigned(
      PushNotificationData notification) async {
    // TODO: Refresh deliveries list and show new assignment
    logger.i('Handling delivery assigned: ${notification.data}');
  }

  static Future<void> _handlePaymentReminder(
      PushNotificationData notification) async {
    // TODO: Update payment reminders in local database
    logger.i('Handling payment reminder: ${notification.data}');
  }

  static Future<void> _handleTeamMessage(
      PushNotificationData notification) async {
    // TODO: Add message to team chat or show in messages section
    logger.i('Handling team message: ${notification.data}');
  }

  static Future<void> _handleRouteUpdated(
      PushNotificationData notification) async {
    // TODO: Refresh route information
    logger.i('Handling route updated: ${notification.data}');
  }

  static Future<void> _handlePromotionAlert(
      PushNotificationData notification) async {
    // TODO: Show promotion details or update promotions list
    logger.i('Handling promotion alert: ${notification.data}');
  }

  static Future<void> _handleSystemMaintenance(
      PushNotificationData notification) async {
    // TODO: Show maintenance notification dialog
    logger.i('Handling system maintenance: ${notification.data}');
  }

  static Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      logger.i('Subscribed to topic: $topic');
    } catch (e) {
      logger.e('Subscribe to topic error: $e');
    }
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      logger.i('Unsubscribed from topic: $topic');
    } catch (e) {
      logger.e('Unsubscribe from topic error: $e');
    }
  }

  static Future<void> subscribeToUserTopics({
    required String userId,
    required String companyId,
    required String userRole,
  }) async {
    try {
      // Subscribe to user-specific topic
      await subscribeToTopic('user_$userId');

      // Subscribe to company topic
      await subscribeToTopic('company_$companyId');

      // Subscribe to role-specific topic
      await subscribeToTopic('role_$userRole');

      // Subscribe to general topics
      await subscribeToTopic('general');
      await subscribeToTopic('announcements');

      logger.i('Subscribed to user topics for $userId');
    } catch (e) {
      logger.e('Subscribe to user topics error: $e');
    }
  }

  static Future<void> unsubscribeFromUserTopics({
    required String userId,
    required String companyId,
    required String userRole,
  }) async {
    try {
      // Unsubscribe from user-specific topic
      await unsubscribeFromTopic('user_$userId');

      // Unsubscribe from company topic
      await unsubscribeFromTopic('company_$companyId');

      // Unsubscribe from role-specific topic
      await unsubscribeFromTopic('role_$userRole');

      logger.i('Unsubscribed from user topics for $userId');
    } catch (e) {
      logger.e('Unsubscribe from user topics error: $e');
    }
  }

  static Future<void> markNotificationAsRead(String notificationId) async {
    try {
      // TODO: Mark notification as read in local database
      // and optionally send read receipt to server
      logger.i('Notification marked as read: $notificationId');
    } catch (e) {
      logger.e('Mark notification as read error: $e');
    }
  }

  static Future<void> clearAllNotifications() async {
    try {
      await LocalNotificationsService().cancelAllNotifications();
      logger.i('All notifications cleared');
    } catch (e) {
      logger.e('Clear all notifications error: $e');
    }
  }

  static void dispose() {
    _notificationStreamController.close();
  }
}

// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  logger.i('Background message received: ${message.messageId}');

  // Handle background message processing here
  // Note: This function has limited capabilities in background mode

  try {
    // You can save the notification to local storage
    // or perform other lightweight operations

    final notificationData = PushNotificationData(
      id: message.messageId ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: message.notification?.title ??
          message.data['title'] ??
          'Arsenal Sell',
      body: message.notification?.body ?? message.data['body'] ?? '',
      type: NotificationType.general,
      priority: NotificationPriority.normal,
      data: message.data,
      receivedAt: DateTime.now(),
    );

    // TODO: Save to local database if needed
  } catch (e) {
    logger.e('Background message handler error: $e');
  }
}

enum NotificationType {
  general,
  visitReminder,
  newOrder,
  orderApproved,
  orderRejected,
  deliveryAssigned,
  paymentReminder,
  teamMessage,
  routeUpdated,
  promotionAlert,
  systemMaintenance,
}

enum NotificationPriority {
  low,
  normal,
  high,
}

class PushNotificationData {
  PushNotificationData({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.priority,
    required this.data,
    required this.receivedAt,
    this.imageUrl,
    this.isRead = false,
  });

  factory PushNotificationData.fromJson(Map<String, dynamic> json) {
    return PushNotificationData(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      type: NotificationType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => NotificationType.general,
      ),
      priority: NotificationPriority.values.firstWhere(
        (e) => e.name == json['priority'],
        orElse: () => NotificationPriority.normal,
      ),
      data: Map<String, dynamic>.from(json['data'] ?? {}),
      receivedAt: DateTime.parse(json['receivedAt']),
      imageUrl: json['imageUrl'],
      isRead: json['isRead'] ?? false,
    );
  }
  final String id;
  final String title;
  final String body;
  final NotificationType type;
  final NotificationPriority priority;
  final Map<String, dynamic> data;
  final DateTime receivedAt;
  final String? imageUrl;
  final bool isRead;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
        'type': type.name,
        'priority': priority.name,
        'data': data,
        'receivedAt': receivedAt.toIso8601String(),
        'imageUrl': imageUrl,
        'isRead': isRead,
      };

  PushNotificationData copyWith({
    String? id,
    String? title,
    String? body,
    NotificationType? type,
    NotificationPriority? priority,
    Map<String, dynamic>? data,
    DateTime? receivedAt,
    String? imageUrl,
    bool? isRead,
  }) =>
      PushNotificationData(
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        type: type ?? this.type,
        priority: priority ?? this.priority,
        data: data ?? this.data,
        receivedAt: receivedAt ?? this.receivedAt,
        imageUrl: imageUrl ?? this.imageUrl,
        isRead: isRead ?? this.isRead,
      );
}

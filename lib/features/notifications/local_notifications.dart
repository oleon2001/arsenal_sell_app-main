import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../../config/logger.dart';

class LocalNotificationsService {
  factory LocalNotificationsService() => _instance;
  LocalNotificationsService._internal();
  static final LocalNotificationsService _instance =
      LocalNotificationsService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    try {
      // Initialize timezone
      tz.initializeTimeZones();

      // Android initialization settings
      const androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      // iOS initialization settings
      const iosSettings = DarwinInitializationSettings();

      // Initialization settings
      const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      // Initialize
      await _notifications.initialize(
        initSettings,
        onDidReceiveNotificationResponse: _onNotificationResponse,
      );

      // Create notification channels for Android
      await _createNotificationChannels();

      _initialized = true;
      logger.i('Local notifications initialized');
    } catch (e) {
      logger.e('Failed to initialize local notifications: $e');
    }
  }

  Future<void> _createNotificationChannels() async {
    // Visit reminders channel
    const visitChannel = AndroidNotificationChannel(
      'visit_reminders',
      'Recordatorios de Visitas',
      description: 'Notificaciones para recordar visitas programadas',
      importance: Importance.high,
    );

    // Sync notifications channel
    const syncChannel = AndroidNotificationChannel(
      'sync_notifications',
      'Sincronización',
      description: 'Notificaciones sobre el estado de sincronización',
      importance: Importance.low,
      playSound: false,
    );

    // Order notifications channel
    const orderChannel = AndroidNotificationChannel(
      'order_notifications',
      'Pedidos',
      description: 'Notificaciones sobre pedidos y entregas',
      importance: Importance.high,
    );

    // Payment reminders channel
    const paymentChannel = AndroidNotificationChannel(
      'payment_reminders',
      'Recordatorios de Cobro',
      description: 'Notificaciones para recordar cobros pendientes',
      importance: Importance.high,
    );

    // Location alerts channel
    const locationChannel = AndroidNotificationChannel(
      'location_alerts',
      'Alertas de Ubicación',
      description: 'Notificaciones sobre entrada/salida de geocercas',
      importance: Importance.high,
    );

    // Create channels
    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(visitChannel);

    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(syncChannel);

    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(orderChannel);

    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(paymentChannel);

    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(locationChannel);
  }

  void _onNotificationResponse(NotificationResponse response) {
    final payload = response.payload;
    if (payload != null) {
      logger.i('Notification tapped with payload: $payload');
      // Handle notification tap
      _handleNotificationTap(payload);
    }
  }

  void _handleNotificationTap(String payload) {
    try {
      // Parse payload and navigate accordingly
      final parts = payload.split('|');
      if (parts.length >= 2) {
        final type = parts[0];
        final id = parts[1];

        switch (type) {
          case 'visit':
            // Navigate to visit details
            break;
          case 'order':
            // Navigate to order details
            break;
          case 'payment':
            // Navigate to payment details
            break;
          case 'sync':
            // Show sync status
            break;
          default:
            logger.w('Unknown notification type: $type');
        }
      }
    } catch (e) {
      logger.e('Error handling notification tap: $e');
    }
  }

  // Visit Notifications
  Future<void> scheduleVisitReminder({
    required String visitId,
    required String customerName,
    required DateTime scheduledTime,
    required String address,
  }) async {
    try {
      const channelId = 'visit_reminders';
      final id = visitId.hashCode;

      // Schedule notification 15 minutes before visit
      final notificationTime =
          scheduledTime.subtract(const Duration(minutes: 15));

      const androidDetails = AndroidNotificationDetails(
        channelId,
        'Recordatorios de Visitas',
        channelDescription: 'Notificaciones para recordar visitas programadas',
        importance: Importance.high,
        priority: Priority.high,
        icon: 'visit_reminder',
        actions: [
          AndroidNotificationAction(
            'start_visit',
            'Iniciar Visita',
            showsUserInterface: true,
          ),
          AndroidNotificationAction(
            'reschedule',
            'Reprogramar',
            showsUserInterface: true,
          ),
        ],
      );

      const iosDetails = DarwinNotificationDetails(
        categoryIdentifier: 'visit_reminder',
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _notifications.zonedSchedule(
        id,
        'Visita Programada',
        'Visita a $customerName en 15 minutos\n$address',
        tz.TZDateTime.from(notificationTime, tz.local),
        details,
        payload: 'visit|$visitId',
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );

      logger
          .i('Visit reminder scheduled for $customerName at $notificationTime');
    } catch (e) {
      logger.e('Failed to schedule visit reminder: $e');
    }
  }

  Future<void> showVisitStartedNotification({
    required String visitId,
    required String customerName,
  }) async {
    try {
      const channelId = 'visit_reminders';
      final id = 'visit_started_$visitId'.hashCode;

      const androidDetails = AndroidNotificationDetails(
        channelId,
        'Recordatorios de Visitas',
        importance: Importance.high,
        priority: Priority.high,
        ongoing: true,
        icon: 'visit_active',
        actions: [
          AndroidNotificationAction(
            'end_visit',
            'Finalizar Visita',
            showsUserInterface: true,
          ),
        ],
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _notifications.show(
        id,
        'Visita en Progreso',
        'Visitando a $customerName',
        details,
        payload: 'visit|$visitId',
      );
    } catch (e) {
      logger.e('Failed to show visit started notification: $e');
    }
  }

  Future<void> cancelVisitNotifications(String visitId) async {
    try {
      final reminderId = visitId.hashCode;
      final activeId = 'visit_started_$visitId'.hashCode;

      await _notifications.cancel(reminderId);
      await _notifications.cancel(activeId);
    } catch (e) {
      logger.e('Failed to cancel visit notifications: $e');
    }
  }

  // Sync Notifications
  Future<void> showSyncInProgressNotification() async {
    try {
      const channelId = 'sync_notifications';
      const id = 999999; // Fixed ID for sync notifications

      const androidDetails = AndroidNotificationDetails(
        channelId,
        'Sincronización',
        importance: Importance.low,
        priority: Priority.low,
        ongoing: true,
        showProgress: true,
        maxProgress: 100,
        autoCancel: false,
        showWhen: false,
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: false,
        presentBadge: false,
        presentSound: false,
      );

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _notifications.show(
        id,
        'Sincronizando datos',
        'Enviando información al servidor...',
        details,
        payload: 'sync|progress',
      );
    } catch (e) {
      logger.e('Failed to show sync progress notification: $e');
    }
  }

  Future<void> updateSyncProgress(int progress, int total) async {
    try {
      const channelId = 'sync_notifications';
      const id = 999999;

      final progressPercentage =
          total > 0 ? (progress / total * 100).round() : 0;

      final androidDetails = AndroidNotificationDetails(
        channelId,
        'Sincronización',
        importance: Importance.low,
        priority: Priority.low,
        ongoing: true,
        showProgress: true,
        maxProgress: 100,
        progress: progressPercentage,
        autoCancel: false,
        showWhen: false,
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: false,
        presentBadge: false,
        presentSound: false,
      );

      final details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _notifications.show(
        id,
        'Sincronizando datos',
        'Progreso: $progress de $total elementos',
        details,
        payload: 'sync|progress',
      );
    } catch (e) {
      logger.e('Failed to update sync progress: $e');
    }
  }

  Future<void> showSyncCompletedNotification({
    required int syncedItems,
    required bool hasErrors,
  }) async {
    try {
      const channelId = 'sync_notifications';
      const id = 999999;

      final title = hasErrors
          ? 'Sincronización completada con errores'
          : 'Sincronización completada';
      final body = hasErrors
          ? 'Se sincronizaron $syncedItems elementos con algunos errores'
          : 'Se sincronizaron $syncedItems elementos exitosamente';

      const androidDetails = AndroidNotificationDetails(
        channelId,
        'Sincronización',
        importance: Importance.low,
        priority: Priority.low,
        timeoutAfter: 5000,
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: false,
        presentSound: false,
      );

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _notifications.show(
        id,
        title,
        body,
        details,
        payload: 'sync|completed',
      );
    } catch (e) {
      logger.e('Failed to show sync completed notification: $e');
    }
  }

  // Order Notifications
  Future<void> showOrderCreatedNotification({
    required String orderId,
    required String customerName,
    required double total,
  }) async {
    try {
      const channelId = 'order_notifications';
      final id = orderId.hashCode;

      const androidDetails = AndroidNotificationDetails(
        channelId,
        'Pedidos',
        importance: Importance.high,
        priority: Priority.high,
        icon: 'order_created',
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _notifications.show(
        id,
        'Pedido Creado',
        'Pedido para $customerName por \$${total.toStringAsFixed(2)}',
        details,
        payload: 'order|$orderId',
      );
    } catch (e) {
      logger.e('Failed to show order created notification: $e');
    }
  }

  // Payment Notifications
  Future<void> schedulePaymentReminder({
    required String paymentId,
    required String customerName,
    required double amount,
    required DateTime dueDate,
  }) async {
    try {
      const channelId = 'payment_reminders';
      final id = paymentId.hashCode;

      // Schedule notification 1 day before due date
      final notificationTime = dueDate.subtract(const Duration(days: 1));

      const androidDetails = AndroidNotificationDetails(
        channelId,
        'Recordatorios de Cobro',
        importance: Importance.high,
        priority: Priority.high,
        icon: 'payment_reminder',
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _notifications.zonedSchedule(
        id,
        'Cobro Pendiente',
        'Cobro a $customerName por \$${amount.toStringAsFixed(2)} vence mañana',
        tz.TZDateTime.from(notificationTime, tz.local),
        details,
        payload: 'payment|$paymentId',
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      logger.e('Failed to schedule payment reminder: $e');
    }
  }

  // Location Notifications
  Future<void> showGeofenceEnteredNotification({
    required String customerName,
    required String customerId,
  }) async {
    try {
      const channelId = 'location_alerts';
      final id = 'geofence_entered_$customerId'.hashCode;

      const androidDetails = AndroidNotificationDetails(
        channelId,
        'Alertas de Ubicación',
        importance: Importance.high,
        priority: Priority.high,
        icon: 'location_entered',
        actions: [
          AndroidNotificationAction(
            'start_visit',
            'Iniciar Visita',
            showsUserInterface: true,
          ),
        ],
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _notifications.show(
        id,
        'Llegaste a tu destino',
        'Estás cerca de $customerName. ¿Iniciar visita?',
        details,
        payload: 'location|$customerId',
      );
    } catch (e) {
      logger.e('Failed to show geofence entered notification: $e');
    }
  }

  // General utility methods
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    String? notificationType,
  }) async {
    try {
      const androidDetails = AndroidNotificationDetails(
        'general',
        'General Notifications',
        importance: Importance.high,
        priority: Priority.high,
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _notifications.show(id, title, body, details, payload: payload);
    } catch (e) {
      logger.e('Failed to show notification: $e');
    }
  }

  Future<void> cancelNotification(int id) async {
    try {
      await _notifications.cancel(id);
    } catch (e) {
      logger.e('Failed to cancel notification $id: $e');
    }
  }

  Future<void> cancelAllNotifications() async {
    try {
      await _notifications.cancelAll();
    } catch (e) {
      logger.e('Failed to cancel all notifications: $e');
    }
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    try {
      return await _notifications.pendingNotificationRequests();
    } catch (e) {
      logger.e('Failed to get pending notifications: $e');
      return [];
    }
  }

  Future<bool> hasPermission() async {
    try {
      final androidImpl = _notifications.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      if (androidImpl != null) {
        return await androidImpl.areNotificationsEnabled() ?? false;
      }

      // For iOS, notifications are enabled by default during initialization
      return true;
    } catch (e) {
      logger.e('Failed to check notification permission: $e');
      return false;
    }
  }

  Future<bool> requestPermission() async {
    try {
      final androidImpl = _notifications.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      if (androidImpl != null) {
        return await androidImpl.requestNotificationsPermission() ?? false;
      }

      return true;
    } catch (e) {
      logger.e('Failed to request notification permission: $e');
      return false;
    }
  }
}

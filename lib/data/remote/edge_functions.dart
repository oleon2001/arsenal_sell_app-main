import 'package:supabase_flutter/supabase_flutter.dart';

import '../../config/logger.dart';

class EdgeFunctionsService {
  final SupabaseClient _client = Supabase.instance.client;

  /// Send visit summary email
  Future<bool> sendVisitEmail({
    required String visitId,
    required String customerEmail,
    required String customerName,
    required String userFullName,
    required DateTime visitDate,
    String? notes,
    List<String>? photoUrls,
    String? signatureUrl,
  }) async {
    try {
      final response = await _client.functions.invoke(
        'send-email',
        body: {
          'type': 'visit_summary',
          'data': {
            'visitId': visitId,
            'customerEmail': customerEmail,
            'customerName': customerName,
            'userFullName': userFullName,
            'visitDate': visitDate.toIso8601String(),
            'notes': notes,
            'photoUrls': photoUrls,
            'signatureUrl': signatureUrl,
          }
        },
      );

      return response.status == 200;
    } catch (e) {
      logger.e('Send visit email error: $e');
      return false;
    }
  }

  /// Send order confirmation email
  Future<bool> sendOrderConfirmationEmail({
    required String orderId,
    required String customerEmail,
    required String customerName,
    required double total,
    required List<Map<String, dynamic>> items,
  }) async {
    try {
      final response = await _client.functions.invoke(
        'send-email',
        body: {
          'type': 'order_confirmation',
          'data': {
            'orderId': orderId,
            'customerEmail': customerEmail,
            'customerName': customerName,
            'total': total,
            'items': items,
          }
        },
      );

      return response.status == 200;
    } catch (e) {
      logger.e('Send order confirmation email error: $e');
      return false;
    }
  }

  /// Send payment receipt email
  Future<bool> sendPaymentReceiptEmail({
    required String paymentId,
    required String customerEmail,
    required String customerName,
    required double amount,
    required String method,
    required DateTime paidAt,
  }) async {
    try {
      final response = await _client.functions.invoke(
        'send-email',
        body: {
          'type': 'payment_receipt',
          'data': {
            'paymentId': paymentId,
            'customerEmail': customerEmail,
            'customerName': customerName,
            'amount': amount,
            'method': method,
            'paidAt': paidAt.toIso8601String(),
          }
        },
      );

      return response.status == 200;
    } catch (e) {
      logger.e('Send payment receipt email error: $e');
      return false;
    }
  }

  /// Generate daily activity report
  Future<Map<String, dynamic>?> generateDailyReport({
    required String userId,
    required DateTime date,
  }) async {
    try {
      final response = await _client.functions.invoke(
        'generate-report',
        body: {
          'type': 'daily_activity',
          'userId': userId,
          'date': date.toIso8601String(),
        },
      );

      if (response.status == 200) {
        return response.data as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      logger.e('Generate daily report error: $e');
      return null;
    }
  }

  /// Generate weekly report
  Future<Map<String, dynamic>?> generateWeeklyReport({
    required String userId,
    required DateTime weekStart,
  }) async {
    try {
      final response = await _client.functions.invoke(
        'generate-report',
        body: {
          'type': 'weekly_activity',
          'userId': userId,
          'weekStart': weekStart.toIso8601String(),
        },
      );

      if (response.status == 200) {
        return response.data as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      logger.e('Generate weekly report error: $e');
      return null;
    }
  }

  /// Generate team performance report
  Future<Map<String, dynamic>?> generateTeamReport({
    required String companyId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final response = await _client.functions.invoke(
        'generate-report',
        body: {
          'type': 'team_performance',
          'companyId': companyId,
          'startDate': startDate.toIso8601String(),
          'endDate': endDate.toIso8601String(),
        },
      );

      if (response.status == 200) {
        return response.data as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      logger.e('Generate team report error: $e');
      return null;
    }
  }

  /// Validate geofence
  Future<bool> validateGeofence({
    required double currentLat,
    required double currentLng,
    required double targetLat,
    required double targetLng,
    required double radiusM,
  }) async {
    try {
      final response = await _client.functions.invoke(
        'validate-geofence',
        body: {
          'currentLat': currentLat,
          'currentLng': currentLng,
          'targetLat': targetLat,
          'targetLng': targetLng,
          'radiusM': radiusM,
        },
      );

      if (response.status == 200) {
        return response.data['isWithinGeofence'] ?? false;
      }
      return false;
    } catch (e) {
      logger.e('Validate geofence error: $e');
      return false;
    }
  }

  /// Calculate route distance and time
  Future<Map<String, dynamic>?> calculateRouteDistance({
    required List<Map<String, double>> waypoints,
  }) async {
    try {
      final response = await _client.functions.invoke(
        'calculate-distance',
        body: {
          'waypoints': waypoints,
        },
      );

      if (response.status == 200) {
        return response.data as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      logger.e('Calculate route distance error: $e');
      return null;
    }
  }

  /// Sync offline data
  Future<bool> syncOfflineData({
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _client.functions.invoke(
        'sync-data',
        body: data,
      );

      return response.status == 200;
    } catch (e) {
      logger.e('Sync offline data error: $e');
      return false;
    }
  }

  /// Apply promotions to order
  Future<Map<String, dynamic>?> applyPromotions({
    required String orderId,
    required List<Map<String, dynamic>> items,
    String? customerCode,
  }) async {
    try {
      final response = await _client.functions.invoke(
        'apply-promotions',
        body: {
          'orderId': orderId,
          'items': items,
          'customerCode': customerCode,
        },
      );

      if (response.status == 200) {
        return response.data as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      logger.e('Apply promotions error: $e');
      return null;
    }
  }

  /// Validate customer credit
  Future<Map<String, dynamic>?> validateCustomerCredit({
    required String customerId,
    required double orderAmount,
  }) async {
    try {
      final response = await _client.functions.invoke(
        'validate-credit',
        body: {
          'customerId': customerId,
          'orderAmount': orderAmount,
        },
      );

      if (response.status == 200) {
        return response.data as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      logger.e('Validate customer credit error: $e');
      return null;
    }
  }

  /// Send notification to team
  Future<bool> sendTeamNotification({
    required String companyId,
    required String title,
    required String message,
    String? targetRole,
    List<String>? targetUserIds,
  }) async {
    try {
      final response = await _client.functions.invoke(
        'send-notification',
        body: {
          'companyId': companyId,
          'title': title,
          'message': message,
          'targetRole': targetRole,
          'targetUserIds': targetUserIds,
        },
      );

      return response.status == 200;
    } catch (e) {
      logger.e('Send team notification error: $e');
      return false;
    }
  }

  /// Generate invoice PDF
  Future<String?> generateInvoicePdf({
    required String orderId,
    required Map<String, dynamic> orderData,
    required Map<String, dynamic> customerData,
    required Map<String, dynamic> companyData,
  }) async {
    try {
      final response = await _client.functions.invoke(
        'generate-invoice',
        body: {
          'orderId': orderId,
          'orderData': orderData,
          'customerData': customerData,
          'companyData': companyData,
        },
      );

      if (response.status == 200) {
        return response.data['pdfUrl'] as String?;
      }
      return null;
    } catch (e) {
      logger.e('Generate invoice PDF error: $e');
      return null;
    }
  }

  /// Process bulk data import
  Future<Map<String, dynamic>?> importBulkData({
    required String dataType,
    required List<Map<String, dynamic>> data,
    required String companyId,
  }) async {
    try {
      final response = await _client.functions.invoke(
        'import-data',
        body: {
          'dataType': dataType,
          'data': data,
          'companyId': companyId,
        },
      );

      if (response.status == 200) {
        return response.data as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      logger.e('Import bulk data error: $e');
      return null;
    }
  }

  /// Backup user data
  Future<bool> backupUserData({
    required String userId,
    required String companyId,
  }) async {
    try {
      final response = await _client.functions.invoke(
        'backup-data',
        body: {
          'userId': userId,
          'companyId': companyId,
        },
      );

      return response.status == 200;
    } catch (e) {
      logger.e('Backup user data error: $e');
      return false;
    }
  }

  /// Clean up old data
  Future<bool> cleanupOldData({
    required String companyId,
    int retentionDays = 90,
  }) async {
    try {
      final response = await _client.functions.invoke(
        'cleanup-data',
        body: {
          'companyId': companyId,
          'retentionDays': retentionDays,
        },
      );

      return response.status == 200;
    } catch (e) {
      logger.e('Cleanup old data error: $e');
      return false;
    }
  }
}

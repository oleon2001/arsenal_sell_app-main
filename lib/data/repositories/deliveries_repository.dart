import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/sales/order.dart';
import '../local/drift/db.dart';
import '../remote/supabase_client.dart';
import '../../config/logger.dart';

enum DeliveryStatus { pending, partial, delivered, rejected }

class DeliveryModel {
  DeliveryModel({
    required this.id,
    required this.orderId,
    required this.status,
    this.deliveredAt,
    this.notes,
    this.order,
  });
  final String id;
  final String orderId;
  final DeliveryStatus status;
  final DateTime? deliveredAt;
  final String? notes;
  final Order? order;
}

class DeliveriesRepository {
  final DatabaseHelper _db = DatabaseHelper.instance;
  final SupabaseService _supabase = SupabaseService();

  Future<List<DeliveryModel>> getDeliveries({bool forceSync = false}) async {
    try {
      final connectivity = await Connectivity().checkConnectivity();
      final isOnline = connectivity != ConnectivityResult.none;

      if (isOnline && forceSync) {
        await _syncDeliveriesFromServer();
      }

      // For now, return mock data
      return [
        DeliveryModel(
          id: '00000000-0000-0000-0000-000000000001',
          orderId: '00000000-0000-0000-0000-000000000002',
          status: DeliveryStatus.pending,
        ),
        DeliveryModel(
          id: '00000000-0000-0000-0000-000000000003',
          orderId: '00000000-0000-0000-0000-000000000004',
          status: DeliveryStatus.delivered,
          deliveredAt: DateTime.now().subtract(const Duration(hours: 2)),
        ),
      ];
    } catch (e) {
      logger.e('Get deliveries error: $e');
      return [];
    }
  }

  Future<DeliveryModel> confirmDelivery(
    String deliveryId,
    DeliveryStatus status,
    String? notes,
  ) async {
    try {
      // TODO: Implement delivery confirmation
      final delivery = DeliveryModel(
        id: deliveryId,
        orderId: 'order_id',
        status: status,
        deliveredAt: status == DeliveryStatus.delivered ? DateTime.now() : null,
        notes: notes,
      );

      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity != ConnectivityResult.none) {
        await _syncDeliveryToServer(delivery);
      }

      return delivery;
    } catch (e) {
      logger.e('Confirm delivery error: $e');
      rethrow;
    }
  }

  Future<void> _syncDeliveriesFromServer() async {
    try {
      // TODO: Implement sync from server
    } catch (e) {
      logger.e('Sync deliveries from server error: $e');
    }
  }

  Future<void> _syncDeliveryToServer(DeliveryModel delivery) async {
    try {
      // TODO: Implement sync to server
    } catch (e) {
      logger.e('Sync delivery to server error: $e');
    }
  }
}

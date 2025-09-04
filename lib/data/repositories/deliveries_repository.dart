import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:uuid/uuid.dart';

import '../../config/logger.dart';
import '../local/drift/db.dart';
import '../models/sales/delivery.dart';
import '../remote/supabase_client.dart';

class DeliveriesRepository {
  final DatabaseHelper _db = DatabaseHelper.instance;
  final SupabaseService _supabase = SupabaseService();
  final _uuid = const Uuid();

  Future<List<Delivery>> getDeliveries({bool forceSync = false}) async {
    try {
      final connectivity = await Connectivity().checkConnectivity();
      final isOnline = connectivity != ConnectivityResult.none;

      if (isOnline && forceSync) {
        await _syncDeliveriesFromServer();
      }

      // Get deliveries from local database
      final deliveryEntities = await _db.getAllDeliveries();

      return deliveryEntities
          .map((entity) => Delivery(
                id: entity.id,
                orderId: entity.orderId,
                status: _mapDeliveryStatus(entity.status),
                deliveredAt: entity.deliveredAt,
                notes: entity.notes,
              ))
          .toList();
    } catch (e) {
      logger.e('Get deliveries error: $e');

      // If it's a table not found error, try to initialize the database
      if (e.toString().contains('no such table: deliveries')) {
        logger.w(
            'Deliveries table not found, attempting to initialize database...');
        try {
          await _db.initialize();
          // Retry the operation
          final deliveryEntities = await _db.getAllDeliveries();
          return deliveryEntities
              .map((entity) => Delivery(
                    id: entity.id,
                    orderId: entity.orderId,
                    status: _mapDeliveryStatus(entity.status),
                    deliveredAt: entity.deliveredAt,
                    notes: entity.notes,
                  ))
              .toList();
        } catch (retryError) {
          logger.e('Retry after database initialization failed: $retryError');
        }
      }

      return [];
    }
  }

  Future<List<Delivery>> getDeliveriesByStatus(DeliveryStatus status) async {
    try {
      final statusString = _mapDeliveryStatusToString(status);
      final deliveryEntities = await _db.getDeliveriesByStatus(statusString);

      return deliveryEntities
          .map((entity) => Delivery(
                id: entity.id,
                orderId: entity.orderId,
                status: _mapDeliveryStatus(entity.status),
                deliveredAt: entity.deliveredAt,
                notes: entity.notes,
              ))
          .toList();
    } catch (e) {
      logger.e('Get deliveries by status error: $e');
      return [];
    }
  }

  Future<List<Delivery>> getDeliveriesByCustomer(String customerId) async {
    try {
      final deliveryEntities = await _db.getDeliveriesByCustomer(customerId);

      return deliveryEntities
          .map((entity) => Delivery(
                id: entity.id,
                orderId: entity.orderId,
                status: _mapDeliveryStatus(entity.status),
                deliveredAt: entity.deliveredAt,
                notes: entity.notes,
              ))
          .toList();
    } catch (e) {
      logger.e('Get deliveries by customer error: $e');
      return [];
    }
  }

  Future<Delivery> confirmDelivery(
    String deliveryId,
    DeliveryStatus status,
    String? notes,
  ) async {
    try {
      // Update delivery status in local database
      await _db.updateDeliveryStatus(
          deliveryId, _mapDeliveryStatusToString(status));

      // Get updated delivery
      final deliveryEntity = await _db.getDeliveryById(deliveryId);
      if (deliveryEntity == null) {
        throw Exception('Delivery not found');
      }

      final delivery = Delivery(
        id: deliveryEntity.id,
        orderId: deliveryEntity.orderId,
        status: _mapDeliveryStatus(deliveryEntity.status),
        deliveredAt: status == DeliveryStatus.delivered
            ? DateTime.now()
            : deliveryEntity.deliveredAt,
        notes: notes ?? deliveryEntity.notes,
      );

      // Sync to server if online
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

  Future<Delivery> createDeliveryFromOrder(
      String orderId, String customerId) async {
    try {
      final deliveryId = _uuid.v4();
      final now = DateTime.now();

      final deliveryEntity = DeliveryEntity(
        id: deliveryId,
        companyId: 'current_company_id', // Will be replaced during sync
        orderId: orderId,
        customerId: customerId,
        userId: 'current_user_id', // Will be replaced during sync
        status: 'PENDING',
        createdAt: now,
        needsSync: true,
      );

      await _db.insertDelivery(deliveryEntity);

      return Delivery(
        id: deliveryId,
        orderId: orderId,
        status: DeliveryStatus.pending,
        deliveredAt: null,
        notes: null,
      );
    } catch (e) {
      logger.e('Create delivery from order error: $e');
      rethrow;
    }
  }

  Future<void> _syncDeliveriesFromServer() async {
    try {
      // TODO: Implement sync from server when Supabase service is ready
      logger.i('Sync deliveries from server - not implemented yet');
    } catch (e) {
      logger.e('Sync deliveries from server error: $e');
    }
  }

  Future<void> _syncDeliveryToServer(Delivery delivery) async {
    try {
      // TODO: Implement sync to server when Supabase service is ready
      logger.i('Sync delivery to server - not implemented yet');
    } catch (e) {
      logger.e('Sync delivery to server error: $e');
    }
  }

  // Helper methods for status mapping
  DeliveryStatus _mapDeliveryStatus(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return DeliveryStatus.pending;
      case 'PARTIAL':
        return DeliveryStatus.partial;
      case 'DELIVERED':
        return DeliveryStatus.delivered;
      case 'REJECTED':
        return DeliveryStatus.rejected;
      default:
        return DeliveryStatus.pending;
    }
  }

  String _mapDeliveryStatusToString(DeliveryStatus status) {
    switch (status) {
      case DeliveryStatus.pending:
        return 'PENDING';
      case DeliveryStatus.partial:
        return 'PARTIAL';
      case DeliveryStatus.delivered:
        return 'DELIVERED';
      case DeliveryStatus.rejected:
        return 'REJECTED';
    }
  }
}

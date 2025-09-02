import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/sales/order.dart';
import '../models/sales/product.dart';
import '../local/drift/db.dart';
import '../remote/supabase_client.dart';
import '../../config/logger.dart';

class OrdersRepository {
  final DatabaseHelper _db = DatabaseHelper.instance;
  final SupabaseService _supabase = SupabaseService();

  Future<List<Order>> getOrders({bool forceSync = false}) async {
    try {
      final connectivity = await Connectivity().checkConnectivity();
      final isOnline = connectivity != ConnectivityResult.none;

      if (isOnline && forceSync) {
        await _syncOrdersFromServer();
      }

      // TODO: Implement getAllOrders in DatabaseHelper
      return <Order>[];
    } catch (e) {
      logger.e('Get orders error: $e');
      rethrow;
    }
  }

  Future<Order> createOrder(Order order) async {
    try {
      // Save locally first
      final entity = _modelToEntity(order);
      await _db.insertOrder(entity);

      // Save order items
      final itemEntities = order.items
          .map((item) => OrderItemEntity(
                id: item.id,
                orderId: order.id,
                productId: item.productId,
                qty: item.qty,
                price: item.price,
                discount: item.discount,
                total: item.total,
              ))
          .toList();

      await _db.insertOrderItems(itemEntities);

      // Try to sync immediately if online
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity != ConnectivityResult.none) {
        await _syncOrderToServer(order);
      }

      return order;
    } catch (e) {
      logger.e('Create order error: $e');
      rethrow;
    }
  }

  Future<List<Product>> getProducts() async {
    try {
      final entities = await _db.getAllProducts();
      return entities
          .map((entity) => Product(
                id: entity.id,
                companyId: entity.companyId,
                sku: entity.sku,
                name: entity.name,
                unit: entity.unit,
                tax: entity.tax,
                active: entity.active,
                createdAt: entity.createdAt,
              ))
          .toList();
    } catch (e) {
      logger.e('Get products error: $e');
      return [];
    }
  }

  Future<void> syncPendingOrders() async {
    try {
      final pendingOrders = await _db.getPendingSyncOrders();

      for (final entity in pendingOrders) {
        final order = _entityToModel(entity);
        await _syncOrderToServer(order);
        // TODO: Implement markOrderSynced in DatabaseHelper
      }
    } catch (e) {
      logger.e('Sync pending orders error: $e');
    }
  }

  Future<void> _syncOrdersFromServer() async {
    try {
      // TODO: Implement getOrders in SupabaseService and insertOrders in DatabaseHelper
    } catch (e) {
      logger.e('Sync orders from server error: $e');
    }
  }

  Future<void> _syncOrderToServer(Order order) async {
    try {
      await _supabase.createOrder(order);
      // Mark as synced in local DB
      final entity = _modelToEntity(order);
      await _db.insertOrder(entity);
    } catch (e) {
      logger.e('Sync order to server error: $e');
    }
  }

  Order _entityToModel(OrderEntity entity) => Order(
        id: entity.id,
        companyId: entity.companyId,
        customerId: entity.customerId,
        userId: entity.userId,
        priceListId: entity.priceListId,
        status: _stringToOrderStatus(entity.status),
        subtotal: entity.subtotal,
        taxTotal: entity.taxTotal,
        discountTotal: entity.discountTotal,
        grandTotal: entity.grandTotal,
        createdAt: entity.createdAt,
      );

  OrderEntity _modelToEntity(Order model) => OrderEntity(
        id: model.id,
        companyId: model.companyId,
        customerId: model.customerId,
        userId: model.userId,
        priceListId: model.priceListId,
        status: model.status.name.toUpperCase(),
        subtotal: model.subtotal,
        taxTotal: model.taxTotal,
        discountTotal: model.discountTotal,
        grandTotal: model.grandTotal,
        createdAt: model.createdAt,
        needsSync: true,
      );

  OrderStatus _stringToOrderStatus(String status) {
    switch (status.toUpperCase()) {
      case 'DRAFT':
        return OrderStatus.draft;
      case 'SENT':
        return OrderStatus.sent;
      case 'APPROVED':
        return OrderStatus.approved;
      case 'REJECTED':
        return OrderStatus.rejected;
      case 'DELIVERED':
        return OrderStatus.delivered;
      case 'CANCELLED':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.draft;
    }
  }
}

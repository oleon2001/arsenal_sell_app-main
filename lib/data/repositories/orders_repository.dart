import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/sales/order.dart';
import '../models/sales/product.dart';
import '../models/customers/customer.dart';
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

  /// Obtiene órdenes de un cliente específico
  Future<List<Order>> getCustomerOrders(String customerId) async {
    try {
      final orderEntities = await _db.getOrdersByCustomer(customerId);
      return orderEntities.map(_entityToModel).toList();
    } catch (e) {
      logger.e('Get customer orders error: $e');
      return [];
    }
  }

  /// Obtiene una orden específica por ID
  Future<Order?> getOrderById(String orderId) async {
    try {
      final orderEntity = await _db.getOrderById(orderId);
      if (orderEntity != null) {
        final order = _entityToModel(orderEntity);

        // Obtener items de la orden
        final orderItems = await _db.getOrderItems(orderId);
        final items = orderItems.map(_orderItemEntityToModel).toList();

        // Obtener información del cliente
        if (order.customerId != null) {
          final customer = await _getCustomerInfo(order.customerId!);
          if (customer != null) {
            // Crear nueva instancia de Order con los datos actualizados
            return Order(
              id: order.id,
              companyId: order.companyId,
              customerId: order.customerId,
              userId: order.userId,
              priceListId: order.priceListId,
              status: order.status,
              subtotal: order.subtotal,
              taxTotal: order.taxTotal,
              discountTotal: order.discountTotal,
              grandTotal: order.grandTotal,
              createdAt: order.createdAt,
              customer: customer,
              items: items,
            );
          }
        }

        // Crear nueva instancia de Order con los items
        return Order(
          id: order.id,
          companyId: order.companyId,
          customerId: order.customerId,
          userId: order.userId,
          priceListId: order.priceListId,
          status: order.status,
          subtotal: order.subtotal,
          taxTotal: order.taxTotal,
          discountTotal: order.discountTotal,
          grandTotal: order.grandTotal,
          createdAt: order.createdAt,
          customer: order.customer,
          items: items,
        );
      }
      return null;
    } catch (e) {
      logger.e('Get order by ID error: $e');
      return null;
    }
  }

  /// Obtiene información del cliente
  Future<Customer?> _getCustomerInfo(String customerId) async {
    try {
      final customerEntity = await _db.getCustomerById(customerId);
      if (customerEntity != null) {
        return Customer(
          id: customerEntity.id,
          companyId: customerEntity.companyId,
          code: customerEntity.code,
          name: customerEntity.name,
          email: customerEntity.email,
          phone: customerEntity.phone,
          address: customerEntity.address,
          latitude: customerEntity.latitude,
          longitude: customerEntity.longitude,
          geoAccuracyM: customerEntity.geoAccuracyM,
          createdBy: customerEntity.createdBy,
          createdAt: customerEntity.createdAt,
          updatedAt: customerEntity.updatedAt,
        );
      }
      return null;
    } catch (e) {
      logger.e('Get customer info error: $e');
      return null;
    }
  }

  /// Actualiza el estado de una orden
  Future<bool> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    try {
      await _db.updateOrderStatus(orderId, newStatus.name.toUpperCase());

      // Intentar sincronizar con el servidor si hay conexión
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity != ConnectivityResult.none) {
        // TODO: Implementar updateOrderStatus en SupabaseService
        // await _supabase.updateOrderStatus(orderId, newStatus);
      }

      return true;
    } catch (e) {
      logger.e('Update order status error: $e');
      return false;
    }
  }

  /// Elimina una orden
  Future<bool> deleteOrder(String orderId) async {
    try {
      // Eliminar items primero
      await _db.deleteOrderItems(orderId);

      // Eliminar orden
      await _db.deleteOrder(orderId);

      // Intentar sincronizar con el servidor si hay conexión
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity != ConnectivityResult.none) {
        // TODO: Implementar deleteOrder en SupabaseService
        // await _supabase.deleteOrder(orderId);
      }

      return true;
    } catch (e) {
      logger.e('Delete order error: $e');
      return false;
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

  OrderItem _orderItemEntityToModel(OrderItemEntity entity) => OrderItem(
        id: entity.id,
        orderId: entity.orderId,
        productId: entity.productId,
        qty: entity.qty,
        price: entity.price,
        discount: entity.discount,
        total: entity.total,
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

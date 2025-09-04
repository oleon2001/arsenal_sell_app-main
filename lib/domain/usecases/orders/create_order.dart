import '../../../data/models/sales/order.dart';
import '../../../data/models/sales/product.dart';
import '../../../data/repositories/orders_repository.dart';
import '../../../config/logger.dart';

class CreateOrderUseCase {
  CreateOrderUseCase(this._repository);
  final OrdersRepository _repository;

  Future<Order> execute({
    required String customerId,
    required String userId,
    required List<OrderItemData> items,
    String? priceListId,
    String? notes,
  }) async {
    try {
      // Validate input
      if (items.isEmpty) {
        throw Exception('El pedido debe tener al menos un producto');
      }

      // Create order items
      final orderItems = <OrderItem>[];
      double subtotal = 0;
      double taxTotal = 0;
      double discountTotal = 0;

      for (final itemData in items) {
        final itemTotal = itemData.quantity * itemData.price;
        final itemDiscount = itemData.discount ?? 0;
        final itemTax =
            (itemTotal - itemDiscount) * (itemData.taxRate ?? 0) / 100;

        final orderItem = OrderItem(
          id: DateTime.now().millisecondsSinceEpoch.toString() +
              orderItems.length.toString(),
          orderId: '', // Will be set after order creation
          productId: itemData.productId,
          qty: itemData.quantity,
          price: itemData.price,
          discount: itemDiscount,
          total: itemTotal - itemDiscount + itemTax,
          product: itemData.product,
        );

        orderItems.add(orderItem);
        subtotal += itemTotal;
        discountTotal += itemDiscount;
        taxTotal += itemTax;
      }

      final grandTotal = subtotal + taxTotal - discountTotal;

      // Create order
      final orderId = DateTime.now().millisecondsSinceEpoch.toString();

      // Update order items with order ID
      final updatedItems = orderItems
          .map((item) => OrderItem(
                id: item.id,
                orderId: orderId,
                productId: item.productId,
                qty: item.qty,
                price: item.price,
                discount: item.discount,
                total: item.total,
                product: item.product,
              ))
          .toList();

      final order = Order(
        id: orderId,
        companyId: 'current_company_id', // TODO: Get from auth service
        customerId: customerId,
        userId: userId,
        priceListId: priceListId,
        subtotal: subtotal,
        taxTotal: taxTotal,
        discountTotal: discountTotal,
        grandTotal: grandTotal,
        createdAt: DateTime.now(),
        items: updatedItems,
      );

      // Save order
      final createdOrder = await _repository.createOrder(order);

      logger.i('Order created successfully: ${createdOrder.id}');
      return createdOrder;
    } catch (e) {
      logger.e('Create order error: $e');
      rethrow;
    }
  }
}

class OrderItemData {
  OrderItemData({
    required this.productId,
    this.product,
    required this.quantity,
    required this.price,
    this.discount,
    this.taxRate,
  });
  final String productId;
  final Product? product;
  final double quantity;
  final double price;
  final double? discount;
  final double? taxRate;
}

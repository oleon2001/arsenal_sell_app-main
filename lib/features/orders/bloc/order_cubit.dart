import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/sales/order.dart';
import '../../../data/models/sales/product.dart';
import '../../../data/repositories/orders_repository.dart';
import '../../../config/logger.dart';

part 'order_state.dart';
part 'order_cubit.freezed.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this._repository) : super(const OrderState.initial());
  final OrdersRepository _repository;

  void createNewOrder(String customerId) {
    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      companyId: 'current_company_id', // TODO: Get from auth
      customerId: customerId,
      status: OrderStatus.draft,
      items: [],
    );

    emit(OrderState.editing(order));
  }

  void addItem(Product product, double quantity, double price) {
    final currentState = state;
    if (currentState is OrderEditing) {
      final newItem = OrderItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        orderId: currentState.order.id,
        productId: product.id,
        qty: quantity,
        price: price,
        total: quantity * price,
        product: product,
      );

      final updatedItems = [...currentState.order.items, newItem];
      final updatedOrder = Order(
        id: currentState.order.id,
        companyId: currentState.order.companyId,
        customerId: currentState.order.customerId,
        userId: currentState.order.userId,
        priceListId: currentState.order.priceListId,
        status: currentState.order.status,
        subtotal: currentState.order.subtotal,
        taxTotal: currentState.order.taxTotal,
        discountTotal: currentState.order.discountTotal,
        grandTotal: currentState.order.grandTotal,
        createdAt: currentState.order.createdAt,
        customer: currentState.order.customer,
        items: updatedItems,
      );
      final recalculatedOrder = _recalculateOrderTotals(updatedOrder);

      emit(OrderState.editing(recalculatedOrder));
    }
  }

  void removeItem(String itemId) {
    final currentState = state;
    if (currentState is OrderEditing) {
      final updatedItems =
          currentState.order.items.where((item) => item.id != itemId).toList();

      final updatedOrder = Order(
        id: currentState.order.id,
        companyId: currentState.order.companyId,
        customerId: currentState.order.customerId,
        userId: currentState.order.userId,
        priceListId: currentState.order.priceListId,
        status: currentState.order.status,
        subtotal: currentState.order.subtotal,
        taxTotal: currentState.order.taxTotal,
        discountTotal: currentState.order.discountTotal,
        grandTotal: currentState.order.grandTotal,
        createdAt: currentState.order.createdAt,
        customer: currentState.order.customer,
        items: updatedItems,
      );
      final recalculatedOrder = _recalculateOrderTotals(updatedOrder);

      emit(OrderState.editing(recalculatedOrder));
    }
  }

  void updateItemQuantity(String itemId, double newQuantity) {
    final currentState = state;
    if (currentState is OrderEditing) {
      final updatedItems = currentState.order.items.map((item) {
        if (item.id == itemId) {
          return OrderItem(
            id: item.id,
            orderId: item.orderId,
            productId: item.productId,
            qty: newQuantity,
            price: item.price,
            discount: item.discount,
            total: newQuantity * item.price,
            product: item.product,
          );
        }
        return item;
      }).toList();

      final updatedOrder = Order(
        id: currentState.order.id,
        companyId: currentState.order.companyId,
        customerId: currentState.order.customerId,
        userId: currentState.order.userId,
        priceListId: currentState.order.priceListId,
        status: currentState.order.status,
        subtotal: currentState.order.subtotal,
        taxTotal: currentState.order.taxTotal,
        discountTotal: currentState.order.discountTotal,
        grandTotal: currentState.order.grandTotal,
        createdAt: currentState.order.createdAt,
        customer: currentState.order.customer,
        items: updatedItems,
      );
      final recalculatedOrder = _recalculateOrderTotals(updatedOrder);

      emit(OrderState.editing(recalculatedOrder));
    }
  }

  Future<void> saveOrder() async {
    try {
      final currentState = state;
      if (currentState is OrderEditing) {
        emit(const OrderState.saving());

        final savedOrder = await _repository.createOrder(currentState.order);
        emit(OrderState.saved(savedOrder));
      }
    } catch (e) {
      logger.e('Save order error: $e');
      emit(OrderState.error(e.toString()));
    }
  }

  Order _recalculateOrderTotals(Order order) {
    double subtotal = 0;
    double taxTotal = 0;
    double discountTotal = 0;

    for (final item in order.items) {
      subtotal += item.total;
      discountTotal += item.discount;
      // Tax calculation would be based on product tax rate
      if (item.product != null) {
        taxTotal += item.total * item.product!.tax / 100;
      }
    }

    final grandTotal = subtotal + taxTotal - discountTotal;

    return Order(
      id: order.id,
      companyId: order.companyId,
      customerId: order.customerId,
      userId: order.userId,
      priceListId: order.priceListId,
      status: order.status,
      subtotal: subtotal,
      taxTotal: taxTotal,
      discountTotal: discountTotal,
      grandTotal: grandTotal,
      createdAt: order.createdAt,
      customer: order.customer,
      items: order.items,
    );
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'product.dart';
import '../customers/customer.dart';

// Commented out until generated files are available
// part 'order.freezed.dart';
// part 'order.g.dart';

enum OrderStatus {
  @JsonValue('DRAFT')
  draft,
  @JsonValue('SENT')
  sent,
  @JsonValue('APPROVED')
  approved,
  @JsonValue('REJECTED')
  rejected,
  @JsonValue('DELIVERED')
  delivered,
  @JsonValue('CANCELLED')
  cancelled,
}

class Order {
  const Order({
    required this.id,
    required this.companyId,
    this.customerId,
    this.userId,
    this.priceListId,
    this.status = OrderStatus.draft,
    this.subtotal = 0.0,
    this.taxTotal = 0.0,
    this.discountTotal = 0.0,
    this.grandTotal = 0.0,
    this.createdAt,
    this.customer,
    this.items = const [],
  });

  final String id;
  final String companyId;
  final String? customerId;
  final String? userId;
  final String? priceListId;
  final OrderStatus status;
  final double subtotal;
  final double taxTotal;
  final double discountTotal;
  final double grandTotal;
  final DateTime? createdAt;
  final Customer? customer;
  final List<OrderItem> items;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'],
        companyId: json['companyId'],
        customerId: json['customerId'],
        userId: json['userId'],
        priceListId: json['priceListId'],
        status: OrderStatus.values.firstWhere((e) => e.name == json['status'],
            orElse: () => OrderStatus.draft),
        subtotal: json['subtotal'] ?? 0.0,
        taxTotal: json['taxTotal'] ?? 0.0,
        discountTotal: json['discountTotal'] ?? 0.0,
        grandTotal: json['grandTotal'] ?? 0.0,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        customer: json['customer'] != null
            ? Customer.fromJson(json['customer'])
            : null,
        items: (json['items'] as List?)
                ?.map((e) => OrderItem.fromJson(e))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'companyId': companyId,
        'customerId': customerId,
        'userId': userId,
        'priceListId': priceListId,
        'status': status.name,
        'subtotal': subtotal,
        'taxTotal': taxTotal,
        'discountTotal': discountTotal,
        'grandTotal': grandTotal,
        'createdAt': createdAt?.toIso8601String(),
        'customer': customer?.toJson(),
        'items': items.map((e) => e.toJson()).toList(),
      };
}

class OrderItem {
  const OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.qty,
    required this.price,
    this.discount = 0.0,
    required this.total,
    this.product,
  });

  final String id;
  final String orderId;
  final String productId;
  final double qty;
  final double price;
  final double discount;
  final double total;
  final Product? product;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json['id'],
        orderId: json['orderId'],
        productId: json['productId'],
        qty: json['qty'],
        price: json['price'],
        discount: json['discount'] ?? 0.0,
        total: json['total'],
        product:
            json['product'] != null ? Product.fromJson(json['product']) : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'orderId': orderId,
        'productId': productId,
        'qty': qty,
        'price': price,
        'discount': discount,
        'total': total,
        'product': product?.toJson(),
      };
}

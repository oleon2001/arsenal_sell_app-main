import 'package:freezed_annotation/freezed_annotation.dart';
import 'product.dart';

part 'order_item.freezed.dart';
part 'order_item.g.dart';

@freezed
class OrderItem with _$OrderItem {
  const factory OrderItem({
    required String id,
    required String orderId,
    required String productId,
    required double qty,
    required double price,
    @Default(0.0) double discount,
    required double total,
    Product? product,
  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
}

// Extensions for business logic
extension OrderItemX on OrderItem {
  /// Calculate the final amount after discount
  double get finalAmount => total - discount;

  /// Calculate the unit price after discount
  double get unitPriceAfterDiscount {
    if (qty == 0) return 0;
    return finalAmount / qty;
  }

  /// Check if item has discount
  bool get hasDiscount => discount > 0;

  /// Calculate discount percentage
  double get discountPercentage {
    if (total == 0) return 0;
    return (discount / total) * 100;
  }

  /// Calculate subtotal (price * qty)
  double get subtotal => price * qty;

  /// Calculate tax amount if product has tax
  double get taxAmount {
    if (product?.tax == null || product!.tax == 0) return 0;
    return finalAmount * (product!.tax / 100);
  }

  /// Get formatted price string
  String get formattedPrice => '\$${price.toStringAsFixed(2)}';

  /// Get formatted total string
  String get formattedTotal => '\$${total.toStringAsFixed(2)}';

  /// Get formatted discount string
  String get formattedDiscount => '\$${discount.toStringAsFixed(2)}';

  /// Get formatted final amount string
  String get formattedFinalAmount => '\$${finalAmount.toStringAsFixed(2)}';

  /// Create a copy with updated quantity and recalculated total
  OrderItem updateQuantity(double newQty) {
    final newTotal = price * newQty;
    return copyWith(
      qty: newQty,
      total: newTotal,
    );
  }

  /// Create a copy with updated price and recalculated total
  OrderItem updatePrice(double newPrice) {
    final newTotal = newPrice * qty;
    return copyWith(
      price: newPrice,
      total: newTotal,
    );
  }

  /// Create a copy with updated discount
  OrderItem updateDiscount(double newDiscount) =>
      copyWith(discount: newDiscount);

  /// Validate if the order item is valid
  bool get isValid =>
      id.isNotEmpty &&
      orderId.isNotEmpty &&
      productId.isNotEmpty &&
      qty > 0 &&
      price >= 0 &&
      total >= 0 &&
      discount >= 0 &&
      discount <= total;

  /// Get display name for the product
  String get displayName => product?.name ?? 'Producto Desconocido';

  /// Get product SKU
  String get sku => product?.sku ?? '';

  /// Get product unit
  String get unit => product?.unit ?? 'ud';

  /// Format quantity with unit
  String get formattedQuantity {
    final qtyString = qty % 1 == 0 ? qty.toInt().toString() : qty.toString();
    return '$qtyString $unit';
  }
}

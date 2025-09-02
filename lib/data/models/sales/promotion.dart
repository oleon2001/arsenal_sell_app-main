import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'product.dart';

part 'promotion.freezed.dart';
part 'promotion.g.dart';

@freezed
class Promotion with _$Promotion {
  const factory Promotion({
    required String id,
    required String companyId,
    required String name,
    String? description,
    required PromotionType type,
    required Map<String, dynamic> rules,
    required DateTime startsAt,
    required DateTime endsAt,
    @Default(true) bool active,
    @Default(0) int priority,
    @Default(0) int usageLimit,
    @Default(0) int usageCount,
    @Default([]) List<String> applicableProducts,
    @Default([]) List<String> applicableCategories,
    @Default([]) List<String> applicableCustomers,
    @Default([]) List<String> excludedProducts,
    @Default([]) List<String> excludedCustomers,
    double? minimumOrderAmount,
    double? maximumDiscount,
    @Default([]) List<DayOfWeek> applicableDays,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    DateTime? createdAt,
    String? createdBy,
  }) = _Promotion;

  factory Promotion.fromJson(Map<String, dynamic> json) =>
      _$PromotionFromJson(json);
}

@freezed
class PromotionResult with _$PromotionResult {
  const factory PromotionResult({
    required String promotionId,
    required String promotionName,
    required PromotionType type,
    required double discountAmount,
    double? discountPercentage,
    @Default([]) List<String> affectedProducts,
    @Default([]) List<PromotionItem> freeItems,
    String? description,
  }) = _PromotionResult;

  factory PromotionResult.fromJson(Map<String, dynamic> json) =>
      _$PromotionResultFromJson(json);
}

@freezed
class PromotionItem with _$PromotionItem {
  const factory PromotionItem({
    required String productId,
    required double quantity,
    Product? product,
  }) = _PromotionItem;

  factory PromotionItem.fromJson(Map<String, dynamic> json) =>
      _$PromotionItemFromJson(json);
}

enum PromotionType {
  @JsonValue('PERCENTAGE_DISCOUNT')
  percentageDiscount,
  @JsonValue('FIXED_DISCOUNT')
  fixedDiscount,
  @JsonValue('BUY_X_GET_Y')
  buyXGetY,
  @JsonValue('FREE_SHIPPING')
  freeShipping,
  @JsonValue('BUNDLE_DISCOUNT')
  bundleDiscount,
  @JsonValue('VOLUME_DISCOUNT')
  volumeDiscount,
  @JsonValue('FIRST_TIME_BUYER')
  firstTimeBuyer,
  @JsonValue('LOYALTY_DISCOUNT')
  loyaltyDiscount,
}

enum DayOfWeek {
  @JsonValue(1)
  monday,
  @JsonValue(2)
  tuesday,
  @JsonValue(3)
  wednesday,
  @JsonValue(4)
  thursday,
  @JsonValue(5)
  friday,
  @JsonValue(6)
  saturday,
  @JsonValue(7)
  sunday,
}

@freezed
class TimeOfDay with _$TimeOfDay {
  const factory TimeOfDay({
    required int hour,
    required int minute,
  }) = _TimeOfDay;

  factory TimeOfDay.fromJson(Map<String, dynamic> json) =>
      _$TimeOfDayFromJson(json);
}

// Extensions for easier usage
extension PromotionX on Promotion {
  /// Check if promotion is currently active
  bool get isCurrentlyActive {
    if (!active) return false;

    final now = DateTime.now();
    if (now.isBefore(startsAt) || now.isAfter(endsAt)) {
      return false;
    }

    // Check usage limit
    if (usageLimit > 0 && usageCount >= usageLimit) {
      return false;
    }

    // Check day of week
    if (applicableDays.isNotEmpty) {
      final currentDay = DayOfWeek.values[now.weekday - 1];
      if (!applicableDays.contains(currentDay)) {
        return false;
      }
    }

    // Check time range
    if (startTime != null && endTime != null) {
      final currentTime = TimeOfDay(hour: now.hour, minute: now.minute);
      if (!_isTimeInRange(currentTime, startTime!, endTime!)) {
        return false;
      }
    }

    return true;
  }

  /// Check if product is applicable for this promotion
  bool isProductApplicable(String productId) {
    // Check excluded products first
    if (excludedProducts.contains(productId)) {
      return false;
    }

    // If specific products are defined, check inclusion
    if (applicableProducts.isNotEmpty) {
      return applicableProducts.contains(productId);
    }

    // If categories are defined, would need to check product category
    // This would require product information

    return true;
  }

  /// Check if customer is applicable for this promotion
  bool isCustomerApplicable(String customerId) {
    // Check excluded customers first
    if (excludedCustomers.contains(customerId)) {
      return false;
    }

    // If specific customers are defined, check inclusion
    if (applicableCustomers.isNotEmpty) {
      return applicableCustomers.contains(customerId);
    }

    return true;
  }

  /// Check if order meets minimum amount requirement
  bool meetsMinimumAmount(double orderAmount) =>
      minimumOrderAmount == null || orderAmount >= minimumOrderAmount!;

  /// Get promotion description for display
  String get displayDescription {
    switch (type) {
      case PromotionType.percentageDiscount:
        final percentage = rules['percentage'] ?? 0;
        return '$percentage% de descuento';
      case PromotionType.fixedDiscount:
        final amount = rules['amount'] ?? 0;
        return '\$$amount de descuento';
      case PromotionType.buyXGetY:
        final buyQty = rules['buyQuantity'] ?? 1;
        final getQty = rules['getQuantity'] ?? 1;
        return 'Compra $buyQty lleva $getQty gratis';
      case PromotionType.freeShipping:
        return 'Envío gratis';
      case PromotionType.bundleDiscount:
        return 'Descuento por paquete';
      case PromotionType.volumeDiscount:
        return 'Descuento por volumen';
      case PromotionType.firstTimeBuyer:
        return 'Descuento primera compra';
      case PromotionType.loyaltyDiscount:
        return 'Descuento por lealtad';
    }
  }

  bool _isTimeInRange(TimeOfDay current, TimeOfDay start, TimeOfDay end) {
    final currentMinutes = current.hour * 60 + current.minute;
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;

    if (startMinutes <= endMinutes) {
      // Same day range
      return currentMinutes >= startMinutes && currentMinutes <= endMinutes;
    } else {
      // Overnight range
      return currentMinutes >= startMinutes || currentMinutes <= endMinutes;
    }
  }
}

extension PromotionTypeX on PromotionType {
  String get displayName {
    switch (this) {
      case PromotionType.percentageDiscount:
        return 'Descuento por Porcentaje';
      case PromotionType.fixedDiscount:
        return 'Descuento Fijo';
      case PromotionType.buyXGetY:
        return 'Compra X Lleva Y';
      case PromotionType.freeShipping:
        return 'Envío Gratis';
      case PromotionType.bundleDiscount:
        return 'Descuento por Paquete';
      case PromotionType.volumeDiscount:
        return 'Descuento por Volumen';
      case PromotionType.firstTimeBuyer:
        return 'Primera Compra';
      case PromotionType.loyaltyDiscount:
        return 'Descuento por Lealtad';
    }
  }

  IconData get icon {
    switch (this) {
      case PromotionType.percentageDiscount:
        return Icons.percent;
      case PromotionType.fixedDiscount:
        return Icons.money_off;
      case PromotionType.buyXGetY:
        return Icons.add_shopping_cart;
      case PromotionType.freeShipping:
        return Icons.local_shipping;
      case PromotionType.bundleDiscount:
        return Icons.inventory;
      case PromotionType.volumeDiscount:
        return Icons.scale;
      case PromotionType.firstTimeBuyer:
        return Icons.new_releases;
      case PromotionType.loyaltyDiscount:
        return Icons.star;
    }
  }
}

extension DayOfWeekX on DayOfWeek {
  String get displayName {
    switch (this) {
      case DayOfWeek.monday:
        return 'Lunes';
      case DayOfWeek.tuesday:
        return 'Martes';
      case DayOfWeek.wednesday:
        return 'Miércoles';
      case DayOfWeek.thursday:
        return 'Jueves';
      case DayOfWeek.friday:
        return 'Viernes';
      case DayOfWeek.saturday:
        return 'Sábado';
      case DayOfWeek.sunday:
        return 'Domingo';
    }
  }

  String get shortName {
    switch (this) {
      case DayOfWeek.monday:
        return 'Lun';
      case DayOfWeek.tuesday:
        return 'Mar';
      case DayOfWeek.wednesday:
        return 'Mié';
      case DayOfWeek.thursday:
        return 'Jue';
      case DayOfWeek.friday:
        return 'Vie';
      case DayOfWeek.saturday:
        return 'Sáb';
      case DayOfWeek.sunday:
        return 'Dom';
    }
  }
}

// Promotion Engine for applying promotions
class PromotionEngine {
  /// Apply promotions to an order
  static List<PromotionResult> applyPromotions({
    required List<Promotion> promotions,
    required List<OrderItemModel> orderItems,
    required String customerId,
    required double orderTotal,
  }) {
    final results = <PromotionResult>[];

    // Sort promotions by priority (higher priority first)
    final sortedPromotions = List<Promotion>.from(promotions)
      ..sort((a, b) => b.priority.compareTo(a.priority));

    for (final promotion in sortedPromotions) {
      if (!promotion.isCurrentlyActive) continue;
      if (!promotion.isCustomerApplicable(customerId)) continue;
      if (!promotion.meetsMinimumAmount(orderTotal)) continue;

      final result = _applyPromotion(promotion, orderItems, orderTotal);
      if (result != null) {
        results.add(result);
      }
    }

    return results;
  }

  static PromotionResult? _applyPromotion(
    Promotion promotion,
    List<OrderItemModel> orderItems,
    double orderTotal,
  ) {
    switch (promotion.type) {
      case PromotionType.percentageDiscount:
        return _applyPercentageDiscount(promotion, orderItems, orderTotal);
      case PromotionType.fixedDiscount:
        return _applyFixedDiscount(promotion, orderTotal);
      case PromotionType.buyXGetY:
        return _applyBuyXGetY(promotion, orderItems);
      case PromotionType.volumeDiscount:
        return _applyVolumeDiscount(promotion, orderItems);
      default:
        return null;
    }
  }

  static PromotionResult? _applyPercentageDiscount(
    Promotion promotion,
    List<OrderItemModel> orderItems,
    double orderTotal,
  ) {
    final percentage = promotion.rules['percentage']?.toDouble() ?? 0;
    if (percentage <= 0) return null;

    final applicableItems = orderItems
        .where((item) => promotion.isProductApplicable(item.productId))
        .toList();

    if (applicableItems.isEmpty) return null;

    final applicableTotal =
        applicableItems.fold<double>(0, (sum, item) => sum + item.total);

    double discountAmount = applicableTotal * (percentage / 100);

    // Apply maximum discount limit
    if (promotion.maximumDiscount != null &&
        discountAmount > promotion.maximumDiscount!) {
      discountAmount = promotion.maximumDiscount!;
    }

    return PromotionResult(
      promotionId: promotion.id,
      promotionName: promotion.name,
      type: promotion.type,
      discountAmount: discountAmount,
      discountPercentage: percentage,
      affectedProducts: applicableItems.map((item) => item.productId).toList(),
      description: '${percentage.toStringAsFixed(1)}% de descuento',
    );
  }

  static PromotionResult? _applyFixedDiscount(
    Promotion promotion,
    double orderTotal,
  ) {
    final amount = promotion.rules['amount']?.toDouble() ?? 0;
    if (amount <= 0) return null;

    final discountAmount = amount > orderTotal ? orderTotal : amount;

    return PromotionResult(
      promotionId: promotion.id,
      promotionName: promotion.name,
      type: promotion.type,
      discountAmount: discountAmount,
      description: '\$${amount.toStringAsFixed(2)} de descuento',
    );
  }

  static PromotionResult? _applyBuyXGetY(
    Promotion promotion,
    List<OrderItemModel> orderItems,
  ) {
    final buyQuantity = promotion.rules['buyQuantity']?.toInt() ?? 1;
    final getQuantity = promotion.rules['getQuantity']?.toInt() ?? 1;
    final buyProductId = promotion.rules['buyProductId'] as String?;
    final getProductId = promotion.rules['getProductId'] as String?;

    if (buyProductId == null || getProductId == null) return null;

    final buyItem =
        orderItems.where((item) => item.productId == buyProductId).firstOrNull;

    if (buyItem == null || buyItem.qty < buyQuantity) return null;

    final sets = (buyItem.qty / buyQuantity).floor();
    final freeQuantity = sets * getQuantity;

    final freeItems = [
      PromotionItem(
        productId: getProductId,
        quantity: freeQuantity.toDouble(),
      ),
    ];

    return PromotionResult(
      promotionId: promotion.id,
      promotionName: promotion.name,
      type: promotion.type,
      discountAmount: 0, // Free items, no direct discount
      freeItems: freeItems,
      description: 'Compra $buyQuantity lleva $getQuantity gratis',
    );
  }

  static PromotionResult? _applyVolumeDiscount(
    Promotion promotion,
    List<OrderItemModel> orderItems,
  ) {
    final tiers = promotion.rules['tiers'] as List<dynamic>? ?? [];
    if (tiers.isEmpty) return null;

    final totalQuantity =
        orderItems.fold<double>(0, (sum, item) => sum + item.qty);

    // Find applicable tier
    Map<String, dynamic>? applicableTier;
    for (final tier in tiers) {
      final minQty = tier['minQuantity']?.toDouble() ?? 0;
      if (totalQuantity >= minQty) {
        applicableTier = tier;
      }
    }

    if (applicableTier == null) return null;

    final discountPercentage =
        applicableTier['discountPercentage']?.toDouble() ?? 0;
    if (discountPercentage <= 0) return null;

    final orderTotal =
        orderItems.fold<double>(0, (sum, item) => sum + item.total);
    final discountAmount = orderTotal * (discountPercentage / 100);

    return PromotionResult(
      promotionId: promotion.id,
      promotionName: promotion.name,
      type: promotion.type,
      discountAmount: discountAmount,
      discountPercentage: discountPercentage,
      affectedProducts: orderItems.map((item) => item.productId).toList(),
      description:
          '${discountPercentage.toStringAsFixed(1)}% descuento por volumen',
    );
  }
}

// Mock OrderItemModel for the promotion engine
class OrderItemModel {
  OrderItemModel({
    required this.productId,
    required this.qty,
    required this.price,
    required this.total,
  });
  final String productId;
  final double qty;
  final double price;
  final double total;
}

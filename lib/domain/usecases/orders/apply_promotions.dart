import '../../../data/models/sales/order.dart';
import '../../../data/models/sales/promotion.dart';
import '../../../data/repositories/orders_repository.dart';
import '../../../config/logger.dart';

class ApplyPromotionsUseCase {
  ApplyPromotionsUseCase(this._repository);
  final OrdersRepository _repository;

  Future<OrderPromotionResult> execute({
    required Order order,
    required List<Promotion> availablePromotions,
    String? customerCode,
  }) async {
    try {
      final applicablePromotions = <Promotion>[];
      final promotionResults = <PromotionResult>[];
      double totalDiscountAmount = 0;

      // Filter promotions that are currently active and applicable
      for (final promotion in availablePromotions) {
        if (_isPromotionApplicable(promotion, order, customerCode)) {
          applicablePromotions.add(promotion);
        }
      }

      // Sort promotions by priority (higher priority first)
      applicablePromotions.sort((a, b) => b.priority.compareTo(a.priority));

      // Apply promotions
      for (final promotion in applicablePromotions) {
        final result = _applyPromotion(promotion, order);
        if (result != null) {
          promotionResults.add(result);
          totalDiscountAmount += result.discountAmount;

          // Check if we've reached the maximum discount limit
          if (promotion.maximumDiscount != null &&
              totalDiscountAmount >= promotion.maximumDiscount!) {
            break;
          }
        }
      }

      // Calculate final order totals with promotions
      final updatedOrder =
          _calculateOrderTotalsWithPromotions(order, promotionResults);

      logger.i(
          'Applied ${promotionResults.length} promotions to order ${order.id}');

      return OrderPromotionResult(
        order: updatedOrder,
        appliedPromotions: promotionResults,
        totalDiscountAmount: totalDiscountAmount,
      );
    } catch (e) {
      logger.e('Apply promotions error: $e');
      rethrow;
    }
  }

  bool _isPromotionApplicable(
      Promotion promotion, Order order, String? customerCode) {
    // Check if promotion is currently active
    if (!promotion.isCurrentlyActive) {
      return false;
    }

    // Check minimum order amount
    if (!promotion.meetsMinimumAmount(order.subtotal)) {
      return false;
    }

    // Check customer eligibility
    if (customerCode != null && !promotion.isCustomerApplicable(customerCode)) {
      return false;
    }

    // Check if any products are applicable
    final bool hasApplicableProducts = order.items
        .any((item) => promotion.isProductApplicable(item.productId));

    if (promotion.applicableProducts.isNotEmpty && !hasApplicableProducts) {
      return false;
    }

    // Check usage limit
    if (promotion.usageLimit > 0 &&
        promotion.usageCount >= promotion.usageLimit) {
      return false;
    }

    return true;
  }

  PromotionResult? _applyPromotion(Promotion promotion, Order order) {
    switch (promotion.type) {
      case PromotionType.percentageDiscount:
        return _applyPercentageDiscount(promotion, order);
      case PromotionType.fixedDiscount:
        return _applyFixedDiscount(promotion, order);
      case PromotionType.buyXGetY:
        return _applyBuyXGetY(promotion, order);
      case PromotionType.volumeDiscount:
        return _applyVolumeDiscount(promotion, order);
      case PromotionType.bundleDiscount:
        return _applyBundleDiscount(promotion, order);
      default:
        return null;
    }
  }

  PromotionResult? _applyPercentageDiscount(Promotion promotion, Order order) {
    final percentage = promotion.rules['percentage']?.toDouble() ?? 0;
    if (percentage <= 0) return null;

    final applicableItems = order.items
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

  PromotionResult? _applyFixedDiscount(Promotion promotion, Order order) {
    final amount = promotion.rules['amount']?.toDouble() ?? 0;
    if (amount <= 0) return null;

    final discountAmount = amount > order.subtotal ? order.subtotal : amount;

    return PromotionResult(
      promotionId: promotion.id,
      promotionName: promotion.name,
      type: promotion.type,
      discountAmount: discountAmount,
      description: '\$${amount.toStringAsFixed(2)} de descuento',
    );
  }

  PromotionResult? _applyBuyXGetY(Promotion promotion, Order order) {
    final buyQuantity = promotion.rules['buyQuantity']?.toInt() ?? 1;
    final getQuantity = promotion.rules['getQuantity']?.toInt() ?? 1;
    final buyProductId = promotion.rules['buyProductId'] as String?;
    final getProductId = promotion.rules['getProductId'] as String?;

    if (buyProductId == null || getProductId == null) return null;

    final buyItem =
        order.items.where((item) => item.productId == buyProductId).firstOrNull;

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

  PromotionResult? _applyVolumeDiscount(Promotion promotion, Order order) {
    final tiers = promotion.rules['tiers'] as List<dynamic>? ?? [];
    if (tiers.isEmpty) return null;

    final totalQuantity =
        order.items.fold<double>(0, (sum, item) => sum + item.qty);

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

    final discountAmount = order.subtotal * (discountPercentage / 100);

    return PromotionResult(
      promotionId: promotion.id,
      promotionName: promotion.name,
      type: promotion.type,
      discountAmount: discountAmount,
      discountPercentage: discountPercentage,
      affectedProducts: order.items.map((item) => item.productId).toList(),
      description:
          '${discountPercentage.toStringAsFixed(1)}% descuento por volumen',
    );
  }

  PromotionResult? _applyBundleDiscount(Promotion promotion, Order order) {
    final bundleProducts =
        promotion.rules['bundleProducts'] as List<String>? ?? [];
    final discountAmount = promotion.rules['discountAmount']?.toDouble() ?? 0;

    if (bundleProducts.isEmpty || discountAmount <= 0) return null;

    // Check if all bundle products are in the order
    final hasAllBundleProducts = bundleProducts.every(
        (productId) => order.items.any((item) => item.productId == productId));

    if (!hasAllBundleProducts) return null;

    return PromotionResult(
      promotionId: promotion.id,
      promotionName: promotion.name,
      type: promotion.type,
      discountAmount: discountAmount,
      affectedProducts: bundleProducts,
      description: 'Descuento por paquete',
    );
  }

  Order _calculateOrderTotalsWithPromotions(
      Order order, List<PromotionResult> promotions) {
    final totalPromotionDiscount =
        promotions.fold<double>(0, (sum, promo) => sum + promo.discountAmount);

    final newDiscountTotal = order.discountTotal + totalPromotionDiscount;
    final newGrandTotal = order.subtotal + order.taxTotal - newDiscountTotal;

    // TODO: Implement copyWith method in Order model
    return Order(
      id: order.id,
      companyId: order.companyId,
      customerId: order.customerId,
      userId: order.userId,
      priceListId: order.priceListId,
      status: order.status,
      subtotal: order.subtotal,
      taxTotal: order.taxTotal,
      discountTotal: newDiscountTotal,
      grandTotal: newGrandTotal,
      createdAt: order.createdAt,
      customer: order.customer,
      items: order.items,
    );
  }
}

class OrderPromotionResult {
  OrderPromotionResult({
    required this.order,
    required this.appliedPromotions,
    required this.totalDiscountAmount,
  });
  final Order order;
  final List<PromotionResult> appliedPromotions;
  final double totalDiscountAmount;
}

extension on List<dynamic> {
  T? firstOrNull<T>() {
    if (isEmpty) return null;
    return first as T;
  }
}

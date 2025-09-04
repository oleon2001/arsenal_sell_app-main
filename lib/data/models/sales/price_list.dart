import 'package:freezed_annotation/freezed_annotation.dart';
import 'product.dart';

// Commented out until generated files are available
// part 'price_list.freezed.dart';
// part 'price_list.g.dart';

class PriceListModel {
  factory PriceListModel.fromJson(Map<String, dynamic> json) => PriceListModel(
        id: json['id'],
        companyId: json['companyId'],
        name: json['name'],
        description: json['description'],
        currency: json['currency'] ?? 'USD',
        isActive: json['isActive'] ?? true,
        isDefault: json['isDefault'] ?? false,
        validFrom: json['validFrom'] != null
            ? DateTime.parse(json['validFrom'])
            : null,
        validTo:
            json['validTo'] != null ? DateTime.parse(json['validTo']) : null,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null,
        prices: (json['prices'] as List?)
                ?.map((e) => PriceModel.fromJson(e))
                .toList() ??
            [],
        targetSegment: json['targetSegment'] != null
            ? CustomerSegment.values
                .firstWhere((e) => e.name == json['targetSegment'])
            : null,
        type: json['type'] != null
            ? PriceListType.values.firstWhere((e) => e.name == json['type'])
            : null,
      );
  const PriceListModel({
    required this.id,
    required this.companyId,
    required this.name,
    this.description,
    this.currency = 'USD',
    this.isActive = true,
    this.isDefault = false,
    this.validFrom,
    this.validTo,
    this.createdAt,
    this.updatedAt,
    this.prices = const [],
    this.targetSegment,
    this.type,
  });

  final String id;
  final String companyId;
  final String name;
  final String? description;
  final String currency;
  final bool isActive;
  final bool isDefault;
  final DateTime? validFrom;
  final DateTime? validTo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<PriceModel> prices;
  final CustomerSegment? targetSegment;
  final PriceListType? type;
}

class PriceModel {
  factory PriceModel.fromJson(Map<String, dynamic> json) => PriceModel(
        id: json['id'],
        priceListId: json['priceListId'],
        productId: json['productId'],
        price: json['price'],
        costPrice: json['costPrice'],
        margin: json['margin'],
        minQuantity: json['minQuantity'],
        maxQuantity: json['maxQuantity'],
        validFrom: json['validFrom'] != null
            ? DateTime.parse(json['validFrom'])
            : null,
        validTo:
            json['validTo'] != null ? DateTime.parse(json['validTo']) : null,
        isActive: json['isActive'] ?? true,
        product:
            json['product'] != null ? Product.fromJson(json['product']) : null,
        unit: json['unit'] != null
            ? PriceUnit.values.firstWhere((e) => e.name == json['unit'])
            : null,
        tiers: (json['tiers'] as List?)
                ?.map((e) => PriceTier.fromJson(e))
                .toList() ??
            [],
      );
  const PriceModel({
    required this.id,
    required this.priceListId,
    required this.productId,
    required this.price,
    this.costPrice,
    this.margin,
    this.minQuantity,
    this.maxQuantity,
    this.validFrom,
    this.validTo,
    this.isActive = true,
    this.product,
    this.unit,
    this.tiers = const [],
  });

  final String id;
  final String priceListId;
  final String productId;
  final double price;
  final double? costPrice;
  final double? margin;
  final double? minQuantity;
  final double? maxQuantity;
  final DateTime? validFrom;
  final DateTime? validTo;
  final bool isActive;
  final Product? product;
  final PriceUnit? unit;
  final List<PriceTier> tiers;
}

class PriceTier {
  factory PriceTier.fromJson(Map<String, dynamic> json) => PriceTier(
        minQuantity: json['minQuantity'],
        price: json['price'],
        maxQuantity: json['maxQuantity'],
        discountPercentage: json['discountPercentage'],
      );
  const PriceTier({
    required this.minQuantity,
    required this.price,
    this.maxQuantity,
    this.discountPercentage,
  });

  final double minQuantity;
  final double price;
  final double? maxQuantity;
  final double? discountPercentage;
}

enum PriceListType {
  @JsonValue('STANDARD')
  standard,
  @JsonValue('WHOLESALE')
  wholesale,
  @JsonValue('RETAIL')
  retail,
  @JsonValue('PROMOTIONAL')
  promotional,
  @JsonValue('SEASONAL')
  seasonal,
  @JsonValue('VOLUME')
  volume,
  @JsonValue('CUSTOMER_SPECIFIC')
  customerSpecific,
}

enum CustomerSegment {
  @JsonValue('GENERAL')
  general,
  @JsonValue('VIP')
  vip,
  @JsonValue('WHOLESALE')
  wholesale,
  @JsonValue('RETAIL')
  retail,
  @JsonValue('DISTRIBUTOR')
  distributor,
  @JsonValue('CORPORATE')
  corporate,
}

enum PriceUnit {
  @JsonValue('UNIT')
  unit,
  @JsonValue('KILOGRAM')
  kilogram,
  @JsonValue('LITER')
  liter,
  @JsonValue('METER')
  meter,
  @JsonValue('SQUARE_METER')
  squareMeter,
  @JsonValue('BOX')
  box,
  @JsonValue('DOZEN')
  dozen,
  @JsonValue('CASE')
  caseUnit,
}

// Helper extensions
extension PriceListModelX on PriceListModel {
  /// Check if price list is currently valid
  bool get isCurrentlyValid {
    final now = DateTime.now();

    if (validFrom != null && now.isBefore(validFrom!)) {
      return false;
    }

    if (validTo != null && now.isAfter(validTo!)) {
      return false;
    }

    return isActive;
  }

  /// Get price for a specific product
  PriceModel? getPriceForProduct(String productId) {
    try {
      return prices.firstWhere(
          (price) => price.productId == productId && price.isActive);
    } catch (e) {
      return null;
    }
  }

  /// Get all active prices
  List<PriceModel> get activePrices =>
      prices.where((price) => price.isActive).toList();

  /// Get price count
  int get priceCount => activePrices.length;

  /// Get average price
  double get averagePrice {
    final active = activePrices;
    if (active.isEmpty) return 0;

    return active.fold<double>(0, (sum, price) => sum + price.price) /
        active.length;
  }

  /// Get price range
  PriceRange get priceRange {
    final active = activePrices;
    if (active.isEmpty) {
      return const PriceRange(min: 0, max: 0);
    }

    double min = active.first.price;
    double max = active.first.price;

    for (final price in active) {
      if (price.price < min) min = price.price;
      if (price.price > max) max = price.price;
    }

    return PriceRange(min: min, max: max);
  }

  /// Format currency
  String formatPrice(double amount) => '$currency ${amount.toStringAsFixed(2)}';
}

extension PriceModelX on PriceModel {
  /// Check if price is currently valid
  bool get isCurrentlyValid {
    final now = DateTime.now();

    if (validFrom != null && now.isBefore(validFrom!)) {
      return false;
    }

    if (validTo != null && now.isAfter(validTo!)) {
      return false;
    }

    return isActive;
  }

  /// Get price for specific quantity
  double getPriceForQuantity(double quantity) {
    if (tiers.isEmpty) return price;

    // Find applicable tier
    PriceTier? applicableTier;

    for (final tier in tiers) {
      if (quantity >= tier.minQuantity) {
        if (tier.maxQuantity == null || quantity <= tier.maxQuantity!) {
          applicableTier = tier;
          break;
        }
      }
    }

    return applicableTier?.price ?? price;
  }

  /// Get discount percentage for quantity
  double getDiscountForQuantity(double quantity) {
    if (tiers.isEmpty) return 0;

    for (final tier in tiers) {
      if (quantity >= tier.minQuantity) {
        if (tier.maxQuantity == null || quantity <= tier.maxQuantity!) {
          return tier.discountPercentage ?? 0;
        }
      }
    }

    return 0;
  }

  /// Calculate profit margin
  double get profitMargin {
    if (costPrice == null || costPrice == 0) return 0;
    return ((price - costPrice!) / price) * 100;
  }

  /// Check if quantity is within valid range
  bool isQuantityValid(double quantity) {
    if (minQuantity != null && quantity < minQuantity!) return false;
    if (maxQuantity != null && quantity > maxQuantity!) return false;
    return true;
  }
}

extension PriceListTypeX on PriceListType {
  String get displayName {
    switch (this) {
      case PriceListType.standard:
        return 'Estándar';
      case PriceListType.wholesale:
        return 'Mayoreo';
      case PriceListType.retail:
        return 'Menudeo';
      case PriceListType.promotional:
        return 'Promocional';
      case PriceListType.seasonal:
        return 'Temporal';
      case PriceListType.volume:
        return 'Por Volumen';
      case PriceListType.customerSpecific:
        return 'Cliente Específico';
    }
  }

  int get priority {
    switch (this) {
      case PriceListType.customerSpecific:
        return 1;
      case PriceListType.promotional:
        return 2;
      case PriceListType.seasonal:
        return 3;
      case PriceListType.volume:
        return 4;
      case PriceListType.wholesale:
        return 5;
      case PriceListType.retail:
        return 6;
      case PriceListType.standard:
        return 7;
    }
  }
}

extension CustomerSegmentX on CustomerSegment {
  String get displayName {
    switch (this) {
      case CustomerSegment.general:
        return 'General';
      case CustomerSegment.vip:
        return 'VIP';
      case CustomerSegment.wholesale:
        return 'Mayorista';
      case CustomerSegment.retail:
        return 'Detallista';
      case CustomerSegment.distributor:
        return 'Distribuidor';
      case CustomerSegment.corporate:
        return 'Corporativo';
    }
  }
}

extension PriceUnitX on PriceUnit {
  String get displayName {
    switch (this) {
      case PriceUnit.unit:
        return 'Unidad';
      case PriceUnit.kilogram:
        return 'Kilogramo';
      case PriceUnit.liter:
        return 'Litro';
      case PriceUnit.meter:
        return 'Metro';
      case PriceUnit.squareMeter:
        return 'Metro²';
      case PriceUnit.box:
        return 'Caja';
      case PriceUnit.dozen:
        return 'Docena';
      case PriceUnit.caseUnit:
        return 'Estuche';
    }
  }

  String get abbreviation {
    switch (this) {
      case PriceUnit.unit:
        return 'ud';
      case PriceUnit.kilogram:
        return 'kg';
      case PriceUnit.liter:
        return 'l';
      case PriceUnit.meter:
        return 'm';
      case PriceUnit.squareMeter:
        return 'm²';
      case PriceUnit.box:
        return 'cja';
      case PriceUnit.dozen:
        return 'doc';
      case PriceUnit.caseUnit:
        return 'est';
    }
  }
}

class PriceRange {
  factory PriceRange.fromJson(Map<String, dynamic> json) => PriceRange(
        min: json['min'],
        max: json['max'],
      );
  const PriceRange({
    required this.min,
    required this.max,
  });

  final double min;
  final double max;
}

// Price calculation utilities
class PriceCalculator {
  /// Calculate final price with discounts and taxes
  static double calculateFinalPrice({
    required double basePrice,
    double discountPercentage = 0,
    double discountAmount = 0,
    double taxPercentage = 0,
    double quantity = 1,
  }) {
    double price = basePrice * quantity;

    // Apply percentage discount
    if (discountPercentage > 0) {
      price = price * (1 - discountPercentage / 100);
    }

    // Apply fixed discount
    if (discountAmount > 0) {
      price = price - discountAmount;
    }

    // Apply tax
    if (taxPercentage > 0) {
      price = price * (1 + taxPercentage / 100);
    }

    return price < 0 ? 0 : price;
  }

  /// Calculate discount amount
  static double calculateDiscountAmount({
    required double basePrice,
    required double discountPercentage,
    double quantity = 1,
  }) =>
      basePrice * quantity * (discountPercentage / 100);

  /// Calculate tax amount
  static double calculateTaxAmount({
    required double netPrice,
    required double taxPercentage,
  }) =>
      netPrice * (taxPercentage / 100);

  /// Calculate profit margin
  static double calculateMargin({
    required double sellingPrice,
    required double costPrice,
  }) {
    if (sellingPrice == 0) return 0;
    return ((sellingPrice - costPrice) / sellingPrice) * 100;
  }

  /// Calculate markup
  static double calculateMarkup({
    required double sellingPrice,
    required double costPrice,
  }) {
    if (costPrice == 0) return 0;
    return ((sellingPrice - costPrice) / costPrice) * 100;
  }
}

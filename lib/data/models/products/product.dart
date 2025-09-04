import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    @JsonKey(name: 'company_id') required String companyId,
    String? sku,
    required String name,
    String? unit,
    double? tax,
    @Default(true) bool active,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

@freezed
class Price with _$Price {
  const factory Price({
    required String id,
    @JsonKey(name: 'price_list_id') required String priceListId,
    @JsonKey(name: 'product_id') required String productId,
    required double price,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Price;

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
}

@freezed
class PriceList with _$PriceList {
  const factory PriceList({
    required String id,
    @JsonKey(name: 'company_id') required String companyId,
    required String name,
    @Default('USD') String currency,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _PriceList;

  factory PriceList.fromJson(Map<String, dynamic> json) =>
      _$PriceListFromJson(json);
}

// Extension para funcionalidades adicionales
extension ProductX on Product {
  /// Verificar si el producto está activo
  bool get isActive => active;

  /// Obtener nombre completo con SKU
  String get displayName {
    if (sku != null && sku!.isNotEmpty) {
      return '$name ($sku)';
    }
    return name;
  }

  /// Obtener unidad de medida formateada
  String get formattedUnit => unit ?? 'unidad';
}

extension PriceX on Price {
  /// Obtener precio formateado
  String get formattedPrice => '\$${price.toStringAsFixed(2)}';
}

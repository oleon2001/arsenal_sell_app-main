import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String companyId,
    String? sku,
    required String name,
    String? unit,
    @Default(0.0) double tax,
    @Default(true) bool active,
    DateTime? createdAt,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

@freezed
class PriceList with _$PriceList {
  const factory PriceList({
    required String id,
    required String companyId,
    required String name,
    @Default('USD') String currency,
    DateTime? createdAt,
    @Default([]) List<Price> prices,
  }) = _PriceList;

  factory PriceList.fromJson(Map<String, dynamic> json) =>
      _$PriceListFromJson(json);
}

@freezed
class Price with _$Price {
  const factory Price({
    required String id,
    required String priceListId,
    required String productId,
    required double price,
    Product? product,
  }) = _Price;

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
}

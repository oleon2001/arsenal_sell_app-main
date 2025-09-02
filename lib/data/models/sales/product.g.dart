// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String,
      companyId: json['companyId'] as String,
      sku: json['sku'] as String?,
      name: json['name'] as String,
      unit: json['unit'] as String?,
      tax: (json['tax'] as num?)?.toDouble() ?? 0.0,
      active: json['active'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'sku': instance.sku,
      'name': instance.name,
      'unit': instance.unit,
      'tax': instance.tax,
      'active': instance.active,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_$PriceListImpl _$$PriceListImplFromJson(Map<String, dynamic> json) =>
    _$PriceListImpl(
      id: json['id'] as String,
      companyId: json['companyId'] as String,
      name: json['name'] as String,
      currency: json['currency'] as String? ?? 'USD',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      prices: (json['prices'] as List<dynamic>?)
              ?.map((e) => Price.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PriceListImplToJson(_$PriceListImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'name': instance.name,
      'currency': instance.currency,
      'createdAt': instance.createdAt?.toIso8601String(),
      'prices': instance.prices,
    };

_$PriceImpl _$$PriceImplFromJson(Map<String, dynamic> json) => _$PriceImpl(
      id: json['id'] as String,
      priceListId: json['priceListId'] as String,
      productId: json['productId'] as String,
      price: (json['price'] as num).toDouble(),
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PriceImplToJson(_$PriceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'priceListId': instance.priceListId,
      'productId': instance.productId,
      'price': instance.price,
      'product': instance.product,
    };

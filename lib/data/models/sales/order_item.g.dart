// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderItemImpl _$$OrderItemImplFromJson(Map<String, dynamic> json) =>
    _$OrderItemImpl(
      id: json['id'] as String,
      orderId: json['orderId'] as String,
      productId: json['productId'] as String,
      qty: (json['qty'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      total: (json['total'] as num).toDouble(),
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OrderItemImplToJson(_$OrderItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'productId': instance.productId,
      'qty': instance.qty,
      'price': instance.price,
      'discount': instance.discount,
      'total': instance.total,
      'product': instance.product,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReturnImpl _$$ReturnImplFromJson(Map<String, dynamic> json) => _$ReturnImpl(
      id: json['id'] as String,
      orderId: json['orderId'] as String?,
      productId: json['productId'] as String?,
      qty: (json['qty'] as num).toDouble(),
      reason: json['reason'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ReturnImplToJson(_$ReturnImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'productId': instance.productId,
      'qty': instance.qty,
      'reason': instance.reason,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

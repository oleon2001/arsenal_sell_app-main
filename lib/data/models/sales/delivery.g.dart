// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeliveryImpl _$$DeliveryImplFromJson(Map<String, dynamic> json) =>
    _$DeliveryImpl(
      id: json['id'] as String,
      orderId: json['orderId'] as String,
      status: $enumDecodeNullable(_$DeliveryStatusEnumMap, json['status']) ??
          DeliveryStatus.pending,
      deliveredAt: json['deliveredAt'] == null
          ? null
          : DateTime.parse(json['deliveredAt'] as String),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$DeliveryImplToJson(_$DeliveryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'status': _$DeliveryStatusEnumMap[instance.status]!,
      'deliveredAt': instance.deliveredAt?.toIso8601String(),
      'notes': instance.notes,
    };

const _$DeliveryStatusEnumMap = {
  DeliveryStatus.pending: 'PENDING',
  DeliveryStatus.partial: 'PARTIAL',
  DeliveryStatus.delivered: 'DELIVERED',
  DeliveryStatus.rejected: 'REJECTED',
};

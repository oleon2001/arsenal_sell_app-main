// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentImpl _$$PaymentImplFromJson(Map<String, dynamic> json) =>
    _$PaymentImpl(
      id: json['id'] as String,
      customerId: json['customerId'] as String,
      orderId: json['orderId'] as String?,
      type: $enumDecodeNullable(_$PaymentTypeEnumMap, json['type']) ??
          PaymentType.sale,
      amount: (json['amount'] as num).toDouble(),
      method: $enumDecodeNullable(_$PaymentMethodEnumMap, json['method']),
      reference: json['reference'] as String?,
      notes: json['notes'] as String?,
      paidAt: json['paidAt'] == null
          ? null
          : DateTime.parse(json['paidAt'] as String),
      status: json['status'] as String? ?? 'PENDING',
    );

Map<String, dynamic> _$$PaymentImplToJson(_$PaymentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'orderId': instance.orderId,
      'type': _$PaymentTypeEnumMap[instance.type]!,
      'amount': instance.amount,
      'method': _$PaymentMethodEnumMap[instance.method],
      'reference': instance.reference,
      'notes': instance.notes,
      'paidAt': instance.paidAt?.toIso8601String(),
      'status': instance.status,
    };

const _$PaymentTypeEnumMap = {
  PaymentType.sale: 'SALE',
  PaymentType.collection: 'COLLECTION',
  PaymentType.refund: 'REFUND',
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.cash: 'CASH',
  PaymentMethod.card: 'CARD',
  PaymentMethod.transfer: 'TRANSFER',
  PaymentMethod.check: 'CHECK',
};

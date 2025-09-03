// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentImpl _$$PaymentImplFromJson(Map<String, dynamic> json) =>
    _$PaymentImpl(
      id: json['id'] as String,
      orderId: json['orderId'] as String?,
      customerId: json['customerId'] as String?,
      userId: json['userId'] as String?,
      amount: (json['amount'] as num).toDouble(),
      method: json['method'] as String?,
      paidAt: json['paidAt'] == null
          ? null
          : DateTime.parse(json['paidAt'] as String),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$PaymentImplToJson(_$PaymentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'customerId': instance.customerId,
      'userId': instance.userId,
      'amount': instance.amount,
      'method': instance.method,
      'paidAt': instance.paidAt?.toIso8601String(),
      'notes': instance.notes,
    };

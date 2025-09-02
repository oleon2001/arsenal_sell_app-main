// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoutePlanImpl _$$RoutePlanImplFromJson(Map<String, dynamic> json) =>
    _$RoutePlanImpl(
      id: json['id'] as String,
      companyId: json['companyId'] as String,
      name: json['name'] as String,
      date: DateTime.parse(json['date'] as String),
      ownerId: json['ownerId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      stops: (json['stops'] as List<dynamic>?)
              ?.map((e) => RouteStop.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$RoutePlanImplToJson(_$RoutePlanImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'name': instance.name,
      'date': instance.date.toIso8601String(),
      'ownerId': instance.ownerId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'stops': instance.stops,
    };

_$RouteStopImpl _$$RouteStopImplFromJson(Map<String, dynamic> json) =>
    _$RouteStopImpl(
      id: json['id'] as String,
      routeId: json['routeId'] as String,
      customerId: json['customerId'] as String,
      plannedTime: json['plannedTime'] == null
          ? null
          : DateTime.parse(json['plannedTime'] as String),
      sequence: (json['sequence'] as num?)?.toInt(),
      notes: json['notes'] as String?,
      customer: json['customer'] == null
          ? null
          : Customer.fromJson(json['customer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$RouteStopImplToJson(_$RouteStopImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'routeId': instance.routeId,
      'customerId': instance.customerId,
      'plannedTime': instance.plannedTime?.toIso8601String(),
      'sequence': instance.sequence,
      'notes': instance.notes,
      'customer': instance.customer,
    };

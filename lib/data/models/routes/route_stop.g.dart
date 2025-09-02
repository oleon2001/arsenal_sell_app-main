// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_stop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RouteStopImpl _$$RouteStopImplFromJson(Map<String, dynamic> json) =>
    _$RouteStopImpl(
      id: json['id'] as String,
      routeId: json['routeId'] as String,
      customerId: json['customerId'] as String,
      plannedTime: json['plannedTime'] == null
          ? null
          : DateTime.parse(json['plannedTime'] as String),
      actualArrivalTime: json['actualArrivalTime'] == null
          ? null
          : DateTime.parse(json['actualArrivalTime'] as String),
      actualDepartureTime: json['actualDepartureTime'] == null
          ? null
          : DateTime.parse(json['actualDepartureTime'] as String),
      sequence: (json['sequence'] as num?)?.toInt(),
      notes: json['notes'] as String?,
      status: $enumDecodeNullable(_$RouteStopStatusEnumMap, json['status']) ??
          RouteStopStatus.pending,
      distanceFromPrevious:
          (json['distanceFromPrevious'] as num?)?.toDouble() ?? 0.0,
      estimatedDuration: (json['estimatedDuration'] as num?)?.toInt() ?? 0,
      customer: json['customer'] == null
          ? null
          : Customer.fromJson(json['customer'] as Map<String, dynamic>),
      visit: json['visit'] == null
          ? null
          : Visit.fromJson(json['visit'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$RouteStopImplToJson(_$RouteStopImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'routeId': instance.routeId,
      'customerId': instance.customerId,
      'plannedTime': instance.plannedTime?.toIso8601String(),
      'actualArrivalTime': instance.actualArrivalTime?.toIso8601String(),
      'actualDepartureTime': instance.actualDepartureTime?.toIso8601String(),
      'sequence': instance.sequence,
      'notes': instance.notes,
      'status': _$RouteStopStatusEnumMap[instance.status]!,
      'distanceFromPrevious': instance.distanceFromPrevious,
      'estimatedDuration': instance.estimatedDuration,
      'customer': instance.customer,
      'visit': instance.visit,
    };

const _$RouteStopStatusEnumMap = {
  RouteStopStatus.pending: 'PENDING',
  RouteStopStatus.inProgress: 'IN_PROGRESS',
  RouteStopStatus.completed: 'COMPLETED',
  RouteStopStatus.skipped: 'SKIPPED',
  RouteStopStatus.cancelled: 'CANCELLED',
};

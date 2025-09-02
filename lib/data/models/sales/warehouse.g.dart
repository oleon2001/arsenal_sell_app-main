// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WarehouseImpl _$$WarehouseImplFromJson(Map<String, dynamic> json) =>
    _$WarehouseImpl(
      id: json['id'] as String,
      companyId: json['companyId'] as String,
      name: json['name'] as String,
      address: json['address'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$WarehouseImplToJson(_$WarehouseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'name': instance.name,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

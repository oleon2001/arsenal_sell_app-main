// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressImpl _$$AddressImplFromJson(Map<String, dynamic> json) =>
    _$AddressImpl(
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zipCode'] as String,
      country: json['country'] as String? ?? 'México',
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      neighborhood: json['neighborhood'] as String?,
      references: json['references'] as String?,
      isMainAddress: json['isMainAddress'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$AddressImplToJson(_$AddressImpl instance) =>
    <String, dynamic>{
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
      'country': instance.country,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'neighborhood': instance.neighborhood,
      'references': instance.references,
      'isMainAddress': instance.isMainAddress,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

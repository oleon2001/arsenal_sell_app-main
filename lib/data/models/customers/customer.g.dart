// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerImpl _$$CustomerImplFromJson(Map<String, dynamic> json) =>
    _$CustomerImpl(
      id: json['id'] as String,
      companyId: json['companyId'] as String,
      code: json['code'] as String?,
      name: json['name'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      geoAccuracyM: (json['geoAccuracyM'] as num?)?.toDouble(),
      createdBy: json['createdBy'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$CustomerImplToJson(_$CustomerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'code': instance.code,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'geoAccuracyM': instance.geoAccuracyM,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$AddressImpl _$$AddressImplFromJson(Map<String, dynamic> json) =>
    _$AddressImpl(
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zipCode'] as String,
      country: json['country'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
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
    };

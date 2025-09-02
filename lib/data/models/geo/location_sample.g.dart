// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_sample.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationSampleImpl _$$LocationSampleImplFromJson(Map<String, dynamic> json) =>
    _$LocationSampleImpl(
      id: (json['id'] as num).toInt(),
      companyId: json['companyId'] as String,
      userId: json['userId'] as String,
      at: DateTime.parse(json['at'] as String),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      speedMs: (json['speedMs'] as num?)?.toDouble(),
      accuracyM: (json['accuracyM'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$LocationSampleImplToJson(
        _$LocationSampleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'userId': instance.userId,
      'at': instance.at.toIso8601String(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'speedMs': instance.speedMs,
      'accuracyM': instance.accuracyM,
    };

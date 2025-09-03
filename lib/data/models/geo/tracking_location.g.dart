// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracking_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrackingLocationImpl _$$TrackingLocationImplFromJson(
        Map<String, dynamic> json) =>
    _$TrackingLocationImpl(
      id: (json['id'] as num).toInt(),
      companyId: json['companyId'] as String,
      userId: json['userId'] as String,
      at: DateTime.parse(json['at'] as String),
      point: json['point'] as Map<String, dynamic>,
      speedMS: (json['speedMS'] as num?)?.toDouble(),
      accuracyM: (json['accuracyM'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$TrackingLocationImplToJson(
        _$TrackingLocationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'userId': instance.userId,
      'at': instance.at.toIso8601String(),
      'point': instance.point,
      'speedMS': instance.speedMS,
      'accuracyM': instance.accuracyM,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FormResponseImpl _$$FormResponseImplFromJson(Map<String, dynamic> json) =>
    _$FormResponseImpl(
      id: json['id'] as String,
      templateId: json['templateId'] as String?,
      customerId: json['customerId'] as String?,
      visitId: json['visitId'] as String?,
      userId: json['userId'] as String?,
      answers: json['answers'] as Map<String, dynamic>,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$FormResponseImplToJson(_$FormResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'templateId': instance.templateId,
      'customerId': instance.customerId,
      'visitId': instance.visitId,
      'userId': instance.userId,
      'answers': instance.answers,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

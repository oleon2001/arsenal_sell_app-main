// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FormTemplateImpl _$$FormTemplateImplFromJson(Map<String, dynamic> json) =>
    _$FormTemplateImpl(
      id: json['id'] as String,
      companyId: json['companyId'] as String,
      name: json['name'] as String,
      schema: json['schema'] as Map<String, dynamic>,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$FormTemplateImplToJson(_$FormTemplateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'name': instance.name,
      'schema': instance.schema,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

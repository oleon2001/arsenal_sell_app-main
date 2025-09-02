// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuditLogImpl _$$AuditLogImplFromJson(Map<String, dynamic> json) =>
    _$AuditLogImpl(
      id: (json['id'] as num).toInt(),
      companyId: json['companyId'] as String,
      actorId: json['actorId'] as String?,
      action: json['action'] as String,
      entity: json['entity'] as String?,
      entityId: json['entityId'] as String?,
      details: json['details'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$AuditLogImplToJson(_$AuditLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'actorId': instance.actorId,
      'action': instance.action,
      'entity': instance.entity,
      'entityId': instance.entityId,
      'details': instance.details,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

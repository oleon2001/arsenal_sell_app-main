// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_queue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmailQueueImpl _$$EmailQueueImplFromJson(Map<String, dynamic> json) =>
    _$EmailQueueImpl(
      id: (json['id'] as num).toInt(),
      toEmail: json['toEmail'] as String,
      subject: json['subject'] as String,
      body: json['body'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      sentAt: json['sentAt'] == null
          ? null
          : DateTime.parse(json['sentAt'] as String),
    );

Map<String, dynamic> _$$EmailQueueImplToJson(_$EmailQueueImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'toEmail': instance.toEmail,
      'subject': instance.subject,
      'body': instance.body,
      'createdAt': instance.createdAt?.toIso8601String(),
      'sentAt': instance.sentAt?.toIso8601String(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_signature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VisitSignatureImpl _$$VisitSignatureImplFromJson(Map<String, dynamic> json) =>
    _$VisitSignatureImpl(
      id: json['id'] as String,
      visitId: json['visitId'] as String,
      storagePath: json['storagePath'] as String,
      signedBy: json['signedBy'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$VisitSignatureImplToJson(
        _$VisitSignatureImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'visitId': instance.visitId,
      'storagePath': instance.storagePath,
      'signedBy': instance.signedBy,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

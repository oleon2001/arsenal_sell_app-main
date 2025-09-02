// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VisitPhotoImpl _$$VisitPhotoImplFromJson(Map<String, dynamic> json) =>
    _$VisitPhotoImpl(
      id: json['id'] as String,
      visitId: json['visitId'] as String,
      storagePath: json['storagePath'] as String,
      localPath: json['localPath'] as String?,
      publicUrl: json['publicUrl'] as String?,
      description: json['description'] as String?,
      type: $enumDecodeNullable(_$PhotoTypeEnumMap, json['type']) ??
          PhotoType.general,
      status: $enumDecodeNullable(_$PhotoStatusEnumMap, json['status']) ??
          PhotoStatus.pendingUpload,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      uploadedAt: json['uploadedAt'] == null
          ? null
          : DateTime.parse(json['uploadedAt'] as String),
      fileSize: (json['fileSize'] as num?)?.toInt() ?? 0,
      mimeType: json['mimeType'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      isRequired: json['isRequired'] as bool? ?? false,
      isSynced: json['isSynced'] as bool? ?? false,
    );

Map<String, dynamic> _$$VisitPhotoImplToJson(_$VisitPhotoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'visitId': instance.visitId,
      'storagePath': instance.storagePath,
      'localPath': instance.localPath,
      'publicUrl': instance.publicUrl,
      'description': instance.description,
      'type': _$PhotoTypeEnumMap[instance.type]!,
      'status': _$PhotoStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt?.toIso8601String(),
      'uploadedAt': instance.uploadedAt?.toIso8601String(),
      'fileSize': instance.fileSize,
      'mimeType': instance.mimeType,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'isRequired': instance.isRequired,
      'isSynced': instance.isSynced,
    };

const _$PhotoTypeEnumMap = {
  PhotoType.general: 'GENERAL',
  PhotoType.product: 'PRODUCT',
  PhotoType.receipt: 'RECEIPT',
  PhotoType.damage: 'DAMAGE',
  PhotoType.inventory: 'INVENTORY',
  PhotoType.storefront: 'STOREFRONT',
  PhotoType.evidence: 'EVIDENCE',
};

const _$PhotoStatusEnumMap = {
  PhotoStatus.pendingUpload: 'PENDING_UPLOAD',
  PhotoStatus.uploading: 'UPLOADING',
  PhotoStatus.uploaded: 'UPLOADED',
  PhotoStatus.failed: 'FAILED',
};

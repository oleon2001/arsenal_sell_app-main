// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VisitSignatureImpl _$$VisitSignatureImplFromJson(Map<String, dynamic> json) =>
    _$VisitSignatureImpl(
      id: json['id'] as String,
      visitId: json['visitId'] as String,
      storagePath: json['storagePath'] as String,
      localPath: json['localPath'] as String?,
      publicUrl: json['publicUrl'] as String?,
      signedBy: json['signedBy'] as String?,
      signerTitle: json['signerTitle'] as String?,
      signerDocument: json['signerDocument'] as String?,
      signerPhone: json['signerPhone'] as String?,
      signerEmail: json['signerEmail'] as String?,
      type: $enumDecodeNullable(_$SignatureTypeEnumMap, json['type']) ??
          SignatureType.visitConfirmation,
      status: $enumDecodeNullable(_$SignatureStatusEnumMap, json['status']) ??
          SignatureStatus.pendingUpload,
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
      notes: json['notes'] as String?,
      canvasWidth: (json['canvasWidth'] as num?)?.toInt() ?? 600,
      canvasHeight: (json['canvasHeight'] as num?)?.toInt() ?? 300,
    );

Map<String, dynamic> _$$VisitSignatureImplToJson(
        _$VisitSignatureImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'visitId': instance.visitId,
      'storagePath': instance.storagePath,
      'localPath': instance.localPath,
      'publicUrl': instance.publicUrl,
      'signedBy': instance.signedBy,
      'signerTitle': instance.signerTitle,
      'signerDocument': instance.signerDocument,
      'signerPhone': instance.signerPhone,
      'signerEmail': instance.signerEmail,
      'type': _$SignatureTypeEnumMap[instance.type]!,
      'status': _$SignatureStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt?.toIso8601String(),
      'uploadedAt': instance.uploadedAt?.toIso8601String(),
      'fileSize': instance.fileSize,
      'mimeType': instance.mimeType,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'isRequired': instance.isRequired,
      'isSynced': instance.isSynced,
      'notes': instance.notes,
      'canvasWidth': instance.canvasWidth,
      'canvasHeight': instance.canvasHeight,
    };

const _$SignatureTypeEnumMap = {
  SignatureType.visitConfirmation: 'VISIT_CONFIRMATION',
  SignatureType.deliveryReceipt: 'DELIVERY_RECEIPT',
  SignatureType.paymentReceipt: 'PAYMENT_RECEIPT',
  SignatureType.contract: 'CONTRACT',
  SignatureType.inspection: 'INSPECTION',
  SignatureType.other: 'OTHER',
};

const _$SignatureStatusEnumMap = {
  SignatureStatus.pendingUpload: 'PENDING_UPLOAD',
  SignatureStatus.uploading: 'UPLOADING',
  SignatureStatus.uploaded: 'UPLOADED',
  SignatureStatus.failed: 'FAILED',
};

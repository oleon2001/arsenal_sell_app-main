import 'dart:math';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'signature.freezed.dart';
part 'signature.g.dart';

enum SignatureStatus {
  @JsonValue('PENDING_UPLOAD')
  pendingUpload,
  @JsonValue('UPLOADING')
  uploading,
  @JsonValue('UPLOADED')
  uploaded,
  @JsonValue('FAILED')
  failed,
}

enum SignatureType {
  @JsonValue('VISIT_CONFIRMATION')
  visitConfirmation,
  @JsonValue('DELIVERY_RECEIPT')
  deliveryReceipt,
  @JsonValue('PAYMENT_RECEIPT')
  paymentReceipt,
  @JsonValue('CONTRACT')
  contract,
  @JsonValue('INSPECTION')
  inspection,
  @JsonValue('OTHER')
  other,
}

@freezed
class VisitSignature with _$VisitSignature {
  const factory VisitSignature({
    required String id,
    required String visitId,
    required String storagePath,
    String? localPath,
    String? publicUrl,
    String? signedBy,
    String? signerTitle,
    String? signerDocument,
    String? signerPhone,
    String? signerEmail,
    @Default(SignatureType.visitConfirmation) SignatureType type,
    @Default(SignatureStatus.pendingUpload) SignatureStatus status,
    DateTime? createdAt,
    DateTime? uploadedAt,
    @Default(0) int fileSize, // in bytes
    String? mimeType,
    double? latitude,
    double? longitude,
    @Default(false) bool isRequired,
    @Default(false) bool isSynced,
    String? notes,
    @Default(600) int canvasWidth,
    @Default(300) int canvasHeight,
  }) = _VisitSignature;

  factory VisitSignature.fromJson(Map<String, dynamic> json) =>
      _$VisitSignatureFromJson(json);
}

// Extensions for business logic
extension VisitSignatureX on VisitSignature {
  /// Check if signature is uploaded
  bool get isUploaded => status == SignatureStatus.uploaded;

  /// Check if signature is pending upload
  bool get isPendingUpload => status == SignatureStatus.pendingUpload;

  /// Check if signature is currently uploading
  bool get isUploading => status == SignatureStatus.uploading;

  /// Check if signature upload failed
  bool get hasFailed => status == SignatureStatus.failed;

  /// Check if signature has coordinates
  bool get hasCoordinates => latitude != null && longitude != null;

  /// Check if signer information is complete
  bool get hasCompleteSignerInfo => signedBy != null && signedBy!.isNotEmpty;

  /// Get formatted file size
  String get formattedFileSize {
    if (fileSize == 0) return 'Tamaño desconocido';

    const int kb = 1024;
    const int mb = kb * 1024;

    if (fileSize < kb) {
      return '$fileSize bytes';
    } else if (fileSize < mb) {
      return '${(fileSize / kb).toStringAsFixed(1)} KB';
    } else {
      return '${(fileSize / mb).toStringAsFixed(1)} MB';
    }
  }

  /// Get signature type display name
  String get typeDisplayName {
    switch (type) {
      case SignatureType.visitConfirmation:
        return 'Confirmación de Visita';
      case SignatureType.deliveryReceipt:
        return 'Recibo de Entrega';
      case SignatureType.paymentReceipt:
        return 'Recibo de Pago';
      case SignatureType.contract:
        return 'Contrato';
      case SignatureType.inspection:
        return 'Inspección';
      case SignatureType.other:
        return 'Otro';
    }
  }

  /// Get status display name
  String get statusDisplayName {
    switch (status) {
      case SignatureStatus.pendingUpload:
        return 'Pendiente de subir';
      case SignatureStatus.uploading:
        return 'Subiendo...';
      case SignatureStatus.uploaded:
        return 'Subida';
      case SignatureStatus.failed:
        return 'Error';
    }
  }

  /// Get status color for UI
  Color get statusColor {
    switch (status) {
      case SignatureStatus.pendingUpload:
        return Colors.orange;
      case SignatureStatus.uploading:
        return Colors.blue;
      case SignatureStatus.uploaded:
        return Colors.green;
      case SignatureStatus.failed:
        return Colors.red;
    }
  }

  /// Get file extension from storage path
  String get fileExtension {
    final parts = storagePath.split('.');
    return parts.isNotEmpty ? parts.last.toLowerCase() : 'png';
  }

  /// Get formatted creation date
  String get formattedCreatedAt {
    if (createdAt == null) return 'Fecha desconocida';
    return '${createdAt!.day.toString().padLeft(2, '0')}/${createdAt!.month.toString().padLeft(2, '0')}/${createdAt!.year} ${createdAt!.hour.toString().padLeft(2, '0')}:${createdAt!.minute.toString().padLeft(2, '0')}';
  }

  /// Get formatted upload date
  String get formattedUploadedAt {
    if (uploadedAt == null) return 'No subida';
    return '${uploadedAt!.day.toString().padLeft(2, '0')}/${uploadedAt!.month.toString().padLeft(2, '0')}/${uploadedAt!.year} ${uploadedAt!.hour.toString().padLeft(2, '0')}:${uploadedAt!.minute.toString().padLeft(2, '0')}';
  }

  /// Get signer display name
  String get signerDisplayName {
    if (signedBy == null || signedBy!.isEmpty) return 'Firmante desconocido';

    if (signerTitle != null && signerTitle!.isNotEmpty) {
      return '$signedBy ($signerTitle)';
    }

    return signedBy!;
  }

  /// Get signer contact info
  String get signerContactInfo {
    final contacts = <String>[];

    if (signerPhone != null && signerPhone!.isNotEmpty) {
      contacts.add('Tel: $signerPhone');
    }

    if (signerEmail != null && signerEmail!.isNotEmpty) {
      contacts.add('Email: $signerEmail');
    }

    return contacts.isNotEmpty
        ? contacts.join(' • ')
        : 'Sin información de contacto';
  }

  /// Create a copy to mark as uploading
  VisitSignature markAsUploading() =>
      copyWith(status: SignatureStatus.uploading);

  /// Create a copy to mark as uploaded
  VisitSignature markAsUploaded({
    String? url,
    DateTime? uploadTime,
  }) =>
      copyWith(
        status: SignatureStatus.uploaded,
        publicUrl: url ?? publicUrl,
        uploadedAt: uploadTime ?? DateTime.now(),
        isSynced: true,
      );

  /// Create a copy to mark as failed
  VisitSignature markAsFailed() => copyWith(status: SignatureStatus.failed);

  /// Create a copy with coordinates
  VisitSignature withCoordinates({
    required double lat,
    required double lng,
  }) =>
      copyWith(
        latitude: lat,
        longitude: lng,
      );

  /// Create a copy with signer information
  VisitSignature withSignerInfo({
    required String name,
    String? title,
    String? document,
    String? phone,
    String? email,
  }) =>
      copyWith(
        signedBy: name,
        signerTitle: title,
        signerDocument: document,
        signerPhone: phone,
        signerEmail: email,
      );

  /// Create a copy with notes
  VisitSignature withNotes(String signatureNotes) =>
      copyWith(notes: signatureNotes);

  /// Validate if the signature is valid
  bool get isValid =>
      id.isNotEmpty &&
      visitId.isNotEmpty &&
      storagePath.isNotEmpty &&
      fileSize >= 0 &&
      canvasWidth > 0 &&
      canvasHeight > 0;

  /// Check if signature can be deleted
  bool get canDelete => !isRequired || status == SignatureStatus.failed;

  /// Check if signature can be retried
  bool get canRetry => status == SignatureStatus.failed;

  /// Get coordinates as a formatted string
  String get formattedCoordinates {
    if (!hasCoordinates) return 'Sin coordenadas';
    return '${latitude!.toStringAsFixed(6)}, ${longitude!.toStringAsFixed(6)}';
  }

  /// Calculate distance from another point
  double? distanceFrom({
    required double targetLat,
    required double targetLng,
  }) {
    if (!hasCoordinates) return null;

    // Simple distance calculation using Haversine formula
    const double earthRadius = 6371000; // Earth's radius in meters

    final double lat1Rad = latitude! * (pi / 180);
    final double lat2Rad = targetLat * (pi / 180);
    final double deltaLatRad = (targetLat - latitude!) * (pi / 180);
    final double deltaLngRad = (targetLng - longitude!) * (pi / 180);

    final double a = sin(deltaLatRad / 2) * sin(deltaLatRad / 2) +
        cos(lat1Rad) *
            cos(lat2Rad) *
            sin(deltaLngRad / 2) *
            sin(deltaLngRad / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    final double distance = earthRadius * c;

    return distance;
  }

  /// Get a unique filename based on visit and timestamp
  String get suggestedFileName {
    final timestamp = (createdAt ?? DateTime.now()).millisecondsSinceEpoch;
    final extension = fileExtension.isNotEmpty ? '.$fileExtension' : '.png';
    return 'signature_visit_${visitId}_${type.name}_$timestamp$extension';
  }

  /// Get canvas aspect ratio
  double get aspectRatio {
    if (canvasHeight == 0) return 2; // Default aspect ratio
    return canvasWidth / canvasHeight;
  }

  /// Check if signature dimensions are valid
  bool get hasValidDimensions =>
      canvasWidth > 0 &&
      canvasHeight > 0 &&
      canvasWidth <= 2000 &&
      canvasHeight <= 1000;

  /// Get signature summary for display
  String get signatureSummary {
    final parts = <String>[];

    parts.add('Firmado por: ${signedBy ?? 'Desconocido'}');

    if (createdAt != null) {
      parts.add('Fecha: $formattedCreatedAt');
    }

    if (hasCoordinates) {
      parts.add('Ubicación: $formattedCoordinates');
    }

    return parts.join('\n');
  }

  /// Check if signature is legally valid
  bool get isLegallyValid =>
      hasCompleteSignerInfo &&
      isUploaded &&
      createdAt != null &&
      hasValidDimensions;
}

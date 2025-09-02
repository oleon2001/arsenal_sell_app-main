import 'dart:math';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'visit_photo.freezed.dart';
part 'visit_photo.g.dart';

enum PhotoType {
  @JsonValue('GENERAL')
  general,
  @JsonValue('PRODUCT')
  product,
  @JsonValue('RECEIPT')
  receipt,
  @JsonValue('DAMAGE')
  damage,
  @JsonValue('INVENTORY')
  inventory,
  @JsonValue('STOREFRONT')
  storefront,
  @JsonValue('EVIDENCE')
  evidence,
}

enum PhotoStatus {
  @JsonValue('PENDING_UPLOAD')
  pendingUpload,
  @JsonValue('UPLOADING')
  uploading,
  @JsonValue('UPLOADED')
  uploaded,
  @JsonValue('FAILED')
  failed,
}

@freezed
class VisitPhoto with _$VisitPhoto {
  const factory VisitPhoto({
    required String id,
    required String visitId,
    required String storagePath,
    String? localPath,
    String? publicUrl,
    String? description,
    @Default(PhotoType.general) PhotoType type,
    @Default(PhotoStatus.pendingUpload) PhotoStatus status,
    DateTime? createdAt,
    DateTime? uploadedAt,
    @Default(0) int fileSize, // in bytes
    String? mimeType,
    double? latitude,
    double? longitude,
    @Default(false) bool isRequired,
    @Default(false) bool isSynced,
  }) = _VisitPhoto;

  factory VisitPhoto.fromJson(Map<String, dynamic> json) =>
      _$VisitPhotoFromJson(json);
}

// Extensions for business logic
extension VisitPhotoX on VisitPhoto {
  /// Check if photo is uploaded
  bool get isUploaded => status == PhotoStatus.uploaded;

  /// Check if photo is pending upload
  bool get isPendingUpload => status == PhotoStatus.pendingUpload;

  /// Check if photo is currently uploading
  bool get isUploading => status == PhotoStatus.uploading;

  /// Check if photo upload failed
  bool get hasFailed => status == PhotoStatus.failed;

  /// Check if photo has coordinates
  bool get hasCoordinates => latitude != null && longitude != null;

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

  /// Get photo type display name
  String get typeDisplayName {
    switch (type) {
      case PhotoType.general:
        return 'General';
      case PhotoType.product:
        return 'Producto';
      case PhotoType.receipt:
        return 'Recibo';
      case PhotoType.damage:
        return 'Daño';
      case PhotoType.inventory:
        return 'Inventario';
      case PhotoType.storefront:
        return 'Fachada';
      case PhotoType.evidence:
        return 'Evidencia';
    }
  }

  /// Get status display name
  String get statusDisplayName {
    switch (status) {
      case PhotoStatus.pendingUpload:
        return 'Pendiente de subir';
      case PhotoStatus.uploading:
        return 'Subiendo...';
      case PhotoStatus.uploaded:
        return 'Subida';
      case PhotoStatus.failed:
        return 'Error';
    }
  }

  /// Get status color for UI
  Color get statusColor {
    switch (status) {
      case PhotoStatus.pendingUpload:
        return Colors.orange;
      case PhotoStatus.uploading:
        return Colors.blue;
      case PhotoStatus.uploaded:
        return Colors.green;
      case PhotoStatus.failed:
        return Colors.red;
    }
  }

  /// Get file extension from storage path
  String get fileExtension {
    final parts = storagePath.split('.');
    return parts.isNotEmpty ? parts.last.toLowerCase() : '';
  }

  /// Check if it's an image file
  bool get isImage {
    const imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'webp'];
    return imageExtensions.contains(fileExtension);
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

  /// Create a copy to mark as uploading
  VisitPhoto markAsUploading() => copyWith(status: PhotoStatus.uploading);

  /// Create a copy to mark as uploaded
  VisitPhoto markAsUploaded({
    String? url,
    DateTime? uploadTime,
  }) =>
      copyWith(
        status: PhotoStatus.uploaded,
        publicUrl: url ?? publicUrl,
        uploadedAt: uploadTime ?? DateTime.now(),
        isSynced: true,
      );

  /// Create a copy to mark as failed
  VisitPhoto markAsFailed() => copyWith(status: PhotoStatus.failed);

  /// Create a copy with coordinates
  VisitPhoto withCoordinates({
    required double lat,
    required double lng,
  }) =>
      copyWith(
        latitude: lat,
        longitude: lng,
      );

  /// Create a copy with description
  VisitPhoto withDescription(String desc) => copyWith(description: desc);

  /// Validate if the photo is valid
  bool get isValid =>
      id.isNotEmpty &&
      visitId.isNotEmpty &&
      storagePath.isNotEmpty &&
      fileSize >= 0;

  /// Get thumbnail URL (if available)
  String? get thumbnailUrl {
    if (publicUrl == null) return null;
    // In a real implementation, you might have thumbnail URLs
    // For now, return the same URL
    return publicUrl;
  }

  /// Check if photo can be deleted
  bool get canDelete => !isRequired || status == PhotoStatus.failed;

  /// Check if photo can be retried
  bool get canRetry => status == PhotoStatus.failed;

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
    final extension = fileExtension.isNotEmpty ? '.$fileExtension' : '.jpg';
    return 'visit_${visitId}_${type.name}_$timestamp$extension';
  }
}

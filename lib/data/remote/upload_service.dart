import 'dart:io';
import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../../config/logger.dart';
import '../../config/app_constants.dart';
import '../models/auth/user_profile.dart';

enum UploadBucket {
  evidencePhotos('evidence-photos'),
  signatures('signatures'),
  documents('documents');

  const UploadBucket(this.name);
  final String name;
}

class UploadResult {
  UploadResult({
    required this.path,
    required this.publicUrl,
    required this.size,
    required this.mimeType,
  });
  final String path;
  final String publicUrl;
  final int size;
  final String mimeType;
}

class UploadService {
  final SupabaseClient _client = Supabase.instance.client;

  /// Upload a photo file
  Future<UploadResult> uploadPhoto({
    required File file,
    required String companyId,
    required String userId,
    String? visitId,
    String? customerId,
  }) async {
    try {
      // Validate file
      _validateImageFile(file);

      final fileName = _generateFileName(
        userId: userId,
        visitId: visitId,
        customerId: customerId,
        extension: path.extension(file.path),
      );

      final filePath = '$companyId/$userId/$fileName';

      final response = await _client.storage
          .from(UploadBucket.evidencePhotos.name)
          .upload(filePath, file);

      final publicUrl = _client.storage
          .from(UploadBucket.evidencePhotos.name)
          .getPublicUrl(filePath);

      final fileSize = await file.length();

      return UploadResult(
        path: filePath,
        publicUrl: publicUrl,
        size: fileSize,
        mimeType: _getMimeType(file.path),
      );
    } catch (e) {
      logger.e('Upload photo error: $e');
      rethrow;
    }
  }

  /// Upload signature data
  Future<UploadResult> uploadSignature({
    required Uint8List signatureData,
    required String companyId,
    required String userId,
    required String visitId,
    String? signedBy,
  }) async {
    try {
      // Validate signature data
      if (signatureData.isEmpty) {
        throw Exception('Signature data is empty');
      }

      if (signatureData.length > AppConstants.maxPhotoSize) {
        throw Exception('Signature file too large');
      }

      final fileName = _generateSignatureFileName(
        userId: userId,
        visitId: visitId,
        signedBy: signedBy,
      );

      final filePath = '$companyId/$userId/signatures/$fileName';

      final response = await _client.storage
          .from(UploadBucket.signatures.name)
          .uploadBinary(filePath, signatureData);

      final publicUrl = _client.storage
          .from(UploadBucket.signatures.name)
          .getPublicUrl(filePath);

      return UploadResult(
        path: filePath,
        publicUrl: publicUrl,
        size: signatureData.length,
        mimeType: 'image/png',
      );
    } catch (e) {
      logger.e('Upload signature error: $e');
      rethrow;
    }
  }

  /// Upload document file
  Future<UploadResult> uploadDocument({
    required File file,
    required String companyId,
    required String userId,
    String? category,
  }) async {
    try {
      // Validate file
      _validateDocumentFile(file);

      final fileName = _generateDocumentFileName(
        userId: userId,
        originalName: path.basename(file.path),
        category: category,
      );

      final filePath = '$companyId/$userId/documents/$fileName';

      final response = await _client.storage
          .from(UploadBucket.documents.name)
          .upload(filePath, file);

      final publicUrl = _client.storage
          .from(UploadBucket.documents.name)
          .getPublicUrl(filePath);

      final fileSize = await file.length();

      return UploadResult(
        path: filePath,
        publicUrl: publicUrl,
        size: fileSize,
        mimeType: _getMimeType(file.path),
      );
    } catch (e) {
      logger.e('Upload document error: $e');
      rethrow;
    }
  }

  /// Upload multiple photos
  Future<List<UploadResult>> uploadMultiplePhotos({
    required List<File> files,
    required String companyId,
    required String userId,
    String? visitId,
    String? customerId,
  }) async {
    final results = <UploadResult>[];

    for (final file in files) {
      try {
        final result = await uploadPhoto(
          file: file,
          companyId: companyId,
          userId: userId,
          visitId: visitId,
          customerId: customerId,
        );
        results.add(result);
      } catch (e) {
        logger.e('Failed to upload photo ${file.path}: $e');
        // Continue with other files
      }
    }

    return results;
  }

  /// Delete file from storage
  Future<void> deleteFile(UploadBucket bucket, String filePath) async {
    try {
      await _client.storage.from(bucket.name).remove([filePath]);
    } catch (e) {
      logger.e('Delete file error: $e');
      rethrow;
    }
  }

  /// Get file download URL
  Future<String> getDownloadUrl(UploadBucket bucket, String filePath) async {
    try {
      return _client.storage.from(bucket.name).getPublicUrl(filePath);
    } catch (e) {
      logger.e('Get download URL error: $e');
      rethrow;
    }
  }

  /// Create signed URL for temporary access
  Future<String> createSignedUrl({
    required UploadBucket bucket,
    required String filePath,
    int expiresInMinutes = 60,
  }) async {
    try {
      return await _client.storage
          .from(bucket.name)
          .createSignedUrl(filePath, expiresInMinutes * 60);
    } catch (e) {
      logger.e('Create signed URL error: $e');
      rethrow;
    }
  }

  /// List files in a directory
  Future<List<FileObject>> listFiles({
    required UploadBucket bucket,
    required String directory,
    int limit = 100,
  }) async {
    try {
      final files =
          await _client.storage.from(bucket.name).list(path: directory);

      // Apply limit manually if needed
      return files.take(limit).toList();
    } catch (e) {
      logger.e('List files error: $e');
      rethrow;
    }
  }

  /// Get file metadata
  Future<FileObject?> getFileMetadata(
      UploadBucket bucket, String filePath) async {
    try {
      final files = await _client.storage
          .from(bucket.name)
          .list(path: path.dirname(filePath));

      final fileName = path.basename(filePath);
      return files.firstWhere(
        (file) => file.name == fileName,
        orElse: () => throw Exception('File not found'),
      );
    } catch (e) {
      logger.e('Get file metadata error: $e');
      return null;
    }
  }

  // Private helper methods
  String _generateFileName({
    required String userId,
    String? visitId,
    String? customerId,
    required String extension,
  }) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final hash = _generateHash('$userId$visitId$customerId$timestamp');

    String prefix = 'photo';
    if (visitId != null) prefix = 'visit_$visitId';
    if (customerId != null) prefix += '_customer_$customerId';

    return '${prefix}_${timestamp}_$hash$extension';
  }

  String _generateSignatureFileName({
    required String userId,
    required String visitId,
    String? signedBy,
  }) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final hash = _generateHash('$userId$visitId$signedBy$timestamp');

    return 'signature_visit_${visitId}_${timestamp}_$hash.png';
  }

  String _generateDocumentFileName({
    required String userId,
    required String originalName,
    String? category,
  }) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final extension = path.extension(originalName);
    final nameWithoutExt = path.basenameWithoutExtension(originalName);
    final sanitizedName = _sanitizeFileName(nameWithoutExt);

    final String prefix = category ?? 'document';
    return '${prefix}_${timestamp}_$sanitizedName$extension';
  }

  String _generateHash(String input) {
    final bytes = utf8.encode(input);
    final digest = md5.convert(bytes);
    return digest.toString().substring(0, 8);
  }

  String _sanitizeFileName(String fileName) => fileName
      .replaceAll(RegExp(r'[^\w\-_.]'), '_')
      .replaceAll(RegExp('_+'), '_')
      .toLowerCase();

  void _validateImageFile(File file) {
    final extension = path.extension(file.path).toLowerCase();
    if (!AppConstants.allowedImageTypes.contains(extension.substring(1))) {
      throw Exception(
          'Invalid image file type. Allowed: ${AppConstants.allowedImageTypes.join(', ')}');
    }
  }

  void _validateDocumentFile(File file) {
    final fileSize = file.lengthSync();
    if (fileSize > AppConstants.maxPhotoSize * 2) {
      // Documents can be larger
      throw Exception(
          'Document file too large. Max size: ${(AppConstants.maxPhotoSize * 2) / (1024 * 1024)}MB');
    }
  }

  String _getMimeType(String filePath) {
    final extension = path.extension(filePath).toLowerCase();
    switch (extension) {
      case '.jpg':
      case '.jpeg':
        return 'image/jpeg';
      case '.png':
        return 'image/png';
      case '.gif':
        return 'image/gif';
      case '.webp':
        return 'image/webp';
      case '.pdf':
        return 'application/pdf';
      case '.doc':
        return 'application/msword';
      case '.docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case '.txt':
        return 'text/plain';
      default:
        return 'application/octet-stream';
    }
  }

  /// Compress image before upload (optional)
  Future<File> compressImage(File file, {int quality = 80}) async {
    // This would require image compression library
    // For now, return the original file
    return file;
  }

  /// Generate thumbnail (optional)
  Future<Uint8List?> generateThumbnail(File imageFile, {int size = 200}) async {
    // This would require image processing library
    // For now, return null
    return null;
  }

  /// Batch upload with progress tracking
  Future<List<UploadResult>> batchUpload({
    required List<File> files,
    required String companyId,
    required String userId,
    Function(int uploaded, int total)? onProgress,
  }) async {
    final results = <UploadResult>[];

    for (int i = 0; i < files.length; i++) {
      try {
        final result = await uploadPhoto(
          file: files[i],
          companyId: companyId,
          userId: userId,
        );
        results.add(result);
        onProgress?.call(i + 1, files.length);
      } catch (e) {
        logger.e('Batch upload failed for file ${files[i].path}: $e');
      }
    }

    return results;
  }
}

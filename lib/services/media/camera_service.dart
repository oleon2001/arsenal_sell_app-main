import 'dart:io';
import 'dart:typed_data'; // Added for Uint8List

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../config/app_constants.dart';
import '../../config/logger.dart';

class CameraService {
  static final ImagePicker _picker = ImagePicker();

  /// Obtiene o crea el directorio de fotos
  static Future<Directory> _getPhotosDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final photosDir = Directory(path.join(appDir.path, 'photos'));
    
    if (!await photosDir.exists()) {
      await photosDir.create(recursive: true);
      logger.i('Created photos directory: ${photosDir.path}');
    }
    
    return photosDir;
  }

  static Future<File?> takePicture() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (image != null) {
        final file = File(image.path);

        // Check file size
        final fileSize = await file.length();
        if (fileSize > AppConstants.maxPhotoSize) {
          throw Exception(
              'File size too large. Maximum size is ${AppConstants.maxPhotoSize / (1024 * 1024)}MB');
        }

        // Get or create photos directory
        final photosDir = await _getPhotosDirectory();
        final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
        final savedFile = await file.copy(path.join(photosDir.path, fileName));

        logger.i('Photo saved successfully: ${savedFile.path}');
        return savedFile;
      }
      return null;
    } catch (e) {
      logger.e('Take picture error: $e');
      rethrow;
    }
  }

  static Future<File?> pickFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (image != null) {
        final file = File(image.path);

        // Check file size
        final fileSize = await file.length();
        if (fileSize > AppConstants.maxPhotoSize) {
          throw Exception(
              'File size too large. Maximum size is ${AppConstants.maxPhotoSize / (1024 * 1024)}MB');
        }

        return file;
      }
      return null;
    } catch (e) {
      logger.e('Pick from gallery error: $e');
      rethrow;
    }
  }

  static Future<List<File>> pickMultipleFromGallery() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      final List<File> files = [];
      for (final image in images) {
        final file = File(image.path);

        // Check file size
        final fileSize = await file.length();
        if (fileSize <= AppConstants.maxPhotoSize) {
          files.add(file);
        } else {
          logger.w('Skipping file ${image.name} - too large');
        }
      }

      return files;
    } catch (e) {
      logger.e('Pick multiple from gallery error: $e');
      return [];
    }
  }

  /// Guarda una imagen desde bytes (útil para imágenes procesadas)
  static Future<File?> saveImageFromBytes(
    Uint8List imageBytes,
    String fileName,
  ) async {
    try {
      final photosDir = await _getPhotosDirectory();
      final file = File(path.join(photosDir.path, fileName));
      await file.writeAsBytes(imageBytes);
      
      logger.i('Image saved from bytes: ${file.path}');
      return file;
    } catch (e) {
      logger.e('Save image from bytes error: $e');
      rethrow;
    }
  }

  /// Obtiene la lista de fotos guardadas
  static Future<List<File>> getSavedPhotos() async {
    try {
      final photosDir = await _getPhotosDirectory();
      final files = photosDir.listSync()
          .whereType<File>()
          .where((file) => file.path.endsWith('.jpg') || file.path.endsWith('.png'))
          .toList();
      
      // Ordenar por fecha de modificación (más recientes primero)
      files.sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));
      
      return files;
    } catch (e) {
      logger.e('Get saved photos error: $e');
      return [];
    }
  }

  /// Elimina una foto guardada
  static Future<bool> deletePhoto(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        logger.i('Photo deleted: $filePath');
        return true;
      }
      return false;
    } catch (e) {
      logger.e('Delete photo error: $e');
      return false;
    }
  }

  /// Limpia fotos antiguas (más de X días)
  static Future<int> cleanupOldPhotos({int daysOld = 30}) async {
    try {
      final photosDir = await _getPhotosDirectory();
      final cutoffDate = DateTime.now().subtract(Duration(days: daysOld));
      int deletedCount = 0;

      final files = photosDir.listSync().whereType<File>();
      
      for (final file in files) {
        final lastModified = file.lastModifiedSync();
        if (lastModified.isBefore(cutoffDate)) {
          await file.delete();
          deletedCount++;
        }
      }

      logger.i('Cleaned up $deletedCount old photos');
      return deletedCount;
    } catch (e) {
      logger.e('Cleanup old photos error: $e');
      return 0;
    }
  }
}

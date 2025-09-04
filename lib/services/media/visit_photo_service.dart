import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import '../../config/logger.dart';
import 'camera_service.dart';

/// Servicio especializado para manejar fotos de visitas
class VisitPhotoService {
  static const String _visitPhotosDir = 'visit_photos';
  
  /// Obtiene o crea el directorio de fotos de visitas
  static Future<Directory> _getVisitPhotosDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final visitPhotosDir = Directory(path.join(appDir.path, _visitPhotosDir));
    
    if (!await visitPhotosDir.exists()) {
      await visitPhotosDir.create(recursive: true);
      logger.i('Created visit photos directory: ${visitPhotosDir.path}');
    }
    
    return visitPhotosDir;
  }

  /// Obtiene o crea el directorio específico para una visita
  static Future<Directory> _getVisitDirectory(String visitId) async {
    final visitPhotosDir = await _getVisitPhotosDirectory();
    final visitDir = Directory(path.join(visitPhotosDir.path, visitId));
    
    if (!await visitDir.exists()) {
      await visitDir.create(recursive: true);
      logger.i('Created visit directory: ${visitDir.path}');
    }
    
    return visitDir;
  }

  /// Toma una foto para una visita específica
  static Future<File?> takeVisitPhoto(String visitId) async {
    try {
      final photo = await CameraService.takePicture();
      if (photo != null) {
        // Mover la foto al directorio específico de la visita
        final visitDir = await _getVisitDirectory(visitId);
        final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
        final visitPhoto = await photo.copy(path.join(visitDir.path, fileName));
        
        // Eliminar la foto temporal
        await photo.delete();
        
        logger.i('Visit photo saved: ${visitPhoto.path}');
        return visitPhoto;
      }
      return null;
    } catch (e) {
      logger.e('Take visit photo error: $e');
      rethrow;
    }
  }

  /// Selecciona fotos de la galería para una visita
  static Future<List<File>> pickVisitPhotosFromGallery(String visitId) async {
    try {
      final photos = await CameraService.pickMultipleFromGallery();
      if (photos.isNotEmpty) {
        final visitDir = await _getVisitDirectory(visitId);
        final List<File> visitPhotos = [];
        
        for (int i = 0; i < photos.length; i++) {
          final photo = photos[i];
          final fileName = 'gallery_${DateTime.now().millisecondsSinceEpoch}_$i.jpg';
          final visitPhoto = await photo.copy(path.join(visitDir.path, fileName));
          visitPhotos.add(visitPhoto);
        }
        
        logger.i('${visitPhotos.length} gallery photos saved for visit: $visitId');
        return visitPhotos;
      }
      return [];
    } catch (e) {
      logger.e('Pick visit photos from gallery error: $e');
      rethrow;
    }
  }

  /// Guarda una imagen desde bytes para una visita
  static Future<File?> saveVisitPhotoFromBytes(
    String visitId,
    Uint8List imageBytes,
    String fileName,
  ) async {
    try {
      final visitDir = await _getVisitDirectory(visitId);
      final file = File(path.join(visitDir.path, fileName));
      await file.writeAsBytes(imageBytes);
      
      logger.i('Visit photo saved from bytes: ${file.path}');
      return file;
    } catch (e) {
      logger.e('Save visit photo from bytes error: $e');
      rethrow;
    }
  }

  /// Obtiene todas las fotos de una visita específica
  static Future<List<File>> getVisitPhotos(String visitId) async {
    try {
      final visitDir = await _getVisitDirectory(visitId);
      
      if (!await visitDir.exists()) {
        return [];
      }
      
      final files = visitDir.listSync()
          .whereType<File>()
          .where((file) => file.path.endsWith('.jpg') || file.path.endsWith('.png'))
          .toList();
      
      // Ordenar por fecha de modificación (más recientes primero)
      files.sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));
      
      logger.i('Found ${files.length} photos for visit: $visitId');
      return files;
    } catch (e) {
      logger.e('Get visit photos error: $e');
      return [];
    }
  }

  /// Elimina una foto específica de una visita
  static Future<bool> deleteVisitPhoto(String visitId, String photoPath) async {
    try {
      final file = File(photoPath);
      if (await file.exists()) {
        await file.delete();
        logger.i('Visit photo deleted: $photoPath');
        return true;
      }
      return false;
    } catch (e) {
      logger.e('Delete visit photo error: $e');
      return false;
    }
  }

  /// Elimina todas las fotos de una visita
  static Future<bool> deleteAllVisitPhotos(String visitId) async {
    try {
      final visitDir = await _getVisitDirectory(visitId);
      
      if (!await visitDir.exists()) {
        return true;
      }
      
      final files = visitDir.listSync().whereType<File>();
      int deletedCount = 0;
      
      for (final file in files) {
        await file.delete();
        deletedCount++;
      }
      
      // Eliminar el directorio de la visita
      await visitDir.delete();
      
      logger.i('Deleted $deletedCount photos and directory for visit: $visitId');
      return true;
    } catch (e) {
      logger.e('Delete all visit photos error: $e');
      return false;
    }
  }

  /// Obtiene el tamaño total de las fotos de una visita
  static Future<int> getVisitPhotosSize(String visitId) async {
    try {
      final visitDir = await _getVisitDirectory(visitId);
      
      if (!await visitDir.exists()) {
        return 0;
      }
      
      final files = visitDir.listSync().whereType<File>();
      int totalSize = 0;
      
      for (final file in files) {
        totalSize += await file.length();
      }
      
      return totalSize;
    } catch (e) {
      logger.e('Get visit photos size error: $e');
      return 0;
    }
  }

  /// Limpia fotos antiguas de todas las visitas
  static Future<int> cleanupOldVisitPhotos({int daysOld = 30}) async {
    try {
      final visitPhotosDir = await _getVisitPhotosDirectory();
      
      if (!await visitPhotosDir.exists()) {
        return 0;
      }
      
      final cutoffDate = DateTime.now().subtract(Duration(days: daysOld));
      int deletedCount = 0;
      
      final visitDirs = visitPhotosDir.listSync().whereType<Directory>();
      
      for (final visitDir in visitDirs) {
        final files = visitDir.listSync().whereType<File>();
        
        for (final file in files) {
          final lastModified = file.lastModifiedSync();
          if (lastModified.isBefore(cutoffDate)) {
            await file.delete();
            deletedCount++;
          }
        }
        
        // Eliminar directorio si está vacío
        final remainingFiles = visitDir.listSync().whereType<File>();
        if (remainingFiles.isEmpty) {
          await visitDir.delete();
        }
      }
      
      logger.i('Cleaned up $deletedCount old visit photos');
      return deletedCount;
    } catch (e) {
      logger.e('Cleanup old visit photos error: $e');
      return 0;
    }
  }

  /// Comprime una foto para reducir su tamaño
  static Future<File?> compressVisitPhoto(
    File originalPhoto,
    String visitId, {
    int quality = 80,
    int maxWidth = 1920,
    int maxHeight = 1080,
  }) async {
    try {
      // TODO: Implementar compresión de imagen
      // Por ahora, solo copiamos la imagen original
      final visitDir = await _getVisitDirectory(visitId);
      final fileName = 'compressed_${path.basename(originalPhoto.path)}';
      final compressedPhoto = await originalPhoto.copy(path.join(visitDir.path, fileName));
      
      logger.i('Visit photo compressed: ${compressedPhoto.path}');
      return compressedPhoto;
    } catch (e) {
      logger.e('Compress visit photo error: $e');
      return null;
    }
  }

  /// Obtiene estadísticas de fotos de visitas
  static Future<Map<String, dynamic>> getVisitPhotosStats() async {
    try {
      final visitPhotosDir = await _getVisitPhotosDirectory();
      
      if (!await visitPhotosDir.exists()) {
        return {
          'totalVisits': 0,
          'totalPhotos': 0,
          'totalSize': 0,
          'averagePhotosPerVisit': 0,
        };
      }
      
      final visitDirs = visitPhotosDir.listSync().whereType<Directory>();
      int totalPhotos = 0;
      int totalSize = 0;
      
      for (final visitDir in visitDirs) {
        final files = visitDir.listSync().whereType<File>();
        totalPhotos += files.length;
        
        for (final file in files) {
          totalSize += await file.length();
        }
      }
      
      final totalVisits = visitDirs.length;
      final averagePhotosPerVisit = totalVisits > 0 ? totalPhotos / totalVisits : 0;
      
      return {
        'totalVisits': totalVisits,
        'totalPhotos': totalPhotos,
        'totalSize': totalSize,
        'averagePhotosPerVisit': averagePhotosPerVisit,
      };
    } catch (e) {
      logger.e('Get visit photos stats error: $e');
      return {};
    }
  }
}

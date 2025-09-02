import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../config/app_constants.dart';
import '../../config/logger.dart';

class CameraService {
  static final ImagePicker _picker = ImagePicker();

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

        // Move to app directory
        final appDir = await getApplicationDocumentsDirectory();
        final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
        final savedFile =
            await file.copy(path.join(appDir.path, 'photos', fileName));

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
}

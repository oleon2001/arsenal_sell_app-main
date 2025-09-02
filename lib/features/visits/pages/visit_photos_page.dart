import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/palette.dart';
import '../../../services/media/camera_service.dart';
import '../bloc/visits_cubit.dart';

class VisitPhotosPage extends StatefulWidget {
  const VisitPhotosPage({
    super.key,
    required this.visitId,
  });
  final String visitId;

  @override
  State<VisitPhotosPage> createState() => _VisitPhotosPageState();
}

class _VisitPhotosPageState extends State<VisitPhotosPage> {
  final List<File> _capturedPhotos = [];
  final bool _isUploading = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Evidencia Fotográfica'),
          actions: [
            TextButton(
              onPressed: _capturedPhotos.isNotEmpty
                  ? () => context.push('/visit/signature/${widget.visitId}')
                  : null,
              child: Text(
                'Siguiente',
                style: TextStyle(
                  color: _capturedPhotos.isNotEmpty
                      ? Colors.white
                      : Colors.white54,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            // Instructions
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: AppPalette.info.withOpacity(0.1),
              child: const Text(
                'Toma fotos como evidencia de tu visita. Mínimo 1 foto requerida.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppPalette.info,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Photo grid
            Expanded(
              child: _capturedPhotos.isEmpty
                  ? _buildEmptyState()
                  : _buildPhotoGrid(),
            ),

            // Camera buttons
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isUploading ? null : _takePicture,
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Tomar Foto'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppPalette.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _isUploading ? null : _pickFromGallery,
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Galería'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildEmptyState() => const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt_outlined,
              size: 80,
              color: AppPalette.textSecondary,
            ),
            SizedBox(height: 16),
            Text(
              'No hay fotos capturadas',
              style: TextStyle(
                fontSize: 18,
                color: AppPalette.textSecondary,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Toma fotos como evidencia de tu visita',
              style: TextStyle(
                fontSize: 14,
                color: AppPalette.textDisabled,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );

  Widget _buildPhotoGrid() => GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        itemCount: _capturedPhotos.length,
        itemBuilder: (context, index) {
          final photo = _capturedPhotos[index];
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: FileImage(photo),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () => _removePhoto(index),
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.fullscreen,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () => _viewPhoto(photo),
                  ),
                ),
              ),
            ],
          );
        },
      );

  Future<void> _takePicture() async {
    try {
      final photo = await CameraService.takePicture();
      if (photo != null) {
        setState(() {
          _capturedPhotos.add(photo);
        });
      }
    } catch (e) {
      _showError('Error al tomar foto: $e');
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      final photos = await CameraService.pickMultipleFromGallery();
      if (photos.isNotEmpty) {
        setState(() {
          _capturedPhotos.addAll(photos);
        });
      }
    } catch (e) {
      _showError('Error al seleccionar fotos: $e');
    }
  }

  void _removePhoto(int index) {
    setState(() {
      _capturedPhotos.removeAt(index);
    });
  }

  void _viewPhoto(File photo) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PhotoViewPage(photo: photo),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppPalette.error,
      ),
    );
  }
}

class PhotoViewPage extends StatelessWidget {
  const PhotoViewPage({super.key, required this.photo});
  final File photo;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.black,
          child: Center(
            child: Image.file(photo),
          ),
        ),
      );
}

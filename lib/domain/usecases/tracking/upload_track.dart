import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../data/repositories/tracking_repository.dart';
import '../../../data/models/geo/location_sample.dart';
import '../../../services/sync/sync_queue.dart';
import '../../../config/logger.dart';

class UploadTrackUseCase {
  UploadTrackUseCase(this._trackingRepository, this._syncQueue);
  final TrackingRepository _trackingRepository;
  final SyncQueue _syncQueue;

  Future<TrackUploadResult> execute({
    required String userId,
    List<LocationSample>? specificSamples,
    bool forceUpload = false,
    UploadStrategy strategy = UploadStrategy.automatic,
  }) async {
    try {
      // Check connectivity
      final connectivity = await Connectivity().checkConnectivity();
      final isOnline = connectivity != ConnectivityResult.none;

      if (!isOnline && !forceUpload) {
        return TrackUploadResult(
          success: false,
          uploadedCount: 0,
          failedCount: 0,
          totalSamples: 0,
          message:
              'Sin conexión a internet. Los datos se subirán automáticamente cuando se restablezca la conexión.',
          strategy: strategy,
        );
      }

      // Get samples to upload
      List<LocationSample> samplesToUpload;
      if (specificSamples != null) {
        samplesToUpload = specificSamples;
      } else {
        // Get pending samples from local storage
        samplesToUpload = await _getPendingSamples(userId, strategy);
      }

      if (samplesToUpload.isEmpty) {
        return TrackUploadResult(
          success: true,
          uploadedCount: 0,
          failedCount: 0,
          totalSamples: 0,
          message: 'No hay datos de ubicación pendientes para subir.',
          strategy: strategy,
        );
      }

      logger.i('Starting upload of ${samplesToUpload.length} location samples');

      // Upload samples in batches
      final uploadResults =
          await _uploadInBatches(samplesToUpload, strategy, isOnline);

      // Calculate results
      final totalSamples = samplesToUpload.length;
      final uploadedCount = uploadResults.successful.length;
      final failedCount = uploadResults.failed.length;

      // Handle failed uploads
      if (uploadResults.failed.isNotEmpty) {
        await _handleFailedUploads(uploadResults.failed, strategy);
      }

      // Clean up successfully uploaded samples
      if (uploadResults.successful.isNotEmpty) {
        await _cleanupUploadedSamples(uploadResults.successful);
      }

      final success = failedCount == 0;
      final message = _generateUploadMessage(
          uploadedCount, failedCount, totalSamples, success);

      logger.i(
          'Upload completed: $uploadedCount successful, $failedCount failed');

      return TrackUploadResult(
        success: success,
        uploadedCount: uploadedCount,
        failedCount: failedCount,
        totalSamples: totalSamples,
        message: message,
        strategy: strategy,
        uploadDuration: uploadResults.duration,
        failedSamples: uploadResults.failed,
      );
    } catch (e) {
      logger.e('Upload track error: $e');
      return TrackUploadResult(
        success: false,
        uploadedCount: 0,
        failedCount: 0,
        totalSamples: 0,
        message: 'Error al subir datos de ubicación: $e',
        strategy: strategy,
      );
    }
  }

  Future<TrackSyncStatus> getSyncStatus({
    required String userId,
  }) async {
    try {
      // Get pending samples count
      final pendingSamples =
          await _getPendingSamples(userId, UploadStrategy.all);

      // Get last sync time
      final lastSyncTime = await _getLastSyncTime(userId);

      // Check connectivity
      final connectivity = await Connectivity().checkConnectivity();
      final isOnline = connectivity != ConnectivityResult.none;

      // Calculate sync statistics
      final stats = await _calculateSyncStats(userId);

      return TrackSyncStatus(
        userId: userId,
        pendingSamplesCount: pendingSamples.length,
        lastSyncAt: lastSyncTime,
        isOnline: isOnline,
        autoSyncEnabled: true, // TODO: Get from settings
        syncStatistics: stats,
      );
    } catch (e) {
      logger.e('Get sync status error: $e');
      rethrow;
    }
  }

  Future<void> scheduleAutoUpload({
    required String userId,
    Duration interval = const Duration(minutes: 15),
  }) async {
    try {
      // TODO: Implement background task scheduling
      // This would use a background service or work manager
      logger
          .i('Auto upload scheduled for user $userId with interval: $interval');
    } catch (e) {
      logger.e('Schedule auto upload error: $e');
    }
  }

  Future<TrackCompressionResult> compressTrackData({
    required List<LocationSample> samples,
    CompressionLevel level = CompressionLevel.medium,
  }) async {
    try {
      final originalCount = samples.length;
      List<LocationSample> compressedSamples;

      switch (level) {
        case CompressionLevel.none:
          compressedSamples = samples;
          break;
        case CompressionLevel.low:
          compressedSamples = _applyLowCompression(samples);
          break;
        case CompressionLevel.medium:
          compressedSamples = _applyMediumCompression(samples);
          break;
        case CompressionLevel.high:
          compressedSamples = _applyHighCompression(samples);
          break;
      }

      final compressionRatio = originalCount > 0
          ? (originalCount - compressedSamples.length) / originalCount
          : 0.0;

      return TrackCompressionResult(
        originalCount: originalCount,
        compressedCount: compressedSamples.length,
        compressionRatio: compressionRatio,
        compressedSamples: compressedSamples,
        level: level,
      );
    } catch (e) {
      logger.e('Compress track data error: $e');
      rethrow;
    }
  }

  Future<List<LocationSample>> _getPendingSamples(
      String userId, UploadStrategy strategy) async {
    // TODO: Implement actual pending samples retrieval
    // This would query the local database for unsynced samples
    return [];
  }

  Future<BatchUploadResult> _uploadInBatches(
    List<LocationSample> samples,
    UploadStrategy strategy,
    bool isOnline,
  ) async {
    final startTime = DateTime.now();
    final successful = <LocationSample>[];
    final failed = <LocationSample>[];

    const batchSize = 50; // Upload 50 samples at a time

    for (int i = 0; i < samples.length; i += batchSize) {
      final batch = samples.skip(i).take(batchSize).toList();

      try {
        if (isOnline) {
          // TODO: Implement uploadTrackingLocations method in TrackingRepository
          // await _trackingRepository.uploadTrackingLocations(batch);
          successful.addAll(batch);
        } else {
          // Add to sync queue for later upload
          for (final sample in batch) {
            await _syncQueue.addToQueue(SyncItem(
              id: sample.id.toString(),
              type: SyncItemType.tracking,
              data: sample.toJson(),
              createdAt: DateTime.now(),
            ));
          }
          successful.addAll(batch);
        }
      } catch (e) {
        logger.e('Batch upload failed: $e');
        failed.addAll(batch);
      }

      // Add small delay between batches to avoid overwhelming the server
      if (i + batchSize < samples.length) {
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }

    final duration = DateTime.now().difference(startTime);

    return BatchUploadResult(
      successful: successful,
      failed: failed,
      duration: duration,
    );
  }

  Future<void> _handleFailedUploads(
    List<LocationSample> failedSamples,
    UploadStrategy strategy,
  ) async {
    try {
      // Add failed samples back to sync queue with retry logic
      for (final sample in failedSamples) {
        await _syncQueue.addToQueue(SyncItem(
          id: sample.id.toString(),
          type: SyncItemType.tracking,
          data: sample.toJson(),
          createdAt: DateTime.now(),
          retryCount: 1,
        ));
      }
    } catch (e) {
      logger.e('Handle failed uploads error: $e');
    }
  }

  Future<void> _cleanupUploadedSamples(List<LocationSample> samples) async {
    try {
      // TODO: Mark samples as synced in local database
      // This would update the needsSync flag to false
    } catch (e) {
      logger.e('Cleanup uploaded samples error: $e');
    }
  }

  String _generateUploadMessage(
    int uploaded,
    int failed,
    int total,
    bool success,
  ) {
    if (total == 0) {
      return 'No hay datos para subir';
    }

    if (success) {
      return 'Se subieron $uploaded ubicaciones exitosamente';
    } else {
      return 'Se subieron $uploaded de $total ubicaciones. $failed fallaron y se reintentarán automáticamente';
    }
  }

  Future<DateTime?> _getLastSyncTime(String userId) async {
    try {
      // TODO: Get last sync time from preferences or database
      return DateTime.now().subtract(const Duration(hours: 1)); // Mock
    } catch (e) {
      return null;
    }
  }

  Future<SyncStatistics> _calculateSyncStats(String userId) async {
    try {
      // TODO: Calculate actual sync statistics
      return SyncStatistics(
        totalSynced: 0,
        todaySynced: 0,
        failedSyncs: 0,
        lastSyncDuration: Duration.zero,
        averageSyncDuration: Duration.zero,
      );
    } catch (e) {
      return SyncStatistics(
        totalSynced: 0,
        todaySynced: 0,
        failedSyncs: 0,
        lastSyncDuration: Duration.zero,
        averageSyncDuration: Duration.zero,
      );
    }
  }

  List<LocationSample> _applyLowCompression(List<LocationSample> samples) {
    // Remove samples with very poor accuracy (> 100m)
    return samples.where((sample) => (sample.accuracyM ?? 0) <= 100).toList();
  }

  List<LocationSample> _applyMediumCompression(List<LocationSample> samples) {
    final filtered = <LocationSample>[];

    for (int i = 0; i < samples.length; i++) {
      final sample = samples[i];

      // Skip samples with poor accuracy
      if ((sample.accuracyM ?? 0) > 50) continue;

      // Skip samples that are too close to the previous one
      if (filtered.isNotEmpty) {
        final lastSample = filtered.last;
        final timeDiff = sample.at.difference(lastSample.at).inSeconds;

        // Keep sample if it's been more than 30 seconds
        if (timeDiff >= 30) {
          filtered.add(sample);
        }
      } else {
        filtered.add(sample);
      }
    }

    return filtered;
  }

  List<LocationSample> _applyHighCompression(List<LocationSample> samples) {
    final filtered = <LocationSample>[];

    for (int i = 0; i < samples.length; i++) {
      final sample = samples[i];

      // Only keep samples with good accuracy
      if ((sample.accuracyM ?? 0) > 20) continue;

      // Skip samples that are too close in time or distance
      if (filtered.isNotEmpty) {
        final lastSample = filtered.last;
        final timeDiff = sample.at.difference(lastSample.at).inSeconds;

        // Keep sample if it's been more than 60 seconds
        if (timeDiff >= 60) {
          filtered.add(sample);
        }
      } else {
        filtered.add(sample);
      }
    }

    return filtered;
  }
}

enum UploadStrategy {
  automatic, // Upload based on connectivity and battery
  immediate, // Upload immediately regardless of conditions
  wifiOnly, // Only upload when on WiFi
  scheduled, // Upload at scheduled times
  all, // Upload all pending samples
}

enum CompressionLevel { none, low, medium, high }

class TrackUploadResult {
  TrackUploadResult({
    required this.success,
    required this.uploadedCount,
    required this.failedCount,
    required this.totalSamples,
    required this.message,
    required this.strategy,
    this.uploadDuration,
    this.failedSamples,
  });
  final bool success;
  final int uploadedCount;
  final int failedCount;
  final int totalSamples;
  final String message;
  final UploadStrategy strategy;
  final Duration? uploadDuration;
  final List<LocationSample>? failedSamples;

  double get successRate => totalSamples > 0 ? uploadedCount / totalSamples : 0;
}

class TrackSyncStatus {
  TrackSyncStatus({
    required this.userId,
    required this.pendingSamplesCount,
    this.lastSyncAt,
    required this.isOnline,
    required this.autoSyncEnabled,
    required this.syncStatistics,
  });
  final String userId;
  final int pendingSamplesCount;
  final DateTime? lastSyncAt;
  final bool isOnline;
  final bool autoSyncEnabled;
  final SyncStatistics syncStatistics;

  bool get needsSync => pendingSamplesCount > 0;
  bool get canSync => isOnline && needsSync;
}

class SyncStatistics {
  SyncStatistics({
    required this.totalSynced,
    required this.todaySynced,
    required this.failedSyncs,
    required this.lastSyncDuration,
    required this.averageSyncDuration,
  });
  final int totalSynced;
  final int todaySynced;
  final int failedSyncs;
  final Duration lastSyncDuration;
  final Duration averageSyncDuration;
}

class TrackCompressionResult {
  TrackCompressionResult({
    required this.originalCount,
    required this.compressedCount,
    required this.compressionRatio,
    required this.compressedSamples,
    required this.level,
  });
  final int originalCount;
  final int compressedCount;
  final double compressionRatio;
  final List<LocationSample> compressedSamples;
  final CompressionLevel level;

  int get savedSamples => originalCount - compressedCount;
  double get compressionPercentage => compressionRatio * 100;
}

class BatchUploadResult {
  BatchUploadResult({
    required this.successful,
    required this.failed,
    required this.duration,
  });
  final List<LocationSample> successful;
  final List<LocationSample> failed;
  final Duration duration;
}

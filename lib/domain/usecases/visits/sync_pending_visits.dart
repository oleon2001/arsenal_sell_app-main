import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../config/logger.dart';
import '../../../data/models/visits/visit.dart';
import '../../../data/repositories/visits_repository.dart';
import '../../../services/sync/sync_queue.dart';

class SyncPendingVisitsUseCase {
  SyncPendingVisitsUseCase(this._visitsRepository, this._syncQueue);
  final VisitsRepository _visitsRepository;
  final SyncQueue _syncQueue;

  Future<VisitSyncResult> execute({
    String? userId,
    bool forceSync = false,
    SyncMode mode = SyncMode.automatic,
    int? maxRetryAttempts,
  }) async {
    try {
      // Check connectivity
      final connectivity = await Connectivity().checkConnectivity();
      final isOnline = connectivity != ConnectivityResult.none;

      if (!isOnline && !forceSync) {
        return VisitSyncResult(
          success: false,
          syncedCount: 0,
          failedCount: 0,
          totalPending: 0,
          message:
              'Sin conexión a internet. Las visitas se sincronizarán automáticamente cuando se restablezca la conexión.',
          mode: mode,
        );
      }

      // Get pending visits
      final pendingVisits = await _getPendingVisits(userId);

      if (pendingVisits.isEmpty) {
        return VisitSyncResult(
          success: true,
          syncedCount: 0,
          failedCount: 0,
          totalPending: 0,
          message: 'No hay visitas pendientes para sincronizar.',
          mode: mode,
        );
      }

      logger.i('Starting sync of ${pendingVisits.length} pending visits');

      // Sync visits based on mode
      final syncResults = await _syncVisits(
        pendingVisits,
        mode,
        isOnline,
        maxRetryAttempts ?? 3,
      );

      // Calculate results
      final totalPending = pendingVisits.length;
      final syncedCount = syncResults.successful.length;
      final failedCount = syncResults.failed.length;

      // Handle failed syncs
      if (syncResults.failed.isNotEmpty) {
        await _handleFailedSyncs(syncResults.failed, mode);
      }

      // Update local records for successful syncs
      if (syncResults.successful.isNotEmpty) {
        await _markVisitsAsSynced(syncResults.successful);
      }

      final success = failedCount == 0;
      final message =
          _generateSyncMessage(syncedCount, failedCount, totalPending, success);

      logger.i(
          'Visit sync completed: $syncedCount successful, $failedCount failed');

      return VisitSyncResult(
        success: success,
        syncedCount: syncedCount,
        failedCount: failedCount,
        totalPending: totalPending,
        message: message,
        mode: mode,
        syncDuration: syncResults.duration,
        failedVisits: syncResults.failed,
        syncDetails: syncResults.details,
      );
    } catch (e) {
      logger.e('Sync pending visits error: $e');
      return VisitSyncResult(
        success: false,
        syncedCount: 0,
        failedCount: 0,
        totalPending: 0,
        message: 'Error al sincronizar visitas: $e',
        mode: mode,
      );
    }
  }

  Future<VisitSyncStatus> getSyncStatus({
    String? userId,
  }) async {
    try {
      // Get pending visits count
      final pendingVisits = await _getPendingVisits(userId);

      // Get last sync time
      final lastSyncTime = await _getLastSyncTime(userId);

      // Check connectivity
      final connectivity = await Connectivity().checkConnectivity();
      final isOnline = connectivity != ConnectivityResult.none;

      // Get sync queue status
      final queueCount = await _syncQueue.getPendingCount();

      // Calculate sync statistics
      final stats = await _calculateSyncStats(userId);

      return VisitSyncStatus(
        userId: userId,
        pendingVisitsCount: pendingVisits.length,
        pendingQueueCount: queueCount,
        lastSyncAt: lastSyncTime,
        isOnline: isOnline,
        autoSyncEnabled: true, // TODO: Get from settings
        syncStatistics: stats,
        nextScheduledSync: _calculateNextSyncTime(),
      );
    } catch (e) {
      logger.e('Get sync status error: $e');
      rethrow;
    }
  }

  Future<List<VisitSyncConflict>> detectSyncConflicts({
    String? userId,
  }) async {
    try {
      final conflicts = <VisitSyncConflict>[];

      // TODO: Implement conflict detection logic
      // This would compare local visits with server versions
      // and identify conflicts based on timestamps, versions, etc.

      return conflicts;
    } catch (e) {
      logger.e('Detect sync conflicts error: $e');
      return [];
    }
  }

  Future<void> resolveSyncConflict({
    required String visitId,
    required ConflictResolutionStrategy strategy,
  }) async {
    try {
      // TODO: Implement conflict resolution
      switch (strategy) {
        case ConflictResolutionStrategy.useLocal:
          // Keep local version and overwrite server
          break;
        case ConflictResolutionStrategy.useServer:
          // Accept server version and overwrite local
          break;
        case ConflictResolutionStrategy.merge:
          // Attempt to merge both versions
          break;
        case ConflictResolutionStrategy.createNew:
          // Create a new visit with merged data
          break;
      }

      logger.i(
          'Sync conflict resolved for visit $visitId using strategy: ${strategy.name}');
    } catch (e) {
      logger.e('Resolve sync conflict error: $e');
      rethrow;
    }
  }

  Future<void> scheduleAutoSync({
    String? userId,
    Duration interval = const Duration(minutes: 30),
  }) async {
    try {
      // TODO: Implement automatic sync scheduling
      // This would use a background service or work manager
      logger.i('Auto sync scheduled for user $userId with interval: $interval');
    } catch (e) {
      logger.e('Schedule auto sync error: $e');
    }
  }

  Future<List<Visit>> _getPendingVisits(String? userId) async {
    try {
      // TODO: Get pending visits from repository
      // This would query local database for visits with isSynced = false
      return [];
    } catch (e) {
      logger.e('Get pending visits error: $e');
      return [];
    }
  }

  Future<VisitBatchSyncResult> _syncVisits(
    List<Visit> visits,
    SyncMode mode,
    bool isOnline,
    int maxRetryAttempts,
  ) async {
    final startTime = DateTime.now();
    final successful = <Visit>[];
    final failed = <Visit>[];
    final details = <VisitSyncDetail>[];

    for (final visit in visits) {
      try {
        final syncDetail =
            await _syncSingleVisit(visit, mode, isOnline, maxRetryAttempts);

        details.add(syncDetail);

        if (syncDetail.success) {
          successful.add(visit);
        } else {
          failed.add(visit);
        }

        // Add small delay between syncs to avoid overwhelming the server
        if (visits.indexOf(visit) < visits.length - 1) {
          await Future.delayed(const Duration(milliseconds: 200));
        }
      } catch (e) {
        logger.e('Sync single visit failed: $e');
        failed.add(visit);
        details.add(VisitSyncDetail(
          visitId: visit.id,
          success: false,
          error: e.toString(),
          attempts: 1,
        ));
      }
    }

    final duration = DateTime.now().difference(startTime);

    return VisitBatchSyncResult(
      successful: successful,
      failed: failed,
      duration: duration,
      details: details,
    );
  }

  Future<VisitSyncDetail> _syncSingleVisit(
    Visit visit,
    SyncMode mode,
    bool isOnline,
    int maxRetryAttempts,
  ) async {
    int attempts = 0;
    String? lastError;

    while (attempts < maxRetryAttempts) {
      attempts++;

      try {
        if (isOnline) {
          // Direct sync to server
          await _visitsRepository.finishVisit(visit);
        } else {
          // Add to sync queue for later processing
          await _syncQueue.addToQueue(SyncItem(
            id: visit.id,
            type: SyncItemType.visit,
            data: visit.toJson(),
            createdAt: DateTime.now(),
            retryCount: attempts - 1,
          ));
        }

        return VisitSyncDetail(
          visitId: visit.id,
          success: true,
          attempts: attempts,
          syncedAt: DateTime.now(),
        );
      } catch (e) {
        lastError = e.toString();
        logger.w('Visit sync attempt $attempts failed for ${visit.id}: $e');

        // Wait before retry (exponential backoff)
        if (attempts < maxRetryAttempts) {
          final delay = Duration(seconds: attempts * 2);
          await Future.delayed(delay);
        }
      }
    }

    return VisitSyncDetail(
      visitId: visit.id,
      success: false,
      error: lastError,
      attempts: attempts,
    );
  }

  Future<void> _handleFailedSyncs(
    List<Visit> failedVisits,
    SyncMode mode,
  ) async {
    try {
      // Add failed visits back to sync queue with retry logic
      for (final visit in failedVisits) {
        await _syncQueue.addToQueue(SyncItem(
          id: visit.id,
          type: SyncItemType.visit,
          data: visit.toJson(),
          createdAt: DateTime.now(),
          retryCount: 1,
        ));
      }
    } catch (e) {
      logger.e('Handle failed syncs error: $e');
    }
  }

  Future<void> _markVisitsAsSynced(List<Visit> visits) async {
    try {
      for (final visit in visits) {
        // TODO: Mark visit as synced in local database
        // await _visitsRepository.markVisitSynced(visit.id);
      }
    } catch (e) {
      logger.e('Mark visits as synced error: $e');
    }
  }

  String _generateSyncMessage(
    int synced,
    int failed,
    int total,
    bool success,
  ) {
    if (total == 0) {
      return 'No hay visitas para sincronizar';
    }

    if (success) {
      return 'Se sincronizaron $synced visitas exitosamente';
    } else {
      return 'Se sincronizaron $synced de $total visitas. $failed fallaron y se reintentarán automáticamente';
    }
  }

  Future<DateTime?> _getLastSyncTime(String? userId) async {
    try {
      // TODO: Get last sync time from preferences or database
      return DateTime.now().subtract(const Duration(hours: 2)); // Mock
    } catch (e) {
      return null;
    }
  }

  Future<VisitSyncStatistics> _calculateSyncStats(String? userId) async {
    try {
      // TODO: Calculate actual sync statistics
      return VisitSyncStatistics(
        totalSynced: 0,
        todaySynced: 0,
        failedSyncs: 0,
        lastSyncDuration: Duration.zero,
        averageSyncDuration: Duration.zero,
        syncSuccessRate: 0,
      );
    } catch (e) {
      return VisitSyncStatistics(
        totalSynced: 0,
        todaySynced: 0,
        failedSyncs: 0,
        lastSyncDuration: Duration.zero,
        averageSyncDuration: Duration.zero,
        syncSuccessRate: 0,
      );
    }
  }

  DateTime? _calculateNextSyncTime() {
    // TODO: Calculate next scheduled sync based on settings
    return DateTime.now().add(const Duration(minutes: 30));
  }
}

enum SyncMode {
  automatic, // Sync based on connectivity and settings
  immediate, // Sync immediately regardless of conditions
  scheduled, // Sync at scheduled intervals
  manual, // Manual sync triggered by user
}

enum ConflictResolutionStrategy {
  useLocal,
  useServer,
  merge,
  createNew,
}

class VisitSyncResult {
  VisitSyncResult({
    required this.success,
    required this.syncedCount,
    required this.failedCount,
    required this.totalPending,
    required this.message,
    required this.mode,
    this.syncDuration,
    this.failedVisits,
    this.syncDetails,
  });
  final bool success;
  final int syncedCount;
  final int failedCount;
  final int totalPending;
  final String message;
  final SyncMode mode;
  final Duration? syncDuration;
  final List<Visit>? failedVisits;
  final List<VisitSyncDetail>? syncDetails;

  double get successRate => totalPending > 0 ? syncedCount / totalPending : 0;
}

class VisitSyncStatus {
  VisitSyncStatus({
    this.userId,
    required this.pendingVisitsCount,
    required this.pendingQueueCount,
    this.lastSyncAt,
    required this.isOnline,
    required this.autoSyncEnabled,
    required this.syncStatistics,
    this.nextScheduledSync,
  });
  final String? userId;
  final int pendingVisitsCount;
  final int pendingQueueCount;
  final DateTime? lastSyncAt;
  final bool isOnline;
  final bool autoSyncEnabled;
  final VisitSyncStatistics syncStatistics;
  final DateTime? nextScheduledSync;

  bool get needsSync => pendingVisitsCount > 0 || pendingQueueCount > 0;
  bool get canSync => isOnline && needsSync;
}

class VisitSyncStatistics {
  VisitSyncStatistics({
    required this.totalSynced,
    required this.todaySynced,
    required this.failedSyncs,
    required this.lastSyncDuration,
    required this.averageSyncDuration,
    required this.syncSuccessRate,
  });
  final int totalSynced;
  final int todaySynced;
  final int failedSyncs;
  final Duration lastSyncDuration;
  final Duration averageSyncDuration;
  final double syncSuccessRate;
}

class VisitSyncDetail {
  VisitSyncDetail({
    required this.visitId,
    required this.success,
    this.error,
    required this.attempts,
    this.syncedAt,
  });
  final String visitId;
  final bool success;
  final String? error;
  final int attempts;
  final DateTime? syncedAt;
}

class VisitSyncConflict {
  VisitSyncConflict({
    required this.visitId,
    required this.localModifiedAt,
    required this.serverModifiedAt,
    required this.localData,
    required this.serverData,
    required this.conflictingFields,
  });
  final String visitId;
  final DateTime localModifiedAt;
  final DateTime serverModifiedAt;
  final Map<String, dynamic> localData;
  final Map<String, dynamic> serverData;
  final List<String> conflictingFields;

  bool get localIsNewer => localModifiedAt.isAfter(serverModifiedAt);
  bool get serverIsNewer => serverModifiedAt.isAfter(localModifiedAt);
  bool get hasDataConflicts => conflictingFields.isNotEmpty;
}

class VisitBatchSyncResult {
  VisitBatchSyncResult({
    required this.successful,
    required this.failed,
    required this.duration,
    required this.details,
  });
  final List<Visit> successful;
  final List<Visit> failed;
  final Duration duration;
  final List<VisitSyncDetail> details;
}

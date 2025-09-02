import 'package:connectivity_plus/connectivity_plus.dart';

import '../../config/logger.dart';
import '../local/drift/db.dart';
import '../models/geo/location_sample.dart';
import '../remote/supabase_client.dart';

class TrackingRepository {
  final DatabaseHelper _db = DatabaseHelper.instance;
  final SupabaseService _supabase = SupabaseService();

  Future<void> saveLocationSample(LocationSample sample) async {
    try {
      final entity = TrackingEntity(
        id: sample.id,
        companyId: sample.companyId,
        userId: sample.userId,
        at: sample.at,
        latitude: sample.latitude,
        longitude: sample.longitude,
        speedMs: sample.speedMs,
        accuracyM: sample.accuracyM,
        needsSync: true,
      );

      await _db.insertTrackingLocation(entity);

      // Try to sync immediately if online
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity != ConnectivityResult.none) {
        await syncPendingLocations();
      }
    } catch (e) {
      logger.e('Save location sample error: $e');
    }
  }

  Future<void> syncPendingLocations() async {
    try {
      final pendingLocations = await _db.getPendingSyncTracking();

      if (pendingLocations.isNotEmpty) {
        final samples = pendingLocations
            .map((entity) => LocationSample(
                  id: entity.id,
                  companyId: entity.companyId,
                  userId: entity.userId,
                  at: entity.at,
                  latitude: entity.latitude,
                  longitude: entity.longitude,
                  speedMs: entity.speedMs,
                  accuracyM: entity.accuracyM,
                ))
            .toList();

        await _supabase.uploadTrackingLocations(samples);

        final ids = pendingLocations.map((e) => e.id).toList();
        await _db.markTrackingSynced(ids);
      }
    } catch (e) {
      logger.e('Sync pending locations error: $e');
    }
  }

  Future<List<LocationSample>> getRealtimeLocations() async {
    try {
      return await _supabase.getRealtimeLocations();
    } catch (e) {
      logger.e('Get realtime locations error: $e');
      return [];
    }
  }

  Future<void> cleanupOldData() async {
    try {
      await _db.cleanupOldTracking();
    } catch (e) {
      logger.e('Cleanup old data error: $e');
    }
  }
}

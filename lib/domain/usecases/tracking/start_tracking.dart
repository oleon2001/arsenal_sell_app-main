import 'dart:async';
import '../../../services/location/location_service.dart';
import '../../../services/location/background_location.dart';
import '../../../data/repositories/tracking_repository.dart';
import '../../../data/models/geo/location_sample.dart';
import '../../../config/logger.dart';
import '../../../config/app_constants.dart';

class StartTrackingUseCase {
  StartTrackingUseCase(this._locationService, this._trackingRepository);
  final LocationService _locationService;
  final TrackingRepository _trackingRepository;

  Future<TrackingSessionResult> execute({
    required String userId,
    required String companyId,
    TrackingMode mode = TrackingMode.standard,
    int? intervalSeconds,
    double? accuracyThreshold,
  }) async {
    try {
      // Request location permissions
      final hasPermissions = await _locationService.requestPermissions();
      if (!hasPermissions) {
        throw Exception(
            'Permisos de ubicación requeridos para iniciar el seguimiento');
      }

      // Get initial location
      final initialLocation = await _locationService.getCurrentLocation();
      if (initialLocation == null) {
        throw Exception('No se pudo obtener la ubicación inicial');
      }

      // Create initial tracking sample
      final initialSample = LocationSample(
        id: DateTime.now().millisecondsSinceEpoch,
        companyId: companyId,
        userId: userId,
        at: DateTime.now(),
        latitude: initialLocation.latitude,
        longitude: initialLocation.longitude,
        speedMs: initialLocation.speed,
        accuracyM: initialLocation.accuracy,
      );

      // Save initial sample
      await _trackingRepository.saveLocationSample(initialSample);

      // Configure tracking parameters based on mode
      final trackingConfig =
          _getTrackingConfig(mode, intervalSeconds, accuracyThreshold);

      // Start location tracking
      await _locationService.startLocationTracking();

      // Start background tracking if needed
      if (mode == TrackingMode.background || mode == TrackingMode.continuous) {
        final backgroundStarted = await BackgroundLocationService.start();
        if (!backgroundStarted) {
          logger.w('Failed to start background location tracking');
        }
      }

      logger.i('Tracking started for user $userId with mode: ${mode.name}');

      return TrackingSessionResult(
        sessionId: 'session_${DateTime.now().millisecondsSinceEpoch}',
        userId: userId,
        companyId: companyId,
        mode: mode,
        config: trackingConfig,
        initialLocation: initialSample,
        startedAt: DateTime.now(),
        isActive: true,
      );
    } catch (e) {
      logger.e('Start tracking error: $e');
      rethrow;
    }
  }

  Future<void> stopTracking({
    required String sessionId,
    required String userId,
  }) async {
    try {
      // Stop location service
      await _locationService.stopLocationTracking();

      // Stop background tracking
      await BackgroundLocationService.stop();

      // Create session end record
      final endSample = LocationSample(
        id: DateTime.now().millisecondsSinceEpoch,
        companyId: 'current_company', // TODO: Get from session
        userId: userId,
        at: DateTime.now(),
        latitude: 0, // TODO: Get final location
        longitude: 0,
        speedMs: 0,
        accuracyM: 0,
      );

      await _trackingRepository.saveLocationSample(endSample);

      logger.i('Tracking stopped for session $sessionId');
    } catch (e) {
      logger.e('Stop tracking error: $e');
      rethrow;
    }
  }

  Future<TrackingStatus> getTrackingStatus({
    required String userId,
  }) async {
    try {
      // Check if location service is running
      final isLocationServiceActive = _locationService.locationStream != null;

      // Check if background service is running
      final isBackgroundActive = BackgroundLocationService.isRunning;

      // Get last location sample
      final currentLocation = await _locationService.getCurrentLocation();

      // Calculate tracking statistics
      final stats = await _calculateTrackingStats(userId);

      return TrackingStatus(
        isActive: isLocationServiceActive || isBackgroundActive,
        isLocationServiceActive: isLocationServiceActive,
        isBackgroundActive: isBackgroundActive,
        currentLocation: currentLocation != null
            ? LocationSample(
                id: DateTime.now().millisecondsSinceEpoch,
                companyId: 'current_company',
                userId: userId,
                at: DateTime.now(),
                latitude: currentLocation.latitude,
                longitude: currentLocation.longitude,
                speedMs: currentLocation.speed,
                accuracyM: currentLocation.accuracy,
              )
            : null,
        statistics: stats,
        lastUpdateAt: DateTime.now(),
      );
    } catch (e) {
      logger.e('Get tracking status error: $e');
      rethrow;
    }
  }

  Future<List<LocationSample>> getTrackingHistory({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
  }) async {
    try {
      // TODO: Implement history retrieval from repository
      // For now, return empty list
      return [];
    } catch (e) {
      logger.e('Get tracking history error: $e');
      return [];
    }
  }

  Future<TrackingAnalytics> analyzeTrackingData({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final history = await getTrackingHistory(
        userId: userId,
        startDate: startDate,
        endDate: endDate,
      );

      if (history.isEmpty) {
        return TrackingAnalytics.empty();
      }

      // Calculate distance traveled
      double totalDistance = 0;
      for (int i = 1; i < history.length; i++) {
        final prev = history[i - 1];
        final current = history[i];

        totalDistance += _locationService.calculateDistance(
          prev.latitude,
          prev.longitude,
          current.latitude,
          current.longitude,
        );
      }

      // Calculate time spent
      final totalTime = endDate.difference(startDate);

      // Calculate average speed
      final averageSpeed = totalTime.inSeconds > 0
          ? (totalDistance / totalTime.inSeconds).toDouble()
          : 0.0;

      // Find max speed
      final maxSpeed =
          history.map((s) => s.speedMs ?? 0).reduce((a, b) => a > b ? a : b);

      // Calculate stops (locations where speed is < 1 m/s for > 5 minutes)
      final stops = _calculateStops(history);

      return TrackingAnalytics(
        userId: userId,
        startDate: startDate,
        endDate: endDate,
        totalDistance: totalDistance,
        totalTime: totalTime,
        averageSpeed: averageSpeed,
        maxSpeed: maxSpeed,
        locationSamples: history.length,
        stops: stops.length,
        stopDuration:
            stops.fold(Duration.zero, (sum, stop) => sum + stop.duration),
      );
    } catch (e) {
      logger.e('Analyze tracking data error: $e');
      rethrow;
    }
  }

  TrackingConfig _getTrackingConfig(
    TrackingMode mode,
    int? intervalSeconds,
    double? accuracyThreshold,
  ) {
    switch (mode) {
      case TrackingMode.standard:
        return TrackingConfig(
          intervalSeconds: intervalSeconds ?? 30,
          accuracyThreshold: accuracyThreshold ?? 20.0,
          distanceFilter: 10,
          backgroundTracking: false,
        );
      case TrackingMode.precise:
        return TrackingConfig(
          intervalSeconds: intervalSeconds ?? 10,
          accuracyThreshold: accuracyThreshold ?? 10.0,
          distanceFilter: 5,
          backgroundTracking: false,
        );
      case TrackingMode.background:
        return TrackingConfig(
          intervalSeconds: intervalSeconds ?? 60,
          accuracyThreshold: accuracyThreshold ?? 50.0,
          distanceFilter: 20,
          backgroundTracking: true,
        );
      case TrackingMode.continuous:
        return TrackingConfig(
          intervalSeconds: intervalSeconds ?? 5,
          accuracyThreshold: accuracyThreshold ?? 5.0,
          distanceFilter: 1,
          backgroundTracking: true,
        );
      case TrackingMode.powerSaving:
        return TrackingConfig(
          intervalSeconds: intervalSeconds ?? 300,
          accuracyThreshold: accuracyThreshold ?? 100.0,
          distanceFilter: 50,
          backgroundTracking: false,
        );
    }
  }

  Future<TrackingStatistics> _calculateTrackingStats(String userId) async {
    try {
      // TODO: Calculate actual statistics from stored data
      return TrackingStatistics(
        totalSamples: 0,
        todaySamples: 0,
        averageAccuracy: 0,
        trackingDuration: Duration.zero,
      );
    } catch (e) {
      logger.e('Calculate tracking stats error: $e');
      return TrackingStatistics(
        totalSamples: 0,
        todaySamples: 0,
        averageAccuracy: 0,
        trackingDuration: Duration.zero,
      );
    }
  }

  List<TrackingStop> _calculateStops(List<LocationSample> history) {
    final stops = <TrackingStop>[];

    if (history.length < 2) return stops;

    TrackingStop? currentStop;

    for (int i = 0; i < history.length; i++) {
      final sample = history[i];
      final isStationary = (sample.speedMs ?? 0) < 1.0; // Less than 1 m/s

      if (isStationary) {
        if (currentStop == null) {
          // Start of a new stop
          currentStop = TrackingStop(
            startTime: sample.at,
            endTime: sample.at,
            latitude: sample.latitude,
            longitude: sample.longitude,
            duration: Duration.zero,
          );
        } else {
          // Continue current stop
          currentStop = currentStop.copyWith(endTime: sample.at);
        }
      } else {
        if (currentStop != null) {
          // End of current stop
          final stopDuration =
              currentStop.endTime.difference(currentStop.startTime);
          if (stopDuration.inMinutes >= 5) {
            // Only count stops of 5+ minutes
            stops.add(currentStop.copyWith(duration: stopDuration));
          }
          currentStop = null;
        }
      }
    }

    // Handle final stop if it exists
    if (currentStop != null) {
      final stopDuration =
          currentStop.endTime.difference(currentStop.startTime);
      if (stopDuration.inMinutes >= 5) {
        stops.add(currentStop.copyWith(duration: stopDuration));
      }
    }

    return stops;
  }
}

enum TrackingMode {
  standard,
  precise,
  background,
  continuous,
  powerSaving,
}

class TrackingConfig {
  TrackingConfig({
    required this.intervalSeconds,
    required this.accuracyThreshold,
    required this.distanceFilter,
    required this.backgroundTracking,
  });
  final int intervalSeconds;
  final double accuracyThreshold;
  final double distanceFilter;
  final bool backgroundTracking;
}

class TrackingSessionResult {
  TrackingSessionResult({
    required this.sessionId,
    required this.userId,
    required this.companyId,
    required this.mode,
    required this.config,
    required this.initialLocation,
    required this.startedAt,
    required this.isActive,
  });
  final String sessionId;
  final String userId;
  final String companyId;
  final TrackingMode mode;
  final TrackingConfig config;
  final LocationSample initialLocation;
  final DateTime startedAt;
  final bool isActive;
}

class TrackingStatus {
  TrackingStatus({
    required this.isActive,
    required this.isLocationServiceActive,
    required this.isBackgroundActive,
    this.currentLocation,
    required this.statistics,
    required this.lastUpdateAt,
  });
  final bool isActive;
  final bool isLocationServiceActive;
  final bool isBackgroundActive;
  final LocationSample? currentLocation;
  final TrackingStatistics statistics;
  final DateTime lastUpdateAt;
}

class TrackingStatistics {
  TrackingStatistics({
    required this.totalSamples,
    required this.todaySamples,
    required this.averageAccuracy,
    this.lastSampleAt,
    required this.trackingDuration,
  });
  final int totalSamples;
  final int todaySamples;
  final double averageAccuracy;
  final DateTime? lastSampleAt;
  final Duration trackingDuration;
}

class TrackingAnalytics {
  TrackingAnalytics({
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.totalDistance,
    required this.totalTime,
    required this.averageSpeed,
    required this.maxSpeed,
    required this.locationSamples,
    required this.stops,
    required this.stopDuration,
  });

  factory TrackingAnalytics.empty() => TrackingAnalytics(
        userId: '',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        totalDistance: 0,
        totalTime: Duration.zero,
        averageSpeed: 0,
        maxSpeed: 0,
        locationSamples: 0,
        stops: 0,
        stopDuration: Duration.zero,
      );
  final String userId;
  final DateTime startDate;
  final DateTime endDate;
  final double totalDistance;
  final Duration totalTime;
  final double averageSpeed;
  final double maxSpeed;
  final int locationSamples;
  final int stops;
  final Duration stopDuration;

  double get movingTime =>
      totalTime.inSeconds - stopDuration.inSeconds.toDouble();
  double get averageMovingSpeed =>
      movingTime > 0 ? totalDistance / movingTime : 0;
}

class TrackingStop {
  TrackingStop({
    required this.startTime,
    required this.endTime,
    required this.latitude,
    required this.longitude,
    required this.duration,
  });
  final DateTime startTime;
  final DateTime endTime;
  final double latitude;
  final double longitude;
  final Duration duration;

  TrackingStop copyWith({
    DateTime? startTime,
    DateTime? endTime,
    double? latitude,
    double? longitude,
    Duration? duration,
  }) =>
      TrackingStop(
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        duration: duration ?? this.duration,
      );
}

import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../config/logger.dart';
import '../../config/app_constants.dart';

class LocationService {
  factory LocationService() => _instance;
  LocationService._internal();
  static final LocationService _instance = LocationService._internal();

  StreamController<Position>? _locationController;
  StreamSubscription<Position>? _locationSubscription;

  Stream<Position> get locationStream {
    _locationController ??= StreamController<Position>.broadcast();
    return _locationController!.stream;
  }

  Future<bool> requestPermissions() async {
    try {
      final status = await Permission.location.request();
      if (status.isGranted) {
        final backgroundStatus = await Permission.locationAlways.request();
        return backgroundStatus.isGranted;
      }
      return false;
    } catch (e) {
      logger.e('Request permissions error: $e');
      return false;
    }
  }

  Future<Position?> getCurrentLocation() async {
    try {
      final hasPermission = await _checkLocationPermission();
      if (!hasPermission) return null;

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );
    } catch (e) {
      logger.e('Get current location error: $e');
      return null;
    }
  }

  Future<void> startLocationTracking() async {
    try {
      final hasPermission = await _checkLocationPermission();
      if (!hasPermission) {
        logger.w('Location permission not granted');
        return;
      }

      const locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5, // meters
        timeLimit: Duration(seconds: 30),
      );

      _locationSubscription = Geolocator.getPositionStream(
        locationSettings: locationSettings,
      ).listen(
        (position) {
          _locationController?.add(position);
        },
        onError: (error) {
          logger.e('Location stream error: $error');
        },
      );
    } catch (e) {
      logger.e('Start location tracking error: $e');
    }
  }

  Future<void> stopLocationTracking() async {
    await _locationSubscription?.cancel();
    _locationSubscription = null;
  }

  Future<bool> _checkLocationPermission() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      logger.w('Location services are disabled');
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        logger.w('Location permissions are denied');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      logger.w('Location permissions are permanently denied');
      return false;
    }

    return true;
  }

  double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) =>
      Geolocator.distanceBetween(lat1, lon1, lat2, lon2);

  bool isWithinGeofence(
    double currentLat,
    double currentLon,
    double targetLat,
    double targetLon,
    double radiusM,
  ) {
    final distance =
        calculateDistance(currentLat, currentLon, targetLat, targetLon);
    return distance <= radiusM;
  }

  void dispose() {
    stopLocationTracking();
    _locationController?.close();
  }
}

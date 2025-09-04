import 'dart:async';
import 'package:geolocator/geolocator.dart';
import '../../config/logger.dart';
import '../../data/models/geo/geofence.dart';
import '../../data/models/customers/customer.dart';

enum GeofenceEvent { enter, exit, dwell }

class GeofenceService {
  factory GeofenceService() => _instance;
  GeofenceService._internal();
  static final GeofenceService _instance = GeofenceService._internal();

  final Map<String, Geofence> _activeGeofences = {};
  final Map<String, bool> _currentStatus = {}; // true = inside, false = outside
  final StreamController<GeofenceEventData> _eventController =
      StreamController<GeofenceEventData>.broadcast();

  Stream<GeofenceEventData> get eventStream => _eventController.stream;

  void addCustomerGeofence(Customer customer) {
    if (customer.latitude == null || customer.longitude == null) return;

    final geofence = Geofence(
      id: 'customer_${customer.id}',
      companyId: customer.companyId,
      ownerId: 'current_user_id', // TODO: Get from auth
      centerLatitude: customer.latitude!,
      centerLongitude: customer.longitude!,
    );

    _activeGeofences[geofence.id] = geofence;
    _currentStatus[geofence.id] = false;
  }

  void addGeofence(Geofence geofence) {
    _activeGeofences[geofence.id] = geofence;
    _currentStatus[geofence.id] = false;
  }

  void removeGeofence(String geofenceId) {
    _activeGeofences.remove(geofenceId);
    _currentStatus.remove(geofenceId);
  }

  void clearAllGeofences() {
    _activeGeofences.clear();
    _currentStatus.clear();
  }

  void checkPosition(Position position) {
    for (final geofence in _activeGeofences.values) {
      final distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        geofence.centerLatitude,
        geofence.centerLongitude,
      );

      final isInside = distance <= geofence.radiusM;
      final wasInside = _currentStatus[geofence.id] ?? false;

      if (isInside && !wasInside) {
        // Entered geofence
        _currentStatus[geofence.id] = true;
        _eventController.add(GeofenceEventData(
          geofence: geofence,
          event: GeofenceEvent.enter,
          position: position,
          distance: distance,
        ));
      } else if (!isInside && wasInside) {
        // Exited geofence
        _currentStatus[geofence.id] = false;
        _eventController.add(GeofenceEventData(
          geofence: geofence,
          event: GeofenceEvent.exit,
          position: position,
          distance: distance,
        ));
      }
    }
  }

  bool isInsideGeofence(String geofenceId) =>
      _currentStatus[geofenceId] ?? false;

  List<String> getActiveGeofences() => _currentStatus.entries
      .where((entry) => entry.value)
      .map((entry) => entry.key)
      .toList();

  void dispose() {
    _eventController.close();
    _activeGeofences.clear();
    _currentStatus.clear();
  }
}

class GeofenceEventData {
  GeofenceEventData({
    required this.geofence,
    required this.event,
    required this.position,
    required this.distance,
  });
  final Geofence geofence;
  final GeofenceEvent event;
  final Position position;
  final double distance;
}

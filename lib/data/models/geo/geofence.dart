import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Commented out until generated files are available
// part 'geofence.freezed.dart';
// part 'geofence.g.dart';

class Geofence {
  const Geofence({
    required this.id,
    required this.companyId,
    required this.ownerId,
    this.radiusM = 10,
    required this.centerLatitude,
    required this.centerLongitude,
    this.name,
    this.description,
    this.isActive = true,
    this.type = GeofenceType.customer,
    this.entityId,
    this.metadata,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String companyId;
  final String ownerId;
  final int radiusM;
  final double centerLatitude;
  final double centerLongitude;
  final String? name;
  final String? description;
  final bool isActive;
  final GeofenceType type;
  final String? entityId;
  final Map<String, dynamic>? metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Geofence.fromJson(Map<String, dynamic> json) => Geofence(
        id: json['id'],
        companyId: json['companyId'],
        ownerId: json['ownerId'],
        radiusM: json['radiusM'] ?? 10,
        centerLatitude: json['centerLatitude'],
        centerLongitude: json['centerLongitude'],
        name: json['name'],
        description: json['description'],
        isActive: json['isActive'] ?? true,
        type: GeofenceType.values.firstWhere((e) => e.name == json['type'],
            orElse: () => GeofenceType.customer),
        entityId: json['entityId'],
        metadata: json['metadata'],
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'companyId': companyId,
        'ownerId': ownerId,
        'radiusM': radiusM,
        'centerLatitude': centerLatitude,
        'centerLongitude': centerLongitude,
        'name': name,
        'description': description,
        'isActive': isActive,
        'type': type.name,
        'entityId': entityId,
        'metadata': metadata,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}

enum GeofenceType {
  @JsonValue('CUSTOMER')
  customer,
  @JsonValue('WAREHOUSE')
  warehouse,
  @JsonValue('ROUTE_POINT')
  routePoint,
  @JsonValue('OFFICE')
  office,
  @JsonValue('CUSTOM')
  custom,
}

class GeofenceEvent {
  const GeofenceEvent({
    required this.id,
    required this.geofenceId,
    required this.userId,
    required this.eventType,
    required this.timestamp,
    required this.latitude,
    required this.longitude,
    this.accuracy,
    this.notes,
    this.metadata,
  });

  final String id;
  final String geofenceId;
  final String userId;
  final GeofenceEventType eventType;
  final DateTime timestamp;
  final double latitude;
  final double longitude;
  final double? accuracy;
  final String? notes;
  final Map<String, dynamic>? metadata;

  factory GeofenceEvent.fromJson(Map<String, dynamic> json) => GeofenceEvent(
        id: json['id'],
        geofenceId: json['geofenceId'],
        userId: json['userId'],
        eventType: GeofenceEventType.values
            .firstWhere((e) => e.name == json['eventType']),
        timestamp: DateTime.parse(json['timestamp']),
        latitude: json['latitude'],
        longitude: json['longitude'],
        accuracy: json['accuracy'],
        notes: json['notes'],
        metadata: json['metadata'],
      );
}

enum GeofenceEventType {
  @JsonValue('ENTER')
  enter,
  @JsonValue('EXIT')
  exit,
  @JsonValue('DWELL')
  dwell,
}

class GeofenceStatus {
  const GeofenceStatus({
    required this.geofenceId,
    required this.userId,
    required this.isInside,
    this.lastEntered,
    this.lastExited,
    this.dwellTime,
    required this.entryCount,
    this.lastUpdated,
  });

  final String geofenceId;
  final String userId;
  final bool isInside;
  final DateTime? lastEntered;
  final DateTime? lastExited;
  final Duration? dwellTime;
  final int entryCount;
  final DateTime? lastUpdated;

  factory GeofenceStatus.fromJson(Map<String, dynamic> json) => GeofenceStatus(
        geofenceId: json['geofenceId'],
        userId: json['userId'],
        isInside: json['isInside'],
        lastEntered: json['lastEntered'] != null
            ? DateTime.parse(json['lastEntered'])
            : null,
        lastExited: json['lastExited'] != null
            ? DateTime.parse(json['lastExited'])
            : null,
        dwellTime: json['dwellTime'] != null
            ? Duration(milliseconds: json['dwellTime'])
            : null,
        entryCount: json['entryCount'],
        lastUpdated: json['lastUpdated'] != null
            ? DateTime.parse(json['lastUpdated'])
            : null,
      );
}

// Extensions for Geofence
extension GeofenceX on Geofence {
  /// Check if a point is inside this geofence
  bool containsPoint(double latitude, double longitude) {
    final distance = calculateDistanceToCenter(latitude, longitude);
    return distance <= radiusM;
  }

  /// Calculate distance from center to a point
  double calculateDistanceToCenter(double latitude, double longitude) =>
      _calculateHaversineDistance(
        centerLatitude,
        centerLongitude,
        latitude,
        longitude,
      );

  /// Get geofence bounds (for map display)
  GeofenceBounds get bounds {
    const double earthRadius = 6371000; // meters

    // Calculate offset in degrees
    final latOffset = (radiusM / earthRadius) * (180 / math.pi);
    final lngOffset = (radiusM / earthRadius) *
        (180 / math.pi) /
        math.cos(centerLatitude * math.pi / 180);

    return GeofenceBounds(
      northEast: GeofencePoint(
        latitude: centerLatitude + latOffset,
        longitude: centerLongitude + lngOffset,
      ),
      southWest: GeofencePoint(
        latitude: centerLatitude - latOffset,
        longitude: centerLongitude - lngOffset,
      ),
    );
  }

  /// Check if geofence overlaps with another geofence
  bool overlapsWith(Geofence other) {
    final distance = calculateDistanceToCenter(
      other.centerLatitude,
      other.centerLongitude,
    );
    return distance < (radiusM + other.radiusM);
  }

  /// Get display name for the geofence
  String get displayName {
    if (name != null && name!.isNotEmpty) {
      return name!;
    }

    switch (type) {
      case GeofenceType.customer:
        return 'Geofence Cliente';
      case GeofenceType.warehouse:
        return 'Geofence Almacén';
      case GeofenceType.routePoint:
        return 'Punto de Ruta';
      case GeofenceType.office:
        return 'Geofence Oficina';
      case GeofenceType.custom:
        return 'Geofence Personalizado';
    }
  }

  /// Get area in square meters
  double get areaSquareMeters => math.pi * radiusM * radiusM;

  /// Check if geofence is valid
  bool get isValid =>
      radiusM > 0 &&
      centerLatitude >= -90 &&
      centerLatitude <= 90 &&
      centerLongitude >= -180 &&
      centerLongitude <= 180 &&
      id.isNotEmpty &&
      companyId.isNotEmpty &&
      ownerId.isNotEmpty;
}

extension GeofenceTypeX on GeofenceType {
  String get displayName {
    switch (this) {
      case GeofenceType.customer:
        return 'Cliente';
      case GeofenceType.warehouse:
        return 'Almacén';
      case GeofenceType.routePoint:
        return 'Punto de Ruta';
      case GeofenceType.office:
        return 'Oficina';
      case GeofenceType.custom:
        return 'Personalizado';
    }
  }

  IconData get icon {
    switch (this) {
      case GeofenceType.customer:
        return Icons.business;
      case GeofenceType.warehouse:
        return Icons.warehouse;
      case GeofenceType.routePoint:
        return Icons.location_on;
      case GeofenceType.office:
        return Icons.business_center;
      case GeofenceType.custom:
        return Icons.place;
    }
  }

  Color get color {
    switch (this) {
      case GeofenceType.customer:
        return Colors.blue;
      case GeofenceType.warehouse:
        return Colors.orange;
      case GeofenceType.routePoint:
        return Colors.green;
      case GeofenceType.office:
        return Colors.purple;
      case GeofenceType.custom:
        return Colors.grey;
    }
  }
}

extension GeofenceEventTypeX on GeofenceEventType {
  String get displayName {
    switch (this) {
      case GeofenceEventType.enter:
        return 'Entrada';
      case GeofenceEventType.exit:
        return 'Salida';
      case GeofenceEventType.dwell:
        return 'Permanencia';
    }
  }

  IconData get icon {
    switch (this) {
      case GeofenceEventType.enter:
        return Icons.login;
      case GeofenceEventType.exit:
        return Icons.logout;
      case GeofenceEventType.dwell:
        return Icons.timer;
    }
  }

  Color get color {
    switch (this) {
      case GeofenceEventType.enter:
        return Colors.green;
      case GeofenceEventType.exit:
        return Colors.red;
      case GeofenceEventType.dwell:
        return Colors.orange;
    }
  }
}

// Helper classes
class GeofenceBounds {
  const GeofenceBounds({
    required this.northEast,
    required this.southWest,
  });

  final GeofencePoint northEast;
  final GeofencePoint southWest;

  factory GeofenceBounds.fromJson(Map<String, dynamic> json) => GeofenceBounds(
        northEast: GeofencePoint.fromJson(json['northEast']),
        southWest: GeofencePoint.fromJson(json['southWest']),
      );
}

class GeofencePoint {
  const GeofencePoint({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  factory GeofencePoint.fromJson(Map<String, dynamic> json) => GeofencePoint(
        latitude: json['latitude'],
        longitude: json['longitude'],
      );
}

// Geofence utilities
class GeofenceUtils {
  /// Calculate Haversine distance between two points
  static double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) =>
      _calculateHaversineDistance(lat1, lon1, lat2, lon2);

  /// Create a customer geofence
  static Geofence createCustomerGeofence({
    required String customerId,
    required String companyId,
    required String ownerId,
    required double latitude,
    required double longitude,
    int radiusM = 10,
    String? customerName,
  }) =>
      Geofence(
        id: 'customer_${customerId}_geofence',
        companyId: companyId,
        ownerId: ownerId,
        radiusM: radiusM,
        centerLatitude: latitude,
        centerLongitude: longitude,
        name: customerName != null ? 'Geofence $customerName' : null,
        type: GeofenceType.customer,
        entityId: customerId,
        createdAt: DateTime.now(),
      );

  /// Create a warehouse geofence
  static Geofence createWarehouseGeofence({
    required String warehouseId,
    required String companyId,
    required String ownerId,
    required double latitude,
    required double longitude,
    int radiusM = 50,
    String? warehouseName,
  }) =>
      Geofence(
        id: 'warehouse_${warehouseId}_geofence',
        companyId: companyId,
        ownerId: ownerId,
        radiusM: radiusM,
        centerLatitude: latitude,
        centerLongitude: longitude,
        name: warehouseName != null ? 'Geofence $warehouseName' : null,
        type: GeofenceType.warehouse,
        entityId: warehouseId,
        createdAt: DateTime.now(),
      );

  /// Validate geofence parameters
  static bool validateGeofence({
    required double latitude,
    required double longitude,
    required int radiusM,
  }) {
    return latitude >= -90 &&
        latitude <= 90 &&
        longitude >= -180 &&
        longitude <= 180 &&
        radiusM > 0 &&
        radiusM <= 10000; // Max 10km radius
  }

  /// Get optimal radius for accuracy
  static int getOptimalRadius(double accuracy) {
    // Ensure minimum radius based on GPS accuracy
    if (accuracy <= 5) return 10;
    if (accuracy <= 10) return 15;
    if (accuracy <= 20) return 25;
    return 30;
  }

  /// Check if point is inside multiple geofences
  static List<String> getContainingGeofences(
    List<Geofence> geofences,
    double latitude,
    double longitude,
  ) =>
      geofences
          .where((geofence) =>
              geofence.isActive && geofence.containsPoint(latitude, longitude))
          .map((geofence) => geofence.id)
          .toList();

  /// Create geofence event
  static GeofenceEvent createEvent({
    required String geofenceId,
    required String userId,
    required GeofenceEventType eventType,
    required double latitude,
    required double longitude,
    double? accuracy,
    String? notes,
    Map<String, dynamic>? metadata,
  }) =>
      GeofenceEvent(
        id: 'event_${DateTime.now().millisecondsSinceEpoch}',
        geofenceId: geofenceId,
        userId: userId,
        eventType: eventType,
        timestamp: DateTime.now(),
        latitude: latitude,
        longitude: longitude,
        accuracy: accuracy,
        notes: notes,
        metadata: metadata,
      );
}

// Private helper function
double _calculateHaversineDistance(
  double lat1,
  double lon1,
  double lat2,
  double lon2,
) {
  const double earthRadius = 6371000; // meters

  final lat1Rad = lat1 * (math.pi / 180);
  final lat2Rad = lat2 * (math.pi / 180);
  final deltaLatRad = (lat2 - lat1) * (math.pi / 180);
  final deltaLonRad = (lon2 - lon1) * (math.pi / 180);

  final a = math.sin(deltaLatRad / 2) * math.sin(deltaLatRad / 2) +
      math.cos(lat1Rad) *
          math.cos(lat2Rad) *
          math.sin(deltaLonRad / 2) *
          math.sin(deltaLonRad / 2);

  final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

  return earthRadius * c;
}

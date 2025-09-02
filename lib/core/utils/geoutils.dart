import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoUtils {
  /// Calculate distance between two points in meters
  static double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) =>
      Geolocator.distanceBetween(lat1, lon1, lat2, lon2);

  /// Check if a point is within a geofence
  static bool isWithinGeofence(
    double currentLat,
    double currentLon,
    double centerLat,
    double centerLon,
    double radiusMeters,
  ) {
    final distance =
        calculateDistance(currentLat, currentLon, centerLat, centerLon);
    return distance <= radiusMeters;
  }

  /// Calculate bearing between two points
  static double calculateBearing(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    final lat1Rad = _degreesToRadians(lat1);
    final lat2Rad = _degreesToRadians(lat2);
    final deltaLonRad = _degreesToRadians(lon2 - lon1);

    final y = sin(deltaLonRad) * cos(lat2Rad);
    final x = cos(lat1Rad) * sin(lat2Rad) -
        sin(lat1Rad) * cos(lat2Rad) * cos(deltaLonRad);

    final bearingRad = atan2(y, x);
    final bearingDeg = _radiansToDegrees(bearingRad);

    return (bearingDeg + 360) % 360;
  }

  /// Get center point of multiple coordinates
  static LatLng getCenterPoint(List<LatLng> coordinates) {
    if (coordinates.isEmpty) {
      throw ArgumentError('Coordinates list cannot be empty');
    }

    if (coordinates.length == 1) {
      return coordinates.first;
    }

    double x = 0, y = 0, z = 0;

    for (final coord in coordinates) {
      final latRad = _degreesToRadians(coord.latitude);
      final lonRad = _degreesToRadians(coord.longitude);

      x += cos(latRad) * cos(lonRad);
      y += cos(latRad) * sin(lonRad);
      z += sin(latRad);
    }

    final total = coordinates.length;
    x /= total;
    y /= total;
    z /= total;

    final centralLonRad = atan2(y, x);
    final centralSquareRoot = sqrt(x * x + y * y);
    final centralLatRad = atan2(z, centralSquareRoot);

    return LatLng(
      _radiansToDegrees(centralLatRad),
      _radiansToDegrees(centralLonRad),
    );
  }

  /// Get bounds that contain all coordinates
  static LatLngBounds getBounds(List<LatLng> coordinates) {
    if (coordinates.isEmpty) {
      throw ArgumentError('Coordinates list cannot be empty');
    }

    double minLat = coordinates.first.latitude;
    double maxLat = coordinates.first.latitude;
    double minLng = coordinates.first.longitude;
    double maxLng = coordinates.first.longitude;

    for (final coord in coordinates) {
      minLat = min(minLat, coord.latitude);
      maxLat = max(maxLat, coord.latitude);
      minLng = min(minLng, coord.longitude);
      maxLng = max(maxLng, coord.longitude);
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  /// Calculate zoom level to fit bounds
  static double calculateZoomLevel(
      LatLngBounds bounds, double mapWidth, double mapHeight) {
    const double padding = 50;

    final double latRad = _degreesToRadians(
        bounds.northeast.latitude - bounds.southwest.latitude);
    final double lngRad = _degreesToRadians(
        bounds.northeast.longitude - bounds.southwest.longitude);

    final double latZoom =
        _calculateZoomFromDistance(latRad, mapHeight - padding);
    final double lngZoom =
        _calculateZoomFromDistance(lngRad, mapWidth - padding);

    return min(latZoom, lngZoom);
  }

  /// Format coordinates to string
  static String formatCoordinates(double lat, double lng,
          {int precision = 6}) =>
      '${lat.toStringAsFixed(precision)}, ${lng.toStringAsFixed(precision)}';

  /// Parse coordinates from string
  static LatLng? parseCoordinates(String coordString) {
    try {
      final parts = coordString.split(',');
      if (parts.length != 2) return null;

      final lat = double.parse(parts[0].trim());
      final lng = double.parse(parts[1].trim());

      if (lat >= -90 && lat <= 90 && lng >= -180 && lng <= 180) {
        return LatLng(lat, lng);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Generate Google Maps URL
  static String generateGoogleMapsUrl(double lat, double lng, {String? label}) {
    final query = label != null ? '$lat,$lng($label)' : '$lat,$lng';
    return 'https://www.google.com/maps/search/?api=1&query=$query';
  }

  /// Generate route URL between two points
  static String generateRouteUrl(
    double fromLat,
    double fromLng,
    double toLat,
    double toLng,
  ) =>
      'https://www.google.com/maps/dir/$fromLat,$fromLng/$toLat,$toLng';

  /// Validate coordinates
  static bool isValidCoordinate(double? lat, double? lng) {
    if (lat == null || lng == null) return false;
    return lat >= -90 && lat <= 90 && lng >= -180 && lng <= 180;
  }

  /// Get accuracy level description
  static String getAccuracyDescription(double? accuracy) {
    if (accuracy == null) return 'Desconocida';
    if (accuracy <= 5) return 'Excelente';
    if (accuracy <= 10) return 'Buena';
    if (accuracy <= 20) return 'Regular';
    return 'Pobre';
  }

  /// Calculate estimated travel time (simple estimation)
  static Duration estimateTravelTime(double distanceMeters,
      {double speedKmh = 30}) {
    final distanceKm = distanceMeters / 1000;
    final timeHours = distanceKm / speedKmh;
    return Duration(milliseconds: (timeHours * 3600 * 1000).round());
  }

  /// Check if coordinates are significantly different
  static bool coordinatesChanged(
      double? oldLat, double? oldLng, double? newLat, double? newLng,
      {double thresholdMeters = 5.0}) {
    if (oldLat == null || oldLng == null || newLat == null || newLng == null) {
      return true;
    }

    final distance = calculateDistance(oldLat, oldLng, newLat, newLng);
    return distance >= thresholdMeters;
  }

  // Private helper methods
  static double _degreesToRadians(double degrees) => degrees * pi / 180;

  static double _radiansToDegrees(double radians) => radians * 180 / pi;

  static double _calculateZoomFromDistance(double distance, double dimension) =>
      log(dimension / distance) / ln2;
}

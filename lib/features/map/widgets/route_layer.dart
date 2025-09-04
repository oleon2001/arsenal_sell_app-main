import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../data/models/routes/route_plan.dart';
import '../../../data/models/customers/customer.dart';
import '../../../core/theme/palette.dart';
import '../../../core/utils/geoutils.dart';

class RouteLayerService {
  /// Create polylines for a route plan
  static Set<Polyline> createRoutePolylines({
    required RoutePlan routePlan,
    Color? routeColor,
  }) {
    final polylines = <Polyline>{};

    if (routePlan.stops.length < 2) return polylines;

    // Sort stops by sequence
    final sortedStops = List<RouteStop>.from(routePlan.stops)
      ..sort((a, b) => (a.sequence ?? 0).compareTo(b.sequence ?? 0));

    final routePoints = <LatLng>[];

    for (final stop in sortedStops) {
      if (stop.customer?.latitude != null && stop.customer?.longitude != null) {
        routePoints.add(LatLng(
          stop.customer!.latitude!,
          stop.customer!.longitude!,
        ));
      }
    }

    if (routePoints.length < 2) return polylines;

    // Main route polyline
    polylines.add(Polyline(
      polylineId: PolylineId('route_${routePlan.id}'),
      points: routePoints,
      color: routeColor ?? AppPalette.primary,
      width: 4,
      patterns: const [],
    ));

    // Add segment polylines with different colors for completed/pending
    for (int i = 0; i < routePoints.length - 1; i++) {
      final segment = [routePoints[i], routePoints[i + 1]];
      final stop = sortedStops[i];

      // Determine segment color based on visit completion
      Color segmentColor = AppPalette.textSecondary; // Default: not visited

      if (stop.customer != null) {
        // TODO: Check if this stop has been visited
        // For now, use different logic
        segmentColor = AppPalette.primary;
      }

      polylines.add(Polyline(
        polylineId: PolylineId('segment_${routePlan.id}_$i'),
        points: segment,
        color: segmentColor,
        width: 3,
        patterns: const [],
      ));
    }

    return polylines;
  }

  /// Create markers for route stops
  static Future<Set<Marker>> createRouteStopMarkers({
    required List<RouteStop> stops,
    required Function(RouteStop) onStopTap,
  }) async {
    final markers = <Marker>{};

    for (int i = 0; i < stops.length; i++) {
      final stop = stops[i];

      if (stop.customer?.latitude == null || stop.customer?.longitude == null) {
        continue;
      }

      final marker = await _createRouteStopMarker(
        stop: stop,
        sequence: i + 1,
        onTap: () => onStopTap(stop),
      );

      markers.add(marker);
    }

    return markers;
  }

  /// Create a single route stop marker
  static Future<Marker> _createRouteStopMarker({
    required RouteStop stop,
    required int sequence,
    required VoidCallback onTap,
  }) async {
    final icon = await _createSequenceIcon(
      sequence: sequence,
      isCompleted: false, // TODO: Check if stop is completed
      isPending: true,
    );

    return Marker(
      markerId: MarkerId('route_stop_${stop.id}'),
      position: LatLng(
        stop.customer!.latitude!,
        stop.customer!.longitude!,
      ),
      icon: icon,
      infoWindow: InfoWindow(
        title: '$sequence. ${stop.customer?.name ?? 'Cliente'}',
        snippet: stop.plannedTime != null
            ? 'Programado: ${_formatTime(stop.plannedTime!)}'
            : 'Sin horario programado',
        onTap: onTap,
      ),
      onTap: onTap,
    );
  }

  /// Create navigation polyline between two points
  static Future<Polyline?> createNavigationPolyline({
    required LatLng origin,
    required LatLng destination,
    Color? color,
  }) async {
    try {
      // In a real implementation, you would use Google Directions API
      // For now, create a simple straight line
      final points = [origin, destination];

      return Polyline(
        polylineId: const PolylineId('navigation'),
        points: points,
        color: color ?? AppPalette.info,
        width: 5,
        patterns: [
          PatternItem.dash(20),
          PatternItem.gap(10),
        ],
      );
    } catch (e) {
      return null;
    }
  }

  /// Create optimized route polylines
  static Set<Polyline> createOptimizedRoute({
    required List<LatLng> waypoints,
    required LatLng currentLocation,
    Color? routeColor,
  }) {
    final polylines = <Polyline>{};

    if (waypoints.isEmpty) return polylines;

    // Simple optimization: nearest neighbor
    final optimizedWaypoints = _optimizeRoute(currentLocation, waypoints);

    // Add current location as starting point
    final allPoints = [currentLocation, ...optimizedWaypoints];

    polylines.add(Polyline(
      polylineId: const PolylineId('optimized_route'),
      points: allPoints,
      color: routeColor ?? AppPalette.success,
      width: 4,
      patterns: const [],
    ));

    return polylines;
  }

  /// Simple route optimization using nearest neighbor algorithm
  static List<LatLng> _optimizeRoute(LatLng start, List<LatLng> waypoints) {
    final unvisited = List<LatLng>.from(waypoints);
    final optimized = <LatLng>[];
    LatLng current = start;

    while (unvisited.isNotEmpty) {
      double minDistance = double.infinity;
      int nearestIndex = 0;

      for (int i = 0; i < unvisited.length; i++) {
        final distance = GeoUtils.calculateDistance(
          current.latitude,
          current.longitude,
          unvisited[i].latitude,
          unvisited[i].longitude,
        );

        if (distance < minDistance) {
          minDistance = distance;
          nearestIndex = i;
        }
      }

      current = unvisited.removeAt(nearestIndex);
      optimized.add(current);
    }

    return optimized;
  }

  /// Create sequence number icon for route stops
  static Future<BitmapDescriptor> _createSequenceIcon({
    required int sequence,
    required bool isCompleted,
    required bool isPending,
  }) async {
    const size = 48.0;
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);

    Color backgroundColor;
    const Color textColor = Colors.white;

    if (isCompleted) {
      backgroundColor = AppPalette.success;
    } else if (isPending) {
      backgroundColor = AppPalette.warning;
    } else {
      backgroundColor = AppPalette.textSecondary;
    }

    // Draw background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    const center = Offset(size / 2, size / 2);
    const radius = size / 2 - 2;

    canvas.drawCircle(center, radius, backgroundPaint);
    canvas.drawCircle(center, radius, borderPaint);

    // Draw sequence number
    final textPainter = TextPainter(textDirection: ui.TextDirection.ltr);
    textPainter.text = TextSpan(
      text: sequence.toString(),
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size - textPainter.width) / 2,
        (size - textPainter.height) / 2,
      ),
    );

    final picture = pictureRecorder.endRecording();
    final image = await picture.toImage(size.toInt(), size.toInt());
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }

  /// Calculate route statistics
  static RouteStatistics calculateRouteStatistics({
    required List<RouteStop> stops,
    LatLng? currentLocation,
  }) {
    if (stops.isEmpty) {
      return const RouteStatistics(
        totalDistance: 0,
        estimatedDuration: Duration.zero,
        completedStops: 0,
        pendingStops: 0,
      );
    }

    final validStops = stops
        .where((stop) =>
            stop.customer?.latitude != null && stop.customer?.longitude != null)
        .toList();

    if (validStops.isEmpty) {
      return RouteStatistics(
        totalDistance: 0,
        estimatedDuration: Duration.zero,
        completedStops: 0,
        pendingStops: validStops.length,
      );
    }

    double totalDistance = 0;
    const int completedStops = 0;
    final int pendingStops = validStops.length;

    // Calculate distances between consecutive stops
    LatLng? previousPoint = currentLocation;

    for (final stop in validStops) {
      final stopLocation = LatLng(
        stop.customer!.latitude!,
        stop.customer!.longitude!,
      );

      if (previousPoint != null) {
        totalDistance += GeoUtils.calculateDistance(
          previousPoint.latitude,
          previousPoint.longitude,
          stopLocation.latitude,
          stopLocation.longitude,
        );
      }

      previousPoint = stopLocation;

      // TODO: Check if stop is completed
      // For now, assume all are pending
    }

    // Estimate duration (average 30 km/h + 15 minutes per stop)
    final travelTime =
        Duration(milliseconds: (totalDistance / 30000 * 3600 * 1000).round());
    final stopTime = Duration(minutes: validStops.length * 15);
    final estimatedDuration = travelTime + stopTime;

    return RouteStatistics(
      totalDistance: totalDistance,
      estimatedDuration: estimatedDuration,
      completedStops: completedStops,
      pendingStops: pendingStops,
    );
  }

  /// Create route bounds that include all stops
  static LatLngBounds? createRouteBounds(List<RouteStop> stops) {
    final validLocations = stops
        .where((stop) =>
            stop.customer?.latitude != null && stop.customer?.longitude != null)
        .map((stop) =>
            LatLng(stop.customer!.latitude!, stop.customer!.longitude!))
        .toList();

    if (validLocations.isEmpty) return null;

    return GeoUtils.getBounds(validLocations);
  }

  /// Format time for display
  static String _formatTime(DateTime dateTime) =>
      '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
}

class RouteStatistics {
  const RouteStatistics({
    required this.totalDistance,
    required this.estimatedDuration,
    required this.completedStops,
    required this.pendingStops,
  });
  final double totalDistance; // in meters
  final Duration estimatedDuration;
  final int completedStops;
  final int pendingStops;

  String get formattedDistance {
    if (totalDistance < 1000) {
      return '${totalDistance.toStringAsFixed(0)} m';
    } else {
      return '${(totalDistance / 1000).toStringAsFixed(1)} km';
    }
  }

  String get formattedDuration {
    final hours = estimatedDuration.inHours;
    final minutes = estimatedDuration.inMinutes % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  int get totalStops => completedStops + pendingStops;

  double get completionPercentage {
    if (totalStops == 0) return 0;
    return (completedStops / totalStops) * 100;
  }
}

// Helper widget for route information display
class RouteInfoWidget extends StatelessWidget {
  const RouteInfoWidget({
    super.key,
    required this.statistics,
    this.onOptimize,
    this.onStartNavigation,
  });
  final RouteStatistics statistics;
  final VoidCallback? onOptimize;
  final VoidCallback? onStartNavigation;

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Información de Ruta',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (onOptimize != null)
                    TextButton.icon(
                      onPressed: onOptimize,
                      icon: const Icon(Icons.route),
                      label: const Text('Optimizar'),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildStatItem(
                      'Distancia',
                      statistics.formattedDistance,
                      Icons.straighten,
                    ),
                  ),
                  Expanded(
                    child: _buildStatItem(
                      'Tiempo Est.',
                      statistics.formattedDuration,
                      Icons.access_time,
                    ),
                  ),
                  Expanded(
                    child: _buildStatItem(
                      'Paradas',
                      '${statistics.completedStops}/${statistics.totalStops}',
                      Icons.location_on,
                    ),
                  ),
                ],
              ),
              if (statistics.totalStops > 0) ...[
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: statistics.completionPercentage / 100,
                  backgroundColor: AppPalette.textSecondary.withOpacity(0.3),
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppPalette.success),
                ),
                const SizedBox(height: 8),
                Text(
                  '${statistics.completionPercentage.toStringAsFixed(1)}% completado',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppPalette.textSecondary,
                  ),
                ),
              ],
              if (onStartNavigation != null) ...[
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: onStartNavigation,
                    icon: const Icon(Icons.navigation),
                    label: const Text('Iniciar Navegación'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppPalette.primary,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      );

  Widget _buildStatItem(String label, String value, IconData icon) => Column(
        children: [
          Icon(icon, color: AppPalette.primary, size: 24),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppPalette.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
}

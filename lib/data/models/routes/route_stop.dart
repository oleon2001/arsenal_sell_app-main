import 'dart:math';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../customers/customer.dart';
import '../visits/visit.dart';

part 'route_stop.freezed.dart';
part 'route_stop.g.dart';

enum RouteStopStatus {
  @JsonValue('PENDING')
  pending,
  @JsonValue('IN_PROGRESS')
  inProgress,
  @JsonValue('COMPLETED')
  completed,
  @JsonValue('SKIPPED')
  skipped,
  @JsonValue('CANCELLED')
  cancelled,
}

@freezed
class RouteStop with _$RouteStop {
  const factory RouteStop({
    required String id,
    required String routeId,
    required String customerId,
    DateTime? plannedTime,
    DateTime? actualArrivalTime,
    DateTime? actualDepartureTime,
    int? sequence,
    String? notes,
    @Default(RouteStopStatus.pending) RouteStopStatus status,
    @Default(0.0) double distanceFromPrevious, // meters
    @Default(0) int estimatedDuration, // minutes
    Customer? customer,
    Visit? visit,
  }) = _RouteStop;

  factory RouteStop.fromJson(Map<String, dynamic> json) =>
      _$RouteStopFromJson(json);
}

// Extensions for business logic
extension RouteStopX on RouteStop {
  /// Check if the stop is completed
  bool get isCompleted => status == RouteStopStatus.completed;

  /// Check if the stop is pending
  bool get isPending => status == RouteStopStatus.pending;

  /// Check if the stop is in progress
  bool get isInProgress => status == RouteStopStatus.inProgress;

  /// Check if the stop was skipped
  bool get isSkipped => status == RouteStopStatus.skipped;

  /// Check if the stop was cancelled
  bool get isCancelled => status == RouteStopStatus.cancelled;

  /// Check if the stop can be started
  bool get canStart => status == RouteStopStatus.pending;

  /// Check if the stop can be completed
  bool get canComplete => status == RouteStopStatus.inProgress;

  /// Calculate actual duration in minutes
  int? get actualDuration {
    if (actualArrivalTime == null || actualDepartureTime == null) return null;
    return actualDepartureTime!.difference(actualArrivalTime!).inMinutes;
  }

  /// Check if the stop is running late
  bool get isRunningLate {
    if (plannedTime == null) return false;
    final now = DateTime.now();
    return now.isAfter(plannedTime!) && !isCompleted;
  }

  /// Calculate delay in minutes (positive if late, negative if early)
  int? get delayInMinutes {
    if (plannedTime == null || actualArrivalTime == null) return null;
    return actualArrivalTime!.difference(plannedTime!).inMinutes;
  }

  /// Get formatted planned time
  String? get formattedPlannedTime {
    if (plannedTime == null) return null;
    return '${plannedTime!.hour.toString().padLeft(2, '0')}:${plannedTime!.minute.toString().padLeft(2, '0')}';
  }

  /// Get formatted actual arrival time
  String? get formattedActualArrivalTime {
    if (actualArrivalTime == null) return null;
    return '${actualArrivalTime!.hour.toString().padLeft(2, '0')}:${actualArrivalTime!.minute.toString().padLeft(2, '0')}';
  }

  /// Get formatted actual departure time
  String? get formattedActualDepartureTime {
    if (actualDepartureTime == null) return null;
    return '${actualDepartureTime!.hour.toString().padLeft(2, '0')}:${actualDepartureTime!.minute.toString().padLeft(2, '0')}';
  }

  /// Get customer name
  String get customerName => customer?.name ?? 'Cliente Desconocido';

  /// Get customer address
  String get customerAddress => customer?.address ?? 'Sin dirección';

  /// Get customer coordinates
  bool get hasCustomerCoordinates =>
      customer?.latitude != null && customer?.longitude != null;

  /// Get formatted distance from previous stop
  String get formattedDistance {
    if (distanceFromPrevious < 1000) {
      return '${distanceFromPrevious.toStringAsFixed(0)} m';
    } else {
      return '${(distanceFromPrevious / 1000).toStringAsFixed(1)} km';
    }
  }

  /// Get formatted estimated duration
  String get formattedEstimatedDuration {
    if (estimatedDuration < 60) {
      return '$estimatedDuration min';
    } else {
      final hours = estimatedDuration ~/ 60;
      final minutes = estimatedDuration % 60;
      return '${hours}h ${minutes}m';
    }
  }

  /// Get formatted actual duration
  String get formattedActualDuration {
    final duration = actualDuration;
    if (duration == null) return 'No registrado';

    if (duration < 60) {
      return '$duration min';
    } else {
      final hours = duration ~/ 60;
      final minutes = duration % 60;
      return '${hours}h ${minutes}m';
    }
  }

  /// Get status display name
  String get statusDisplayName {
    switch (status) {
      case RouteStopStatus.pending:
        return 'Pendiente';
      case RouteStopStatus.inProgress:
        return 'En Progreso';
      case RouteStopStatus.completed:
        return 'Completado';
      case RouteStopStatus.skipped:
        return 'Omitido';
      case RouteStopStatus.cancelled:
        return 'Cancelado';
    }
  }

  /// Get status color for UI
  Color get statusColor {
    switch (status) {
      case RouteStopStatus.pending:
        return Colors.grey;
      case RouteStopStatus.inProgress:
        return Colors.blue;
      case RouteStopStatus.completed:
        return Colors.green;
      case RouteStopStatus.skipped:
        return Colors.orange;
      case RouteStopStatus.cancelled:
        return Colors.red;
    }
  }

  /// Create a copy to start the stop
  RouteStop start() => copyWith(
        status: RouteStopStatus.inProgress,
        actualArrivalTime: DateTime.now(),
      );

  /// Create a copy to complete the stop
  RouteStop complete({String? completionNotes}) => copyWith(
        status: RouteStopStatus.completed,
        actualDepartureTime: DateTime.now(),
        notes: completionNotes ?? notes,
      );

  /// Create a copy to skip the stop
  RouteStop skip({String? skipReason}) => copyWith(
        status: RouteStopStatus.skipped,
        notes: skipReason ?? notes,
      );

  /// Create a copy to cancel the stop
  RouteStop cancel({String? cancelReason}) => copyWith(
        status: RouteStopStatus.cancelled,
        notes: cancelReason ?? notes,
      );

  /// Validate if the route stop is valid
  bool get isValid =>
      id.isNotEmpty &&
      routeId.isNotEmpty &&
      customerId.isNotEmpty &&
      (sequence == null || sequence! >= 0) &&
      (estimatedDuration >= 0) &&
      (distanceFromPrevious >= 0);

  /// Check if coordinates are within geofence range
  bool isWithinGeofence({
    required double currentLat,
    required double currentLng,
    double radiusMeters = 10,
  }) {
    if (!hasCustomerCoordinates) return false;

    // Calculate distance using Haversine formula
    const double earthRadius = 6371000; // Earth's radius in meters

    final double lat1Rad = customer!.latitude! * (pi / 180);
    final double lat2Rad = currentLat * (pi / 180);
    final double deltaLatRad = (currentLat - customer!.latitude!) * (pi / 180);
    final double deltaLngRad = (currentLng - customer!.longitude!) * (pi / 180);

    final double a = sin(deltaLatRad / 2) * sin(deltaLatRad / 2) +
        cos(lat1Rad) *
            cos(lat2Rad) *
            sin(deltaLngRad / 2) *
            sin(deltaLngRad / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    final double distance = earthRadius * c;

    return distance <= radiusMeters;
  }

  /// Get time until planned arrival
  Duration? get timeUntilPlanned {
    if (plannedTime == null) return null;
    final now = DateTime.now();
    return plannedTime!.isAfter(now) ? plannedTime!.difference(now) : null;
  }

  /// Check if it's time to start this stop
  bool get isTimeToStart {
    if (plannedTime == null) return false;
    final now = DateTime.now();
    // Allow starting 15 minutes before planned time
    final allowedStartTime = plannedTime!.subtract(const Duration(minutes: 15));
    return now.isAfter(allowedStartTime) && !isCompleted;
  }
}

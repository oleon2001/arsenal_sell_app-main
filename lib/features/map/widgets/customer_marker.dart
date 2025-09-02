import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../data/models/customers/customer.dart';
import '../../../data/models/visits/visit.dart';
import '../../../core/theme/palette.dart';

class CustomerMarkerService {
  static final Map<String, BitmapDescriptor> _cachedIcons = {};

  /// Create a marker for a customer
  static Future<Marker> createCustomerMarker({
    required Customer customer,
    required VoidCallback onTap,
    bool hasActiveVisit = false,
    bool hasUncompletedOrders = false,
    CustomerStatus status = CustomerStatus.active,
  }) async {
    if (customer.latitude == null || customer.longitude == null) {
      throw ArgumentError('Customer must have valid coordinates');
    }

    final icon = await _getCustomerIcon(
      status: status,
      hasActiveVisit: hasActiveVisit,
      hasUncompletedOrders: hasUncompletedOrders,
    );

    return Marker(
      markerId: MarkerId('customer_${customer.id}'),
      position: LatLng(customer.latitude!, customer.longitude!),
      icon: icon,
      infoWindow: InfoWindow(
        title: customer.name,
        snippet: customer.address ?? 'Sin dirección',
        onTap: onTap,
      ),
      onTap: onTap,
    );
  }

  /// Create a marker for team member location
  static Future<Marker> createTeamMemberMarker({
    required String userId,
    required String userName,
    required double latitude,
    required double longitude,
    required DateTime lastUpdate,
    bool isActive = true,
  }) async {
    final icon = await _getTeamMemberIcon(isActive: isActive);

    return Marker(
      markerId: MarkerId('team_$userId'),
      position: LatLng(latitude, longitude),
      icon: icon,
      infoWindow: InfoWindow(
        title: userName,
        snippet: 'Actualizado: ${_formatTime(lastUpdate)}',
      ),
    );
  }

  /// Create a marker for visit location
  static Future<Marker> createVisitMarker({
    required Visit visit,
    required VoidCallback onTap,
  }) async {
    if (visit.checkinLatitude == null || visit.checkinLongitude == null) {
      throw ArgumentError('Visit must have check-in coordinates');
    }

    final icon = await _getVisitIcon(
      purpose: visit.purpose,
      isCompleted: visit.finishedAt != null,
    );

    return Marker(
      markerId: MarkerId('visit_${visit.id}'),
      position: LatLng(visit.checkinLatitude!, visit.checkinLongitude!),
      icon: icon,
      infoWindow: InfoWindow(
        title: 'Visita - ${_getVisitPurposeLabel(visit.purpose)}',
        snippet: visit.customer?.name ?? 'Cliente',
        onTap: onTap,
      ),
      onTap: onTap,
    );
  }

  /// Get customer icon based on status
  static Future<BitmapDescriptor> _getCustomerIcon({
    required CustomerStatus status,
    required bool hasActiveVisit,
    required bool hasUncompletedOrders,
  }) async {
    final key =
        'customer_${status.name}_${hasActiveVisit}_$hasUncompletedOrders';

    if (_cachedIcons.containsKey(key)) {
      return _cachedIcons[key]!;
    }

    Color iconColor;
    IconData iconData = Icons.business;

    if (hasActiveVisit) {
      iconColor = AppPalette.warning;
      iconData = Icons.location_on;
    } else if (hasUncompletedOrders) {
      iconColor = AppPalette.info;
      iconData = Icons.shopping_cart;
    } else {
      switch (status) {
        case CustomerStatus.active:
          iconColor = AppPalette.success;
          break;
        case CustomerStatus.inactive:
          iconColor = AppPalette.textSecondary;
          break;
        case CustomerStatus.blocked:
          iconColor = AppPalette.error;
          break;
        case CustomerStatus.prospect:
          iconColor = AppPalette.primary;
          break;
      }
    }

    final icon = await _createCustomIcon(
      icon: iconData,
      color: iconColor,
      size: 48,
    );

    _cachedIcons[key] = icon;
    return icon;
  }

  /// Get team member icon
  static Future<BitmapDescriptor> _getTeamMemberIcon({
    required bool isActive,
  }) async {
    final key = 'team_member_$isActive';

    if (_cachedIcons.containsKey(key)) {
      return _cachedIcons[key]!;
    }

    final icon = await _createCustomIcon(
      icon: Icons.person_pin_circle,
      color: isActive ? AppPalette.vendedor : AppPalette.textSecondary,
      size: 48,
    );

    _cachedIcons[key] = icon;
    return icon;
  }

  /// Get visit icon based on purpose
  static Future<BitmapDescriptor> _getVisitIcon({
    required VisitPurpose purpose,
    required bool isCompleted,
  }) async {
    final key = 'visit_${purpose.name}_$isCompleted';

    if (_cachedIcons.containsKey(key)) {
      return _cachedIcons[key]!;
    }

    IconData iconData;
    Color baseColor;

    switch (purpose) {
      case VisitPurpose.venta:
        iconData = Icons.shopping_cart;
        baseColor = AppPalette.success;
        break;
      case VisitPurpose.cobro:
        iconData = Icons.payment;
        baseColor = AppPalette.warning;
        break;
      case VisitPurpose.entrega:
        iconData = Icons.local_shipping;
        baseColor = AppPalette.info;
        break;
      case VisitPurpose.auditoria:
        iconData = Icons.assignment;
        baseColor = AppPalette.primary;
        break;
      case VisitPurpose.devolucion:
        iconData = Icons.keyboard_return;
        baseColor = AppPalette.error;
        break;
      default:
        iconData = Icons.location_on;
        baseColor = AppPalette.textSecondary;
    }

    final color = isCompleted ? baseColor : baseColor.withOpacity(0.6);

    final icon = await _createCustomIcon(
      icon: iconData,
      color: color,
      size: 40,
    );

    _cachedIcons[key] = icon;
    return icon;
  }

  /// Create custom icon from IconData
  static Future<BitmapDescriptor> _createCustomIcon({
    required IconData icon,
    required Color color,
    required double size,
  }) async {
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);

    // Draw background circle
    final backgroundPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final center = Offset(size / 2, size / 2);
    final radius = size / 2 - 2;

    canvas.drawCircle(center, radius, backgroundPaint);
    canvas.drawCircle(center, radius, borderPaint);

    // Draw icon
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        fontSize: size * 0.6,
        fontFamily: icon.fontFamily,
        color: color,
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

  /// Create cluster marker for multiple customers
  static Future<BitmapDescriptor> createClusterIcon({
    required int count,
    required Color color,
  }) async {
    final key = 'cluster_${count}_${color.value}';

    if (_cachedIcons.containsKey(key)) {
      return _cachedIcons[key]!;
    }

    const size = 60.0;
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);

    // Draw background circle
    final backgroundPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    const center = Offset(size / 2, size / 2);
    const radius = size / 2 - 2;

    canvas.drawCircle(center, radius, backgroundPaint);
    canvas.drawCircle(center, radius, borderPaint);

    // Draw count text
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
      text: count.toString(),
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
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

    final icon = BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
    _cachedIcons[key] = icon;
    return icon;
  }

  /// Get geofence circle overlay
  static Circle createGeofenceCircle({
    required String id,
    required LatLng center,
    required double radiusMeters,
    Color? strokeColor,
    Color? fillColor,
  }) =>
      Circle(
        circleId: CircleId('geofence_$id'),
        center: center,
        radius: radiusMeters,
        strokeWidth: 2,
        strokeColor: strokeColor ?? AppPalette.primary,
        fillColor: (fillColor ?? AppPalette.primary).withOpacity(0.2),
      );

  /// Clear cached icons
  static void clearCache() {
    _cachedIcons.clear();
  }

  static String _getVisitPurposeLabel(VisitPurpose purpose) {
    switch (purpose) {
      case VisitPurpose.venta:
        return 'Venta';
      case VisitPurpose.cobro:
        return 'Cobro';
      case VisitPurpose.entrega:
        return 'Entrega';
      case VisitPurpose.visita:
        return 'Visita';
      case VisitPurpose.auditoria:
        return 'Auditoría';
      case VisitPurpose.devolucion:
        return 'Devolución';
      case VisitPurpose.otro:
        return 'Otro';
    }
  }

  static String _formatTime(DateTime dateTime) =>
      '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
}

enum CustomerStatus {
  active,
  inactive,
  blocked,
  prospect,
}

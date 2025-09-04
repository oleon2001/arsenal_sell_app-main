import '../../../config/logger.dart';
import '../../../data/repositories/deliveries_repository.dart';
import '../../../services/location/location_service.dart';

class ConfirmDeliveryUseCase {
  ConfirmDeliveryUseCase(this._repository, this._locationService);
  final DeliveriesRepository _repository;
  final LocationService _locationService;

  Future<DeliveryConfirmationResult> execute({
    required String deliveryId,
    required String orderId,
    required DeliveryConfirmationType confirmationType,
    String? notes,
    List<String>? photoUrls,
    String? signatureUrl,
    String? recipientName,
    List<DeliveredItem>? partialItems,
  }) async {
    try {
      // Get current location for delivery confirmation
      final currentLocation = await _locationService.getCurrentLocation();

      DeliveryStatus status;
      String confirmationMessage;

      switch (confirmationType) {
        case DeliveryConfirmationType.delivered:
          status = DeliveryStatus.delivered;
          confirmationMessage = 'Entrega confirmada exitosamente';
          break;
        case DeliveryConfirmationType.partial:
          status = DeliveryStatus.partial;
          confirmationMessage = 'Entrega parcial registrada';
          break;
        case DeliveryConfirmationType.rejected:
          status = DeliveryStatus.rejected;
          confirmationMessage = 'Entrega rechazada';
          break;
      }

      // Validate delivery requirements
      _validateDeliveryRequirements(
          confirmationType, photoUrls, signatureUrl, partialItems);

      // Create delivery confirmation data
      final deliveryData = DeliveryConfirmationData(
        deliveryId: deliveryId,
        orderId: orderId,
        status: status,
        confirmedAt: DateTime.now(),
        confirmedBy: 'current_user_id', // TODO: Get from auth service
        latitude: currentLocation?.latitude,
        longitude: currentLocation?.longitude,
        accuracy: currentLocation?.accuracy,
        notes: notes,
        photoUrls: photoUrls ?? [],
        signatureUrl: signatureUrl,
        recipientName: recipientName,
        partialItems: partialItems ?? [],
      );

      // Confirm delivery in repository
      final confirmedDelivery = await _repository.confirmDelivery(
        deliveryId,
        status,
        notes,
      );

      // Log delivery confirmation
      logger.i('Delivery confirmed: $deliveryId with status: ${status.name}');

      // Generate delivery report if needed
      final deliveryReport = await _generateDeliveryReport(deliveryData);

      return DeliveryConfirmationResult(
        delivery: confirmedDelivery,
        confirmationData: deliveryData,
        message: confirmationMessage,
        deliveryReport: deliveryReport,
      );
    } catch (e) {
      logger.e('Confirm delivery error: $e');
      rethrow;
    }
  }

  void _validateDeliveryRequirements(
    DeliveryConfirmationType type,
    List<String>? photoUrls,
    String? signatureUrl,
    List<DeliveredItem>? partialItems,
  ) {
    switch (type) {
      case DeliveryConfirmationType.delivered:
        if (signatureUrl == null || signatureUrl.isEmpty) {
          throw Exception('Firma del cliente requerida para confirmar entrega');
        }
        break;
      case DeliveryConfirmationType.partial:
        if (partialItems == null || partialItems.isEmpty) {
          throw Exception(
              'Debe especificar los productos entregados parcialmente');
        }
        break;
      case DeliveryConfirmationType.rejected:
        // No additional requirements for rejection
        break;
    }

    // Photo evidence is recommended but not mandatory
    if (photoUrls?.isEmpty ?? true) {
      logger.w('No photo evidence provided for delivery confirmation');
    }
  }

  Future<DeliveryReport?> _generateDeliveryReport(
      DeliveryConfirmationData data) async {
    try {
      return DeliveryReport(
        deliveryId: data.deliveryId,
        orderId: data.orderId,
        status: data.status,
        confirmedAt: data.confirmedAt,
        confirmedBy: data.confirmedBy,
        location: data.latitude != null && data.longitude != null
            ? DeliveryLocation(
                latitude: data.latitude!,
                longitude: data.longitude!,
                accuracy: data.accuracy,
              )
            : null,
        recipientName: data.recipientName,
        notes: data.notes,
        photoCount: data.photoUrls.length,
        hasSignature: data.signatureUrl != null,
        deliveredItems: data.partialItems,
      );
    } catch (e) {
      logger.e('Generate delivery report error: $e');
      return null;
    }
  }

  Future<List<DeliveryModel>> getPendingDeliveries({
    String? userId,
    DateTime? date,
  }) async {
    try {
      final deliveries = await _repository.getDeliveries(forceSync: true);

      return deliveries.where((delivery) {
        final bool matches = delivery.status == DeliveryStatus.pending;

        if (userId != null) {
          // TODO: Filter by assigned user
        }

        if (date != null) {
          // TODO: Filter by delivery date
        }

        return matches;
      }).toList();
    } catch (e) {
      logger.e('Get pending deliveries error: $e');
      rethrow;
    }
  }

  Future<DeliveryRouteOptimization> optimizeDeliveryRoute({
    required List<DeliveryModel> deliveries,
    required double currentLatitude,
    required double currentLongitude,
  }) async {
    try {
      // Simple optimization using nearest neighbor algorithm
      final unvisited = List<DeliveryModel>.from(deliveries);
      final optimized = <DeliveryModel>[];

      final double currentLat = currentLatitude;
      final double currentLng = currentLongitude;
      double totalDistance = 0;

      while (unvisited.isNotEmpty) {
        double minDistance = double.infinity;
        int nearestIndex = 0;

        for (int i = 0; i < unvisited.length; i++) {
          final delivery = unvisited[i];
          // TODO: Get customer location from delivery.order.customer
          final distance = _locationService.calculateDistance(currentLat,
              currentLng, 0, 0 // TODO: Use actual customer coordinates
              );

          if (distance < minDistance) {
            minDistance = distance;
            nearestIndex = i;
          }
        }

        final nearestDelivery = unvisited.removeAt(nearestIndex);
        optimized.add(nearestDelivery);
        totalDistance += minDistance;

        // TODO: Update current position to delivery location
      }

      // Estimate total time (assuming 30 km/h average speed + 15 min per delivery)
      final travelTimeHours =
          totalDistance / 30000; // Convert m to km and divide by speed
      final deliveryTimeHours = deliveries.length * 0.25; // 15 min per delivery
      final totalTimeHours = travelTimeHours + deliveryTimeHours;

      return DeliveryRouteOptimization(
        optimizedDeliveries: optimized,
        totalDistance: totalDistance,
        estimatedDuration: Duration(minutes: (totalTimeHours * 60).round()),
        deliveryCount: deliveries.length,
      );
    } catch (e) {
      logger.e('Optimize delivery route error: $e');
      rethrow;
    }
  }
}

enum DeliveryConfirmationType {
  delivered,
  partial,
  rejected,
}

class DeliveryConfirmationData {
  DeliveryConfirmationData({
    required this.deliveryId,
    required this.orderId,
    required this.status,
    required this.confirmedAt,
    required this.confirmedBy,
    this.latitude,
    this.longitude,
    this.accuracy,
    this.notes,
    required this.photoUrls,
    this.signatureUrl,
    this.recipientName,
    required this.partialItems,
  });
  final String deliveryId;
  final String orderId;
  final DeliveryStatus status;
  final DateTime confirmedAt;
  final String confirmedBy;
  final double? latitude;
  final double? longitude;
  final double? accuracy;
  final String? notes;
  final List<String> photoUrls;
  final String? signatureUrl;
  final String? recipientName;
  final List<DeliveredItem> partialItems;
}

class DeliveryConfirmationResult {
  DeliveryConfirmationResult({
    required this.delivery,
    required this.confirmationData,
    required this.message,
    this.deliveryReport,
  });
  final DeliveryModel delivery;
  final DeliveryConfirmationData confirmationData;
  final String message;
  final DeliveryReport? deliveryReport;
}

class DeliveredItem {
  DeliveredItem({
    required this.productId,
    required this.productName,
    required this.orderedQuantity,
    required this.deliveredQuantity,
    this.notes,
  });
  final String productId;
  final String productName;
  final double orderedQuantity;
  final double deliveredQuantity;
  final String? notes;
}

class DeliveryReport {
  DeliveryReport({
    required this.deliveryId,
    required this.orderId,
    required this.status,
    required this.confirmedAt,
    required this.confirmedBy,
    this.location,
    this.recipientName,
    this.notes,
    required this.photoCount,
    required this.hasSignature,
    required this.deliveredItems,
  });
  final String deliveryId;
  final String orderId;
  final DeliveryStatus status;
  final DateTime confirmedAt;
  final String confirmedBy;
  final DeliveryLocation? location;
  final String? recipientName;
  final String? notes;
  final int photoCount;
  final bool hasSignature;
  final List<DeliveredItem> deliveredItems;
}

class DeliveryLocation {
  DeliveryLocation({
    required this.latitude,
    required this.longitude,
    this.accuracy,
  });
  final double latitude;
  final double longitude;
  final double? accuracy;
}

class DeliveryRouteOptimization {
  DeliveryRouteOptimization({
    required this.optimizedDeliveries,
    required this.totalDistance,
    required this.estimatedDuration,
    required this.deliveryCount,
  });
  final List<DeliveryModel> optimizedDeliveries;
  final double totalDistance;
  final Duration estimatedDuration;
  final int deliveryCount;
}

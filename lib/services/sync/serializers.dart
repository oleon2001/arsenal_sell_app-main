import 'dart:convert';

import '../../config/logger.dart';
import '../../data/models/customers/customer.dart';
import '../../data/models/geo/location_sample.dart';
import '../../data/models/routes/route_plan.dart';
import '../../data/models/sales/order.dart';
import '../../data/models/payments/payment.dart';
import '../../data/models/visits/visit.dart';

/// Service for serializing and deserializing data for sync operations
class SyncSerializers {
  /// Serialize customer data for sync
  static Map<String, dynamic> serializeCustomer(Customer customer) {
    try {
      final data = customer.toJson();

      // Add sync metadata
      data['sync_action'] = 'upsert';
      data['sync_timestamp'] = DateTime.now().toIso8601String();
      data['local_id'] = customer.id;

      // Handle coordinates for PostGIS
      if (customer.latitude != null && customer.longitude != null) {
        data['location'] = {
          'type': 'Point',
          'coordinates': [customer.longitude, customer.latitude],
        };
      }

      return data;
    } catch (e) {
      logger.e('Serialize customer error: $e');
      rethrow;
    }
  }

  /// Deserialize customer data from sync
  static Customer deserializeCustomer(Map<String, dynamic> data) {
    try {
      // Handle PostGIS coordinates
      if (data['location'] != null && data['location']['coordinates'] != null) {
        final coordinates = data['location']['coordinates'] as List;
        if (coordinates.length >= 2) {
          data['longitude'] = coordinates[0];
          data['latitude'] = coordinates[1];
        }
      }

      return Customer.fromJson(data);
    } catch (e) {
      logger.e('Deserialize customer error: $e');
      rethrow;
    }
  }

  /// Serialize visit data for sync
  static Map<String, dynamic> serializeVisit(Visit visit) {
    try {
      final data = visit.toJson();

      // Add sync metadata
      data['sync_action'] = 'upsert';
      data['sync_timestamp'] = DateTime.now().toIso8601String();
      data['local_id'] = visit.id;

      // Handle coordinates for PostGIS
      if (visit.checkinLatitude != null && visit.checkinLongitude != null) {
        data['checkin'] = {
          'type': 'Point',
          'coordinates': [visit.checkinLongitude, visit.checkinLatitude],
        };
      }

      if (visit.checkoutLatitude != null && visit.checkoutLongitude != null) {
        data['checkout'] = {
          'type': 'Point',
          'coordinates': [visit.checkoutLongitude, visit.checkoutLatitude],
        };
      }

      // Handle photos and signatures
      if (visit.photos.isNotEmpty) {
        data['photos'] = visit.photos
            .map((photo) => {
                  'storage_path': photo.storagePath,
                  'created_at': photo.createdAt?.toIso8601String(),
                })
            .toList();
      }

      if (visit.signature != null) {
        data['signature'] = {
          'storage_path': visit.signature!.storagePath,
          'signed_by': visit.signature!.signedBy,
          'created_at': visit.signature!.createdAt?.toIso8601String(),
        };
      }

      return data;
    } catch (e) {
      logger.e('Serialize visit error: $e');
      rethrow;
    }
  }

  /// Deserialize visit data from sync
  static Visit deserializeVisit(Map<String, dynamic> data) {
    try {
      // Handle PostGIS coordinates
      if (data['checkin'] != null && data['checkin']['coordinates'] != null) {
        final coordinates = data['checkin']['coordinates'] as List;
        if (coordinates.length >= 2) {
          data['checkinLongitude'] = coordinates[0];
          data['checkinLatitude'] = coordinates[1];
        }
      }

      if (data['checkout'] != null && data['checkout']['coordinates'] != null) {
        final coordinates = data['checkout']['coordinates'] as List;
        if (coordinates.length >= 2) {
          data['checkoutLongitude'] = coordinates[0];
          data['checkoutLatitude'] = coordinates[1];
        }
      }

      // Handle photos array
      if (data['photos'] != null) {
        // Keep photos as-is for now until generated models are available
        // TODO: Implement proper VisitPhoto deserialization
      }

      // Handle signature
      if (data['signature'] != null) {
        // Keep signature as-is for now until generated models are available
        // TODO: Implement proper VisitSignature deserialization
      }

      return Visit.fromJson(data);
    } catch (e) {
      logger.e('Deserialize visit error: $e');
      rethrow;
    }
  }

  /// Serialize order data for sync
  static Map<String, dynamic> serializeOrder(Order order) {
    try {
      final data = order.toJson();

      // Add sync metadata
      data['sync_action'] = 'upsert';
      data['sync_timestamp'] = DateTime.now().toIso8601String();
      data['local_id'] = order.id;

      // Serialize order items separately for relational structure
      if (order.items.isNotEmpty) {
        data['items'] = order.items
            .map((item) => {
                  'id': item.id,
                  'order_id': order.id,
                  'product_id': item.productId,
                  'qty': item.qty,
                  'price': item.price,
                  'discount': item.discount,
                  'total': item.total,
                })
            .toList();
      }

      return data;
    } catch (e) {
      logger.e('Serialize order error: $e');
      rethrow;
    }
  }

  /// Deserialize order data from sync
  static Order deserializeOrder(Map<String, dynamic> data) {
    try {
      // Handle order items
      if (data['items'] != null) {
        final items = (data['items'] as List)
            .map((itemData) => OrderItem(
                  id: itemData['id'],
                  orderId: itemData['order_id'],
                  productId: itemData['product_id'],
                  qty: itemData['qty']?.toDouble() ?? 0,
                  price: itemData['price']?.toDouble() ?? 0,
                  discount: itemData['discount']?.toDouble() ?? 0,
                  total: itemData['total']?.toDouble() ?? 0,
                ))
            .toList();
        data['items'] = items.map((item) => item.toJson()).toList();
      }

      return Order.fromJson(data);
    } catch (e) {
      logger.e('Deserialize order error: $e');
      rethrow;
    }
  }

  /// Serialize location sample for sync
  static Map<String, dynamic> serializeLocationSample(LocationSample sample) {
    try {
      final data = sample.toJson();

      // Add sync metadata
      data['sync_action'] = 'insert';
      data['sync_timestamp'] = DateTime.now().toIso8601String();
      data['local_id'] = sample.id.toString();

      // Handle coordinates for PostGIS
      data['point'] = {
        'type': 'Point',
        'coordinates': [sample.longitude, sample.latitude],
      };

      return data;
    } catch (e) {
      logger.e('Serialize location sample error: $e');
      rethrow;
    }
  }

  /// Deserialize location sample from sync
  static LocationSample deserializeLocationSample(Map<String, dynamic> data) {
    try {
      // Handle PostGIS coordinates
      if (data['point'] != null && data['point']['coordinates'] != null) {
        final coordinates = data['point']['coordinates'] as List;
        if (coordinates.length >= 2) {
          data['longitude'] = coordinates[0];
          data['latitude'] = coordinates[1];
        }
      }

      return LocationSample.fromJson(data);
    } catch (e) {
      logger.e('Deserialize location sample error: $e');
      rethrow;
    }
  }

  /// Serialize payment data for sync
  static Map<String, dynamic> serializePayment(Payment payment) {
    try {
      final data = {
        'id': payment.id,
        'order_id': payment.orderId,
        'customer_id': payment.customerId,
        'amount': payment.amount,
        'payment_method': payment.paymentMethod.toJson(),
        'created_at': payment.createdAt?.toIso8601String(),
        'notes': payment.notes,
        'status': payment.status.name,
        'reference': payment.reference,
      };

      // Add sync metadata
      data['sync_action'] = 'upsert';
      data['sync_timestamp'] = DateTime.now().toIso8601String();
      data['local_id'] = payment.id;

      return data;
    } catch (e) {
      logger.e('Serialize payment error: $e');
      rethrow;
    }
  }

  /// Deserialize payment data from sync
  static Payment deserializePayment(Map<String, dynamic> data) {
    try {
      return Payment(
        id: data['id'],
        orderId: data['order_id'],
        customerId: data['customer_id'],
        amount: data['amount']?.toDouble() ?? 0,
        paymentMethod: PaymentMethod.fromJson(data['payment_method']),
        createdAt: data['created_at'] != null
            ? DateTime.parse(data['created_at'])
            : null,
        notes: data['notes'],
        status: _parsePaymentStatus(data['status']),
        reference: data['reference'],
      );
    } catch (e) {
      logger.e('Deserialize payment error: $e');
      rethrow;
    }
  }

  /// Serialize route plan for sync
  static Map<String, dynamic> serializeRoutePlan(RoutePlan route) {
    try {
      final data = route.toJson();

      // Add sync metadata
      data['sync_action'] = 'upsert';
      data['sync_timestamp'] = DateTime.now().toIso8601String();
      data['local_id'] = route.id;

      // Serialize route stops separately for relational structure
      if (route.stops.isNotEmpty) {
        data['stops'] = route.stops
            .map((stop) => {
                  'id': stop.id,
                  'route_id': route.id,
                  'customer_id': stop.customerId,
                  'planned_time': stop.plannedTime?.toIso8601String(),
                  'sequence': stop.sequence,
                  'notes': stop.notes,
                })
            .toList();
      }

      return data;
    } catch (e) {
      logger.e('Serialize route plan error: $e');
      rethrow;
    }
  }

  /// Create batch sync payload
  static Map<String, dynamic> createBatchSyncPayload({
    List<Customer>? customers,
    List<Visit>? visits,
    List<Order>? orders,
    List<LocationSample>? locationSamples,
    List<Payment>? payments,
    List<RoutePlan>? routes,
  }) {
    try {
      final payload = <String, dynamic>{
        'batch_id': DateTime.now().millisecondsSinceEpoch.toString(),
        'timestamp': DateTime.now().toIso8601String(),
        'data': <String, List<Map<String, dynamic>>>{},
      };

      if (customers != null && customers.isNotEmpty) {
        payload['data']['customers'] =
            customers.map(serializeCustomer).toList();
      }

      if (visits != null && visits.isNotEmpty) {
        payload['data']['visits'] = visits.map(serializeVisit).toList();
      }

      if (orders != null && orders.isNotEmpty) {
        payload['data']['orders'] = orders.map(serializeOrder).toList();
      }

      if (locationSamples != null && locationSamples.isNotEmpty) {
        payload['data']['tracking_locations'] =
            locationSamples.map(serializeLocationSample).toList();
      }

      if (payments != null && payments.isNotEmpty) {
        payload['data']['payments'] = payments.map(serializePayment).toList();
      }

      if (routes != null && routes.isNotEmpty) {
        payload['data']['routes'] = routes.map(serializeRoutePlan).toList();
      }

      return payload;
    } catch (e) {
      logger.e('Create batch sync payload error: $e');
      rethrow;
    }
  }

  /// Parse batch sync response
  static Map<String, List<dynamic>> parseBatchSyncResponse(
      Map<String, dynamic> response) {
    try {
      final result = <String, List<dynamic>>{};

      if (response['data'] != null) {
        final data = response['data'] as Map<String, dynamic>;

        if (data['customers'] != null) {
          result['customers'] = (data['customers'] as List)
              .map((e) => deserializeCustomer(Map<String, dynamic>.from(e)))
              .toList();
        }

        if (data['visits'] != null) {
          result['visits'] = (data['visits'] as List)
              .map((e) => deserializeVisit(Map<String, dynamic>.from(e)))
              .toList();
        }

        if (data['orders'] != null) {
          result['orders'] = (data['orders'] as List)
              .map((e) => deserializeOrder(Map<String, dynamic>.from(e)))
              .toList();
        }

        if (data['tracking_locations'] != null) {
          result['tracking_locations'] = (data['tracking_locations'] as List)
              .map((e) =>
                  deserializeLocationSample(Map<String, dynamic>.from(e)))
              .toList();
        }

        if (data['payments'] != null) {
          result['payments'] = (data['payments'] as List)
              .map((e) => deserializePayment(Map<String, dynamic>.from(e)))
              .toList();
        }
      }

      return result;
    } catch (e) {
      logger.e('Parse batch sync response error: $e');
      rethrow;
    }
  }

  /// Validate sync data integrity
  static bool validateSyncData(Map<String, dynamic> data, String dataType) {
    try {
      switch (dataType) {
        case 'customer':
          return data.containsKey('id') &&
              data.containsKey('name') &&
              data.containsKey('company_id');
        case 'visit':
          return data.containsKey('id') &&
              data.containsKey('customer_id') &&
              data.containsKey('purpose');
        case 'order':
          return data.containsKey('id') &&
              data.containsKey('customer_id') &&
              data.containsKey('status');
        case 'location_sample':
          return data.containsKey('user_id') &&
              data.containsKey('latitude') &&
              data.containsKey('longitude');
        case 'payment':
          return data.containsKey('id') &&
              data.containsKey('amount') &&
              data.containsKey('paid_at');
        default:
          return false;
      }
    } catch (e) {
      logger.e('Validate sync data error: $e');
      return false;
    }
  }

  /// Clean sync metadata from data
  static Map<String, dynamic> cleanSyncMetadata(Map<String, dynamic> data) {
    final cleanData = Map<String, dynamic>.from(data);
    cleanData.removeWhere((key, value) => key.startsWith('sync_'));
    cleanData.remove('local_id');
    return cleanData;
  }

  /// Generate sync diff
  static Map<String, dynamic> generateSyncDiff({
    required Map<String, dynamic> localData,
    required Map<String, dynamic> serverData,
  }) {
    final diff = <String, dynamic>{};

    localData.forEach((key, localValue) {
      final serverValue = serverData[key];

      if (serverValue == null) {
        diff[key] = {'action': 'add', 'value': localValue};
      } else if (localValue != serverValue) {
        diff[key] = {
          'action': 'update',
          'old_value': serverValue,
          'new_value': localValue,
        };
      }
    });

    serverData.forEach((key, serverValue) {
      if (!localData.containsKey(key)) {
        diff[key] = {'action': 'remove', 'value': serverValue};
      }
    });

    return diff;
  }

  /// Compress sync data for efficient transfer
  static String compressSyncData(Map<String, dynamic> data) {
    try {
      final jsonString = jsonEncode(data);
      // In a real implementation, you might use gzip compression
      return jsonString;
    } catch (e) {
      logger.e('Compress sync data error: $e');
      rethrow;
    }
  }

  /// Decompress sync data
  static Map<String, dynamic> decompressSyncData(String compressedData) {
    try {
      // In a real implementation, you might use gzip decompression
      return jsonDecode(compressedData) as Map<String, dynamic>;
    } catch (e) {
      logger.e('Decompress sync data error: $e');
      rethrow;
    }
  }

  // Helper methods for payment parsing
  static PaymentStatus _parsePaymentStatus(String? status) {
    if (status == null) return PaymentStatus.pending;
    switch (status.toLowerCase()) {
      case 'pending':
        return PaymentStatus.pending;
      case 'completed':
        return PaymentStatus.completed;
      case 'failed':
        return PaymentStatus.failed;
      case 'cancelled':
        return PaymentStatus.cancelled;
      default:
        return PaymentStatus.pending;
    }
  }
}

// Domain entities for Arsenal Sell App
// These are pure domain objects without any external dependencies
import 'dart:math' show atan2, sqrt;

export '../data/models/audit/audit_log.dart';
export '../data/models/auth/company.dart';
export '../data/models/auth/user_profile.dart';
export '../data/models/customers/customer.dart';
export '../data/models/forms/form_response.dart';
export '../data/models/forms/form_template.dart';
export '../data/models/geo/geofence.dart';
export '../data/models/geo/location_sample.dart';
export '../data/models/geo/tracking_location.dart';
export '../data/models/notifications/email_queue.dart';
export '../data/models/reports/kpi.dart';
export '../data/models/routes/route_plan.dart';
export '../data/models/sales/delivery.dart';
export '../data/models/sales/inventory.dart';
export '../data/models/sales/inventory_alert.dart';
export '../data/models/sales/inventory_movement.dart';
export '../data/models/sales/inventory_transfer.dart';
export '../data/models/sales/order.dart';
export '../data/models/sales/payment.dart';
export '../data/models/sales/price_list.dart';
export '../data/models/sales/product.dart';
export '../data/models/sales/promotion.dart';
export '../data/models/sales/return.dart';
export '../data/models/sales/warehouse.dart';
export '../data/models/visits/visit.dart';
export '../data/models/visits/visit_photo.dart';
export '../data/models/visits/visit_signature.dart';

// Core domain interfaces
abstract class Repository<T> {
  Future<List<T>> getAll();
  Future<T?> getById(String id);
  Future<T> create(T entity);
  Future<T> update(T entity);
  Future<void> delete(String id);
}

abstract class UseCase<T, P> {
  Future<T> call(P params);
}

abstract class NoParamsUseCase<T> {
  Future<T> call();
}

// Core domain value objects
class Coordinates {
  const Coordinates({
    required this.latitude,
    required this.longitude,
    this.accuracy,
  });
  final double latitude;
  final double longitude;
  final double? accuracy;

  bool isValid() =>
      latitude >= -90 &&
      latitude <= 90 &&
      longitude >= -180 &&
      longitude <= 180;

  double distanceTo(Coordinates other) {
    // Haversine formula implementation would go here
    // For now, return a simple calculation
    final dLat = (other.latitude - latitude) * (3.14159 / 180);
    final dLon = (other.longitude - longitude) * (3.14159 / 180);
    final a = (dLat / 2) * (dLat / 2) +
        latitude *
            (3.14159 / 180) *
            other.latitude *
            (3.14159 / 180) *
            (dLon / 2) *
            (dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return 6371000 * c; // Distance in meters
  }

  @override
  String toString() => 'Coordinates($latitude, $longitude)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Coordinates &&
          runtimeType == other.runtimeType &&
          latitude == other.latitude &&
          longitude == other.longitude;

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}

class Money {
  const Money({
    required this.amount,
    this.currency = 'USD',
  });
  final double amount;
  final String currency;

  Money operator +(Money other) {
    if (currency != other.currency) {
      throw ArgumentError('Cannot add different currencies');
    }
    return Money(amount: amount + other.amount, currency: currency);
  }

  Money operator -(Money other) {
    if (currency != other.currency) {
      throw ArgumentError('Cannot subtract different currencies');
    }
    return Money(amount: amount - other.amount, currency: currency);
  }

  Money operator *(double multiplier) =>
      Money(amount: amount * multiplier, currency: currency);

  bool operator >(Money other) {
    if (currency != other.currency) {
      throw ArgumentError('Cannot compare different currencies');
    }
    return amount > other.amount;
  }

  bool operator <(Money other) {
    if (currency != other.currency) {
      throw ArgumentError('Cannot compare different currencies');
    }
    return amount < other.amount;
  }

  String formatted() => '$currency ${amount.toStringAsFixed(2)}';

  @override
  String toString() => formatted();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Money &&
          runtimeType == other.runtimeType &&
          amount == other.amount &&
          currency == other.currency;

  @override
  int get hashCode => amount.hashCode ^ currency.hashCode;
}

class TimeRange {
  const TimeRange({
    required this.start,
    required this.end,
  });
  final DateTime start;
  final DateTime end;

  bool contains(DateTime dateTime) =>
      dateTime.isAfter(start) && dateTime.isBefore(end);

  Duration get duration => end.difference(start);

  bool overlaps(TimeRange other) =>
      start.isBefore(other.end) && end.isAfter(other.start);

  @override
  String toString() => 'TimeRange($start - $end)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeRange &&
          runtimeType == other.runtimeType &&
          start == other.start &&
          end == other.end;

  @override
  int get hashCode => start.hashCode ^ end.hashCode;
}

// Domain exceptions
class DomainException implements Exception {
  const DomainException(this.message, {this.code});
  final String message;
  final String? code;

  @override
  String toString() =>
      'DomainException: $message${code != null ? ' (Code: $code)' : ''}';
}

class ValidationException extends DomainException {
  const ValidationException(super.message) : super(code: 'VALIDATION_ERROR');
}

class BusinessRuleException extends DomainException {
  const BusinessRuleException(super.message)
      : super(code: 'BUSINESS_RULE_ERROR');
}

class AuthorizationException extends DomainException {
  const AuthorizationException(super.message)
      : super(code: 'AUTHORIZATION_ERROR');
}

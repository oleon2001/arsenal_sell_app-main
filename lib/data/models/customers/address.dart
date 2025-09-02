import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
class Address with _$Address {
  const factory Address({
    required String street,
    required String city,
    required String state,
    required String zipCode,
    @Default('México') String country,
    double? latitude,
    double? longitude,
    String? neighborhood,
    String? references,
    @Default(false) bool isMainAddress,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

// Extensions for Address
extension AddressX on Address {
  /// Get full formatted address
  String get fullAddress {
    final parts = <String>[];

    parts.add(street);

    if (neighborhood != null && neighborhood!.isNotEmpty) {
      parts.add(neighborhood!);
    }

    parts.add(city);
    parts.add(state);

    if (zipCode.isNotEmpty) {
      parts.add('C.P. $zipCode');
    }

    parts.add(country);

    return parts.join(', ');
  }

  /// Get short formatted address
  String get shortAddress {
    final parts = <String>[];

    parts.add(street);
    if (neighborhood != null && neighborhood!.isNotEmpty) {
      parts.add(neighborhood!);
    }
    parts.add(city);

    return parts.join(', ');
  }

  /// Check if address has coordinates
  bool get hasCoordinates => latitude != null && longitude != null;

  /// Get coordinates as a map
  Map<String, double>? get coordinates {
    if (!hasCoordinates) return null;
    return {
      'latitude': latitude!,
      'longitude': longitude!,
    };
  }

  /// Validate address completeness
  bool get isComplete =>
      street.isNotEmpty &&
      city.isNotEmpty &&
      state.isNotEmpty &&
      zipCode.isNotEmpty;

  /// Get distance to another address (if both have coordinates)
  double? distanceTo(Address other) {
    if (!hasCoordinates || !other.hasCoordinates) return null;

    // Using Haversine formula
    const double earthRadius = 6371000; // meters

    final lat1Rad = latitude! * (3.14159265359 / 180);
    final lat2Rad = other.latitude! * (3.14159265359 / 180);
    final deltaLatRad = (other.latitude! - latitude!) * (3.14159265359 / 180);
    final deltaLonRad = (other.longitude! - longitude!) * (3.14159265359 / 180);

    final a = math.sin(deltaLatRad / 2) * math.sin(deltaLatRad / 2) +
        math.cos(lat1Rad) *
            math.cos(lat2Rad) *
            math.sin(deltaLonRad / 2) *
            math.sin(deltaLonRad / 2);

    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return earthRadius * c;
  }
}

// Address validation utilities
class AddressValidator {
  /// Validate Mexican postal code
  static bool isValidMexicanZipCode(String zipCode) {
    final regex = RegExp(r'^\d{5}$');
    return regex.hasMatch(zipCode);
  }

  /// Validate coordinates
  static bool areValidCoordinates(double? lat, double? lng) {
    if (lat == null || lng == null) return false;

    // Basic coordinate validation
    return lat >= -90 && lat <= 90 && lng >= -180 && lng <= 180;
  }

  /// Validate Mexican state
  static bool isValidMexicanState(String state) {
    const mexicanStates = [
      'Aguascalientes',
      'Baja California',
      'Baja California Sur',
      'Campeche',
      'Chiapas',
      'Chihuahua',
      'Ciudad de México',
      'Coahuila',
      'Colima',
      'Durango',
      'Estado de México',
      'Guanajuato',
      'Guerrero',
      'Hidalgo',
      'Jalisco',
      'Michoacán',
      'Morelos',
      'Nayarit',
      'Nuevo León',
      'Oaxaca',
      'Puebla',
      'Querétaro',
      'Quintana Roo',
      'San Luis Potosí',
      'Sinaloa',
      'Sonora',
      'Tabasco',
      'Tamaulipas',
      'Tlaxcala',
      'Veracruz',
      'Yucatán',
      'Zacatecas'
    ];

    return mexicanStates.contains(state);
  }
}

// Common Mexican states for dropdowns
class MexicanStates {
  static const List<String> states = [
    'Aguascalientes',
    'Baja California',
    'Baja California Sur',
    'Campeche',
    'Chiapas',
    'Chihuahua',
    'Ciudad de México',
    'Coahuila',
    'Colima',
    'Durango',
    'Estado de México',
    'Guanajuato',
    'Guerrero',
    'Hidalgo',
    'Jalisco',
    'Michoacán',
    'Morelos',
    'Nayarit',
    'Nuevo León',
    'Oaxaca',
    'Puebla',
    'Querétaro',
    'Quintana Roo',
    'San Luis Potosí',
    'Sinaloa',
    'Sonora',
    'Tabasco',
    'Tamaulipas',
    'Tlaxcala',
    'Veracruz',
    'Yucatán',
    'Zacatecas',
  ];

  static List<DropdownMenuItem<String>> get dropdownItems => states
      .map((state) => DropdownMenuItem(
            value: state,
            child: Text(state),
          ))
      .toList();
}

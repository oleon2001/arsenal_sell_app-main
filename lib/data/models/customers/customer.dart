import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
class Customer with _$Customer {
  const factory Customer({
    required String id,
    @JsonKey(name: 'company_id') required String companyId,
    String? code,
    required String name,
    String? email,
    String? phone,
    String? address,
    // Mantener compatibilidad con latitude/longitude
    double? latitude,
    double? longitude,
    // Agregar soporte para PostGIS location
    @JsonKey(name: 'location') String? location,
    @JsonKey(name: 'geo_accuracy_m') double? geoAccuracyM,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}

// Extension para compatibilidad con coordenadas
extension CustomerX on Customer {
  /// Verificar si tiene coordenadas (compatibilidad con ambos sistemas)
  bool get hasCoordinates =>
      (latitude != null && longitude != null) ||
      (location != null && location!.isNotEmpty);

  /// Obtener coordenadas como string formateado
  String get formattedCoordinates {
    if (latitude != null && longitude != null) {
      return '${latitude!.toStringAsFixed(6)}, ${longitude!.toStringAsFixed(6)}';
    }
    if (location != null && location!.isNotEmpty) {
      return _parsePostGisPoint(location!);
    }
    return 'Sin coordenadas';
  }

  /// Obtener latitud (prioridad: latitude directo, luego parsear location)
  double? get effectiveLatitude {
    if (latitude != null) return latitude;
    if (location != null && location!.isNotEmpty) {
      return _parseLatitude(location!);
    }
    return null;
  }

  /// Obtener longitud (prioridad: longitude directo, luego parsear location)
  double? get effectiveLongitude {
    if (longitude != null) return longitude;
    if (location != null && location!.isNotEmpty) {
      return _parseLongitude(location!);
    }
    return null;
  }

  /// Crear PostGIS Point desde coordenadas
  static String createPostGisPoint(double latitude, double longitude) {
    return 'POINT($longitude $latitude)'; // PostGIS usa (longitud latitud)
  }

  /// Parsear PostGIS Point a coordenadas
  static String _parsePostGisPoint(String postGisPoint) {
    try {
      // Formato: POINT(longitude latitude)
      final match =
          RegExp(r'POINT\(([-\d.]+) ([-\d.]+)\)').firstMatch(postGisPoint);
      if (match != null) {
        final longitude = double.parse(match.group(1)!);
        final latitude = double.parse(match.group(2)!);
        return '${latitude.toStringAsFixed(6)}, ${longitude.toStringAsFixed(6)}';
      }
      return 'Formato inválido';
    } catch (e) {
      return 'Error al parsear coordenadas';
    }
  }

  /// Parsear latitud desde PostGIS Point
  static double? _parseLatitude(String postGisPoint) {
    try {
      final match =
          RegExp(r'POINT\([-\d.]+ ([-\d.]+)\)').firstMatch(postGisPoint);
      return match != null ? double.parse(match.group(1)!) : null;
    } catch (e) {
      return null;
    }
  }

  /// Parsear longitud desde PostGIS Point
  static double? _parseLongitude(String postGisPoint) {
    try {
      final match =
          RegExp(r'POINT\(([-\d.]+) [-\d.]+\)').firstMatch(postGisPoint);
      return match != null ? double.parse(match.group(1)!) : null;
    } catch (e) {
      return null;
    }
  }
}

@freezed
class Address with _$Address {
  const factory Address({
    required String street,
    required String city,
    required String state,
    required String zipCode,
    String? country,
    double? latitude,
    double? longitude,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

import '../../data/models/customers/customer.dart';

/// Servicio para mapear entre el modelo Flutter y la estructura real de la BD
class CustomerMapper {
  /// Convierte un Customer de Flutter a formato compatible con Supabase
  static Map<String, dynamic> toSupabaseFormat(Customer customer) {
    // ✅ LOGGING DETALLADO
    print('=== CUSTOMER MAPPER TO SUPABASE ===');
    print('Customer: ${customer.name}');
    print('Latitude: ${customer.latitude}');
    print('Longitude: ${customer.longitude}');
    print(
        'Has coordinates: ${customer.latitude != null && customer.longitude != null}');
    print('===================================');

    final Map<String, dynamic> supabaseData = {
      'id': customer.id,
      'company_id': customer.companyId,
      'code': customer.code,
      'name': customer.name,
      'email': customer.email,
      'phone': customer.phone,
      'address': customer.address,
      'geo_accuracy_m': customer.geoAccuracyM,
      'created_by': customer.createdBy,
      'created_at': customer.createdAt?.toIso8601String(),
      'updated_at': customer.updatedAt?.toIso8601String(),
    };

    // ✅ ENVIAR COORDENADAS EN AMBOS FORMATOS PARA COMPATIBILIDAD
    if (customer.latitude != null && customer.longitude != null) {
      // Formato PostGIS para consultas geoespaciales
      supabaseData['location'] =
          'POINT(${customer.longitude} ${customer.latitude})';

      // Formato directo para compatibilidad y debugging
      supabaseData['latitude'] = customer.latitude;
      supabaseData['longitude'] = customer.longitude;

      print('✅ Coordinates added to Supabase data:');
      print('  - location: ${supabaseData['location']}');
      print('  - latitude: ${supabaseData['latitude']}');
      print('  - longitude: ${supabaseData['longitude']}');
    } else {
      print('❌ No coordinates to send');
    }

    return supabaseData;
  }

  /// Convierte datos de Supabase a Customer de Flutter
  static Customer fromSupabaseFormat(Map<String, dynamic> supabaseData) {
    double? latitude;
    double? longitude;

    // ✅ PRIORIDAD 1: Usar coordenadas directas si están disponibles
    if (supabaseData['latitude'] != null && supabaseData['longitude'] != null) {
      try {
        latitude = supabaseData['latitude']?.toDouble();
        longitude = supabaseData['longitude']?.toDouble();
      } catch (e) {
        print('Error converting latitude/longitude to double: $e');
      }
    }

    // ✅ PRIORIDAD 2: Parsear desde PostGIS si no hay coordenadas directas
    if ((latitude == null || longitude == null) &&
        supabaseData['location'] != null) {
      final locationData = supabaseData['location'];

      if (locationData is String) {
        // Formato string: POINT(longitude latitude)
        if (locationData.startsWith('POINT(')) {
          try {
            final match = RegExp(r'POINT\(([-\d.]+) ([-\d.]+)\)')
                .firstMatch(locationData);
            if (match != null) {
              longitude = double.parse(match.group(1)!);
              latitude = double.parse(match.group(2)!);
            }
          } catch (e) {
            print('Error parsing PostGIS string coordinates: $e');
          }
        }
      } else if (locationData is Map<String, dynamic>) {
        // Formato JSON: {"type": "Point", "coordinates": [lng, lat]}
        try {
          final coordinates = locationData['coordinates'] as List<dynamic>?;
          if (coordinates != null && coordinates.length >= 2) {
            longitude = coordinates[0]?.toDouble();
            latitude = coordinates[1]?.toDouble();
          }
        } catch (e) {
          print('Error parsing PostGIS JSON coordinates: $e');
        }
      }
    }

    return Customer(
      id: supabaseData['id'],
      companyId: supabaseData['company_id'],
      code: supabaseData['code'],
      name: supabaseData['name'],
      email: supabaseData['email'],
      phone: supabaseData['phone'],
      address: supabaseData['address'],
      latitude: latitude,
      longitude: longitude,
      location: supabaseData['location'], // Mantener el campo original también
      geoAccuracyM: supabaseData['geo_accuracy_m']?.toDouble(),
      createdBy: supabaseData['created_by'],
      createdAt: supabaseData['created_at'] != null
          ? DateTime.parse(supabaseData['created_at'])
          : null,
      updatedAt: supabaseData['updated_at'] != null
          ? DateTime.parse(supabaseData['updated_at'])
          : null,
    );
  }

  /// Crea un Customer con coordenadas PostGIS
  static Customer createWithPostGisLocation({
    required String id,
    required String companyId,
    required String name,
    String? code,
    String? email,
    String? phone,
    String? address,
    double? latitude,
    double? longitude,
    double? geoAccuracyM,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    String? postGisLocation;
    if (latitude != null && longitude != null) {
      postGisLocation = 'POINT($longitude $latitude)';
    }

    return Customer(
      id: id,
      companyId: companyId,
      code: code,
      name: name,
      email: email,
      phone: phone,
      address: address,
      latitude: latitude,
      longitude: longitude,
      location: postGisLocation,
      geoAccuracyM: geoAccuracyM,
      createdBy: createdBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

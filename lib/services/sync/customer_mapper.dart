import '../../data/models/customers/customer.dart';

/// Servicio para mapear entre el modelo Flutter y la estructura real de la BD
class CustomerMapper {
  /// Convierte un Customer de Flutter a formato compatible con Supabase
  static Map<String, dynamic> toSupabaseFormat(Customer customer) {
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

    // Convertir coordenadas a formato PostGIS si están disponibles
    if (customer.latitude != null && customer.longitude != null) {
      supabaseData['location'] =
          'POINT(${customer.longitude} ${customer.latitude})';
    }

    return supabaseData;
  }

  /// Convierte datos de Supabase a Customer de Flutter
  static Customer fromSupabaseFormat(Map<String, dynamic> supabaseData) {
    // Extraer coordenadas de PostGIS location si existe
    double? latitude;
    double? longitude;

    if (supabaseData['location'] != null) {
      final locationStr = supabaseData['location'] as String;
      if (locationStr.startsWith('POINT(')) {
        try {
          // Formato: POINT(longitude latitude)
          final match =
              RegExp(r'POINT\(([-\d.]+) ([-\d.]+)\)').firstMatch(locationStr);
          if (match != null) {
            longitude = double.parse(match.group(1)!);
            latitude = double.parse(match.group(2)!);
          }
        } catch (e) {
          // Si falla el parsing, mantener como null
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

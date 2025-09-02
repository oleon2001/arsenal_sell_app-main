import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
class Customer with _$Customer {
  const factory Customer({
    required String id,
    required String companyId,
    String? code,
    required String name,
    String? email,
    String? phone,
    String? address,
    double? latitude,
    double? longitude,
    double? geoAccuracyM,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
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

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Address _$AddressFromJson(Map<String, dynamic> json) {
  return _Address.fromJson(json);
}

/// @nodoc
mixin _$Address {
  String get street => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  String get zipCode => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  String? get neighborhood => throw _privateConstructorUsedError;
  String? get references => throw _privateConstructorUsedError;
  bool get isMainAddress => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddressCopyWith<Address> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressCopyWith<$Res> {
  factory $AddressCopyWith(Address value, $Res Function(Address) then) =
      _$AddressCopyWithImpl<$Res, Address>;
  @useResult
  $Res call(
      {String street,
      String city,
      String state,
      String zipCode,
      String country,
      double? latitude,
      double? longitude,
      String? neighborhood,
      String? references,
      bool isMainAddress,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$AddressCopyWithImpl<$Res, $Val extends Address>
    implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? street = null,
    Object? city = null,
    Object? state = null,
    Object? zipCode = null,
    Object? country = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? neighborhood = freezed,
    Object? references = freezed,
    Object? isMainAddress = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      street: null == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      zipCode: null == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      neighborhood: freezed == neighborhood
          ? _value.neighborhood
          : neighborhood // ignore: cast_nullable_to_non_nullable
              as String?,
      references: freezed == references
          ? _value.references
          : references // ignore: cast_nullable_to_non_nullable
              as String?,
      isMainAddress: null == isMainAddress
          ? _value.isMainAddress
          : isMainAddress // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddressImplCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$$AddressImplCopyWith(
          _$AddressImpl value, $Res Function(_$AddressImpl) then) =
      __$$AddressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String street,
      String city,
      String state,
      String zipCode,
      String country,
      double? latitude,
      double? longitude,
      String? neighborhood,
      String? references,
      bool isMainAddress,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$AddressImplCopyWithImpl<$Res>
    extends _$AddressCopyWithImpl<$Res, _$AddressImpl>
    implements _$$AddressImplCopyWith<$Res> {
  __$$AddressImplCopyWithImpl(
      _$AddressImpl _value, $Res Function(_$AddressImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? street = null,
    Object? city = null,
    Object? state = null,
    Object? zipCode = null,
    Object? country = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? neighborhood = freezed,
    Object? references = freezed,
    Object? isMainAddress = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$AddressImpl(
      street: null == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      zipCode: null == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      neighborhood: freezed == neighborhood
          ? _value.neighborhood
          : neighborhood // ignore: cast_nullable_to_non_nullable
              as String?,
      references: freezed == references
          ? _value.references
          : references // ignore: cast_nullable_to_non_nullable
              as String?,
      isMainAddress: null == isMainAddress
          ? _value.isMainAddress
          : isMainAddress // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressImpl implements _Address {
  const _$AddressImpl(
      {required this.street,
      required this.city,
      required this.state,
      required this.zipCode,
      this.country = 'México',
      this.latitude,
      this.longitude,
      this.neighborhood,
      this.references,
      this.isMainAddress = false,
      this.createdAt,
      this.updatedAt});

  factory _$AddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressImplFromJson(json);

  @override
  final String street;
  @override
  final String city;
  @override
  final String state;
  @override
  final String zipCode;
  @override
  @JsonKey()
  final String country;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final String? neighborhood;
  @override
  final String? references;
  @override
  @JsonKey()
  final bool isMainAddress;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Address(street: $street, city: $city, state: $state, zipCode: $zipCode, country: $country, latitude: $latitude, longitude: $longitude, neighborhood: $neighborhood, references: $references, isMainAddress: $isMainAddress, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressImpl &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.zipCode, zipCode) || other.zipCode == zipCode) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.neighborhood, neighborhood) ||
                other.neighborhood == neighborhood) &&
            (identical(other.references, references) ||
                other.references == references) &&
            (identical(other.isMainAddress, isMainAddress) ||
                other.isMainAddress == isMainAddress) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      street,
      city,
      state,
      zipCode,
      country,
      latitude,
      longitude,
      neighborhood,
      references,
      isMainAddress,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      __$$AddressImplCopyWithImpl<_$AddressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressImplToJson(
      this,
    );
  }
}

abstract class _Address implements Address {
  const factory _Address(
      {required final String street,
      required final String city,
      required final String state,
      required final String zipCode,
      final String country,
      final double? latitude,
      final double? longitude,
      final String? neighborhood,
      final String? references,
      final bool isMainAddress,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$AddressImpl;

  factory _Address.fromJson(Map<String, dynamic> json) = _$AddressImpl.fromJson;

  @override
  String get street;
  @override
  String get city;
  @override
  String get state;
  @override
  String get zipCode;
  @override
  String get country;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  String? get neighborhood;
  @override
  String? get references;
  @override
  bool get isMainAddress;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_sample.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LocationSample _$LocationSampleFromJson(Map<String, dynamic> json) {
  return _LocationSample.fromJson(json);
}

/// @nodoc
mixin _$LocationSample {
  int get id => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  DateTime get at => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  double? get speedMs => throw _privateConstructorUsedError;
  double? get accuracyM => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationSampleCopyWith<LocationSample> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationSampleCopyWith<$Res> {
  factory $LocationSampleCopyWith(
          LocationSample value, $Res Function(LocationSample) then) =
      _$LocationSampleCopyWithImpl<$Res, LocationSample>;
  @useResult
  $Res call(
      {int id,
      String companyId,
      String userId,
      DateTime at,
      double latitude,
      double longitude,
      double? speedMs,
      double? accuracyM});
}

/// @nodoc
class _$LocationSampleCopyWithImpl<$Res, $Val extends LocationSample>
    implements $LocationSampleCopyWith<$Res> {
  _$LocationSampleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? userId = null,
    Object? at = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? speedMs = freezed,
    Object? accuracyM = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      companyId: null == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      at: null == at
          ? _value.at
          : at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      speedMs: freezed == speedMs
          ? _value.speedMs
          : speedMs // ignore: cast_nullable_to_non_nullable
              as double?,
      accuracyM: freezed == accuracyM
          ? _value.accuracyM
          : accuracyM // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocationSampleImplCopyWith<$Res>
    implements $LocationSampleCopyWith<$Res> {
  factory _$$LocationSampleImplCopyWith(_$LocationSampleImpl value,
          $Res Function(_$LocationSampleImpl) then) =
      __$$LocationSampleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String companyId,
      String userId,
      DateTime at,
      double latitude,
      double longitude,
      double? speedMs,
      double? accuracyM});
}

/// @nodoc
class __$$LocationSampleImplCopyWithImpl<$Res>
    extends _$LocationSampleCopyWithImpl<$Res, _$LocationSampleImpl>
    implements _$$LocationSampleImplCopyWith<$Res> {
  __$$LocationSampleImplCopyWithImpl(
      _$LocationSampleImpl _value, $Res Function(_$LocationSampleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? userId = null,
    Object? at = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? speedMs = freezed,
    Object? accuracyM = freezed,
  }) {
    return _then(_$LocationSampleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      companyId: null == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      at: null == at
          ? _value.at
          : at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      speedMs: freezed == speedMs
          ? _value.speedMs
          : speedMs // ignore: cast_nullable_to_non_nullable
              as double?,
      accuracyM: freezed == accuracyM
          ? _value.accuracyM
          : accuracyM // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationSampleImpl implements _LocationSample {
  const _$LocationSampleImpl(
      {required this.id,
      required this.companyId,
      required this.userId,
      required this.at,
      required this.latitude,
      required this.longitude,
      this.speedMs,
      this.accuracyM});

  factory _$LocationSampleImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationSampleImplFromJson(json);

  @override
  final int id;
  @override
  final String companyId;
  @override
  final String userId;
  @override
  final DateTime at;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final double? speedMs;
  @override
  final double? accuracyM;

  @override
  String toString() {
    return 'LocationSample(id: $id, companyId: $companyId, userId: $userId, at: $at, latitude: $latitude, longitude: $longitude, speedMs: $speedMs, accuracyM: $accuracyM)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationSampleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.at, at) || other.at == at) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.speedMs, speedMs) || other.speedMs == speedMs) &&
            (identical(other.accuracyM, accuracyM) ||
                other.accuracyM == accuracyM));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, companyId, userId, at,
      latitude, longitude, speedMs, accuracyM);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationSampleImplCopyWith<_$LocationSampleImpl> get copyWith =>
      __$$LocationSampleImplCopyWithImpl<_$LocationSampleImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationSampleImplToJson(
      this,
    );
  }
}

abstract class _LocationSample implements LocationSample {
  const factory _LocationSample(
      {required final int id,
      required final String companyId,
      required final String userId,
      required final DateTime at,
      required final double latitude,
      required final double longitude,
      final double? speedMs,
      final double? accuracyM}) = _$LocationSampleImpl;

  factory _LocationSample.fromJson(Map<String, dynamic> json) =
      _$LocationSampleImpl.fromJson;

  @override
  int get id;
  @override
  String get companyId;
  @override
  String get userId;
  @override
  DateTime get at;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  double? get speedMs;
  @override
  double? get accuracyM;
  @override
  @JsonKey(ignore: true)
  _$$LocationSampleImplCopyWith<_$LocationSampleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

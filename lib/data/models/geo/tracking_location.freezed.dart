// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tracking_location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TrackingLocation _$TrackingLocationFromJson(Map<String, dynamic> json) {
  return _TrackingLocation.fromJson(json);
}

/// @nodoc
mixin _$TrackingLocation {
  int get id => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  DateTime get at => throw _privateConstructorUsedError;
  Map<String, dynamic> get point =>
      throw _privateConstructorUsedError; // geography(Point,4326)
  double? get speedMS => throw _privateConstructorUsedError;
  double? get accuracyM => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrackingLocationCopyWith<TrackingLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackingLocationCopyWith<$Res> {
  factory $TrackingLocationCopyWith(
          TrackingLocation value, $Res Function(TrackingLocation) then) =
      _$TrackingLocationCopyWithImpl<$Res, TrackingLocation>;
  @useResult
  $Res call(
      {int id,
      String companyId,
      String userId,
      DateTime at,
      Map<String, dynamic> point,
      double? speedMS,
      double? accuracyM});
}

/// @nodoc
class _$TrackingLocationCopyWithImpl<$Res, $Val extends TrackingLocation>
    implements $TrackingLocationCopyWith<$Res> {
  _$TrackingLocationCopyWithImpl(this._value, this._then);

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
    Object? point = null,
    Object? speedMS = freezed,
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
      point: null == point
          ? _value.point
          : point // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      speedMS: freezed == speedMS
          ? _value.speedMS
          : speedMS // ignore: cast_nullable_to_non_nullable
              as double?,
      accuracyM: freezed == accuracyM
          ? _value.accuracyM
          : accuracyM // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrackingLocationImplCopyWith<$Res>
    implements $TrackingLocationCopyWith<$Res> {
  factory _$$TrackingLocationImplCopyWith(_$TrackingLocationImpl value,
          $Res Function(_$TrackingLocationImpl) then) =
      __$$TrackingLocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String companyId,
      String userId,
      DateTime at,
      Map<String, dynamic> point,
      double? speedMS,
      double? accuracyM});
}

/// @nodoc
class __$$TrackingLocationImplCopyWithImpl<$Res>
    extends _$TrackingLocationCopyWithImpl<$Res, _$TrackingLocationImpl>
    implements _$$TrackingLocationImplCopyWith<$Res> {
  __$$TrackingLocationImplCopyWithImpl(_$TrackingLocationImpl _value,
      $Res Function(_$TrackingLocationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? userId = null,
    Object? at = null,
    Object? point = null,
    Object? speedMS = freezed,
    Object? accuracyM = freezed,
  }) {
    return _then(_$TrackingLocationImpl(
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
      point: null == point
          ? _value._point
          : point // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      speedMS: freezed == speedMS
          ? _value.speedMS
          : speedMS // ignore: cast_nullable_to_non_nullable
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
class _$TrackingLocationImpl implements _TrackingLocation {
  const _$TrackingLocationImpl(
      {required this.id,
      required this.companyId,
      required this.userId,
      required this.at,
      required final Map<String, dynamic> point,
      this.speedMS,
      this.accuracyM})
      : _point = point;

  factory _$TrackingLocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrackingLocationImplFromJson(json);

  @override
  final int id;
  @override
  final String companyId;
  @override
  final String userId;
  @override
  final DateTime at;
  final Map<String, dynamic> _point;
  @override
  Map<String, dynamic> get point {
    if (_point is EqualUnmodifiableMapView) return _point;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_point);
  }

// geography(Point,4326)
  @override
  final double? speedMS;
  @override
  final double? accuracyM;

  @override
  String toString() {
    return 'TrackingLocation(id: $id, companyId: $companyId, userId: $userId, at: $at, point: $point, speedMS: $speedMS, accuracyM: $accuracyM)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrackingLocationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.at, at) || other.at == at) &&
            const DeepCollectionEquality().equals(other._point, _point) &&
            (identical(other.speedMS, speedMS) || other.speedMS == speedMS) &&
            (identical(other.accuracyM, accuracyM) ||
                other.accuracyM == accuracyM));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, companyId, userId, at,
      const DeepCollectionEquality().hash(_point), speedMS, accuracyM);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrackingLocationImplCopyWith<_$TrackingLocationImpl> get copyWith =>
      __$$TrackingLocationImplCopyWithImpl<_$TrackingLocationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrackingLocationImplToJson(
      this,
    );
  }
}

abstract class _TrackingLocation implements TrackingLocation {
  const factory _TrackingLocation(
      {required final int id,
      required final String companyId,
      required final String userId,
      required final DateTime at,
      required final Map<String, dynamic> point,
      final double? speedMS,
      final double? accuracyM}) = _$TrackingLocationImpl;

  factory _TrackingLocation.fromJson(Map<String, dynamic> json) =
      _$TrackingLocationImpl.fromJson;

  @override
  int get id;
  @override
  String get companyId;
  @override
  String get userId;
  @override
  DateTime get at;
  @override
  Map<String, dynamic> get point;
  @override // geography(Point,4326)
  double? get speedMS;
  @override
  double? get accuracyM;
  @override
  @JsonKey(ignore: true)
  _$$TrackingLocationImplCopyWith<_$TrackingLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

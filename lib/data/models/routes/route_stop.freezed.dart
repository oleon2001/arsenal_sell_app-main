// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_stop.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RouteStop _$RouteStopFromJson(Map<String, dynamic> json) {
  return _RouteStop.fromJson(json);
}

/// @nodoc
mixin _$RouteStop {
  String get id => throw _privateConstructorUsedError;
  String get routeId => throw _privateConstructorUsedError;
  String get customerId => throw _privateConstructorUsedError;
  DateTime? get plannedTime => throw _privateConstructorUsedError;
  DateTime? get actualArrivalTime => throw _privateConstructorUsedError;
  DateTime? get actualDepartureTime => throw _privateConstructorUsedError;
  int? get sequence => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  RouteStopStatus get status => throw _privateConstructorUsedError;
  double get distanceFromPrevious =>
      throw _privateConstructorUsedError; // meters
  int get estimatedDuration => throw _privateConstructorUsedError; // minutes
  Customer? get customer => throw _privateConstructorUsedError;
  Visit? get visit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RouteStopCopyWith<RouteStop> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteStopCopyWith<$Res> {
  factory $RouteStopCopyWith(RouteStop value, $Res Function(RouteStop) then) =
      _$RouteStopCopyWithImpl<$Res, RouteStop>;
  @useResult
  $Res call(
      {String id,
      String routeId,
      String customerId,
      DateTime? plannedTime,
      DateTime? actualArrivalTime,
      DateTime? actualDepartureTime,
      int? sequence,
      String? notes,
      RouteStopStatus status,
      double distanceFromPrevious,
      int estimatedDuration,
      Customer? customer,
      Visit? visit});

  $CustomerCopyWith<$Res>? get customer;
}

/// @nodoc
class _$RouteStopCopyWithImpl<$Res, $Val extends RouteStop>
    implements $RouteStopCopyWith<$Res> {
  _$RouteStopCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? routeId = null,
    Object? customerId = null,
    Object? plannedTime = freezed,
    Object? actualArrivalTime = freezed,
    Object? actualDepartureTime = freezed,
    Object? sequence = freezed,
    Object? notes = freezed,
    Object? status = null,
    Object? distanceFromPrevious = null,
    Object? estimatedDuration = null,
    Object? customer = freezed,
    Object? visit = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      routeId: null == routeId
          ? _value.routeId
          : routeId // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      plannedTime: freezed == plannedTime
          ? _value.plannedTime
          : plannedTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualArrivalTime: freezed == actualArrivalTime
          ? _value.actualArrivalTime
          : actualArrivalTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualDepartureTime: freezed == actualDepartureTime
          ? _value.actualDepartureTime
          : actualDepartureTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sequence: freezed == sequence
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RouteStopStatus,
      distanceFromPrevious: null == distanceFromPrevious
          ? _value.distanceFromPrevious
          : distanceFromPrevious // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedDuration: null == estimatedDuration
          ? _value.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as int,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as Customer?,
      visit: freezed == visit
          ? _value.visit
          : visit // ignore: cast_nullable_to_non_nullable
              as Visit?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CustomerCopyWith<$Res>? get customer {
    if (_value.customer == null) {
      return null;
    }

    return $CustomerCopyWith<$Res>(_value.customer!, (value) {
      return _then(_value.copyWith(customer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RouteStopImplCopyWith<$Res>
    implements $RouteStopCopyWith<$Res> {
  factory _$$RouteStopImplCopyWith(
          _$RouteStopImpl value, $Res Function(_$RouteStopImpl) then) =
      __$$RouteStopImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String routeId,
      String customerId,
      DateTime? plannedTime,
      DateTime? actualArrivalTime,
      DateTime? actualDepartureTime,
      int? sequence,
      String? notes,
      RouteStopStatus status,
      double distanceFromPrevious,
      int estimatedDuration,
      Customer? customer,
      Visit? visit});

  @override
  $CustomerCopyWith<$Res>? get customer;
}

/// @nodoc
class __$$RouteStopImplCopyWithImpl<$Res>
    extends _$RouteStopCopyWithImpl<$Res, _$RouteStopImpl>
    implements _$$RouteStopImplCopyWith<$Res> {
  __$$RouteStopImplCopyWithImpl(
      _$RouteStopImpl _value, $Res Function(_$RouteStopImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? routeId = null,
    Object? customerId = null,
    Object? plannedTime = freezed,
    Object? actualArrivalTime = freezed,
    Object? actualDepartureTime = freezed,
    Object? sequence = freezed,
    Object? notes = freezed,
    Object? status = null,
    Object? distanceFromPrevious = null,
    Object? estimatedDuration = null,
    Object? customer = freezed,
    Object? visit = freezed,
  }) {
    return _then(_$RouteStopImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      routeId: null == routeId
          ? _value.routeId
          : routeId // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      plannedTime: freezed == plannedTime
          ? _value.plannedTime
          : plannedTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualArrivalTime: freezed == actualArrivalTime
          ? _value.actualArrivalTime
          : actualArrivalTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualDepartureTime: freezed == actualDepartureTime
          ? _value.actualDepartureTime
          : actualDepartureTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sequence: freezed == sequence
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RouteStopStatus,
      distanceFromPrevious: null == distanceFromPrevious
          ? _value.distanceFromPrevious
          : distanceFromPrevious // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedDuration: null == estimatedDuration
          ? _value.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as int,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as Customer?,
      visit: freezed == visit
          ? _value.visit
          : visit // ignore: cast_nullable_to_non_nullable
              as Visit?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteStopImpl implements _RouteStop {
  const _$RouteStopImpl(
      {required this.id,
      required this.routeId,
      required this.customerId,
      this.plannedTime,
      this.actualArrivalTime,
      this.actualDepartureTime,
      this.sequence,
      this.notes,
      this.status = RouteStopStatus.pending,
      this.distanceFromPrevious = 0.0,
      this.estimatedDuration = 0,
      this.customer,
      this.visit});

  factory _$RouteStopImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteStopImplFromJson(json);

  @override
  final String id;
  @override
  final String routeId;
  @override
  final String customerId;
  @override
  final DateTime? plannedTime;
  @override
  final DateTime? actualArrivalTime;
  @override
  final DateTime? actualDepartureTime;
  @override
  final int? sequence;
  @override
  final String? notes;
  @override
  @JsonKey()
  final RouteStopStatus status;
  @override
  @JsonKey()
  final double distanceFromPrevious;
// meters
  @override
  @JsonKey()
  final int estimatedDuration;
// minutes
  @override
  final Customer? customer;
  @override
  final Visit? visit;

  @override
  String toString() {
    return 'RouteStop(id: $id, routeId: $routeId, customerId: $customerId, plannedTime: $plannedTime, actualArrivalTime: $actualArrivalTime, actualDepartureTime: $actualDepartureTime, sequence: $sequence, notes: $notes, status: $status, distanceFromPrevious: $distanceFromPrevious, estimatedDuration: $estimatedDuration, customer: $customer, visit: $visit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteStopImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.routeId, routeId) || other.routeId == routeId) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.plannedTime, plannedTime) ||
                other.plannedTime == plannedTime) &&
            (identical(other.actualArrivalTime, actualArrivalTime) ||
                other.actualArrivalTime == actualArrivalTime) &&
            (identical(other.actualDepartureTime, actualDepartureTime) ||
                other.actualDepartureTime == actualDepartureTime) &&
            (identical(other.sequence, sequence) ||
                other.sequence == sequence) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.distanceFromPrevious, distanceFromPrevious) ||
                other.distanceFromPrevious == distanceFromPrevious) &&
            (identical(other.estimatedDuration, estimatedDuration) ||
                other.estimatedDuration == estimatedDuration) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            (identical(other.visit, visit) || other.visit == visit));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      routeId,
      customerId,
      plannedTime,
      actualArrivalTime,
      actualDepartureTime,
      sequence,
      notes,
      status,
      distanceFromPrevious,
      estimatedDuration,
      customer,
      visit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteStopImplCopyWith<_$RouteStopImpl> get copyWith =>
      __$$RouteStopImplCopyWithImpl<_$RouteStopImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteStopImplToJson(
      this,
    );
  }
}

abstract class _RouteStop implements RouteStop {
  const factory _RouteStop(
      {required final String id,
      required final String routeId,
      required final String customerId,
      final DateTime? plannedTime,
      final DateTime? actualArrivalTime,
      final DateTime? actualDepartureTime,
      final int? sequence,
      final String? notes,
      final RouteStopStatus status,
      final double distanceFromPrevious,
      final int estimatedDuration,
      final Customer? customer,
      final Visit? visit}) = _$RouteStopImpl;

  factory _RouteStop.fromJson(Map<String, dynamic> json) =
      _$RouteStopImpl.fromJson;

  @override
  String get id;
  @override
  String get routeId;
  @override
  String get customerId;
  @override
  DateTime? get plannedTime;
  @override
  DateTime? get actualArrivalTime;
  @override
  DateTime? get actualDepartureTime;
  @override
  int? get sequence;
  @override
  String? get notes;
  @override
  RouteStopStatus get status;
  @override
  double get distanceFromPrevious;
  @override // meters
  int get estimatedDuration;
  @override // minutes
  Customer? get customer;
  @override
  Visit? get visit;
  @override
  @JsonKey(ignore: true)
  _$$RouteStopImplCopyWith<_$RouteStopImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

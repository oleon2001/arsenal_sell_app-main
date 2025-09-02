// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RoutePlan _$RoutePlanFromJson(Map<String, dynamic> json) {
  return _RoutePlan.fromJson(json);
}

/// @nodoc
mixin _$RoutePlan {
  String get id => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String? get ownerId => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  List<RouteStop> get stops => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoutePlanCopyWith<RoutePlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoutePlanCopyWith<$Res> {
  factory $RoutePlanCopyWith(RoutePlan value, $Res Function(RoutePlan) then) =
      _$RoutePlanCopyWithImpl<$Res, RoutePlan>;
  @useResult
  $Res call(
      {String id,
      String companyId,
      String name,
      DateTime date,
      String? ownerId,
      DateTime? createdAt,
      List<RouteStop> stops});
}

/// @nodoc
class _$RoutePlanCopyWithImpl<$Res, $Val extends RoutePlan>
    implements $RoutePlanCopyWith<$Res> {
  _$RoutePlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? name = null,
    Object? date = null,
    Object? ownerId = freezed,
    Object? createdAt = freezed,
    Object? stops = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      companyId: null == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ownerId: freezed == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      stops: null == stops
          ? _value.stops
          : stops // ignore: cast_nullable_to_non_nullable
              as List<RouteStop>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoutePlanImplCopyWith<$Res>
    implements $RoutePlanCopyWith<$Res> {
  factory _$$RoutePlanImplCopyWith(
          _$RoutePlanImpl value, $Res Function(_$RoutePlanImpl) then) =
      __$$RoutePlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String companyId,
      String name,
      DateTime date,
      String? ownerId,
      DateTime? createdAt,
      List<RouteStop> stops});
}

/// @nodoc
class __$$RoutePlanImplCopyWithImpl<$Res>
    extends _$RoutePlanCopyWithImpl<$Res, _$RoutePlanImpl>
    implements _$$RoutePlanImplCopyWith<$Res> {
  __$$RoutePlanImplCopyWithImpl(
      _$RoutePlanImpl _value, $Res Function(_$RoutePlanImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? name = null,
    Object? date = null,
    Object? ownerId = freezed,
    Object? createdAt = freezed,
    Object? stops = null,
  }) {
    return _then(_$RoutePlanImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      companyId: null == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ownerId: freezed == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      stops: null == stops
          ? _value._stops
          : stops // ignore: cast_nullable_to_non_nullable
              as List<RouteStop>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoutePlanImpl implements _RoutePlan {
  const _$RoutePlanImpl(
      {required this.id,
      required this.companyId,
      required this.name,
      required this.date,
      this.ownerId,
      this.createdAt,
      final List<RouteStop> stops = const []})
      : _stops = stops;

  factory _$RoutePlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoutePlanImplFromJson(json);

  @override
  final String id;
  @override
  final String companyId;
  @override
  final String name;
  @override
  final DateTime date;
  @override
  final String? ownerId;
  @override
  final DateTime? createdAt;
  final List<RouteStop> _stops;
  @override
  @JsonKey()
  List<RouteStop> get stops {
    if (_stops is EqualUnmodifiableListView) return _stops;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stops);
  }

  @override
  String toString() {
    return 'RoutePlan(id: $id, companyId: $companyId, name: $name, date: $date, ownerId: $ownerId, createdAt: $createdAt, stops: $stops)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoutePlanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._stops, _stops));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, companyId, name, date,
      ownerId, createdAt, const DeepCollectionEquality().hash(_stops));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoutePlanImplCopyWith<_$RoutePlanImpl> get copyWith =>
      __$$RoutePlanImplCopyWithImpl<_$RoutePlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoutePlanImplToJson(
      this,
    );
  }
}

abstract class _RoutePlan implements RoutePlan {
  const factory _RoutePlan(
      {required final String id,
      required final String companyId,
      required final String name,
      required final DateTime date,
      final String? ownerId,
      final DateTime? createdAt,
      final List<RouteStop> stops}) = _$RoutePlanImpl;

  factory _RoutePlan.fromJson(Map<String, dynamic> json) =
      _$RoutePlanImpl.fromJson;

  @override
  String get id;
  @override
  String get companyId;
  @override
  String get name;
  @override
  DateTime get date;
  @override
  String? get ownerId;
  @override
  DateTime? get createdAt;
  @override
  List<RouteStop> get stops;
  @override
  @JsonKey(ignore: true)
  _$$RoutePlanImplCopyWith<_$RoutePlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RouteStop _$RouteStopFromJson(Map<String, dynamic> json) {
  return _RouteStop.fromJson(json);
}

/// @nodoc
mixin _$RouteStop {
  String get id => throw _privateConstructorUsedError;
  String get routeId => throw _privateConstructorUsedError;
  String get customerId => throw _privateConstructorUsedError;
  DateTime? get plannedTime => throw _privateConstructorUsedError;
  int? get sequence => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  Customer? get customer => throw _privateConstructorUsedError;

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
      int? sequence,
      String? notes,
      Customer? customer});

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
    Object? sequence = freezed,
    Object? notes = freezed,
    Object? customer = freezed,
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
      sequence: freezed == sequence
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as Customer?,
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
      int? sequence,
      String? notes,
      Customer? customer});

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
    Object? sequence = freezed,
    Object? notes = freezed,
    Object? customer = freezed,
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
      sequence: freezed == sequence
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as Customer?,
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
      this.sequence,
      this.notes,
      this.customer});

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
  final int? sequence;
  @override
  final String? notes;
  @override
  final Customer? customer;

  @override
  String toString() {
    return 'RouteStop(id: $id, routeId: $routeId, customerId: $customerId, plannedTime: $plannedTime, sequence: $sequence, notes: $notes, customer: $customer)';
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
            (identical(other.sequence, sequence) ||
                other.sequence == sequence) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.customer, customer) ||
                other.customer == customer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, routeId, customerId,
      plannedTime, sequence, notes, customer);

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
      final int? sequence,
      final String? notes,
      final Customer? customer}) = _$RouteStopImpl;

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
  int? get sequence;
  @override
  String? get notes;
  @override
  Customer? get customer;
  @override
  @JsonKey(ignore: true)
  _$$RouteStopImplCopyWith<_$RouteStopImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

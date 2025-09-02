// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kpi.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KPI _$KPIFromJson(Map<String, dynamic> json) {
  return _KPI.fromJson(json);
}

/// @nodoc
mixin _$KPI {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  KPIType get type => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  double get target => throw _privateConstructorUsedError;
  String? get unit => throw _privateConstructorUsedError;
  DateTime get period => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  String? get companyId => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  KPITrend? get trend => throw _privateConstructorUsedError;
  double? get previousValue => throw _privateConstructorUsedError;
  List<KPIDataPoint> get dataPoints => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KPICopyWith<KPI> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KPICopyWith<$Res> {
  factory $KPICopyWith(KPI value, $Res Function(KPI) then) =
      _$KPICopyWithImpl<$Res, KPI>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      KPIType type,
      double value,
      double target,
      String? unit,
      DateTime period,
      String? userId,
      String? companyId,
      DateTime? createdAt,
      KPITrend? trend,
      double? previousValue,
      List<KPIDataPoint> dataPoints});
}

/// @nodoc
class _$KPICopyWithImpl<$Res, $Val extends KPI> implements $KPICopyWith<$Res> {
  _$KPICopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? value = null,
    Object? target = null,
    Object? unit = freezed,
    Object? period = null,
    Object? userId = freezed,
    Object? companyId = freezed,
    Object? createdAt = freezed,
    Object? trend = freezed,
    Object? previousValue = freezed,
    Object? dataPoints = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as KPIType,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      target: null == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as double,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      companyId: freezed == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      trend: freezed == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as KPITrend?,
      previousValue: freezed == previousValue
          ? _value.previousValue
          : previousValue // ignore: cast_nullable_to_non_nullable
              as double?,
      dataPoints: null == dataPoints
          ? _value.dataPoints
          : dataPoints // ignore: cast_nullable_to_non_nullable
              as List<KPIDataPoint>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KPIImplCopyWith<$Res> implements $KPICopyWith<$Res> {
  factory _$$KPIImplCopyWith(_$KPIImpl value, $Res Function(_$KPIImpl) then) =
      __$$KPIImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      KPIType type,
      double value,
      double target,
      String? unit,
      DateTime period,
      String? userId,
      String? companyId,
      DateTime? createdAt,
      KPITrend? trend,
      double? previousValue,
      List<KPIDataPoint> dataPoints});
}

/// @nodoc
class __$$KPIImplCopyWithImpl<$Res> extends _$KPICopyWithImpl<$Res, _$KPIImpl>
    implements _$$KPIImplCopyWith<$Res> {
  __$$KPIImplCopyWithImpl(_$KPIImpl _value, $Res Function(_$KPIImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? value = null,
    Object? target = null,
    Object? unit = freezed,
    Object? period = null,
    Object? userId = freezed,
    Object? companyId = freezed,
    Object? createdAt = freezed,
    Object? trend = freezed,
    Object? previousValue = freezed,
    Object? dataPoints = null,
  }) {
    return _then(_$KPIImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as KPIType,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      target: null == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as double,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      companyId: freezed == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      trend: freezed == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as KPITrend?,
      previousValue: freezed == previousValue
          ? _value.previousValue
          : previousValue // ignore: cast_nullable_to_non_nullable
              as double?,
      dataPoints: null == dataPoints
          ? _value._dataPoints
          : dataPoints // ignore: cast_nullable_to_non_nullable
              as List<KPIDataPoint>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KPIImpl implements _KPI {
  const _$KPIImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.type,
      required this.value,
      required this.target,
      this.unit,
      required this.period,
      this.userId,
      this.companyId,
      this.createdAt,
      this.trend,
      this.previousValue,
      final List<KPIDataPoint> dataPoints = const []})
      : _dataPoints = dataPoints;

  factory _$KPIImpl.fromJson(Map<String, dynamic> json) =>
      _$$KPIImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final KPIType type;
  @override
  final double value;
  @override
  final double target;
  @override
  final String? unit;
  @override
  final DateTime period;
  @override
  final String? userId;
  @override
  final String? companyId;
  @override
  final DateTime? createdAt;
  @override
  final KPITrend? trend;
  @override
  final double? previousValue;
  final List<KPIDataPoint> _dataPoints;
  @override
  @JsonKey()
  List<KPIDataPoint> get dataPoints {
    if (_dataPoints is EqualUnmodifiableListView) return _dataPoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dataPoints);
  }

  @override
  String toString() {
    return 'KPI(id: $id, name: $name, description: $description, type: $type, value: $value, target: $target, unit: $unit, period: $period, userId: $userId, companyId: $companyId, createdAt: $createdAt, trend: $trend, previousValue: $previousValue, dataPoints: $dataPoints)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KPIImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.trend, trend) || other.trend == trend) &&
            (identical(other.previousValue, previousValue) ||
                other.previousValue == previousValue) &&
            const DeepCollectionEquality()
                .equals(other._dataPoints, _dataPoints));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      type,
      value,
      target,
      unit,
      period,
      userId,
      companyId,
      createdAt,
      trend,
      previousValue,
      const DeepCollectionEquality().hash(_dataPoints));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KPIImplCopyWith<_$KPIImpl> get copyWith =>
      __$$KPIImplCopyWithImpl<_$KPIImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KPIImplToJson(
      this,
    );
  }
}

abstract class _KPI implements KPI {
  const factory _KPI(
      {required final String id,
      required final String name,
      required final String description,
      required final KPIType type,
      required final double value,
      required final double target,
      final String? unit,
      required final DateTime period,
      final String? userId,
      final String? companyId,
      final DateTime? createdAt,
      final KPITrend? trend,
      final double? previousValue,
      final List<KPIDataPoint> dataPoints}) = _$KPIImpl;

  factory _KPI.fromJson(Map<String, dynamic> json) = _$KPIImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  KPIType get type;
  @override
  double get value;
  @override
  double get target;
  @override
  String? get unit;
  @override
  DateTime get period;
  @override
  String? get userId;
  @override
  String? get companyId;
  @override
  DateTime? get createdAt;
  @override
  KPITrend? get trend;
  @override
  double? get previousValue;
  @override
  List<KPIDataPoint> get dataPoints;
  @override
  @JsonKey(ignore: true)
  _$$KPIImplCopyWith<_$KPIImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

KPIDataPoint _$KPIDataPointFromJson(Map<String, dynamic> json) {
  return _KPIDataPoint.fromJson(json);
}

/// @nodoc
mixin _$KPIDataPoint {
  DateTime get date => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  String? get label => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KPIDataPointCopyWith<KPIDataPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KPIDataPointCopyWith<$Res> {
  factory $KPIDataPointCopyWith(
          KPIDataPoint value, $Res Function(KPIDataPoint) then) =
      _$KPIDataPointCopyWithImpl<$Res, KPIDataPoint>;
  @useResult
  $Res call(
      {DateTime date,
      double value,
      String? label,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$KPIDataPointCopyWithImpl<$Res, $Val extends KPIDataPoint>
    implements $KPIDataPointCopyWith<$Res> {
  _$KPIDataPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? value = null,
    Object? label = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KPIDataPointImplCopyWith<$Res>
    implements $KPIDataPointCopyWith<$Res> {
  factory _$$KPIDataPointImplCopyWith(
          _$KPIDataPointImpl value, $Res Function(_$KPIDataPointImpl) then) =
      __$$KPIDataPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime date,
      double value,
      String? label,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$KPIDataPointImplCopyWithImpl<$Res>
    extends _$KPIDataPointCopyWithImpl<$Res, _$KPIDataPointImpl>
    implements _$$KPIDataPointImplCopyWith<$Res> {
  __$$KPIDataPointImplCopyWithImpl(
      _$KPIDataPointImpl _value, $Res Function(_$KPIDataPointImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? value = null,
    Object? label = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$KPIDataPointImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KPIDataPointImpl implements _KPIDataPoint {
  const _$KPIDataPointImpl(
      {required this.date,
      required this.value,
      this.label,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$KPIDataPointImpl.fromJson(Map<String, dynamic> json) =>
      _$$KPIDataPointImplFromJson(json);

  @override
  final DateTime date;
  @override
  final double value;
  @override
  final String? label;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'KPIDataPoint(date: $date, value: $value, label: $label, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KPIDataPointImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.label, label) || other.label == label) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, date, value, label,
      const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KPIDataPointImplCopyWith<_$KPIDataPointImpl> get copyWith =>
      __$$KPIDataPointImplCopyWithImpl<_$KPIDataPointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KPIDataPointImplToJson(
      this,
    );
  }
}

abstract class _KPIDataPoint implements KPIDataPoint {
  const factory _KPIDataPoint(
      {required final DateTime date,
      required final double value,
      final String? label,
      final Map<String, dynamic>? metadata}) = _$KPIDataPointImpl;

  factory _KPIDataPoint.fromJson(Map<String, dynamic> json) =
      _$KPIDataPointImpl.fromJson;

  @override
  DateTime get date;
  @override
  double get value;
  @override
  String? get label;
  @override
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$KPIDataPointImplCopyWith<_$KPIDataPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

KPIDashboard _$KPIDashboardFromJson(Map<String, dynamic> json) {
  return _KPIDashboard.fromJson(json);
}

/// @nodoc
mixin _$KPIDashboard {
  String get userId => throw _privateConstructorUsedError;
  DateTime get period => throw _privateConstructorUsedError;
  List<KPI> get kpis => throw _privateConstructorUsedError;
  KPISummary get summary => throw _privateConstructorUsedError;
  List<KPIAlert> get alerts => throw _privateConstructorUsedError;
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KPIDashboardCopyWith<KPIDashboard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KPIDashboardCopyWith<$Res> {
  factory $KPIDashboardCopyWith(
          KPIDashboard value, $Res Function(KPIDashboard) then) =
      _$KPIDashboardCopyWithImpl<$Res, KPIDashboard>;
  @useResult
  $Res call(
      {String userId,
      DateTime period,
      List<KPI> kpis,
      KPISummary summary,
      List<KPIAlert> alerts,
      DateTime? lastUpdated});

  $KPISummaryCopyWith<$Res> get summary;
}

/// @nodoc
class _$KPIDashboardCopyWithImpl<$Res, $Val extends KPIDashboard>
    implements $KPIDashboardCopyWith<$Res> {
  _$KPIDashboardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? period = null,
    Object? kpis = null,
    Object? summary = null,
    Object? alerts = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as DateTime,
      kpis: null == kpis
          ? _value.kpis
          : kpis // ignore: cast_nullable_to_non_nullable
              as List<KPI>,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as KPISummary,
      alerts: null == alerts
          ? _value.alerts
          : alerts // ignore: cast_nullable_to_non_nullable
              as List<KPIAlert>,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $KPISummaryCopyWith<$Res> get summary {
    return $KPISummaryCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$KPIDashboardImplCopyWith<$Res>
    implements $KPIDashboardCopyWith<$Res> {
  factory _$$KPIDashboardImplCopyWith(
          _$KPIDashboardImpl value, $Res Function(_$KPIDashboardImpl) then) =
      __$$KPIDashboardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      DateTime period,
      List<KPI> kpis,
      KPISummary summary,
      List<KPIAlert> alerts,
      DateTime? lastUpdated});

  @override
  $KPISummaryCopyWith<$Res> get summary;
}

/// @nodoc
class __$$KPIDashboardImplCopyWithImpl<$Res>
    extends _$KPIDashboardCopyWithImpl<$Res, _$KPIDashboardImpl>
    implements _$$KPIDashboardImplCopyWith<$Res> {
  __$$KPIDashboardImplCopyWithImpl(
      _$KPIDashboardImpl _value, $Res Function(_$KPIDashboardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? period = null,
    Object? kpis = null,
    Object? summary = null,
    Object? alerts = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(_$KPIDashboardImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as DateTime,
      kpis: null == kpis
          ? _value._kpis
          : kpis // ignore: cast_nullable_to_non_nullable
              as List<KPI>,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as KPISummary,
      alerts: null == alerts
          ? _value._alerts
          : alerts // ignore: cast_nullable_to_non_nullable
              as List<KPIAlert>,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KPIDashboardImpl implements _KPIDashboard {
  const _$KPIDashboardImpl(
      {required this.userId,
      required this.period,
      required final List<KPI> kpis,
      required this.summary,
      final List<KPIAlert> alerts = const [],
      this.lastUpdated})
      : _kpis = kpis,
        _alerts = alerts;

  factory _$KPIDashboardImpl.fromJson(Map<String, dynamic> json) =>
      _$$KPIDashboardImplFromJson(json);

  @override
  final String userId;
  @override
  final DateTime period;
  final List<KPI> _kpis;
  @override
  List<KPI> get kpis {
    if (_kpis is EqualUnmodifiableListView) return _kpis;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_kpis);
  }

  @override
  final KPISummary summary;
  final List<KPIAlert> _alerts;
  @override
  @JsonKey()
  List<KPIAlert> get alerts {
    if (_alerts is EqualUnmodifiableListView) return _alerts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_alerts);
  }

  @override
  final DateTime? lastUpdated;

  @override
  String toString() {
    return 'KPIDashboard(userId: $userId, period: $period, kpis: $kpis, summary: $summary, alerts: $alerts, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KPIDashboardImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.period, period) || other.period == period) &&
            const DeepCollectionEquality().equals(other._kpis, _kpis) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality().equals(other._alerts, _alerts) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      period,
      const DeepCollectionEquality().hash(_kpis),
      summary,
      const DeepCollectionEquality().hash(_alerts),
      lastUpdated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KPIDashboardImplCopyWith<_$KPIDashboardImpl> get copyWith =>
      __$$KPIDashboardImplCopyWithImpl<_$KPIDashboardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KPIDashboardImplToJson(
      this,
    );
  }
}

abstract class _KPIDashboard implements KPIDashboard {
  const factory _KPIDashboard(
      {required final String userId,
      required final DateTime period,
      required final List<KPI> kpis,
      required final KPISummary summary,
      final List<KPIAlert> alerts,
      final DateTime? lastUpdated}) = _$KPIDashboardImpl;

  factory _KPIDashboard.fromJson(Map<String, dynamic> json) =
      _$KPIDashboardImpl.fromJson;

  @override
  String get userId;
  @override
  DateTime get period;
  @override
  List<KPI> get kpis;
  @override
  KPISummary get summary;
  @override
  List<KPIAlert> get alerts;
  @override
  DateTime? get lastUpdated;
  @override
  @JsonKey(ignore: true)
  _$$KPIDashboardImplCopyWith<_$KPIDashboardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

KPISummary _$KPISummaryFromJson(Map<String, dynamic> json) {
  return _KPISummary.fromJson(json);
}

/// @nodoc
mixin _$KPISummary {
  int get totalKPIs => throw _privateConstructorUsedError;
  int get kpisOnTarget => throw _privateConstructorUsedError;
  int get kpisAboveTarget => throw _privateConstructorUsedError;
  int get kpisBelowTarget => throw _privateConstructorUsedError;
  double get overallPerformance => throw _privateConstructorUsedError;
  KPITrend? get overallTrend => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KPISummaryCopyWith<KPISummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KPISummaryCopyWith<$Res> {
  factory $KPISummaryCopyWith(
          KPISummary value, $Res Function(KPISummary) then) =
      _$KPISummaryCopyWithImpl<$Res, KPISummary>;
  @useResult
  $Res call(
      {int totalKPIs,
      int kpisOnTarget,
      int kpisAboveTarget,
      int kpisBelowTarget,
      double overallPerformance,
      KPITrend? overallTrend});
}

/// @nodoc
class _$KPISummaryCopyWithImpl<$Res, $Val extends KPISummary>
    implements $KPISummaryCopyWith<$Res> {
  _$KPISummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalKPIs = null,
    Object? kpisOnTarget = null,
    Object? kpisAboveTarget = null,
    Object? kpisBelowTarget = null,
    Object? overallPerformance = null,
    Object? overallTrend = freezed,
  }) {
    return _then(_value.copyWith(
      totalKPIs: null == totalKPIs
          ? _value.totalKPIs
          : totalKPIs // ignore: cast_nullable_to_non_nullable
              as int,
      kpisOnTarget: null == kpisOnTarget
          ? _value.kpisOnTarget
          : kpisOnTarget // ignore: cast_nullable_to_non_nullable
              as int,
      kpisAboveTarget: null == kpisAboveTarget
          ? _value.kpisAboveTarget
          : kpisAboveTarget // ignore: cast_nullable_to_non_nullable
              as int,
      kpisBelowTarget: null == kpisBelowTarget
          ? _value.kpisBelowTarget
          : kpisBelowTarget // ignore: cast_nullable_to_non_nullable
              as int,
      overallPerformance: null == overallPerformance
          ? _value.overallPerformance
          : overallPerformance // ignore: cast_nullable_to_non_nullable
              as double,
      overallTrend: freezed == overallTrend
          ? _value.overallTrend
          : overallTrend // ignore: cast_nullable_to_non_nullable
              as KPITrend?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KPISummaryImplCopyWith<$Res>
    implements $KPISummaryCopyWith<$Res> {
  factory _$$KPISummaryImplCopyWith(
          _$KPISummaryImpl value, $Res Function(_$KPISummaryImpl) then) =
      __$$KPISummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalKPIs,
      int kpisOnTarget,
      int kpisAboveTarget,
      int kpisBelowTarget,
      double overallPerformance,
      KPITrend? overallTrend});
}

/// @nodoc
class __$$KPISummaryImplCopyWithImpl<$Res>
    extends _$KPISummaryCopyWithImpl<$Res, _$KPISummaryImpl>
    implements _$$KPISummaryImplCopyWith<$Res> {
  __$$KPISummaryImplCopyWithImpl(
      _$KPISummaryImpl _value, $Res Function(_$KPISummaryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalKPIs = null,
    Object? kpisOnTarget = null,
    Object? kpisAboveTarget = null,
    Object? kpisBelowTarget = null,
    Object? overallPerformance = null,
    Object? overallTrend = freezed,
  }) {
    return _then(_$KPISummaryImpl(
      totalKPIs: null == totalKPIs
          ? _value.totalKPIs
          : totalKPIs // ignore: cast_nullable_to_non_nullable
              as int,
      kpisOnTarget: null == kpisOnTarget
          ? _value.kpisOnTarget
          : kpisOnTarget // ignore: cast_nullable_to_non_nullable
              as int,
      kpisAboveTarget: null == kpisAboveTarget
          ? _value.kpisAboveTarget
          : kpisAboveTarget // ignore: cast_nullable_to_non_nullable
              as int,
      kpisBelowTarget: null == kpisBelowTarget
          ? _value.kpisBelowTarget
          : kpisBelowTarget // ignore: cast_nullable_to_non_nullable
              as int,
      overallPerformance: null == overallPerformance
          ? _value.overallPerformance
          : overallPerformance // ignore: cast_nullable_to_non_nullable
              as double,
      overallTrend: freezed == overallTrend
          ? _value.overallTrend
          : overallTrend // ignore: cast_nullable_to_non_nullable
              as KPITrend?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KPISummaryImpl implements _KPISummary {
  const _$KPISummaryImpl(
      {required this.totalKPIs,
      required this.kpisOnTarget,
      required this.kpisAboveTarget,
      required this.kpisBelowTarget,
      required this.overallPerformance,
      this.overallTrend});

  factory _$KPISummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$KPISummaryImplFromJson(json);

  @override
  final int totalKPIs;
  @override
  final int kpisOnTarget;
  @override
  final int kpisAboveTarget;
  @override
  final int kpisBelowTarget;
  @override
  final double overallPerformance;
  @override
  final KPITrend? overallTrend;

  @override
  String toString() {
    return 'KPISummary(totalKPIs: $totalKPIs, kpisOnTarget: $kpisOnTarget, kpisAboveTarget: $kpisAboveTarget, kpisBelowTarget: $kpisBelowTarget, overallPerformance: $overallPerformance, overallTrend: $overallTrend)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KPISummaryImpl &&
            (identical(other.totalKPIs, totalKPIs) ||
                other.totalKPIs == totalKPIs) &&
            (identical(other.kpisOnTarget, kpisOnTarget) ||
                other.kpisOnTarget == kpisOnTarget) &&
            (identical(other.kpisAboveTarget, kpisAboveTarget) ||
                other.kpisAboveTarget == kpisAboveTarget) &&
            (identical(other.kpisBelowTarget, kpisBelowTarget) ||
                other.kpisBelowTarget == kpisBelowTarget) &&
            (identical(other.overallPerformance, overallPerformance) ||
                other.overallPerformance == overallPerformance) &&
            (identical(other.overallTrend, overallTrend) ||
                other.overallTrend == overallTrend));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, totalKPIs, kpisOnTarget,
      kpisAboveTarget, kpisBelowTarget, overallPerformance, overallTrend);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KPISummaryImplCopyWith<_$KPISummaryImpl> get copyWith =>
      __$$KPISummaryImplCopyWithImpl<_$KPISummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KPISummaryImplToJson(
      this,
    );
  }
}

abstract class _KPISummary implements KPISummary {
  const factory _KPISummary(
      {required final int totalKPIs,
      required final int kpisOnTarget,
      required final int kpisAboveTarget,
      required final int kpisBelowTarget,
      required final double overallPerformance,
      final KPITrend? overallTrend}) = _$KPISummaryImpl;

  factory _KPISummary.fromJson(Map<String, dynamic> json) =
      _$KPISummaryImpl.fromJson;

  @override
  int get totalKPIs;
  @override
  int get kpisOnTarget;
  @override
  int get kpisAboveTarget;
  @override
  int get kpisBelowTarget;
  @override
  double get overallPerformance;
  @override
  KPITrend? get overallTrend;
  @override
  @JsonKey(ignore: true)
  _$$KPISummaryImplCopyWith<_$KPISummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

KPIAlert _$KPIAlertFromJson(Map<String, dynamic> json) {
  return _KPIAlert.fromJson(json);
}

/// @nodoc
mixin _$KPIAlert {
  String get kpiId => throw _privateConstructorUsedError;
  String get kpiName => throw _privateConstructorUsedError;
  KPIAlertType get type => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  KPIAlertSeverity get severity => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  bool? get acknowledged => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KPIAlertCopyWith<KPIAlert> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KPIAlertCopyWith<$Res> {
  factory $KPIAlertCopyWith(KPIAlert value, $Res Function(KPIAlert) then) =
      _$KPIAlertCopyWithImpl<$Res, KPIAlert>;
  @useResult
  $Res call(
      {String kpiId,
      String kpiName,
      KPIAlertType type,
      String message,
      KPIAlertSeverity severity,
      DateTime? createdAt,
      bool? acknowledged});
}

/// @nodoc
class _$KPIAlertCopyWithImpl<$Res, $Val extends KPIAlert>
    implements $KPIAlertCopyWith<$Res> {
  _$KPIAlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kpiId = null,
    Object? kpiName = null,
    Object? type = null,
    Object? message = null,
    Object? severity = null,
    Object? createdAt = freezed,
    Object? acknowledged = freezed,
  }) {
    return _then(_value.copyWith(
      kpiId: null == kpiId
          ? _value.kpiId
          : kpiId // ignore: cast_nullable_to_non_nullable
              as String,
      kpiName: null == kpiName
          ? _value.kpiName
          : kpiName // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as KPIAlertType,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as KPIAlertSeverity,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      acknowledged: freezed == acknowledged
          ? _value.acknowledged
          : acknowledged // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KPIAlertImplCopyWith<$Res>
    implements $KPIAlertCopyWith<$Res> {
  factory _$$KPIAlertImplCopyWith(
          _$KPIAlertImpl value, $Res Function(_$KPIAlertImpl) then) =
      __$$KPIAlertImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String kpiId,
      String kpiName,
      KPIAlertType type,
      String message,
      KPIAlertSeverity severity,
      DateTime? createdAt,
      bool? acknowledged});
}

/// @nodoc
class __$$KPIAlertImplCopyWithImpl<$Res>
    extends _$KPIAlertCopyWithImpl<$Res, _$KPIAlertImpl>
    implements _$$KPIAlertImplCopyWith<$Res> {
  __$$KPIAlertImplCopyWithImpl(
      _$KPIAlertImpl _value, $Res Function(_$KPIAlertImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kpiId = null,
    Object? kpiName = null,
    Object? type = null,
    Object? message = null,
    Object? severity = null,
    Object? createdAt = freezed,
    Object? acknowledged = freezed,
  }) {
    return _then(_$KPIAlertImpl(
      kpiId: null == kpiId
          ? _value.kpiId
          : kpiId // ignore: cast_nullable_to_non_nullable
              as String,
      kpiName: null == kpiName
          ? _value.kpiName
          : kpiName // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as KPIAlertType,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as KPIAlertSeverity,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      acknowledged: freezed == acknowledged
          ? _value.acknowledged
          : acknowledged // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KPIAlertImpl implements _KPIAlert {
  const _$KPIAlertImpl(
      {required this.kpiId,
      required this.kpiName,
      required this.type,
      required this.message,
      required this.severity,
      this.createdAt,
      this.acknowledged});

  factory _$KPIAlertImpl.fromJson(Map<String, dynamic> json) =>
      _$$KPIAlertImplFromJson(json);

  @override
  final String kpiId;
  @override
  final String kpiName;
  @override
  final KPIAlertType type;
  @override
  final String message;
  @override
  final KPIAlertSeverity severity;
  @override
  final DateTime? createdAt;
  @override
  final bool? acknowledged;

  @override
  String toString() {
    return 'KPIAlert(kpiId: $kpiId, kpiName: $kpiName, type: $type, message: $message, severity: $severity, createdAt: $createdAt, acknowledged: $acknowledged)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KPIAlertImpl &&
            (identical(other.kpiId, kpiId) || other.kpiId == kpiId) &&
            (identical(other.kpiName, kpiName) || other.kpiName == kpiName) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.acknowledged, acknowledged) ||
                other.acknowledged == acknowledged));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, kpiId, kpiName, type, message,
      severity, createdAt, acknowledged);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KPIAlertImplCopyWith<_$KPIAlertImpl> get copyWith =>
      __$$KPIAlertImplCopyWithImpl<_$KPIAlertImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KPIAlertImplToJson(
      this,
    );
  }
}

abstract class _KPIAlert implements KPIAlert {
  const factory _KPIAlert(
      {required final String kpiId,
      required final String kpiName,
      required final KPIAlertType type,
      required final String message,
      required final KPIAlertSeverity severity,
      final DateTime? createdAt,
      final bool? acknowledged}) = _$KPIAlertImpl;

  factory _KPIAlert.fromJson(Map<String, dynamic> json) =
      _$KPIAlertImpl.fromJson;

  @override
  String get kpiId;
  @override
  String get kpiName;
  @override
  KPIAlertType get type;
  @override
  String get message;
  @override
  KPIAlertSeverity get severity;
  @override
  DateTime? get createdAt;
  @override
  bool? get acknowledged;
  @override
  @JsonKey(ignore: true)
  _$$KPIAlertImplCopyWith<_$KPIAlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

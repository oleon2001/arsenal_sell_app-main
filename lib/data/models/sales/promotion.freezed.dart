// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'promotion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Promotion _$PromotionFromJson(Map<String, dynamic> json) {
  return _Promotion.fromJson(json);
}

/// @nodoc
mixin _$Promotion {
  String get id => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  PromotionType get type => throw _privateConstructorUsedError;
  Map<String, dynamic> get rules => throw _privateConstructorUsedError;
  DateTime get startsAt => throw _privateConstructorUsedError;
  DateTime get endsAt => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  int get priority => throw _privateConstructorUsedError;
  int get usageLimit => throw _privateConstructorUsedError;
  int get usageCount => throw _privateConstructorUsedError;
  List<String> get applicableProducts => throw _privateConstructorUsedError;
  List<String> get applicableCategories => throw _privateConstructorUsedError;
  List<String> get applicableCustomers => throw _privateConstructorUsedError;
  List<String> get excludedProducts => throw _privateConstructorUsedError;
  List<String> get excludedCustomers => throw _privateConstructorUsedError;
  double? get minimumOrderAmount => throw _privateConstructorUsedError;
  double? get maximumDiscount => throw _privateConstructorUsedError;
  List<DayOfWeek> get applicableDays => throw _privateConstructorUsedError;
  TimeOfDay? get startTime => throw _privateConstructorUsedError;
  TimeOfDay? get endTime => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PromotionCopyWith<Promotion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromotionCopyWith<$Res> {
  factory $PromotionCopyWith(Promotion value, $Res Function(Promotion) then) =
      _$PromotionCopyWithImpl<$Res, Promotion>;
  @useResult
  $Res call(
      {String id,
      String companyId,
      String name,
      String? description,
      PromotionType type,
      Map<String, dynamic> rules,
      DateTime startsAt,
      DateTime endsAt,
      bool active,
      int priority,
      int usageLimit,
      int usageCount,
      List<String> applicableProducts,
      List<String> applicableCategories,
      List<String> applicableCustomers,
      List<String> excludedProducts,
      List<String> excludedCustomers,
      double? minimumOrderAmount,
      double? maximumDiscount,
      List<DayOfWeek> applicableDays,
      TimeOfDay? startTime,
      TimeOfDay? endTime,
      DateTime? createdAt,
      String? createdBy});

  $TimeOfDayCopyWith<$Res>? get startTime;
  $TimeOfDayCopyWith<$Res>? get endTime;
}

/// @nodoc
class _$PromotionCopyWithImpl<$Res, $Val extends Promotion>
    implements $PromotionCopyWith<$Res> {
  _$PromotionCopyWithImpl(this._value, this._then);

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
    Object? description = freezed,
    Object? type = null,
    Object? rules = null,
    Object? startsAt = null,
    Object? endsAt = null,
    Object? active = null,
    Object? priority = null,
    Object? usageLimit = null,
    Object? usageCount = null,
    Object? applicableProducts = null,
    Object? applicableCategories = null,
    Object? applicableCustomers = null,
    Object? excludedProducts = null,
    Object? excludedCustomers = null,
    Object? minimumOrderAmount = freezed,
    Object? maximumDiscount = freezed,
    Object? applicableDays = null,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? createdAt = freezed,
    Object? createdBy = freezed,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PromotionType,
      rules: null == rules
          ? _value.rules
          : rules // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      startsAt: null == startsAt
          ? _value.startsAt
          : startsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endsAt: null == endsAt
          ? _value.endsAt
          : endsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      usageLimit: null == usageLimit
          ? _value.usageLimit
          : usageLimit // ignore: cast_nullable_to_non_nullable
              as int,
      usageCount: null == usageCount
          ? _value.usageCount
          : usageCount // ignore: cast_nullable_to_non_nullable
              as int,
      applicableProducts: null == applicableProducts
          ? _value.applicableProducts
          : applicableProducts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      applicableCategories: null == applicableCategories
          ? _value.applicableCategories
          : applicableCategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      applicableCustomers: null == applicableCustomers
          ? _value.applicableCustomers
          : applicableCustomers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      excludedProducts: null == excludedProducts
          ? _value.excludedProducts
          : excludedProducts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      excludedCustomers: null == excludedCustomers
          ? _value.excludedCustomers
          : excludedCustomers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      minimumOrderAmount: freezed == minimumOrderAmount
          ? _value.minimumOrderAmount
          : minimumOrderAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      maximumDiscount: freezed == maximumDiscount
          ? _value.maximumDiscount
          : maximumDiscount // ignore: cast_nullable_to_non_nullable
              as double?,
      applicableDays: null == applicableDays
          ? _value.applicableDays
          : applicableDays // ignore: cast_nullable_to_non_nullable
              as List<DayOfWeek>,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TimeOfDayCopyWith<$Res>? get startTime {
    if (_value.startTime == null) {
      return null;
    }

    return $TimeOfDayCopyWith<$Res>(_value.startTime!, (value) {
      return _then(_value.copyWith(startTime: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TimeOfDayCopyWith<$Res>? get endTime {
    if (_value.endTime == null) {
      return null;
    }

    return $TimeOfDayCopyWith<$Res>(_value.endTime!, (value) {
      return _then(_value.copyWith(endTime: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PromotionImplCopyWith<$Res>
    implements $PromotionCopyWith<$Res> {
  factory _$$PromotionImplCopyWith(
          _$PromotionImpl value, $Res Function(_$PromotionImpl) then) =
      __$$PromotionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String companyId,
      String name,
      String? description,
      PromotionType type,
      Map<String, dynamic> rules,
      DateTime startsAt,
      DateTime endsAt,
      bool active,
      int priority,
      int usageLimit,
      int usageCount,
      List<String> applicableProducts,
      List<String> applicableCategories,
      List<String> applicableCustomers,
      List<String> excludedProducts,
      List<String> excludedCustomers,
      double? minimumOrderAmount,
      double? maximumDiscount,
      List<DayOfWeek> applicableDays,
      TimeOfDay? startTime,
      TimeOfDay? endTime,
      DateTime? createdAt,
      String? createdBy});

  @override
  $TimeOfDayCopyWith<$Res>? get startTime;
  @override
  $TimeOfDayCopyWith<$Res>? get endTime;
}

/// @nodoc
class __$$PromotionImplCopyWithImpl<$Res>
    extends _$PromotionCopyWithImpl<$Res, _$PromotionImpl>
    implements _$$PromotionImplCopyWith<$Res> {
  __$$PromotionImplCopyWithImpl(
      _$PromotionImpl _value, $Res Function(_$PromotionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? name = null,
    Object? description = freezed,
    Object? type = null,
    Object? rules = null,
    Object? startsAt = null,
    Object? endsAt = null,
    Object? active = null,
    Object? priority = null,
    Object? usageLimit = null,
    Object? usageCount = null,
    Object? applicableProducts = null,
    Object? applicableCategories = null,
    Object? applicableCustomers = null,
    Object? excludedProducts = null,
    Object? excludedCustomers = null,
    Object? minimumOrderAmount = freezed,
    Object? maximumDiscount = freezed,
    Object? applicableDays = null,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? createdAt = freezed,
    Object? createdBy = freezed,
  }) {
    return _then(_$PromotionImpl(
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PromotionType,
      rules: null == rules
          ? _value._rules
          : rules // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      startsAt: null == startsAt
          ? _value.startsAt
          : startsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endsAt: null == endsAt
          ? _value.endsAt
          : endsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      usageLimit: null == usageLimit
          ? _value.usageLimit
          : usageLimit // ignore: cast_nullable_to_non_nullable
              as int,
      usageCount: null == usageCount
          ? _value.usageCount
          : usageCount // ignore: cast_nullable_to_non_nullable
              as int,
      applicableProducts: null == applicableProducts
          ? _value._applicableProducts
          : applicableProducts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      applicableCategories: null == applicableCategories
          ? _value._applicableCategories
          : applicableCategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      applicableCustomers: null == applicableCustomers
          ? _value._applicableCustomers
          : applicableCustomers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      excludedProducts: null == excludedProducts
          ? _value._excludedProducts
          : excludedProducts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      excludedCustomers: null == excludedCustomers
          ? _value._excludedCustomers
          : excludedCustomers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      minimumOrderAmount: freezed == minimumOrderAmount
          ? _value.minimumOrderAmount
          : minimumOrderAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      maximumDiscount: freezed == maximumDiscount
          ? _value.maximumDiscount
          : maximumDiscount // ignore: cast_nullable_to_non_nullable
              as double?,
      applicableDays: null == applicableDays
          ? _value._applicableDays
          : applicableDays // ignore: cast_nullable_to_non_nullable
              as List<DayOfWeek>,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PromotionImpl implements _Promotion {
  const _$PromotionImpl(
      {required this.id,
      required this.companyId,
      required this.name,
      this.description,
      required this.type,
      required final Map<String, dynamic> rules,
      required this.startsAt,
      required this.endsAt,
      this.active = true,
      this.priority = 0,
      this.usageLimit = 0,
      this.usageCount = 0,
      final List<String> applicableProducts = const [],
      final List<String> applicableCategories = const [],
      final List<String> applicableCustomers = const [],
      final List<String> excludedProducts = const [],
      final List<String> excludedCustomers = const [],
      this.minimumOrderAmount,
      this.maximumDiscount,
      final List<DayOfWeek> applicableDays = const [],
      this.startTime,
      this.endTime,
      this.createdAt,
      this.createdBy})
      : _rules = rules,
        _applicableProducts = applicableProducts,
        _applicableCategories = applicableCategories,
        _applicableCustomers = applicableCustomers,
        _excludedProducts = excludedProducts,
        _excludedCustomers = excludedCustomers,
        _applicableDays = applicableDays;

  factory _$PromotionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PromotionImplFromJson(json);

  @override
  final String id;
  @override
  final String companyId;
  @override
  final String name;
  @override
  final String? description;
  @override
  final PromotionType type;
  final Map<String, dynamic> _rules;
  @override
  Map<String, dynamic> get rules {
    if (_rules is EqualUnmodifiableMapView) return _rules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_rules);
  }

  @override
  final DateTime startsAt;
  @override
  final DateTime endsAt;
  @override
  @JsonKey()
  final bool active;
  @override
  @JsonKey()
  final int priority;
  @override
  @JsonKey()
  final int usageLimit;
  @override
  @JsonKey()
  final int usageCount;
  final List<String> _applicableProducts;
  @override
  @JsonKey()
  List<String> get applicableProducts {
    if (_applicableProducts is EqualUnmodifiableListView)
      return _applicableProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_applicableProducts);
  }

  final List<String> _applicableCategories;
  @override
  @JsonKey()
  List<String> get applicableCategories {
    if (_applicableCategories is EqualUnmodifiableListView)
      return _applicableCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_applicableCategories);
  }

  final List<String> _applicableCustomers;
  @override
  @JsonKey()
  List<String> get applicableCustomers {
    if (_applicableCustomers is EqualUnmodifiableListView)
      return _applicableCustomers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_applicableCustomers);
  }

  final List<String> _excludedProducts;
  @override
  @JsonKey()
  List<String> get excludedProducts {
    if (_excludedProducts is EqualUnmodifiableListView)
      return _excludedProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_excludedProducts);
  }

  final List<String> _excludedCustomers;
  @override
  @JsonKey()
  List<String> get excludedCustomers {
    if (_excludedCustomers is EqualUnmodifiableListView)
      return _excludedCustomers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_excludedCustomers);
  }

  @override
  final double? minimumOrderAmount;
  @override
  final double? maximumDiscount;
  final List<DayOfWeek> _applicableDays;
  @override
  @JsonKey()
  List<DayOfWeek> get applicableDays {
    if (_applicableDays is EqualUnmodifiableListView) return _applicableDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_applicableDays);
  }

  @override
  final TimeOfDay? startTime;
  @override
  final TimeOfDay? endTime;
  @override
  final DateTime? createdAt;
  @override
  final String? createdBy;

  @override
  String toString() {
    return 'Promotion(id: $id, companyId: $companyId, name: $name, description: $description, type: $type, rules: $rules, startsAt: $startsAt, endsAt: $endsAt, active: $active, priority: $priority, usageLimit: $usageLimit, usageCount: $usageCount, applicableProducts: $applicableProducts, applicableCategories: $applicableCategories, applicableCustomers: $applicableCustomers, excludedProducts: $excludedProducts, excludedCustomers: $excludedCustomers, minimumOrderAmount: $minimumOrderAmount, maximumDiscount: $maximumDiscount, applicableDays: $applicableDays, startTime: $startTime, endTime: $endTime, createdAt: $createdAt, createdBy: $createdBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PromotionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._rules, _rules) &&
            (identical(other.startsAt, startsAt) ||
                other.startsAt == startsAt) &&
            (identical(other.endsAt, endsAt) || other.endsAt == endsAt) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.usageLimit, usageLimit) ||
                other.usageLimit == usageLimit) &&
            (identical(other.usageCount, usageCount) ||
                other.usageCount == usageCount) &&
            const DeepCollectionEquality()
                .equals(other._applicableProducts, _applicableProducts) &&
            const DeepCollectionEquality()
                .equals(other._applicableCategories, _applicableCategories) &&
            const DeepCollectionEquality()
                .equals(other._applicableCustomers, _applicableCustomers) &&
            const DeepCollectionEquality()
                .equals(other._excludedProducts, _excludedProducts) &&
            const DeepCollectionEquality()
                .equals(other._excludedCustomers, _excludedCustomers) &&
            (identical(other.minimumOrderAmount, minimumOrderAmount) ||
                other.minimumOrderAmount == minimumOrderAmount) &&
            (identical(other.maximumDiscount, maximumDiscount) ||
                other.maximumDiscount == maximumDiscount) &&
            const DeepCollectionEquality()
                .equals(other._applicableDays, _applicableDays) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        companyId,
        name,
        description,
        type,
        const DeepCollectionEquality().hash(_rules),
        startsAt,
        endsAt,
        active,
        priority,
        usageLimit,
        usageCount,
        const DeepCollectionEquality().hash(_applicableProducts),
        const DeepCollectionEquality().hash(_applicableCategories),
        const DeepCollectionEquality().hash(_applicableCustomers),
        const DeepCollectionEquality().hash(_excludedProducts),
        const DeepCollectionEquality().hash(_excludedCustomers),
        minimumOrderAmount,
        maximumDiscount,
        const DeepCollectionEquality().hash(_applicableDays),
        startTime,
        endTime,
        createdAt,
        createdBy
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PromotionImplCopyWith<_$PromotionImpl> get copyWith =>
      __$$PromotionImplCopyWithImpl<_$PromotionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PromotionImplToJson(
      this,
    );
  }
}

abstract class _Promotion implements Promotion {
  const factory _Promotion(
      {required final String id,
      required final String companyId,
      required final String name,
      final String? description,
      required final PromotionType type,
      required final Map<String, dynamic> rules,
      required final DateTime startsAt,
      required final DateTime endsAt,
      final bool active,
      final int priority,
      final int usageLimit,
      final int usageCount,
      final List<String> applicableProducts,
      final List<String> applicableCategories,
      final List<String> applicableCustomers,
      final List<String> excludedProducts,
      final List<String> excludedCustomers,
      final double? minimumOrderAmount,
      final double? maximumDiscount,
      final List<DayOfWeek> applicableDays,
      final TimeOfDay? startTime,
      final TimeOfDay? endTime,
      final DateTime? createdAt,
      final String? createdBy}) = _$PromotionImpl;

  factory _Promotion.fromJson(Map<String, dynamic> json) =
      _$PromotionImpl.fromJson;

  @override
  String get id;
  @override
  String get companyId;
  @override
  String get name;
  @override
  String? get description;
  @override
  PromotionType get type;
  @override
  Map<String, dynamic> get rules;
  @override
  DateTime get startsAt;
  @override
  DateTime get endsAt;
  @override
  bool get active;
  @override
  int get priority;
  @override
  int get usageLimit;
  @override
  int get usageCount;
  @override
  List<String> get applicableProducts;
  @override
  List<String> get applicableCategories;
  @override
  List<String> get applicableCustomers;
  @override
  List<String> get excludedProducts;
  @override
  List<String> get excludedCustomers;
  @override
  double? get minimumOrderAmount;
  @override
  double? get maximumDiscount;
  @override
  List<DayOfWeek> get applicableDays;
  @override
  TimeOfDay? get startTime;
  @override
  TimeOfDay? get endTime;
  @override
  DateTime? get createdAt;
  @override
  String? get createdBy;
  @override
  @JsonKey(ignore: true)
  _$$PromotionImplCopyWith<_$PromotionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PromotionResult _$PromotionResultFromJson(Map<String, dynamic> json) {
  return _PromotionResult.fromJson(json);
}

/// @nodoc
mixin _$PromotionResult {
  String get promotionId => throw _privateConstructorUsedError;
  String get promotionName => throw _privateConstructorUsedError;
  PromotionType get type => throw _privateConstructorUsedError;
  double get discountAmount => throw _privateConstructorUsedError;
  double? get discountPercentage => throw _privateConstructorUsedError;
  List<String> get affectedProducts => throw _privateConstructorUsedError;
  List<PromotionItem> get freeItems => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PromotionResultCopyWith<PromotionResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromotionResultCopyWith<$Res> {
  factory $PromotionResultCopyWith(
          PromotionResult value, $Res Function(PromotionResult) then) =
      _$PromotionResultCopyWithImpl<$Res, PromotionResult>;
  @useResult
  $Res call(
      {String promotionId,
      String promotionName,
      PromotionType type,
      double discountAmount,
      double? discountPercentage,
      List<String> affectedProducts,
      List<PromotionItem> freeItems,
      String? description});
}

/// @nodoc
class _$PromotionResultCopyWithImpl<$Res, $Val extends PromotionResult>
    implements $PromotionResultCopyWith<$Res> {
  _$PromotionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? promotionId = null,
    Object? promotionName = null,
    Object? type = null,
    Object? discountAmount = null,
    Object? discountPercentage = freezed,
    Object? affectedProducts = null,
    Object? freeItems = null,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      promotionId: null == promotionId
          ? _value.promotionId
          : promotionId // ignore: cast_nullable_to_non_nullable
              as String,
      promotionName: null == promotionName
          ? _value.promotionName
          : promotionName // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PromotionType,
      discountAmount: null == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double,
      discountPercentage: freezed == discountPercentage
          ? _value.discountPercentage
          : discountPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      affectedProducts: null == affectedProducts
          ? _value.affectedProducts
          : affectedProducts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      freeItems: null == freeItems
          ? _value.freeItems
          : freeItems // ignore: cast_nullable_to_non_nullable
              as List<PromotionItem>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PromotionResultImplCopyWith<$Res>
    implements $PromotionResultCopyWith<$Res> {
  factory _$$PromotionResultImplCopyWith(_$PromotionResultImpl value,
          $Res Function(_$PromotionResultImpl) then) =
      __$$PromotionResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String promotionId,
      String promotionName,
      PromotionType type,
      double discountAmount,
      double? discountPercentage,
      List<String> affectedProducts,
      List<PromotionItem> freeItems,
      String? description});
}

/// @nodoc
class __$$PromotionResultImplCopyWithImpl<$Res>
    extends _$PromotionResultCopyWithImpl<$Res, _$PromotionResultImpl>
    implements _$$PromotionResultImplCopyWith<$Res> {
  __$$PromotionResultImplCopyWithImpl(
      _$PromotionResultImpl _value, $Res Function(_$PromotionResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? promotionId = null,
    Object? promotionName = null,
    Object? type = null,
    Object? discountAmount = null,
    Object? discountPercentage = freezed,
    Object? affectedProducts = null,
    Object? freeItems = null,
    Object? description = freezed,
  }) {
    return _then(_$PromotionResultImpl(
      promotionId: null == promotionId
          ? _value.promotionId
          : promotionId // ignore: cast_nullable_to_non_nullable
              as String,
      promotionName: null == promotionName
          ? _value.promotionName
          : promotionName // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PromotionType,
      discountAmount: null == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double,
      discountPercentage: freezed == discountPercentage
          ? _value.discountPercentage
          : discountPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      affectedProducts: null == affectedProducts
          ? _value._affectedProducts
          : affectedProducts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      freeItems: null == freeItems
          ? _value._freeItems
          : freeItems // ignore: cast_nullable_to_non_nullable
              as List<PromotionItem>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PromotionResultImpl implements _PromotionResult {
  const _$PromotionResultImpl(
      {required this.promotionId,
      required this.promotionName,
      required this.type,
      required this.discountAmount,
      this.discountPercentage,
      final List<String> affectedProducts = const [],
      final List<PromotionItem> freeItems = const [],
      this.description})
      : _affectedProducts = affectedProducts,
        _freeItems = freeItems;

  factory _$PromotionResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$PromotionResultImplFromJson(json);

  @override
  final String promotionId;
  @override
  final String promotionName;
  @override
  final PromotionType type;
  @override
  final double discountAmount;
  @override
  final double? discountPercentage;
  final List<String> _affectedProducts;
  @override
  @JsonKey()
  List<String> get affectedProducts {
    if (_affectedProducts is EqualUnmodifiableListView)
      return _affectedProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_affectedProducts);
  }

  final List<PromotionItem> _freeItems;
  @override
  @JsonKey()
  List<PromotionItem> get freeItems {
    if (_freeItems is EqualUnmodifiableListView) return _freeItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_freeItems);
  }

  @override
  final String? description;

  @override
  String toString() {
    return 'PromotionResult(promotionId: $promotionId, promotionName: $promotionName, type: $type, discountAmount: $discountAmount, discountPercentage: $discountPercentage, affectedProducts: $affectedProducts, freeItems: $freeItems, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PromotionResultImpl &&
            (identical(other.promotionId, promotionId) ||
                other.promotionId == promotionId) &&
            (identical(other.promotionName, promotionName) ||
                other.promotionName == promotionName) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.discountPercentage, discountPercentage) ||
                other.discountPercentage == discountPercentage) &&
            const DeepCollectionEquality()
                .equals(other._affectedProducts, _affectedProducts) &&
            const DeepCollectionEquality()
                .equals(other._freeItems, _freeItems) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      promotionId,
      promotionName,
      type,
      discountAmount,
      discountPercentage,
      const DeepCollectionEquality().hash(_affectedProducts),
      const DeepCollectionEquality().hash(_freeItems),
      description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PromotionResultImplCopyWith<_$PromotionResultImpl> get copyWith =>
      __$$PromotionResultImplCopyWithImpl<_$PromotionResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PromotionResultImplToJson(
      this,
    );
  }
}

abstract class _PromotionResult implements PromotionResult {
  const factory _PromotionResult(
      {required final String promotionId,
      required final String promotionName,
      required final PromotionType type,
      required final double discountAmount,
      final double? discountPercentage,
      final List<String> affectedProducts,
      final List<PromotionItem> freeItems,
      final String? description}) = _$PromotionResultImpl;

  factory _PromotionResult.fromJson(Map<String, dynamic> json) =
      _$PromotionResultImpl.fromJson;

  @override
  String get promotionId;
  @override
  String get promotionName;
  @override
  PromotionType get type;
  @override
  double get discountAmount;
  @override
  double? get discountPercentage;
  @override
  List<String> get affectedProducts;
  @override
  List<PromotionItem> get freeItems;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$PromotionResultImplCopyWith<_$PromotionResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PromotionItem _$PromotionItemFromJson(Map<String, dynamic> json) {
  return _PromotionItem.fromJson(json);
}

/// @nodoc
mixin _$PromotionItem {
  String get productId => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  Product? get product => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PromotionItemCopyWith<PromotionItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromotionItemCopyWith<$Res> {
  factory $PromotionItemCopyWith(
          PromotionItem value, $Res Function(PromotionItem) then) =
      _$PromotionItemCopyWithImpl<$Res, PromotionItem>;
  @useResult
  $Res call({String productId, double quantity, Product? product});

  $ProductCopyWith<$Res>? get product;
}

/// @nodoc
class _$PromotionItemCopyWithImpl<$Res, $Val extends PromotionItem>
    implements $PromotionItemCopyWith<$Res> {
  _$PromotionItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? quantity = null,
    Object? product = freezed,
  }) {
    return _then(_value.copyWith(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res>? get product {
    if (_value.product == null) {
      return null;
    }

    return $ProductCopyWith<$Res>(_value.product!, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PromotionItemImplCopyWith<$Res>
    implements $PromotionItemCopyWith<$Res> {
  factory _$$PromotionItemImplCopyWith(
          _$PromotionItemImpl value, $Res Function(_$PromotionItemImpl) then) =
      __$$PromotionItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String productId, double quantity, Product? product});

  @override
  $ProductCopyWith<$Res>? get product;
}

/// @nodoc
class __$$PromotionItemImplCopyWithImpl<$Res>
    extends _$PromotionItemCopyWithImpl<$Res, _$PromotionItemImpl>
    implements _$$PromotionItemImplCopyWith<$Res> {
  __$$PromotionItemImplCopyWithImpl(
      _$PromotionItemImpl _value, $Res Function(_$PromotionItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? quantity = null,
    Object? product = freezed,
  }) {
    return _then(_$PromotionItemImpl(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PromotionItemImpl implements _PromotionItem {
  const _$PromotionItemImpl(
      {required this.productId, required this.quantity, this.product});

  factory _$PromotionItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PromotionItemImplFromJson(json);

  @override
  final String productId;
  @override
  final double quantity;
  @override
  final Product? product;

  @override
  String toString() {
    return 'PromotionItem(productId: $productId, quantity: $quantity, product: $product)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PromotionItemImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.product, product) || other.product == product));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, productId, quantity, product);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PromotionItemImplCopyWith<_$PromotionItemImpl> get copyWith =>
      __$$PromotionItemImplCopyWithImpl<_$PromotionItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PromotionItemImplToJson(
      this,
    );
  }
}

abstract class _PromotionItem implements PromotionItem {
  const factory _PromotionItem(
      {required final String productId,
      required final double quantity,
      final Product? product}) = _$PromotionItemImpl;

  factory _PromotionItem.fromJson(Map<String, dynamic> json) =
      _$PromotionItemImpl.fromJson;

  @override
  String get productId;
  @override
  double get quantity;
  @override
  Product? get product;
  @override
  @JsonKey(ignore: true)
  _$$PromotionItemImplCopyWith<_$PromotionItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TimeOfDay _$TimeOfDayFromJson(Map<String, dynamic> json) {
  return _TimeOfDay.fromJson(json);
}

/// @nodoc
mixin _$TimeOfDay {
  int get hour => throw _privateConstructorUsedError;
  int get minute => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimeOfDayCopyWith<TimeOfDay> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeOfDayCopyWith<$Res> {
  factory $TimeOfDayCopyWith(TimeOfDay value, $Res Function(TimeOfDay) then) =
      _$TimeOfDayCopyWithImpl<$Res, TimeOfDay>;
  @useResult
  $Res call({int hour, int minute});
}

/// @nodoc
class _$TimeOfDayCopyWithImpl<$Res, $Val extends TimeOfDay>
    implements $TimeOfDayCopyWith<$Res> {
  _$TimeOfDayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hour = null,
    Object? minute = null,
  }) {
    return _then(_value.copyWith(
      hour: null == hour
          ? _value.hour
          : hour // ignore: cast_nullable_to_non_nullable
              as int,
      minute: null == minute
          ? _value.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeOfDayImplCopyWith<$Res>
    implements $TimeOfDayCopyWith<$Res> {
  factory _$$TimeOfDayImplCopyWith(
          _$TimeOfDayImpl value, $Res Function(_$TimeOfDayImpl) then) =
      __$$TimeOfDayImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int hour, int minute});
}

/// @nodoc
class __$$TimeOfDayImplCopyWithImpl<$Res>
    extends _$TimeOfDayCopyWithImpl<$Res, _$TimeOfDayImpl>
    implements _$$TimeOfDayImplCopyWith<$Res> {
  __$$TimeOfDayImplCopyWithImpl(
      _$TimeOfDayImpl _value, $Res Function(_$TimeOfDayImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hour = null,
    Object? minute = null,
  }) {
    return _then(_$TimeOfDayImpl(
      hour: null == hour
          ? _value.hour
          : hour // ignore: cast_nullable_to_non_nullable
              as int,
      minute: null == minute
          ? _value.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeOfDayImpl implements _TimeOfDay {
  const _$TimeOfDayImpl({required this.hour, required this.minute});

  factory _$TimeOfDayImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeOfDayImplFromJson(json);

  @override
  final int hour;
  @override
  final int minute;

  @override
  String toString() {
    return 'TimeOfDay(hour: $hour, minute: $minute)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeOfDayImpl &&
            (identical(other.hour, hour) || other.hour == hour) &&
            (identical(other.minute, minute) || other.minute == minute));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, hour, minute);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeOfDayImplCopyWith<_$TimeOfDayImpl> get copyWith =>
      __$$TimeOfDayImplCopyWithImpl<_$TimeOfDayImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeOfDayImplToJson(
      this,
    );
  }
}

abstract class _TimeOfDay implements TimeOfDay {
  const factory _TimeOfDay(
      {required final int hour, required final int minute}) = _$TimeOfDayImpl;

  factory _TimeOfDay.fromJson(Map<String, dynamic> json) =
      _$TimeOfDayImpl.fromJson;

  @override
  int get hour;
  @override
  int get minute;
  @override
  @JsonKey(ignore: true)
  _$$TimeOfDayImplCopyWith<_$TimeOfDayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

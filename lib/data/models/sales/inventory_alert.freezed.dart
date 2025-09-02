// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_alert.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InventoryAlert _$InventoryAlertFromJson(Map<String, dynamic> json) {
  return _InventoryAlert.fromJson(json);
}

/// @nodoc
mixin _$InventoryAlert {
  String get id => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String get warehouseId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  AlertType get alertType => throw _privateConstructorUsedError;
  double? get threshold => throw _privateConstructorUsedError;
  double? get currentValue => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get resolvedAt => throw _privateConstructorUsedError;
  String? get resolvedBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryAlertCopyWith<InventoryAlert> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryAlertCopyWith<$Res> {
  factory $InventoryAlertCopyWith(
          InventoryAlert value, $Res Function(InventoryAlert) then) =
      _$InventoryAlertCopyWithImpl<$Res, InventoryAlert>;
  @useResult
  $Res call(
      {String id,
      String companyId,
      String warehouseId,
      String productId,
      AlertType alertType,
      double? threshold,
      double? currentValue,
      bool isActive,
      DateTime? createdAt,
      DateTime? resolvedAt,
      String? resolvedBy});
}

/// @nodoc
class _$InventoryAlertCopyWithImpl<$Res, $Val extends InventoryAlert>
    implements $InventoryAlertCopyWith<$Res> {
  _$InventoryAlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? warehouseId = null,
    Object? productId = null,
    Object? alertType = null,
    Object? threshold = freezed,
    Object? currentValue = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? resolvedAt = freezed,
    Object? resolvedBy = freezed,
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
      warehouseId: null == warehouseId
          ? _value.warehouseId
          : warehouseId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      alertType: null == alertType
          ? _value.alertType
          : alertType // ignore: cast_nullable_to_non_nullable
              as AlertType,
      threshold: freezed == threshold
          ? _value.threshold
          : threshold // ignore: cast_nullable_to_non_nullable
              as double?,
      currentValue: freezed == currentValue
          ? _value.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as double?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      resolvedAt: freezed == resolvedAt
          ? _value.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      resolvedBy: freezed == resolvedBy
          ? _value.resolvedBy
          : resolvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryAlertImplCopyWith<$Res>
    implements $InventoryAlertCopyWith<$Res> {
  factory _$$InventoryAlertImplCopyWith(_$InventoryAlertImpl value,
          $Res Function(_$InventoryAlertImpl) then) =
      __$$InventoryAlertImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String companyId,
      String warehouseId,
      String productId,
      AlertType alertType,
      double? threshold,
      double? currentValue,
      bool isActive,
      DateTime? createdAt,
      DateTime? resolvedAt,
      String? resolvedBy});
}

/// @nodoc
class __$$InventoryAlertImplCopyWithImpl<$Res>
    extends _$InventoryAlertCopyWithImpl<$Res, _$InventoryAlertImpl>
    implements _$$InventoryAlertImplCopyWith<$Res> {
  __$$InventoryAlertImplCopyWithImpl(
      _$InventoryAlertImpl _value, $Res Function(_$InventoryAlertImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? warehouseId = null,
    Object? productId = null,
    Object? alertType = null,
    Object? threshold = freezed,
    Object? currentValue = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? resolvedAt = freezed,
    Object? resolvedBy = freezed,
  }) {
    return _then(_$InventoryAlertImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      companyId: null == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String,
      warehouseId: null == warehouseId
          ? _value.warehouseId
          : warehouseId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      alertType: null == alertType
          ? _value.alertType
          : alertType // ignore: cast_nullable_to_non_nullable
              as AlertType,
      threshold: freezed == threshold
          ? _value.threshold
          : threshold // ignore: cast_nullable_to_non_nullable
              as double?,
      currentValue: freezed == currentValue
          ? _value.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as double?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      resolvedAt: freezed == resolvedAt
          ? _value.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      resolvedBy: freezed == resolvedBy
          ? _value.resolvedBy
          : resolvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryAlertImpl implements _InventoryAlert {
  const _$InventoryAlertImpl(
      {required this.id,
      required this.companyId,
      required this.warehouseId,
      required this.productId,
      required this.alertType,
      this.threshold,
      this.currentValue,
      this.isActive = true,
      this.createdAt,
      this.resolvedAt,
      this.resolvedBy});

  factory _$InventoryAlertImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryAlertImplFromJson(json);

  @override
  final String id;
  @override
  final String companyId;
  @override
  final String warehouseId;
  @override
  final String productId;
  @override
  final AlertType alertType;
  @override
  final double? threshold;
  @override
  final double? currentValue;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? resolvedAt;
  @override
  final String? resolvedBy;

  @override
  String toString() {
    return 'InventoryAlert(id: $id, companyId: $companyId, warehouseId: $warehouseId, productId: $productId, alertType: $alertType, threshold: $threshold, currentValue: $currentValue, isActive: $isActive, createdAt: $createdAt, resolvedAt: $resolvedAt, resolvedBy: $resolvedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryAlertImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.warehouseId, warehouseId) ||
                other.warehouseId == warehouseId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.alertType, alertType) ||
                other.alertType == alertType) &&
            (identical(other.threshold, threshold) ||
                other.threshold == threshold) &&
            (identical(other.currentValue, currentValue) ||
                other.currentValue == currentValue) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt) &&
            (identical(other.resolvedBy, resolvedBy) ||
                other.resolvedBy == resolvedBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      companyId,
      warehouseId,
      productId,
      alertType,
      threshold,
      currentValue,
      isActive,
      createdAt,
      resolvedAt,
      resolvedBy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryAlertImplCopyWith<_$InventoryAlertImpl> get copyWith =>
      __$$InventoryAlertImplCopyWithImpl<_$InventoryAlertImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryAlertImplToJson(
      this,
    );
  }
}

abstract class _InventoryAlert implements InventoryAlert {
  const factory _InventoryAlert(
      {required final String id,
      required final String companyId,
      required final String warehouseId,
      required final String productId,
      required final AlertType alertType,
      final double? threshold,
      final double? currentValue,
      final bool isActive,
      final DateTime? createdAt,
      final DateTime? resolvedAt,
      final String? resolvedBy}) = _$InventoryAlertImpl;

  factory _InventoryAlert.fromJson(Map<String, dynamic> json) =
      _$InventoryAlertImpl.fromJson;

  @override
  String get id;
  @override
  String get companyId;
  @override
  String get warehouseId;
  @override
  String get productId;
  @override
  AlertType get alertType;
  @override
  double? get threshold;
  @override
  double? get currentValue;
  @override
  bool get isActive;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get resolvedAt;
  @override
  String? get resolvedBy;
  @override
  @JsonKey(ignore: true)
  _$$InventoryAlertImplCopyWith<_$InventoryAlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProductAlertConfig _$ProductAlertConfigFromJson(Map<String, dynamic> json) {
  return _ProductAlertConfig.fromJson(json);
}

/// @nodoc
mixin _$ProductAlertConfig {
  String get id => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  double get lowStockThreshold => throw _privateConstructorUsedError;
  double get outOfStockThreshold => throw _privateConstructorUsedError;
  double? get overstockThreshold => throw _privateConstructorUsedError;
  int get expiringDaysThreshold => throw _privateConstructorUsedError;
  bool get enableLowStockAlert => throw _privateConstructorUsedError;
  bool get enableOutOfStockAlert => throw _privateConstructorUsedError;
  bool get enableOverstockAlert => throw _privateConstructorUsedError;
  bool get enableExpiringAlert => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductAlertConfigCopyWith<ProductAlertConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductAlertConfigCopyWith<$Res> {
  factory $ProductAlertConfigCopyWith(
          ProductAlertConfig value, $Res Function(ProductAlertConfig) then) =
      _$ProductAlertConfigCopyWithImpl<$Res, ProductAlertConfig>;
  @useResult
  $Res call(
      {String id,
      String companyId,
      String productId,
      double lowStockThreshold,
      double outOfStockThreshold,
      double? overstockThreshold,
      int expiringDaysThreshold,
      bool enableLowStockAlert,
      bool enableOutOfStockAlert,
      bool enableOverstockAlert,
      bool enableExpiringAlert,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$ProductAlertConfigCopyWithImpl<$Res, $Val extends ProductAlertConfig>
    implements $ProductAlertConfigCopyWith<$Res> {
  _$ProductAlertConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? productId = null,
    Object? lowStockThreshold = null,
    Object? outOfStockThreshold = null,
    Object? overstockThreshold = freezed,
    Object? expiringDaysThreshold = null,
    Object? enableLowStockAlert = null,
    Object? enableOutOfStockAlert = null,
    Object? enableOverstockAlert = null,
    Object? enableExpiringAlert = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      lowStockThreshold: null == lowStockThreshold
          ? _value.lowStockThreshold
          : lowStockThreshold // ignore: cast_nullable_to_non_nullable
              as double,
      outOfStockThreshold: null == outOfStockThreshold
          ? _value.outOfStockThreshold
          : outOfStockThreshold // ignore: cast_nullable_to_non_nullable
              as double,
      overstockThreshold: freezed == overstockThreshold
          ? _value.overstockThreshold
          : overstockThreshold // ignore: cast_nullable_to_non_nullable
              as double?,
      expiringDaysThreshold: null == expiringDaysThreshold
          ? _value.expiringDaysThreshold
          : expiringDaysThreshold // ignore: cast_nullable_to_non_nullable
              as int,
      enableLowStockAlert: null == enableLowStockAlert
          ? _value.enableLowStockAlert
          : enableLowStockAlert // ignore: cast_nullable_to_non_nullable
              as bool,
      enableOutOfStockAlert: null == enableOutOfStockAlert
          ? _value.enableOutOfStockAlert
          : enableOutOfStockAlert // ignore: cast_nullable_to_non_nullable
              as bool,
      enableOverstockAlert: null == enableOverstockAlert
          ? _value.enableOverstockAlert
          : enableOverstockAlert // ignore: cast_nullable_to_non_nullable
              as bool,
      enableExpiringAlert: null == enableExpiringAlert
          ? _value.enableExpiringAlert
          : enableExpiringAlert // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ProductAlertConfigImplCopyWith<$Res>
    implements $ProductAlertConfigCopyWith<$Res> {
  factory _$$ProductAlertConfigImplCopyWith(_$ProductAlertConfigImpl value,
          $Res Function(_$ProductAlertConfigImpl) then) =
      __$$ProductAlertConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String companyId,
      String productId,
      double lowStockThreshold,
      double outOfStockThreshold,
      double? overstockThreshold,
      int expiringDaysThreshold,
      bool enableLowStockAlert,
      bool enableOutOfStockAlert,
      bool enableOverstockAlert,
      bool enableExpiringAlert,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$ProductAlertConfigImplCopyWithImpl<$Res>
    extends _$ProductAlertConfigCopyWithImpl<$Res, _$ProductAlertConfigImpl>
    implements _$$ProductAlertConfigImplCopyWith<$Res> {
  __$$ProductAlertConfigImplCopyWithImpl(_$ProductAlertConfigImpl _value,
      $Res Function(_$ProductAlertConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? productId = null,
    Object? lowStockThreshold = null,
    Object? outOfStockThreshold = null,
    Object? overstockThreshold = freezed,
    Object? expiringDaysThreshold = null,
    Object? enableLowStockAlert = null,
    Object? enableOutOfStockAlert = null,
    Object? enableOverstockAlert = null,
    Object? enableExpiringAlert = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ProductAlertConfigImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      companyId: null == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      lowStockThreshold: null == lowStockThreshold
          ? _value.lowStockThreshold
          : lowStockThreshold // ignore: cast_nullable_to_non_nullable
              as double,
      outOfStockThreshold: null == outOfStockThreshold
          ? _value.outOfStockThreshold
          : outOfStockThreshold // ignore: cast_nullable_to_non_nullable
              as double,
      overstockThreshold: freezed == overstockThreshold
          ? _value.overstockThreshold
          : overstockThreshold // ignore: cast_nullable_to_non_nullable
              as double?,
      expiringDaysThreshold: null == expiringDaysThreshold
          ? _value.expiringDaysThreshold
          : expiringDaysThreshold // ignore: cast_nullable_to_non_nullable
              as int,
      enableLowStockAlert: null == enableLowStockAlert
          ? _value.enableLowStockAlert
          : enableLowStockAlert // ignore: cast_nullable_to_non_nullable
              as bool,
      enableOutOfStockAlert: null == enableOutOfStockAlert
          ? _value.enableOutOfStockAlert
          : enableOutOfStockAlert // ignore: cast_nullable_to_non_nullable
              as bool,
      enableOverstockAlert: null == enableOverstockAlert
          ? _value.enableOverstockAlert
          : enableOverstockAlert // ignore: cast_nullable_to_non_nullable
              as bool,
      enableExpiringAlert: null == enableExpiringAlert
          ? _value.enableExpiringAlert
          : enableExpiringAlert // ignore: cast_nullable_to_non_nullable
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
class _$ProductAlertConfigImpl implements _ProductAlertConfig {
  const _$ProductAlertConfigImpl(
      {required this.id,
      required this.companyId,
      required this.productId,
      this.lowStockThreshold = 10.0,
      this.outOfStockThreshold = 0.0,
      this.overstockThreshold,
      this.expiringDaysThreshold = 30,
      this.enableLowStockAlert = true,
      this.enableOutOfStockAlert = true,
      this.enableOverstockAlert = false,
      this.enableExpiringAlert = true,
      this.createdAt,
      this.updatedAt});

  factory _$ProductAlertConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductAlertConfigImplFromJson(json);

  @override
  final String id;
  @override
  final String companyId;
  @override
  final String productId;
  @override
  @JsonKey()
  final double lowStockThreshold;
  @override
  @JsonKey()
  final double outOfStockThreshold;
  @override
  final double? overstockThreshold;
  @override
  @JsonKey()
  final int expiringDaysThreshold;
  @override
  @JsonKey()
  final bool enableLowStockAlert;
  @override
  @JsonKey()
  final bool enableOutOfStockAlert;
  @override
  @JsonKey()
  final bool enableOverstockAlert;
  @override
  @JsonKey()
  final bool enableExpiringAlert;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ProductAlertConfig(id: $id, companyId: $companyId, productId: $productId, lowStockThreshold: $lowStockThreshold, outOfStockThreshold: $outOfStockThreshold, overstockThreshold: $overstockThreshold, expiringDaysThreshold: $expiringDaysThreshold, enableLowStockAlert: $enableLowStockAlert, enableOutOfStockAlert: $enableOutOfStockAlert, enableOverstockAlert: $enableOverstockAlert, enableExpiringAlert: $enableExpiringAlert, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductAlertConfigImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.lowStockThreshold, lowStockThreshold) ||
                other.lowStockThreshold == lowStockThreshold) &&
            (identical(other.outOfStockThreshold, outOfStockThreshold) ||
                other.outOfStockThreshold == outOfStockThreshold) &&
            (identical(other.overstockThreshold, overstockThreshold) ||
                other.overstockThreshold == overstockThreshold) &&
            (identical(other.expiringDaysThreshold, expiringDaysThreshold) ||
                other.expiringDaysThreshold == expiringDaysThreshold) &&
            (identical(other.enableLowStockAlert, enableLowStockAlert) ||
                other.enableLowStockAlert == enableLowStockAlert) &&
            (identical(other.enableOutOfStockAlert, enableOutOfStockAlert) ||
                other.enableOutOfStockAlert == enableOutOfStockAlert) &&
            (identical(other.enableOverstockAlert, enableOverstockAlert) ||
                other.enableOverstockAlert == enableOverstockAlert) &&
            (identical(other.enableExpiringAlert, enableExpiringAlert) ||
                other.enableExpiringAlert == enableExpiringAlert) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      companyId,
      productId,
      lowStockThreshold,
      outOfStockThreshold,
      overstockThreshold,
      expiringDaysThreshold,
      enableLowStockAlert,
      enableOutOfStockAlert,
      enableOverstockAlert,
      enableExpiringAlert,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductAlertConfigImplCopyWith<_$ProductAlertConfigImpl> get copyWith =>
      __$$ProductAlertConfigImplCopyWithImpl<_$ProductAlertConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductAlertConfigImplToJson(
      this,
    );
  }
}

abstract class _ProductAlertConfig implements ProductAlertConfig {
  const factory _ProductAlertConfig(
      {required final String id,
      required final String companyId,
      required final String productId,
      final double lowStockThreshold,
      final double outOfStockThreshold,
      final double? overstockThreshold,
      final int expiringDaysThreshold,
      final bool enableLowStockAlert,
      final bool enableOutOfStockAlert,
      final bool enableOverstockAlert,
      final bool enableExpiringAlert,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$ProductAlertConfigImpl;

  factory _ProductAlertConfig.fromJson(Map<String, dynamic> json) =
      _$ProductAlertConfigImpl.fromJson;

  @override
  String get id;
  @override
  String get companyId;
  @override
  String get productId;
  @override
  double get lowStockThreshold;
  @override
  double get outOfStockThreshold;
  @override
  double? get overstockThreshold;
  @override
  int get expiringDaysThreshold;
  @override
  bool get enableLowStockAlert;
  @override
  bool get enableOutOfStockAlert;
  @override
  bool get enableOverstockAlert;
  @override
  bool get enableExpiringAlert;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$ProductAlertConfigImplCopyWith<_$ProductAlertConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Inventory _$InventoryFromJson(Map<String, dynamic> json) {
  return _Inventory.fromJson(json);
}

/// @nodoc
mixin _$Inventory {
  String get id => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String get warehouseId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  double get currentStock => throw _privateConstructorUsedError;
  double get reservedStock => throw _privateConstructorUsedError;
  double? get availableStock => throw _privateConstructorUsedError;
  double? get minStock => throw _privateConstructorUsedError;
  double? get maxStock => throw _privateConstructorUsedError;
  double? get reorderPoint => throw _privateConstructorUsedError;
  double? get unitCost => throw _privateConstructorUsedError;
  DateTime? get lastUpdated => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryCopyWith<Inventory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryCopyWith<$Res> {
  factory $InventoryCopyWith(Inventory value, $Res Function(Inventory) then) =
      _$InventoryCopyWithImpl<$Res, Inventory>;
  @useResult
  $Res call(
      {String id,
      String companyId,
      String warehouseId,
      String productId,
      double currentStock,
      double reservedStock,
      double? availableStock,
      double? minStock,
      double? maxStock,
      double? reorderPoint,
      double? unitCost,
      DateTime? lastUpdated,
      DateTime? createdAt});
}

/// @nodoc
class _$InventoryCopyWithImpl<$Res, $Val extends Inventory>
    implements $InventoryCopyWith<$Res> {
  _$InventoryCopyWithImpl(this._value, this._then);

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
    Object? currentStock = null,
    Object? reservedStock = null,
    Object? availableStock = freezed,
    Object? minStock = freezed,
    Object? maxStock = freezed,
    Object? reorderPoint = freezed,
    Object? unitCost = freezed,
    Object? lastUpdated = freezed,
    Object? createdAt = freezed,
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
      currentStock: null == currentStock
          ? _value.currentStock
          : currentStock // ignore: cast_nullable_to_non_nullable
              as double,
      reservedStock: null == reservedStock
          ? _value.reservedStock
          : reservedStock // ignore: cast_nullable_to_non_nullable
              as double,
      availableStock: freezed == availableStock
          ? _value.availableStock
          : availableStock // ignore: cast_nullable_to_non_nullable
              as double?,
      minStock: freezed == minStock
          ? _value.minStock
          : minStock // ignore: cast_nullable_to_non_nullable
              as double?,
      maxStock: freezed == maxStock
          ? _value.maxStock
          : maxStock // ignore: cast_nullable_to_non_nullable
              as double?,
      reorderPoint: freezed == reorderPoint
          ? _value.reorderPoint
          : reorderPoint // ignore: cast_nullable_to_non_nullable
              as double?,
      unitCost: freezed == unitCost
          ? _value.unitCost
          : unitCost // ignore: cast_nullable_to_non_nullable
              as double?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryImplCopyWith<$Res>
    implements $InventoryCopyWith<$Res> {
  factory _$$InventoryImplCopyWith(
          _$InventoryImpl value, $Res Function(_$InventoryImpl) then) =
      __$$InventoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String companyId,
      String warehouseId,
      String productId,
      double currentStock,
      double reservedStock,
      double? availableStock,
      double? minStock,
      double? maxStock,
      double? reorderPoint,
      double? unitCost,
      DateTime? lastUpdated,
      DateTime? createdAt});
}

/// @nodoc
class __$$InventoryImplCopyWithImpl<$Res>
    extends _$InventoryCopyWithImpl<$Res, _$InventoryImpl>
    implements _$$InventoryImplCopyWith<$Res> {
  __$$InventoryImplCopyWithImpl(
      _$InventoryImpl _value, $Res Function(_$InventoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? warehouseId = null,
    Object? productId = null,
    Object? currentStock = null,
    Object? reservedStock = null,
    Object? availableStock = freezed,
    Object? minStock = freezed,
    Object? maxStock = freezed,
    Object? reorderPoint = freezed,
    Object? unitCost = freezed,
    Object? lastUpdated = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$InventoryImpl(
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
      currentStock: null == currentStock
          ? _value.currentStock
          : currentStock // ignore: cast_nullable_to_non_nullable
              as double,
      reservedStock: null == reservedStock
          ? _value.reservedStock
          : reservedStock // ignore: cast_nullable_to_non_nullable
              as double,
      availableStock: freezed == availableStock
          ? _value.availableStock
          : availableStock // ignore: cast_nullable_to_non_nullable
              as double?,
      minStock: freezed == minStock
          ? _value.minStock
          : minStock // ignore: cast_nullable_to_non_nullable
              as double?,
      maxStock: freezed == maxStock
          ? _value.maxStock
          : maxStock // ignore: cast_nullable_to_non_nullable
              as double?,
      reorderPoint: freezed == reorderPoint
          ? _value.reorderPoint
          : reorderPoint // ignore: cast_nullable_to_non_nullable
              as double?,
      unitCost: freezed == unitCost
          ? _value.unitCost
          : unitCost // ignore: cast_nullable_to_non_nullable
              as double?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryImpl implements _Inventory {
  const _$InventoryImpl(
      {required this.id,
      required this.companyId,
      required this.warehouseId,
      required this.productId,
      required this.currentStock,
      required this.reservedStock,
      this.availableStock,
      this.minStock,
      this.maxStock,
      this.reorderPoint,
      this.unitCost,
      this.lastUpdated,
      this.createdAt});

  factory _$InventoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryImplFromJson(json);

  @override
  final String id;
  @override
  final String companyId;
  @override
  final String warehouseId;
  @override
  final String productId;
  @override
  final double currentStock;
  @override
  final double reservedStock;
  @override
  final double? availableStock;
  @override
  final double? minStock;
  @override
  final double? maxStock;
  @override
  final double? reorderPoint;
  @override
  final double? unitCost;
  @override
  final DateTime? lastUpdated;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Inventory(id: $id, companyId: $companyId, warehouseId: $warehouseId, productId: $productId, currentStock: $currentStock, reservedStock: $reservedStock, availableStock: $availableStock, minStock: $minStock, maxStock: $maxStock, reorderPoint: $reorderPoint, unitCost: $unitCost, lastUpdated: $lastUpdated, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.warehouseId, warehouseId) ||
                other.warehouseId == warehouseId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.currentStock, currentStock) ||
                other.currentStock == currentStock) &&
            (identical(other.reservedStock, reservedStock) ||
                other.reservedStock == reservedStock) &&
            (identical(other.availableStock, availableStock) ||
                other.availableStock == availableStock) &&
            (identical(other.minStock, minStock) ||
                other.minStock == minStock) &&
            (identical(other.maxStock, maxStock) ||
                other.maxStock == maxStock) &&
            (identical(other.reorderPoint, reorderPoint) ||
                other.reorderPoint == reorderPoint) &&
            (identical(other.unitCost, unitCost) ||
                other.unitCost == unitCost) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      companyId,
      warehouseId,
      productId,
      currentStock,
      reservedStock,
      availableStock,
      minStock,
      maxStock,
      reorderPoint,
      unitCost,
      lastUpdated,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryImplCopyWith<_$InventoryImpl> get copyWith =>
      __$$InventoryImplCopyWithImpl<_$InventoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryImplToJson(
      this,
    );
  }
}

abstract class _Inventory implements Inventory {
  const factory _Inventory(
      {required final String id,
      required final String companyId,
      required final String warehouseId,
      required final String productId,
      required final double currentStock,
      required final double reservedStock,
      final double? availableStock,
      final double? minStock,
      final double? maxStock,
      final double? reorderPoint,
      final double? unitCost,
      final DateTime? lastUpdated,
      final DateTime? createdAt}) = _$InventoryImpl;

  factory _Inventory.fromJson(Map<String, dynamic> json) =
      _$InventoryImpl.fromJson;

  @override
  String get id;
  @override
  String get companyId;
  @override
  String get warehouseId;
  @override
  String get productId;
  @override
  double get currentStock;
  @override
  double get reservedStock;
  @override
  double? get availableStock;
  @override
  double? get minStock;
  @override
  double? get maxStock;
  @override
  double? get reorderPoint;
  @override
  double? get unitCost;
  @override
  DateTime? get lastUpdated;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$InventoryImplCopyWith<_$InventoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InventorySummary _$InventorySummaryFromJson(Map<String, dynamic> json) {
  return _InventorySummary.fromJson(json);
}

/// @nodoc
mixin _$InventorySummary {
  String get id => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String get warehouseId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  String get warehouseName => throw _privateConstructorUsedError;
  String get productName => throw _privateConstructorUsedError;
  String? get sku => throw _privateConstructorUsedError;
  String? get unit => throw _privateConstructorUsedError;
  double get currentStock => throw _privateConstructorUsedError;
  double get reservedStock => throw _privateConstructorUsedError;
  double get availableStock => throw _privateConstructorUsedError;
  double? get minStock => throw _privateConstructorUsedError;
  double? get maxStock => throw _privateConstructorUsedError;
  double? get reorderPoint => throw _privateConstructorUsedError;
  double? get unitCost => throw _privateConstructorUsedError;
  double? get totalValue => throw _privateConstructorUsedError;
  DateTime? get lastUpdated => throw _privateConstructorUsedError;
  String get stockStatus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventorySummaryCopyWith<InventorySummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventorySummaryCopyWith<$Res> {
  factory $InventorySummaryCopyWith(
          InventorySummary value, $Res Function(InventorySummary) then) =
      _$InventorySummaryCopyWithImpl<$Res, InventorySummary>;
  @useResult
  $Res call(
      {String id,
      String companyId,
      String warehouseId,
      String productId,
      String warehouseName,
      String productName,
      String? sku,
      String? unit,
      double currentStock,
      double reservedStock,
      double availableStock,
      double? minStock,
      double? maxStock,
      double? reorderPoint,
      double? unitCost,
      double? totalValue,
      DateTime? lastUpdated,
      String stockStatus});
}

/// @nodoc
class _$InventorySummaryCopyWithImpl<$Res, $Val extends InventorySummary>
    implements $InventorySummaryCopyWith<$Res> {
  _$InventorySummaryCopyWithImpl(this._value, this._then);

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
    Object? warehouseName = null,
    Object? productName = null,
    Object? sku = freezed,
    Object? unit = freezed,
    Object? currentStock = null,
    Object? reservedStock = null,
    Object? availableStock = null,
    Object? minStock = freezed,
    Object? maxStock = freezed,
    Object? reorderPoint = freezed,
    Object? unitCost = freezed,
    Object? totalValue = freezed,
    Object? lastUpdated = freezed,
    Object? stockStatus = null,
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
      warehouseName: null == warehouseName
          ? _value.warehouseName
          : warehouseName // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      sku: freezed == sku
          ? _value.sku
          : sku // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      currentStock: null == currentStock
          ? _value.currentStock
          : currentStock // ignore: cast_nullable_to_non_nullable
              as double,
      reservedStock: null == reservedStock
          ? _value.reservedStock
          : reservedStock // ignore: cast_nullable_to_non_nullable
              as double,
      availableStock: null == availableStock
          ? _value.availableStock
          : availableStock // ignore: cast_nullable_to_non_nullable
              as double,
      minStock: freezed == minStock
          ? _value.minStock
          : minStock // ignore: cast_nullable_to_non_nullable
              as double?,
      maxStock: freezed == maxStock
          ? _value.maxStock
          : maxStock // ignore: cast_nullable_to_non_nullable
              as double?,
      reorderPoint: freezed == reorderPoint
          ? _value.reorderPoint
          : reorderPoint // ignore: cast_nullable_to_non_nullable
              as double?,
      unitCost: freezed == unitCost
          ? _value.unitCost
          : unitCost // ignore: cast_nullable_to_non_nullable
              as double?,
      totalValue: freezed == totalValue
          ? _value.totalValue
          : totalValue // ignore: cast_nullable_to_non_nullable
              as double?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      stockStatus: null == stockStatus
          ? _value.stockStatus
          : stockStatus // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventorySummaryImplCopyWith<$Res>
    implements $InventorySummaryCopyWith<$Res> {
  factory _$$InventorySummaryImplCopyWith(_$InventorySummaryImpl value,
          $Res Function(_$InventorySummaryImpl) then) =
      __$$InventorySummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String companyId,
      String warehouseId,
      String productId,
      String warehouseName,
      String productName,
      String? sku,
      String? unit,
      double currentStock,
      double reservedStock,
      double availableStock,
      double? minStock,
      double? maxStock,
      double? reorderPoint,
      double? unitCost,
      double? totalValue,
      DateTime? lastUpdated,
      String stockStatus});
}

/// @nodoc
class __$$InventorySummaryImplCopyWithImpl<$Res>
    extends _$InventorySummaryCopyWithImpl<$Res, _$InventorySummaryImpl>
    implements _$$InventorySummaryImplCopyWith<$Res> {
  __$$InventorySummaryImplCopyWithImpl(_$InventorySummaryImpl _value,
      $Res Function(_$InventorySummaryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? warehouseId = null,
    Object? productId = null,
    Object? warehouseName = null,
    Object? productName = null,
    Object? sku = freezed,
    Object? unit = freezed,
    Object? currentStock = null,
    Object? reservedStock = null,
    Object? availableStock = null,
    Object? minStock = freezed,
    Object? maxStock = freezed,
    Object? reorderPoint = freezed,
    Object? unitCost = freezed,
    Object? totalValue = freezed,
    Object? lastUpdated = freezed,
    Object? stockStatus = null,
  }) {
    return _then(_$InventorySummaryImpl(
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
      warehouseName: null == warehouseName
          ? _value.warehouseName
          : warehouseName // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      sku: freezed == sku
          ? _value.sku
          : sku // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      currentStock: null == currentStock
          ? _value.currentStock
          : currentStock // ignore: cast_nullable_to_non_nullable
              as double,
      reservedStock: null == reservedStock
          ? _value.reservedStock
          : reservedStock // ignore: cast_nullable_to_non_nullable
              as double,
      availableStock: null == availableStock
          ? _value.availableStock
          : availableStock // ignore: cast_nullable_to_non_nullable
              as double,
      minStock: freezed == minStock
          ? _value.minStock
          : minStock // ignore: cast_nullable_to_non_nullable
              as double?,
      maxStock: freezed == maxStock
          ? _value.maxStock
          : maxStock // ignore: cast_nullable_to_non_nullable
              as double?,
      reorderPoint: freezed == reorderPoint
          ? _value.reorderPoint
          : reorderPoint // ignore: cast_nullable_to_non_nullable
              as double?,
      unitCost: freezed == unitCost
          ? _value.unitCost
          : unitCost // ignore: cast_nullable_to_non_nullable
              as double?,
      totalValue: freezed == totalValue
          ? _value.totalValue
          : totalValue // ignore: cast_nullable_to_non_nullable
              as double?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      stockStatus: null == stockStatus
          ? _value.stockStatus
          : stockStatus // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventorySummaryImpl implements _InventorySummary {
  const _$InventorySummaryImpl(
      {required this.id,
      required this.companyId,
      required this.warehouseId,
      required this.productId,
      required this.warehouseName,
      required this.productName,
      this.sku,
      this.unit,
      required this.currentStock,
      required this.reservedStock,
      required this.availableStock,
      this.minStock,
      this.maxStock,
      this.reorderPoint,
      this.unitCost,
      this.totalValue,
      this.lastUpdated,
      required this.stockStatus});

  factory _$InventorySummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventorySummaryImplFromJson(json);

  @override
  final String id;
  @override
  final String companyId;
  @override
  final String warehouseId;
  @override
  final String productId;
  @override
  final String warehouseName;
  @override
  final String productName;
  @override
  final String? sku;
  @override
  final String? unit;
  @override
  final double currentStock;
  @override
  final double reservedStock;
  @override
  final double availableStock;
  @override
  final double? minStock;
  @override
  final double? maxStock;
  @override
  final double? reorderPoint;
  @override
  final double? unitCost;
  @override
  final double? totalValue;
  @override
  final DateTime? lastUpdated;
  @override
  final String stockStatus;

  @override
  String toString() {
    return 'InventorySummary(id: $id, companyId: $companyId, warehouseId: $warehouseId, productId: $productId, warehouseName: $warehouseName, productName: $productName, sku: $sku, unit: $unit, currentStock: $currentStock, reservedStock: $reservedStock, availableStock: $availableStock, minStock: $minStock, maxStock: $maxStock, reorderPoint: $reorderPoint, unitCost: $unitCost, totalValue: $totalValue, lastUpdated: $lastUpdated, stockStatus: $stockStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventorySummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.warehouseId, warehouseId) ||
                other.warehouseId == warehouseId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.warehouseName, warehouseName) ||
                other.warehouseName == warehouseName) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.sku, sku) || other.sku == sku) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.currentStock, currentStock) ||
                other.currentStock == currentStock) &&
            (identical(other.reservedStock, reservedStock) ||
                other.reservedStock == reservedStock) &&
            (identical(other.availableStock, availableStock) ||
                other.availableStock == availableStock) &&
            (identical(other.minStock, minStock) ||
                other.minStock == minStock) &&
            (identical(other.maxStock, maxStock) ||
                other.maxStock == maxStock) &&
            (identical(other.reorderPoint, reorderPoint) ||
                other.reorderPoint == reorderPoint) &&
            (identical(other.unitCost, unitCost) ||
                other.unitCost == unitCost) &&
            (identical(other.totalValue, totalValue) ||
                other.totalValue == totalValue) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.stockStatus, stockStatus) ||
                other.stockStatus == stockStatus));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      companyId,
      warehouseId,
      productId,
      warehouseName,
      productName,
      sku,
      unit,
      currentStock,
      reservedStock,
      availableStock,
      minStock,
      maxStock,
      reorderPoint,
      unitCost,
      totalValue,
      lastUpdated,
      stockStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventorySummaryImplCopyWith<_$InventorySummaryImpl> get copyWith =>
      __$$InventorySummaryImplCopyWithImpl<_$InventorySummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventorySummaryImplToJson(
      this,
    );
  }
}

abstract class _InventorySummary implements InventorySummary {
  const factory _InventorySummary(
      {required final String id,
      required final String companyId,
      required final String warehouseId,
      required final String productId,
      required final String warehouseName,
      required final String productName,
      final String? sku,
      final String? unit,
      required final double currentStock,
      required final double reservedStock,
      required final double availableStock,
      final double? minStock,
      final double? maxStock,
      final double? reorderPoint,
      final double? unitCost,
      final double? totalValue,
      final DateTime? lastUpdated,
      required final String stockStatus}) = _$InventorySummaryImpl;

  factory _InventorySummary.fromJson(Map<String, dynamic> json) =
      _$InventorySummaryImpl.fromJson;

  @override
  String get id;
  @override
  String get companyId;
  @override
  String get warehouseId;
  @override
  String get productId;
  @override
  String get warehouseName;
  @override
  String get productName;
  @override
  String? get sku;
  @override
  String? get unit;
  @override
  double get currentStock;
  @override
  double get reservedStock;
  @override
  double get availableStock;
  @override
  double? get minStock;
  @override
  double? get maxStock;
  @override
  double? get reorderPoint;
  @override
  double? get unitCost;
  @override
  double? get totalValue;
  @override
  DateTime? get lastUpdated;
  @override
  String get stockStatus;
  @override
  @JsonKey(ignore: true)
  _$$InventorySummaryImplCopyWith<_$InventorySummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

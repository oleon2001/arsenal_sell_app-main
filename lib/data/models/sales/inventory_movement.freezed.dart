// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_movement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InventoryMovement _$InventoryMovementFromJson(Map<String, dynamic> json) {
  return _InventoryMovement.fromJson(json);
}

/// @nodoc
mixin _$InventoryMovement {
  String get id => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String get warehouseId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  InventoryMovementType get movementType => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  double? get unitCost => throw _privateConstructorUsedError;
  double? get totalCost => throw _privateConstructorUsedError;
  String? get referenceId => throw _privateConstructorUsedError;
  String? get referenceType => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryMovementCopyWith<InventoryMovement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryMovementCopyWith<$Res> {
  factory $InventoryMovementCopyWith(
          InventoryMovement value, $Res Function(InventoryMovement) then) =
      _$InventoryMovementCopyWithImpl<$Res, InventoryMovement>;
  @useResult
  $Res call(
      {String id,
      String companyId,
      String warehouseId,
      String productId,
      InventoryMovementType movementType,
      double quantity,
      double? unitCost,
      double? totalCost,
      String? referenceId,
      String? referenceType,
      String? notes,
      String? createdBy,
      DateTime? createdAt});
}

/// @nodoc
class _$InventoryMovementCopyWithImpl<$Res, $Val extends InventoryMovement>
    implements $InventoryMovementCopyWith<$Res> {
  _$InventoryMovementCopyWithImpl(this._value, this._then);

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
    Object? movementType = null,
    Object? quantity = null,
    Object? unitCost = freezed,
    Object? totalCost = freezed,
    Object? referenceId = freezed,
    Object? referenceType = freezed,
    Object? notes = freezed,
    Object? createdBy = freezed,
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
      movementType: null == movementType
          ? _value.movementType
          : movementType // ignore: cast_nullable_to_non_nullable
              as InventoryMovementType,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unitCost: freezed == unitCost
          ? _value.unitCost
          : unitCost // ignore: cast_nullable_to_non_nullable
              as double?,
      totalCost: freezed == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double?,
      referenceId: freezed == referenceId
          ? _value.referenceId
          : referenceId // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceType: freezed == referenceType
          ? _value.referenceType
          : referenceType // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryMovementImplCopyWith<$Res>
    implements $InventoryMovementCopyWith<$Res> {
  factory _$$InventoryMovementImplCopyWith(_$InventoryMovementImpl value,
          $Res Function(_$InventoryMovementImpl) then) =
      __$$InventoryMovementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String companyId,
      String warehouseId,
      String productId,
      InventoryMovementType movementType,
      double quantity,
      double? unitCost,
      double? totalCost,
      String? referenceId,
      String? referenceType,
      String? notes,
      String? createdBy,
      DateTime? createdAt});
}

/// @nodoc
class __$$InventoryMovementImplCopyWithImpl<$Res>
    extends _$InventoryMovementCopyWithImpl<$Res, _$InventoryMovementImpl>
    implements _$$InventoryMovementImplCopyWith<$Res> {
  __$$InventoryMovementImplCopyWithImpl(_$InventoryMovementImpl _value,
      $Res Function(_$InventoryMovementImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? warehouseId = null,
    Object? productId = null,
    Object? movementType = null,
    Object? quantity = null,
    Object? unitCost = freezed,
    Object? totalCost = freezed,
    Object? referenceId = freezed,
    Object? referenceType = freezed,
    Object? notes = freezed,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$InventoryMovementImpl(
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
      movementType: null == movementType
          ? _value.movementType
          : movementType // ignore: cast_nullable_to_non_nullable
              as InventoryMovementType,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unitCost: freezed == unitCost
          ? _value.unitCost
          : unitCost // ignore: cast_nullable_to_non_nullable
              as double?,
      totalCost: freezed == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double?,
      referenceId: freezed == referenceId
          ? _value.referenceId
          : referenceId // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceType: freezed == referenceType
          ? _value.referenceType
          : referenceType // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryMovementImpl implements _InventoryMovement {
  const _$InventoryMovementImpl(
      {required this.id,
      required this.companyId,
      required this.warehouseId,
      required this.productId,
      required this.movementType,
      required this.quantity,
      this.unitCost,
      this.totalCost,
      this.referenceId,
      this.referenceType,
      this.notes,
      this.createdBy,
      this.createdAt});

  factory _$InventoryMovementImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryMovementImplFromJson(json);

  @override
  final String id;
  @override
  final String companyId;
  @override
  final String warehouseId;
  @override
  final String productId;
  @override
  final InventoryMovementType movementType;
  @override
  final double quantity;
  @override
  final double? unitCost;
  @override
  final double? totalCost;
  @override
  final String? referenceId;
  @override
  final String? referenceType;
  @override
  final String? notes;
  @override
  final String? createdBy;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'InventoryMovement(id: $id, companyId: $companyId, warehouseId: $warehouseId, productId: $productId, movementType: $movementType, quantity: $quantity, unitCost: $unitCost, totalCost: $totalCost, referenceId: $referenceId, referenceType: $referenceType, notes: $notes, createdBy: $createdBy, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryMovementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.warehouseId, warehouseId) ||
                other.warehouseId == warehouseId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.movementType, movementType) ||
                other.movementType == movementType) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitCost, unitCost) ||
                other.unitCost == unitCost) &&
            (identical(other.totalCost, totalCost) ||
                other.totalCost == totalCost) &&
            (identical(other.referenceId, referenceId) ||
                other.referenceId == referenceId) &&
            (identical(other.referenceType, referenceType) ||
                other.referenceType == referenceType) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
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
      movementType,
      quantity,
      unitCost,
      totalCost,
      referenceId,
      referenceType,
      notes,
      createdBy,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryMovementImplCopyWith<_$InventoryMovementImpl> get copyWith =>
      __$$InventoryMovementImplCopyWithImpl<_$InventoryMovementImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryMovementImplToJson(
      this,
    );
  }
}

abstract class _InventoryMovement implements InventoryMovement {
  const factory _InventoryMovement(
      {required final String id,
      required final String companyId,
      required final String warehouseId,
      required final String productId,
      required final InventoryMovementType movementType,
      required final double quantity,
      final double? unitCost,
      final double? totalCost,
      final String? referenceId,
      final String? referenceType,
      final String? notes,
      final String? createdBy,
      final DateTime? createdAt}) = _$InventoryMovementImpl;

  factory _InventoryMovement.fromJson(Map<String, dynamic> json) =
      _$InventoryMovementImpl.fromJson;

  @override
  String get id;
  @override
  String get companyId;
  @override
  String get warehouseId;
  @override
  String get productId;
  @override
  InventoryMovementType get movementType;
  @override
  double get quantity;
  @override
  double? get unitCost;
  @override
  double? get totalCost;
  @override
  String? get referenceId;
  @override
  String? get referenceType;
  @override
  String? get notes;
  @override
  String? get createdBy;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$InventoryMovementImplCopyWith<_$InventoryMovementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_transfer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InventoryTransfer _$InventoryTransferFromJson(Map<String, dynamic> json) {
  return _InventoryTransfer.fromJson(json);
}

/// @nodoc
mixin _$InventoryTransfer {
  String get id => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String get fromWarehouseId => throw _privateConstructorUsedError;
  String get toWarehouseId => throw _privateConstructorUsedError;
  TransferStatus get status => throw _privateConstructorUsedError;
  String? get requestedBy => throw _privateConstructorUsedError;
  String? get approvedBy => throw _privateConstructorUsedError;
  String? get shippedBy => throw _privateConstructorUsedError;
  String? get receivedBy => throw _privateConstructorUsedError;
  DateTime? get requestedAt => throw _privateConstructorUsedError;
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  DateTime? get shippedAt => throw _privateConstructorUsedError;
  DateTime? get receivedAt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  List<TransferItem> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryTransferCopyWith<InventoryTransfer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryTransferCopyWith<$Res> {
  factory $InventoryTransferCopyWith(
          InventoryTransfer value, $Res Function(InventoryTransfer) then) =
      _$InventoryTransferCopyWithImpl<$Res, InventoryTransfer>;
  @useResult
  $Res call(
      {String id,
      String companyId,
      String fromWarehouseId,
      String toWarehouseId,
      TransferStatus status,
      String? requestedBy,
      String? approvedBy,
      String? shippedBy,
      String? receivedBy,
      DateTime? requestedAt,
      DateTime? approvedAt,
      DateTime? shippedAt,
      DateTime? receivedAt,
      String? notes,
      DateTime? createdAt,
      List<TransferItem> items});
}

/// @nodoc
class _$InventoryTransferCopyWithImpl<$Res, $Val extends InventoryTransfer>
    implements $InventoryTransferCopyWith<$Res> {
  _$InventoryTransferCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? fromWarehouseId = null,
    Object? toWarehouseId = null,
    Object? status = null,
    Object? requestedBy = freezed,
    Object? approvedBy = freezed,
    Object? shippedBy = freezed,
    Object? receivedBy = freezed,
    Object? requestedAt = freezed,
    Object? approvedAt = freezed,
    Object? shippedAt = freezed,
    Object? receivedAt = freezed,
    Object? notes = freezed,
    Object? createdAt = freezed,
    Object? items = null,
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
      fromWarehouseId: null == fromWarehouseId
          ? _value.fromWarehouseId
          : fromWarehouseId // ignore: cast_nullable_to_non_nullable
              as String,
      toWarehouseId: null == toWarehouseId
          ? _value.toWarehouseId
          : toWarehouseId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TransferStatus,
      requestedBy: freezed == requestedBy
          ? _value.requestedBy
          : requestedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      shippedBy: freezed == shippedBy
          ? _value.shippedBy
          : shippedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      receivedBy: freezed == receivedBy
          ? _value.receivedBy
          : receivedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      requestedAt: freezed == requestedAt
          ? _value.requestedAt
          : requestedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      shippedAt: freezed == shippedAt
          ? _value.shippedAt
          : shippedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      receivedAt: freezed == receivedAt
          ? _value.receivedAt
          : receivedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<TransferItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryTransferImplCopyWith<$Res>
    implements $InventoryTransferCopyWith<$Res> {
  factory _$$InventoryTransferImplCopyWith(_$InventoryTransferImpl value,
          $Res Function(_$InventoryTransferImpl) then) =
      __$$InventoryTransferImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String companyId,
      String fromWarehouseId,
      String toWarehouseId,
      TransferStatus status,
      String? requestedBy,
      String? approvedBy,
      String? shippedBy,
      String? receivedBy,
      DateTime? requestedAt,
      DateTime? approvedAt,
      DateTime? shippedAt,
      DateTime? receivedAt,
      String? notes,
      DateTime? createdAt,
      List<TransferItem> items});
}

/// @nodoc
class __$$InventoryTransferImplCopyWithImpl<$Res>
    extends _$InventoryTransferCopyWithImpl<$Res, _$InventoryTransferImpl>
    implements _$$InventoryTransferImplCopyWith<$Res> {
  __$$InventoryTransferImplCopyWithImpl(_$InventoryTransferImpl _value,
      $Res Function(_$InventoryTransferImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? fromWarehouseId = null,
    Object? toWarehouseId = null,
    Object? status = null,
    Object? requestedBy = freezed,
    Object? approvedBy = freezed,
    Object? shippedBy = freezed,
    Object? receivedBy = freezed,
    Object? requestedAt = freezed,
    Object? approvedAt = freezed,
    Object? shippedAt = freezed,
    Object? receivedAt = freezed,
    Object? notes = freezed,
    Object? createdAt = freezed,
    Object? items = null,
  }) {
    return _then(_$InventoryTransferImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      companyId: null == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String,
      fromWarehouseId: null == fromWarehouseId
          ? _value.fromWarehouseId
          : fromWarehouseId // ignore: cast_nullable_to_non_nullable
              as String,
      toWarehouseId: null == toWarehouseId
          ? _value.toWarehouseId
          : toWarehouseId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TransferStatus,
      requestedBy: freezed == requestedBy
          ? _value.requestedBy
          : requestedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      shippedBy: freezed == shippedBy
          ? _value.shippedBy
          : shippedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      receivedBy: freezed == receivedBy
          ? _value.receivedBy
          : receivedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      requestedAt: freezed == requestedAt
          ? _value.requestedAt
          : requestedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      shippedAt: freezed == shippedAt
          ? _value.shippedAt
          : shippedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      receivedAt: freezed == receivedAt
          ? _value.receivedAt
          : receivedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<TransferItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryTransferImpl implements _InventoryTransfer {
  const _$InventoryTransferImpl(
      {required this.id,
      required this.companyId,
      required this.fromWarehouseId,
      required this.toWarehouseId,
      this.status = TransferStatus.pending,
      this.requestedBy,
      this.approvedBy,
      this.shippedBy,
      this.receivedBy,
      this.requestedAt,
      this.approvedAt,
      this.shippedAt,
      this.receivedAt,
      this.notes,
      this.createdAt,
      final List<TransferItem> items = const []})
      : _items = items;

  factory _$InventoryTransferImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryTransferImplFromJson(json);

  @override
  final String id;
  @override
  final String companyId;
  @override
  final String fromWarehouseId;
  @override
  final String toWarehouseId;
  @override
  @JsonKey()
  final TransferStatus status;
  @override
  final String? requestedBy;
  @override
  final String? approvedBy;
  @override
  final String? shippedBy;
  @override
  final String? receivedBy;
  @override
  final DateTime? requestedAt;
  @override
  final DateTime? approvedAt;
  @override
  final DateTime? shippedAt;
  @override
  final DateTime? receivedAt;
  @override
  final String? notes;
  @override
  final DateTime? createdAt;
  final List<TransferItem> _items;
  @override
  @JsonKey()
  List<TransferItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'InventoryTransfer(id: $id, companyId: $companyId, fromWarehouseId: $fromWarehouseId, toWarehouseId: $toWarehouseId, status: $status, requestedBy: $requestedBy, approvedBy: $approvedBy, shippedBy: $shippedBy, receivedBy: $receivedBy, requestedAt: $requestedAt, approvedAt: $approvedAt, shippedAt: $shippedAt, receivedAt: $receivedAt, notes: $notes, createdAt: $createdAt, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryTransferImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.fromWarehouseId, fromWarehouseId) ||
                other.fromWarehouseId == fromWarehouseId) &&
            (identical(other.toWarehouseId, toWarehouseId) ||
                other.toWarehouseId == toWarehouseId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.requestedBy, requestedBy) ||
                other.requestedBy == requestedBy) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
            (identical(other.shippedBy, shippedBy) ||
                other.shippedBy == shippedBy) &&
            (identical(other.receivedBy, receivedBy) ||
                other.receivedBy == receivedBy) &&
            (identical(other.requestedAt, requestedAt) ||
                other.requestedAt == requestedAt) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.shippedAt, shippedAt) ||
                other.shippedAt == shippedAt) &&
            (identical(other.receivedAt, receivedAt) ||
                other.receivedAt == receivedAt) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      companyId,
      fromWarehouseId,
      toWarehouseId,
      status,
      requestedBy,
      approvedBy,
      shippedBy,
      receivedBy,
      requestedAt,
      approvedAt,
      shippedAt,
      receivedAt,
      notes,
      createdAt,
      const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryTransferImplCopyWith<_$InventoryTransferImpl> get copyWith =>
      __$$InventoryTransferImplCopyWithImpl<_$InventoryTransferImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryTransferImplToJson(
      this,
    );
  }
}

abstract class _InventoryTransfer implements InventoryTransfer {
  const factory _InventoryTransfer(
      {required final String id,
      required final String companyId,
      required final String fromWarehouseId,
      required final String toWarehouseId,
      final TransferStatus status,
      final String? requestedBy,
      final String? approvedBy,
      final String? shippedBy,
      final String? receivedBy,
      final DateTime? requestedAt,
      final DateTime? approvedAt,
      final DateTime? shippedAt,
      final DateTime? receivedAt,
      final String? notes,
      final DateTime? createdAt,
      final List<TransferItem> items}) = _$InventoryTransferImpl;

  factory _InventoryTransfer.fromJson(Map<String, dynamic> json) =
      _$InventoryTransferImpl.fromJson;

  @override
  String get id;
  @override
  String get companyId;
  @override
  String get fromWarehouseId;
  @override
  String get toWarehouseId;
  @override
  TransferStatus get status;
  @override
  String? get requestedBy;
  @override
  String? get approvedBy;
  @override
  String? get shippedBy;
  @override
  String? get receivedBy;
  @override
  DateTime? get requestedAt;
  @override
  DateTime? get approvedAt;
  @override
  DateTime? get shippedAt;
  @override
  DateTime? get receivedAt;
  @override
  String? get notes;
  @override
  DateTime? get createdAt;
  @override
  List<TransferItem> get items;
  @override
  @JsonKey(ignore: true)
  _$$InventoryTransferImplCopyWith<_$InventoryTransferImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TransferItem _$TransferItemFromJson(Map<String, dynamic> json) {
  return _TransferItem.fromJson(json);
}

/// @nodoc
mixin _$TransferItem {
  String get id => throw _privateConstructorUsedError;
  String get transferId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  double? get transferredQuantity => throw _privateConstructorUsedError;
  double? get unitCost => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransferItemCopyWith<TransferItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferItemCopyWith<$Res> {
  factory $TransferItemCopyWith(
          TransferItem value, $Res Function(TransferItem) then) =
      _$TransferItemCopyWithImpl<$Res, TransferItem>;
  @useResult
  $Res call(
      {String id,
      String transferId,
      String productId,
      double quantity,
      double? transferredQuantity,
      double? unitCost,
      String? notes});
}

/// @nodoc
class _$TransferItemCopyWithImpl<$Res, $Val extends TransferItem>
    implements $TransferItemCopyWith<$Res> {
  _$TransferItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? transferId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? transferredQuantity = freezed,
    Object? unitCost = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      transferId: null == transferId
          ? _value.transferId
          : transferId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      transferredQuantity: freezed == transferredQuantity
          ? _value.transferredQuantity
          : transferredQuantity // ignore: cast_nullable_to_non_nullable
              as double?,
      unitCost: freezed == unitCost
          ? _value.unitCost
          : unitCost // ignore: cast_nullable_to_non_nullable
              as double?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransferItemImplCopyWith<$Res>
    implements $TransferItemCopyWith<$Res> {
  factory _$$TransferItemImplCopyWith(
          _$TransferItemImpl value, $Res Function(_$TransferItemImpl) then) =
      __$$TransferItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String transferId,
      String productId,
      double quantity,
      double? transferredQuantity,
      double? unitCost,
      String? notes});
}

/// @nodoc
class __$$TransferItemImplCopyWithImpl<$Res>
    extends _$TransferItemCopyWithImpl<$Res, _$TransferItemImpl>
    implements _$$TransferItemImplCopyWith<$Res> {
  __$$TransferItemImplCopyWithImpl(
      _$TransferItemImpl _value, $Res Function(_$TransferItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? transferId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? transferredQuantity = freezed,
    Object? unitCost = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$TransferItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      transferId: null == transferId
          ? _value.transferId
          : transferId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      transferredQuantity: freezed == transferredQuantity
          ? _value.transferredQuantity
          : transferredQuantity // ignore: cast_nullable_to_non_nullable
              as double?,
      unitCost: freezed == unitCost
          ? _value.unitCost
          : unitCost // ignore: cast_nullable_to_non_nullable
              as double?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransferItemImpl implements _TransferItem {
  const _$TransferItemImpl(
      {required this.id,
      required this.transferId,
      required this.productId,
      required this.quantity,
      this.transferredQuantity,
      this.unitCost,
      this.notes});

  factory _$TransferItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransferItemImplFromJson(json);

  @override
  final String id;
  @override
  final String transferId;
  @override
  final String productId;
  @override
  final double quantity;
  @override
  final double? transferredQuantity;
  @override
  final double? unitCost;
  @override
  final String? notes;

  @override
  String toString() {
    return 'TransferItem(id: $id, transferId: $transferId, productId: $productId, quantity: $quantity, transferredQuantity: $transferredQuantity, unitCost: $unitCost, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.transferId, transferId) ||
                other.transferId == transferId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.transferredQuantity, transferredQuantity) ||
                other.transferredQuantity == transferredQuantity) &&
            (identical(other.unitCost, unitCost) ||
                other.unitCost == unitCost) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, transferId, productId,
      quantity, transferredQuantity, unitCost, notes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferItemImplCopyWith<_$TransferItemImpl> get copyWith =>
      __$$TransferItemImplCopyWithImpl<_$TransferItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransferItemImplToJson(
      this,
    );
  }
}

abstract class _TransferItem implements TransferItem {
  const factory _TransferItem(
      {required final String id,
      required final String transferId,
      required final String productId,
      required final double quantity,
      final double? transferredQuantity,
      final double? unitCost,
      final String? notes}) = _$TransferItemImpl;

  factory _TransferItem.fromJson(Map<String, dynamic> json) =
      _$TransferItemImpl.fromJson;

  @override
  String get id;
  @override
  String get transferId;
  @override
  String get productId;
  @override
  double get quantity;
  @override
  double? get transferredQuantity;
  @override
  double? get unitCost;
  @override
  String? get notes;
  @override
  @JsonKey(ignore: true)
  _$$TransferItemImplCopyWith<_$TransferItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_transfer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventoryTransferImpl _$$InventoryTransferImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryTransferImpl(
      id: json['id'] as String,
      companyId: json['companyId'] as String,
      fromWarehouseId: json['fromWarehouseId'] as String,
      toWarehouseId: json['toWarehouseId'] as String,
      status: $enumDecodeNullable(_$TransferStatusEnumMap, json['status']) ??
          TransferStatus.pending,
      requestedBy: json['requestedBy'] as String?,
      approvedBy: json['approvedBy'] as String?,
      shippedBy: json['shippedBy'] as String?,
      receivedBy: json['receivedBy'] as String?,
      requestedAt: json['requestedAt'] == null
          ? null
          : DateTime.parse(json['requestedAt'] as String),
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
      shippedAt: json['shippedAt'] == null
          ? null
          : DateTime.parse(json['shippedAt'] as String),
      receivedAt: json['receivedAt'] == null
          ? null
          : DateTime.parse(json['receivedAt'] as String),
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => TransferItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$InventoryTransferImplToJson(
        _$InventoryTransferImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'fromWarehouseId': instance.fromWarehouseId,
      'toWarehouseId': instance.toWarehouseId,
      'status': _$TransferStatusEnumMap[instance.status]!,
      'requestedBy': instance.requestedBy,
      'approvedBy': instance.approvedBy,
      'shippedBy': instance.shippedBy,
      'receivedBy': instance.receivedBy,
      'requestedAt': instance.requestedAt?.toIso8601String(),
      'approvedAt': instance.approvedAt?.toIso8601String(),
      'shippedAt': instance.shippedAt?.toIso8601String(),
      'receivedAt': instance.receivedAt?.toIso8601String(),
      'notes': instance.notes,
      'createdAt': instance.createdAt?.toIso8601String(),
      'items': instance.items,
    };

const _$TransferStatusEnumMap = {
  TransferStatus.pending: 'PENDING',
  TransferStatus.inTransit: 'IN_TRANSIT',
  TransferStatus.completed: 'COMPLETED',
  TransferStatus.cancelled: 'CANCELLED',
};

_$TransferItemImpl _$$TransferItemImplFromJson(Map<String, dynamic> json) =>
    _$TransferItemImpl(
      id: json['id'] as String,
      transferId: json['transferId'] as String,
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      transferredQuantity: (json['transferredQuantity'] as num?)?.toDouble(),
      unitCost: (json['unitCost'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$TransferItemImplToJson(_$TransferItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transferId': instance.transferId,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'transferredQuantity': instance.transferredQuantity,
      'unitCost': instance.unitCost,
      'notes': instance.notes,
    };

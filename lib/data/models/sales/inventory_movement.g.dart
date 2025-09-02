// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_movement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventoryMovementImpl _$$InventoryMovementImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryMovementImpl(
      id: json['id'] as String,
      companyId: json['companyId'] as String,
      warehouseId: json['warehouseId'] as String,
      productId: json['productId'] as String,
      movementType:
          $enumDecode(_$InventoryMovementTypeEnumMap, json['movementType']),
      quantity: (json['quantity'] as num).toDouble(),
      unitCost: (json['unitCost'] as num?)?.toDouble(),
      totalCost: (json['totalCost'] as num?)?.toDouble(),
      referenceId: json['referenceId'] as String?,
      referenceType: json['referenceType'] as String?,
      notes: json['notes'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$InventoryMovementImplToJson(
        _$InventoryMovementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'warehouseId': instance.warehouseId,
      'productId': instance.productId,
      'movementType': _$InventoryMovementTypeEnumMap[instance.movementType]!,
      'quantity': instance.quantity,
      'unitCost': instance.unitCost,
      'totalCost': instance.totalCost,
      'referenceId': instance.referenceId,
      'referenceType': instance.referenceType,
      'notes': instance.notes,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$InventoryMovementTypeEnumMap = {
  InventoryMovementType.purchase: 'PURCHASE',
  InventoryMovementType.sale: 'SALE',
  InventoryMovementType.adjustment: 'ADJUSTMENT',
  InventoryMovementType.transferIn: 'TRANSFER_IN',
  InventoryMovementType.transferOut: 'TRANSFER_OUT',
  InventoryMovementType.return_: 'RETURN',
  InventoryMovementType.damaged: 'DAMAGED',
  InventoryMovementType.expired: 'EXPIRED',
  InventoryMovementType.loss: 'LOSS',
  InventoryMovementType.initial: 'INITIAL',
};

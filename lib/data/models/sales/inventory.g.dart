// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventoryImpl _$$InventoryImplFromJson(Map<String, dynamic> json) =>
    _$InventoryImpl(
      id: json['id'] as String,
      companyId: json['companyId'] as String,
      warehouseId: json['warehouseId'] as String,
      productId: json['productId'] as String,
      currentStock: (json['currentStock'] as num).toDouble(),
      reservedStock: (json['reservedStock'] as num).toDouble(),
      availableStock: (json['availableStock'] as num?)?.toDouble(),
      minStock: (json['minStock'] as num?)?.toDouble(),
      maxStock: (json['maxStock'] as num?)?.toDouble(),
      reorderPoint: (json['reorderPoint'] as num?)?.toDouble(),
      unitCost: (json['unitCost'] as num?)?.toDouble(),
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$InventoryImplToJson(_$InventoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'warehouseId': instance.warehouseId,
      'productId': instance.productId,
      'currentStock': instance.currentStock,
      'reservedStock': instance.reservedStock,
      'availableStock': instance.availableStock,
      'minStock': instance.minStock,
      'maxStock': instance.maxStock,
      'reorderPoint': instance.reorderPoint,
      'unitCost': instance.unitCost,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_$InventorySummaryImpl _$$InventorySummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$InventorySummaryImpl(
      id: json['id'] as String,
      companyId: json['companyId'] as String,
      warehouseId: json['warehouseId'] as String,
      productId: json['productId'] as String,
      warehouseName: json['warehouseName'] as String,
      productName: json['productName'] as String,
      sku: json['sku'] as String?,
      unit: json['unit'] as String?,
      currentStock: (json['currentStock'] as num).toDouble(),
      reservedStock: (json['reservedStock'] as num).toDouble(),
      availableStock: (json['availableStock'] as num).toDouble(),
      minStock: (json['minStock'] as num?)?.toDouble(),
      maxStock: (json['maxStock'] as num?)?.toDouble(),
      reorderPoint: (json['reorderPoint'] as num?)?.toDouble(),
      unitCost: (json['unitCost'] as num?)?.toDouble(),
      totalValue: (json['totalValue'] as num?)?.toDouble(),
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
      stockStatus: json['stockStatus'] as String,
    );

Map<String, dynamic> _$$InventorySummaryImplToJson(
        _$InventorySummaryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'warehouseId': instance.warehouseId,
      'productId': instance.productId,
      'warehouseName': instance.warehouseName,
      'productName': instance.productName,
      'sku': instance.sku,
      'unit': instance.unit,
      'currentStock': instance.currentStock,
      'reservedStock': instance.reservedStock,
      'availableStock': instance.availableStock,
      'minStock': instance.minStock,
      'maxStock': instance.maxStock,
      'reorderPoint': instance.reorderPoint,
      'unitCost': instance.unitCost,
      'totalValue': instance.totalValue,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
      'stockStatus': instance.stockStatus,
    };

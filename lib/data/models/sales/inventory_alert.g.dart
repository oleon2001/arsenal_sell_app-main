// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_alert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventoryAlertImpl _$$InventoryAlertImplFromJson(Map<String, dynamic> json) =>
    _$InventoryAlertImpl(
      id: json['id'] as String,
      companyId: json['companyId'] as String,
      warehouseId: json['warehouseId'] as String,
      productId: json['productId'] as String,
      alertType: $enumDecode(_$AlertTypeEnumMap, json['alertType']),
      threshold: (json['threshold'] as num?)?.toDouble(),
      currentValue: (json['currentValue'] as num?)?.toDouble(),
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      resolvedAt: json['resolvedAt'] == null
          ? null
          : DateTime.parse(json['resolvedAt'] as String),
      resolvedBy: json['resolvedBy'] as String?,
    );

Map<String, dynamic> _$$InventoryAlertImplToJson(
        _$InventoryAlertImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'warehouseId': instance.warehouseId,
      'productId': instance.productId,
      'alertType': _$AlertTypeEnumMap[instance.alertType]!,
      'threshold': instance.threshold,
      'currentValue': instance.currentValue,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'resolvedAt': instance.resolvedAt?.toIso8601String(),
      'resolvedBy': instance.resolvedBy,
    };

const _$AlertTypeEnumMap = {
  AlertType.lowStock: 'LOW_STOCK',
  AlertType.outOfStock: 'OUT_OF_STOCK',
  AlertType.overstock: 'OVERSTOCK',
  AlertType.expiringSoon: 'EXPIRING_SOON',
};

_$ProductAlertConfigImpl _$$ProductAlertConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductAlertConfigImpl(
      id: json['id'] as String,
      companyId: json['companyId'] as String,
      productId: json['productId'] as String,
      lowStockThreshold:
          (json['lowStockThreshold'] as num?)?.toDouble() ?? 10.0,
      outOfStockThreshold:
          (json['outOfStockThreshold'] as num?)?.toDouble() ?? 0.0,
      overstockThreshold: (json['overstockThreshold'] as num?)?.toDouble(),
      expiringDaysThreshold:
          (json['expiringDaysThreshold'] as num?)?.toInt() ?? 30,
      enableLowStockAlert: json['enableLowStockAlert'] as bool? ?? true,
      enableOutOfStockAlert: json['enableOutOfStockAlert'] as bool? ?? true,
      enableOverstockAlert: json['enableOverstockAlert'] as bool? ?? false,
      enableExpiringAlert: json['enableExpiringAlert'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ProductAlertConfigImplToJson(
        _$ProductAlertConfigImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'productId': instance.productId,
      'lowStockThreshold': instance.lowStockThreshold,
      'outOfStockThreshold': instance.outOfStockThreshold,
      'overstockThreshold': instance.overstockThreshold,
      'expiringDaysThreshold': instance.expiringDaysThreshold,
      'enableLowStockAlert': instance.enableLowStockAlert,
      'enableOutOfStockAlert': instance.enableOutOfStockAlert,
      'enableOverstockAlert': instance.enableOverstockAlert,
      'enableExpiringAlert': instance.enableExpiringAlert,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

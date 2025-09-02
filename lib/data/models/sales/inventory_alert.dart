import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_alert.freezed.dart';
part 'inventory_alert.g.dart';

enum AlertType {
  @JsonValue('LOW_STOCK')
  lowStock,
  @JsonValue('OUT_OF_STOCK')
  outOfStock,
  @JsonValue('OVERSTOCK')
  overstock,
  @JsonValue('EXPIRING_SOON')
  expiringSoon,
}

@freezed
class InventoryAlert with _$InventoryAlert {
  const factory InventoryAlert({
    required String id,
    required String companyId,
    required String warehouseId,
    required String productId,
    required AlertType alertType,
    double? threshold,
    double? currentValue,
    @Default(true) bool isActive,
    DateTime? createdAt,
    DateTime? resolvedAt,
    String? resolvedBy,
  }) = _InventoryAlert;

  factory InventoryAlert.fromJson(Map<String, dynamic> json) =>
      _$InventoryAlertFromJson(json);
}

@freezed
class ProductAlertConfig with _$ProductAlertConfig {
  const factory ProductAlertConfig({
    required String id,
    required String companyId,
    required String productId,
    @Default(10.0) double lowStockThreshold,
    @Default(0.0) double outOfStockThreshold,
    double? overstockThreshold,
    @Default(30) int expiringDaysThreshold,
    @Default(true) bool enableLowStockAlert,
    @Default(true) bool enableOutOfStockAlert,
    @Default(false) bool enableOverstockAlert,
    @Default(true) bool enableExpiringAlert,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ProductAlertConfig;

  factory ProductAlertConfig.fromJson(Map<String, dynamic> json) =>
      _$ProductAlertConfigFromJson(json);
}

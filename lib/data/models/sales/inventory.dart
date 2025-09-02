import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory.freezed.dart';
part 'inventory.g.dart';

@freezed
class Inventory with _$Inventory {
  const factory Inventory({
    required String id,
    required String companyId,
    required String warehouseId,
    required String productId,
    required double currentStock,
    required double reservedStock,
    double? availableStock,
    double? minStock,
    double? maxStock,
    double? reorderPoint,
    double? unitCost,
    DateTime? lastUpdated,
    DateTime? createdAt,
  }) = _Inventory;

  factory Inventory.fromJson(Map<String, dynamic> json) =>
      _$InventoryFromJson(json);
}

@freezed
class InventorySummary with _$InventorySummary {
  const factory InventorySummary({
    required String id,
    required String companyId,
    required String warehouseId,
    required String productId,
    required String warehouseName,
    required String productName,
    String? sku,
    String? unit,
    required double currentStock,
    required double reservedStock,
    required double availableStock,
    double? minStock,
    double? maxStock,
    double? reorderPoint,
    double? unitCost,
    double? totalValue,
    DateTime? lastUpdated,
    required String stockStatus,
  }) = _InventorySummary;

  factory InventorySummary.fromJson(Map<String, dynamic> json) =>
      _$InventorySummaryFromJson(json);
}

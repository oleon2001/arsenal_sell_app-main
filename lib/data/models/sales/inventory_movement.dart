import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_movement.freezed.dart';
part 'inventory_movement.g.dart';

enum InventoryMovementType {
  @JsonValue('PURCHASE')
  purchase,
  @JsonValue('SALE')
  sale,
  @JsonValue('ADJUSTMENT')
  adjustment,
  @JsonValue('TRANSFER_IN')
  transferIn,
  @JsonValue('TRANSFER_OUT')
  transferOut,
  @JsonValue('RETURN')
  return_,
  @JsonValue('DAMAGED')
  damaged,
  @JsonValue('EXPIRED')
  expired,
  @JsonValue('LOSS')
  loss,
  @JsonValue('INITIAL')
  initial,
}

@freezed
class InventoryMovement with _$InventoryMovement {
  const factory InventoryMovement({
    required String id,
    required String companyId,
    required String warehouseId,
    required String productId,
    required InventoryMovementType movementType,
    required double quantity,
    double? unitCost,
    double? totalCost,
    String? referenceId,
    String? referenceType,
    String? notes,
    String? createdBy,
    DateTime? createdAt,
  }) = _InventoryMovement;

  factory InventoryMovement.fromJson(Map<String, dynamic> json) =>
      _$InventoryMovementFromJson(json);
}

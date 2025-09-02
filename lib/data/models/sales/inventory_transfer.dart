import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_transfer.freezed.dart';
part 'inventory_transfer.g.dart';

enum TransferStatus {
  @JsonValue('PENDING')
  pending,
  @JsonValue('IN_TRANSIT')
  inTransit,
  @JsonValue('COMPLETED')
  completed,
  @JsonValue('CANCELLED')
  cancelled,
}

@freezed
class InventoryTransfer with _$InventoryTransfer {
  const factory InventoryTransfer({
    required String id,
    required String companyId,
    required String fromWarehouseId,
    required String toWarehouseId,
    @Default(TransferStatus.pending) TransferStatus status,
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
    @Default([]) List<TransferItem> items,
  }) = _InventoryTransfer;

  factory InventoryTransfer.fromJson(Map<String, dynamic> json) =>
      _$InventoryTransferFromJson(json);
}

@freezed
class TransferItem with _$TransferItem {
  const factory TransferItem({
    required String id,
    required String transferId,
    required String productId,
    required double quantity,
    double? transferredQuantity,
    double? unitCost,
    String? notes,
  }) = _TransferItem;

  factory TransferItem.fromJson(Map<String, dynamic> json) =>
      _$TransferItemFromJson(json);
}

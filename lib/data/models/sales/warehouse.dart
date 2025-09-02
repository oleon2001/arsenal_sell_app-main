import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse.freezed.dart';
part 'warehouse.g.dart';

@freezed
class Warehouse with _$Warehouse {
  const factory Warehouse({
    required String id,
    required String companyId,
    required String name,
    String? address,
    double? latitude,
    double? longitude,
    DateTime? createdAt,
  }) = _Warehouse;

  factory Warehouse.fromJson(Map<String, dynamic> json) =>
      _$WarehouseFromJson(json);
}

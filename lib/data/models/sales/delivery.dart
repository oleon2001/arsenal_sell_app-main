import 'package:freezed_annotation/freezed_annotation.dart';

part 'delivery.freezed.dart';
part 'delivery.g.dart';

enum DeliveryStatus {
  @JsonValue('PENDING')
  pending,
  @JsonValue('PARTIAL')
  partial,
  @JsonValue('DELIVERED')
  delivered,
  @JsonValue('REJECTED')
  rejected,
}

@freezed
class Delivery with _$Delivery {
  const factory Delivery({
    required String id,
    required String orderId,
    @Default(DeliveryStatus.pending) DeliveryStatus status,
    DateTime? deliveredAt,
    String? notes,
  }) = _Delivery;

  factory Delivery.fromJson(Map<String, dynamic> json) =>
      _$DeliveryFromJson(json);
}

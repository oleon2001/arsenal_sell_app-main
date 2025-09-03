import 'package:freezed_annotation/freezed_annotation.dart';

part 'return.freezed.dart';
part 'return.g.dart';

@freezed
class Return with _$Return {
  const factory Return({
    required String id,
    String? orderId,
    String? productId,
    required double qty,
    String? reason,
    DateTime? createdAt,
  }) = _Return;

  factory Return.fromJson(Map<String, dynamic> json) =>
      _$ReturnFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'form_response.freezed.dart';
part 'form_response.g.dart';

@freezed
class FormResponse with _$FormResponse {
  const factory FormResponse({
    required String id,
    String? templateId,
    String? customerId,
    String? visitId,
    String? userId,
    required Map<String, dynamic> answers,
    DateTime? createdAt,
  }) = _FormResponse;

  factory FormResponse.fromJson(Map<String, dynamic> json) =>
      _$FormResponseFromJson(json);
}

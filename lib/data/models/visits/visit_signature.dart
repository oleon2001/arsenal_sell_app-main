import 'package:freezed_annotation/freezed_annotation.dart';

part 'visit_signature.freezed.dart';
part 'visit_signature.g.dart';

@freezed
class VisitSignature with _$VisitSignature {
  const factory VisitSignature({
    required String id,
    required String visitId,
    required String storagePath,
    String? signedBy,
    DateTime? createdAt,
  }) = _VisitSignature;

  factory VisitSignature.fromJson(Map<String, dynamic> json) =>
      _$VisitSignatureFromJson(json);
}

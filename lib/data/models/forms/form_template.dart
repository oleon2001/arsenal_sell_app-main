import 'package:freezed_annotation/freezed_annotation.dart';

part 'form_template.freezed.dart';
part 'form_template.g.dart';

@freezed
class FormTemplate with _$FormTemplate {
  const factory FormTemplate({
    required String id,
    required String companyId,
    required String name,
    required Map<String, dynamic> schema,
    DateTime? createdAt,
  }) = _FormTemplate;

  factory FormTemplate.fromJson(Map<String, dynamic> json) =>
      _$FormTemplateFromJson(json);
}

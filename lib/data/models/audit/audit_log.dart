import 'package:freezed_annotation/freezed_annotation.dart';

part 'audit_log.freezed.dart';
part 'audit_log.g.dart';

@freezed
class AuditLog with _$AuditLog {
  const factory AuditLog({
    required int id,
    required String companyId,
    String? actorId,
    required String action,
    String? entity,
    String? entityId,
    Map<String, dynamic>? details,
    DateTime? createdAt,
  }) = _AuditLog;

  factory AuditLog.fromJson(Map<String, dynamic> json) =>
      _$AuditLogFromJson(json);
}

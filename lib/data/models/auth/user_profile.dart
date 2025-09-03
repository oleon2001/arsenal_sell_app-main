import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

enum UserRole {
  @JsonValue('ADMIN')
  admin,
  @JsonValue('SUPERVISOR')
  supervisor,
  @JsonValue('VENDEDOR')
  vendedor,
  @JsonValue('REPARTIDOR')
  repartidor
}

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    @JsonKey(name: 'company_id') String? companyId,
    @JsonKey(name: 'full_name') String? fullName,
    String? phone,
    String? email,
    @Default(UserRole.vendedor) UserRole role,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}

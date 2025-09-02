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
    String? companyId,
    String? fullName,
    String? phone,
    String? email,
    @Default(UserRole.vendedor) UserRole role,
    @Default(true) bool isActive,
    DateTime? createdAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}

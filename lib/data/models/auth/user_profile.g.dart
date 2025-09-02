// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: json['id'] as String,
      companyId: json['companyId'] as String?,
      fullName: json['fullName'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      role: $enumDecodeNullable(_$UserRoleEnumMap, json['role']) ??
          UserRole.vendedor,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'fullName': instance.fullName,
      'phone': instance.phone,
      'email': instance.email,
      'role': _$UserRoleEnumMap[instance.role]!,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$UserRoleEnumMap = {
  UserRole.admin: 'ADMIN',
  UserRole.supervisor: 'SUPERVISOR',
  UserRole.vendedor: 'VENDEDOR',
  UserRole.repartidor: 'REPARTIDOR',
};

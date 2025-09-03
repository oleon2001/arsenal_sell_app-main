// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: json['id'] as String,
      companyId: json['company_id'] as String?,
      fullName: json['full_name'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      role: $enumDecodeNullable(_$UserRoleEnumMap, json['role']) ??
          UserRole.vendedor,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company_id': instance.companyId,
      'full_name': instance.fullName,
      'phone': instance.phone,
      'email': instance.email,
      'role': _$UserRoleEnumMap[instance.role]!,
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
    };

const _$UserRoleEnumMap = {
  UserRole.admin: 'ADMIN',
  UserRole.supervisor: 'SUPERVISOR',
  UserRole.vendedor: 'VENDEDOR',
  UserRole.repartidor: 'REPARTIDOR',
};

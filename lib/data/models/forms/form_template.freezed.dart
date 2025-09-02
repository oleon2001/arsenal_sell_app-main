// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form_template.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FormTemplate _$FormTemplateFromJson(Map<String, dynamic> json) {
  return _FormTemplate.fromJson(json);
}

/// @nodoc
mixin _$FormTemplate {
  String get id => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Map<String, dynamic> get schema => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FormTemplateCopyWith<FormTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FormTemplateCopyWith<$Res> {
  factory $FormTemplateCopyWith(
          FormTemplate value, $Res Function(FormTemplate) then) =
      _$FormTemplateCopyWithImpl<$Res, FormTemplate>;
  @useResult
  $Res call(
      {String id,
      String companyId,
      String name,
      Map<String, dynamic> schema,
      DateTime? createdAt});
}

/// @nodoc
class _$FormTemplateCopyWithImpl<$Res, $Val extends FormTemplate>
    implements $FormTemplateCopyWith<$Res> {
  _$FormTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? name = null,
    Object? schema = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      companyId: null == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FormTemplateImplCopyWith<$Res>
    implements $FormTemplateCopyWith<$Res> {
  factory _$$FormTemplateImplCopyWith(
          _$FormTemplateImpl value, $Res Function(_$FormTemplateImpl) then) =
      __$$FormTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String companyId,
      String name,
      Map<String, dynamic> schema,
      DateTime? createdAt});
}

/// @nodoc
class __$$FormTemplateImplCopyWithImpl<$Res>
    extends _$FormTemplateCopyWithImpl<$Res, _$FormTemplateImpl>
    implements _$$FormTemplateImplCopyWith<$Res> {
  __$$FormTemplateImplCopyWithImpl(
      _$FormTemplateImpl _value, $Res Function(_$FormTemplateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyId = null,
    Object? name = null,
    Object? schema = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$FormTemplateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      companyId: null == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      schema: null == schema
          ? _value._schema
          : schema // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FormTemplateImpl implements _FormTemplate {
  const _$FormTemplateImpl(
      {required this.id,
      required this.companyId,
      required this.name,
      required final Map<String, dynamic> schema,
      this.createdAt})
      : _schema = schema;

  factory _$FormTemplateImpl.fromJson(Map<String, dynamic> json) =>
      _$$FormTemplateImplFromJson(json);

  @override
  final String id;
  @override
  final String companyId;
  @override
  final String name;
  final Map<String, dynamic> _schema;
  @override
  Map<String, dynamic> get schema {
    if (_schema is EqualUnmodifiableMapView) return _schema;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_schema);
  }

  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'FormTemplate(id: $id, companyId: $companyId, name: $name, schema: $schema, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FormTemplateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._schema, _schema) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, companyId, name,
      const DeepCollectionEquality().hash(_schema), createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FormTemplateImplCopyWith<_$FormTemplateImpl> get copyWith =>
      __$$FormTemplateImplCopyWithImpl<_$FormTemplateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FormTemplateImplToJson(
      this,
    );
  }
}

abstract class _FormTemplate implements FormTemplate {
  const factory _FormTemplate(
      {required final String id,
      required final String companyId,
      required final String name,
      required final Map<String, dynamic> schema,
      final DateTime? createdAt}) = _$FormTemplateImpl;

  factory _FormTemplate.fromJson(Map<String, dynamic> json) =
      _$FormTemplateImpl.fromJson;

  @override
  String get id;
  @override
  String get companyId;
  @override
  String get name;
  @override
  Map<String, dynamic> get schema;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$FormTemplateImplCopyWith<_$FormTemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

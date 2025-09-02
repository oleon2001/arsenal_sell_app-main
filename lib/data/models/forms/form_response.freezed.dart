// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FormResponse _$FormResponseFromJson(Map<String, dynamic> json) {
  return _FormResponse.fromJson(json);
}

/// @nodoc
mixin _$FormResponse {
  String get id => throw _privateConstructorUsedError;
  String? get templateId => throw _privateConstructorUsedError;
  String? get customerId => throw _privateConstructorUsedError;
  String? get visitId => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  Map<String, dynamic> get answers => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FormResponseCopyWith<FormResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FormResponseCopyWith<$Res> {
  factory $FormResponseCopyWith(
          FormResponse value, $Res Function(FormResponse) then) =
      _$FormResponseCopyWithImpl<$Res, FormResponse>;
  @useResult
  $Res call(
      {String id,
      String? templateId,
      String? customerId,
      String? visitId,
      String? userId,
      Map<String, dynamic> answers,
      DateTime? createdAt});
}

/// @nodoc
class _$FormResponseCopyWithImpl<$Res, $Val extends FormResponse>
    implements $FormResponseCopyWith<$Res> {
  _$FormResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? templateId = freezed,
    Object? customerId = freezed,
    Object? visitId = freezed,
    Object? userId = freezed,
    Object? answers = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      templateId: freezed == templateId
          ? _value.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String?,
      visitId: freezed == visitId
          ? _value.visitId
          : visitId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      answers: null == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FormResponseImplCopyWith<$Res>
    implements $FormResponseCopyWith<$Res> {
  factory _$$FormResponseImplCopyWith(
          _$FormResponseImpl value, $Res Function(_$FormResponseImpl) then) =
      __$$FormResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? templateId,
      String? customerId,
      String? visitId,
      String? userId,
      Map<String, dynamic> answers,
      DateTime? createdAt});
}

/// @nodoc
class __$$FormResponseImplCopyWithImpl<$Res>
    extends _$FormResponseCopyWithImpl<$Res, _$FormResponseImpl>
    implements _$$FormResponseImplCopyWith<$Res> {
  __$$FormResponseImplCopyWithImpl(
      _$FormResponseImpl _value, $Res Function(_$FormResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? templateId = freezed,
    Object? customerId = freezed,
    Object? visitId = freezed,
    Object? userId = freezed,
    Object? answers = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$FormResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      templateId: freezed == templateId
          ? _value.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String?,
      visitId: freezed == visitId
          ? _value.visitId
          : visitId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      answers: null == answers
          ? _value._answers
          : answers // ignore: cast_nullable_to_non_nullable
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
class _$FormResponseImpl implements _FormResponse {
  const _$FormResponseImpl(
      {required this.id,
      this.templateId,
      this.customerId,
      this.visitId,
      this.userId,
      required final Map<String, dynamic> answers,
      this.createdAt})
      : _answers = answers;

  factory _$FormResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$FormResponseImplFromJson(json);

  @override
  final String id;
  @override
  final String? templateId;
  @override
  final String? customerId;
  @override
  final String? visitId;
  @override
  final String? userId;
  final Map<String, dynamic> _answers;
  @override
  Map<String, dynamic> get answers {
    if (_answers is EqualUnmodifiableMapView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_answers);
  }

  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'FormResponse(id: $id, templateId: $templateId, customerId: $customerId, visitId: $visitId, userId: $userId, answers: $answers, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FormResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.templateId, templateId) ||
                other.templateId == templateId) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.visitId, visitId) || other.visitId == visitId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality().equals(other._answers, _answers) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      templateId,
      customerId,
      visitId,
      userId,
      const DeepCollectionEquality().hash(_answers),
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FormResponseImplCopyWith<_$FormResponseImpl> get copyWith =>
      __$$FormResponseImplCopyWithImpl<_$FormResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FormResponseImplToJson(
      this,
    );
  }
}

abstract class _FormResponse implements FormResponse {
  const factory _FormResponse(
      {required final String id,
      final String? templateId,
      final String? customerId,
      final String? visitId,
      final String? userId,
      required final Map<String, dynamic> answers,
      final DateTime? createdAt}) = _$FormResponseImpl;

  factory _FormResponse.fromJson(Map<String, dynamic> json) =
      _$FormResponseImpl.fromJson;

  @override
  String get id;
  @override
  String? get templateId;
  @override
  String? get customerId;
  @override
  String? get visitId;
  @override
  String? get userId;
  @override
  Map<String, dynamic> get answers;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$FormResponseImplCopyWith<_$FormResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

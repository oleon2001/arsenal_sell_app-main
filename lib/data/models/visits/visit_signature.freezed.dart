// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visit_signature.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VisitSignature _$VisitSignatureFromJson(Map<String, dynamic> json) {
  return _VisitSignature.fromJson(json);
}

/// @nodoc
mixin _$VisitSignature {
  String get id => throw _privateConstructorUsedError;
  String get visitId => throw _privateConstructorUsedError;
  String get storagePath => throw _privateConstructorUsedError;
  String? get signedBy => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VisitSignatureCopyWith<VisitSignature> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisitSignatureCopyWith<$Res> {
  factory $VisitSignatureCopyWith(
          VisitSignature value, $Res Function(VisitSignature) then) =
      _$VisitSignatureCopyWithImpl<$Res, VisitSignature>;
  @useResult
  $Res call(
      {String id,
      String visitId,
      String storagePath,
      String? signedBy,
      DateTime? createdAt});
}

/// @nodoc
class _$VisitSignatureCopyWithImpl<$Res, $Val extends VisitSignature>
    implements $VisitSignatureCopyWith<$Res> {
  _$VisitSignatureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? visitId = null,
    Object? storagePath = null,
    Object? signedBy = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      visitId: null == visitId
          ? _value.visitId
          : visitId // ignore: cast_nullable_to_non_nullable
              as String,
      storagePath: null == storagePath
          ? _value.storagePath
          : storagePath // ignore: cast_nullable_to_non_nullable
              as String,
      signedBy: freezed == signedBy
          ? _value.signedBy
          : signedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VisitSignatureImplCopyWith<$Res>
    implements $VisitSignatureCopyWith<$Res> {
  factory _$$VisitSignatureImplCopyWith(_$VisitSignatureImpl value,
          $Res Function(_$VisitSignatureImpl) then) =
      __$$VisitSignatureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String visitId,
      String storagePath,
      String? signedBy,
      DateTime? createdAt});
}

/// @nodoc
class __$$VisitSignatureImplCopyWithImpl<$Res>
    extends _$VisitSignatureCopyWithImpl<$Res, _$VisitSignatureImpl>
    implements _$$VisitSignatureImplCopyWith<$Res> {
  __$$VisitSignatureImplCopyWithImpl(
      _$VisitSignatureImpl _value, $Res Function(_$VisitSignatureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? visitId = null,
    Object? storagePath = null,
    Object? signedBy = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$VisitSignatureImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      visitId: null == visitId
          ? _value.visitId
          : visitId // ignore: cast_nullable_to_non_nullable
              as String,
      storagePath: null == storagePath
          ? _value.storagePath
          : storagePath // ignore: cast_nullable_to_non_nullable
              as String,
      signedBy: freezed == signedBy
          ? _value.signedBy
          : signedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VisitSignatureImpl implements _VisitSignature {
  const _$VisitSignatureImpl(
      {required this.id,
      required this.visitId,
      required this.storagePath,
      this.signedBy,
      this.createdAt});

  factory _$VisitSignatureImpl.fromJson(Map<String, dynamic> json) =>
      _$$VisitSignatureImplFromJson(json);

  @override
  final String id;
  @override
  final String visitId;
  @override
  final String storagePath;
  @override
  final String? signedBy;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'VisitSignature(id: $id, visitId: $visitId, storagePath: $storagePath, signedBy: $signedBy, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VisitSignatureImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.visitId, visitId) || other.visitId == visitId) &&
            (identical(other.storagePath, storagePath) ||
                other.storagePath == storagePath) &&
            (identical(other.signedBy, signedBy) ||
                other.signedBy == signedBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, visitId, storagePath, signedBy, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VisitSignatureImplCopyWith<_$VisitSignatureImpl> get copyWith =>
      __$$VisitSignatureImplCopyWithImpl<_$VisitSignatureImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VisitSignatureImplToJson(
      this,
    );
  }
}

abstract class _VisitSignature implements VisitSignature {
  const factory _VisitSignature(
      {required final String id,
      required final String visitId,
      required final String storagePath,
      final String? signedBy,
      final DateTime? createdAt}) = _$VisitSignatureImpl;

  factory _VisitSignature.fromJson(Map<String, dynamic> json) =
      _$VisitSignatureImpl.fromJson;

  @override
  String get id;
  @override
  String get visitId;
  @override
  String get storagePath;
  @override
  String? get signedBy;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$VisitSignatureImplCopyWith<_$VisitSignatureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

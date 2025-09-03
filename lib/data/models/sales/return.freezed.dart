// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'return.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Return _$ReturnFromJson(Map<String, dynamic> json) {
  return _Return.fromJson(json);
}

/// @nodoc
mixin _$Return {
  String get id => throw _privateConstructorUsedError;
  String? get orderId => throw _privateConstructorUsedError;
  String? get productId => throw _privateConstructorUsedError;
  double get qty => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReturnCopyWith<Return> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReturnCopyWith<$Res> {
  factory $ReturnCopyWith(Return value, $Res Function(Return) then) =
      _$ReturnCopyWithImpl<$Res, Return>;
  @useResult
  $Res call(
      {String id,
      String? orderId,
      String? productId,
      double qty,
      String? reason,
      DateTime? createdAt});
}

/// @nodoc
class _$ReturnCopyWithImpl<$Res, $Val extends Return>
    implements $ReturnCopyWith<$Res> {
  _$ReturnCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderId = freezed,
    Object? productId = freezed,
    Object? qty = null,
    Object? reason = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String?,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
      qty: null == qty
          ? _value.qty
          : qty // ignore: cast_nullable_to_non_nullable
              as double,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReturnImplCopyWith<$Res> implements $ReturnCopyWith<$Res> {
  factory _$$ReturnImplCopyWith(
          _$ReturnImpl value, $Res Function(_$ReturnImpl) then) =
      __$$ReturnImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? orderId,
      String? productId,
      double qty,
      String? reason,
      DateTime? createdAt});
}

/// @nodoc
class __$$ReturnImplCopyWithImpl<$Res>
    extends _$ReturnCopyWithImpl<$Res, _$ReturnImpl>
    implements _$$ReturnImplCopyWith<$Res> {
  __$$ReturnImplCopyWithImpl(
      _$ReturnImpl _value, $Res Function(_$ReturnImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderId = freezed,
    Object? productId = freezed,
    Object? qty = null,
    Object? reason = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$ReturnImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String?,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
      qty: null == qty
          ? _value.qty
          : qty // ignore: cast_nullable_to_non_nullable
              as double,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
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
class _$ReturnImpl implements _Return {
  const _$ReturnImpl(
      {required this.id,
      this.orderId,
      this.productId,
      required this.qty,
      this.reason,
      this.createdAt});

  factory _$ReturnImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReturnImplFromJson(json);

  @override
  final String id;
  @override
  final String? orderId;
  @override
  final String? productId;
  @override
  final double qty;
  @override
  final String? reason;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Return(id: $id, orderId: $orderId, productId: $productId, qty: $qty, reason: $reason, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReturnImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.qty, qty) || other.qty == qty) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, orderId, productId, qty, reason, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReturnImplCopyWith<_$ReturnImpl> get copyWith =>
      __$$ReturnImplCopyWithImpl<_$ReturnImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReturnImplToJson(
      this,
    );
  }
}

abstract class _Return implements Return {
  const factory _Return(
      {required final String id,
      final String? orderId,
      final String? productId,
      required final double qty,
      final String? reason,
      final DateTime? createdAt}) = _$ReturnImpl;

  factory _Return.fromJson(Map<String, dynamic> json) = _$ReturnImpl.fromJson;

  @override
  String get id;
  @override
  String? get orderId;
  @override
  String? get productId;
  @override
  double get qty;
  @override
  String? get reason;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$ReturnImplCopyWith<_$ReturnImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

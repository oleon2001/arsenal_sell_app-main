// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_queue.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EmailQueue _$EmailQueueFromJson(Map<String, dynamic> json) {
  return _EmailQueue.fromJson(json);
}

/// @nodoc
mixin _$EmailQueue {
  int get id => throw _privateConstructorUsedError;
  String get toEmail => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get sentAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmailQueueCopyWith<EmailQueue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailQueueCopyWith<$Res> {
  factory $EmailQueueCopyWith(
          EmailQueue value, $Res Function(EmailQueue) then) =
      _$EmailQueueCopyWithImpl<$Res, EmailQueue>;
  @useResult
  $Res call(
      {int id,
      String toEmail,
      String subject,
      String body,
      DateTime? createdAt,
      DateTime? sentAt});
}

/// @nodoc
class _$EmailQueueCopyWithImpl<$Res, $Val extends EmailQueue>
    implements $EmailQueueCopyWith<$Res> {
  _$EmailQueueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? toEmail = null,
    Object? subject = null,
    Object? body = null,
    Object? createdAt = freezed,
    Object? sentAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      toEmail: null == toEmail
          ? _value.toEmail
          : toEmail // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sentAt: freezed == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmailQueueImplCopyWith<$Res>
    implements $EmailQueueCopyWith<$Res> {
  factory _$$EmailQueueImplCopyWith(
          _$EmailQueueImpl value, $Res Function(_$EmailQueueImpl) then) =
      __$$EmailQueueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String toEmail,
      String subject,
      String body,
      DateTime? createdAt,
      DateTime? sentAt});
}

/// @nodoc
class __$$EmailQueueImplCopyWithImpl<$Res>
    extends _$EmailQueueCopyWithImpl<$Res, _$EmailQueueImpl>
    implements _$$EmailQueueImplCopyWith<$Res> {
  __$$EmailQueueImplCopyWithImpl(
      _$EmailQueueImpl _value, $Res Function(_$EmailQueueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? toEmail = null,
    Object? subject = null,
    Object? body = null,
    Object? createdAt = freezed,
    Object? sentAt = freezed,
  }) {
    return _then(_$EmailQueueImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      toEmail: null == toEmail
          ? _value.toEmail
          : toEmail // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sentAt: freezed == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailQueueImpl implements _EmailQueue {
  const _$EmailQueueImpl(
      {required this.id,
      required this.toEmail,
      required this.subject,
      required this.body,
      this.createdAt,
      this.sentAt});

  factory _$EmailQueueImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailQueueImplFromJson(json);

  @override
  final int id;
  @override
  final String toEmail;
  @override
  final String subject;
  @override
  final String body;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? sentAt;

  @override
  String toString() {
    return 'EmailQueue(id: $id, toEmail: $toEmail, subject: $subject, body: $body, createdAt: $createdAt, sentAt: $sentAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailQueueImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.toEmail, toEmail) || other.toEmail == toEmail) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, toEmail, subject, body, createdAt, sentAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailQueueImplCopyWith<_$EmailQueueImpl> get copyWith =>
      __$$EmailQueueImplCopyWithImpl<_$EmailQueueImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailQueueImplToJson(
      this,
    );
  }
}

abstract class _EmailQueue implements EmailQueue {
  const factory _EmailQueue(
      {required final int id,
      required final String toEmail,
      required final String subject,
      required final String body,
      final DateTime? createdAt,
      final DateTime? sentAt}) = _$EmailQueueImpl;

  factory _EmailQueue.fromJson(Map<String, dynamic> json) =
      _$EmailQueueImpl.fromJson;

  @override
  int get id;
  @override
  String get toEmail;
  @override
  String get subject;
  @override
  String get body;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get sentAt;
  @override
  @JsonKey(ignore: true)
  _$$EmailQueueImplCopyWith<_$EmailQueueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

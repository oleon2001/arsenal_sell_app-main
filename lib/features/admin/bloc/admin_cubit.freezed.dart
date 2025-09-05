// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AdminState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AdminStats stats, List<UserProfile> users,
            SystemInfo systemInfo, List<AuditLog> auditLogs)
        loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AdminStats stats, List<UserProfile> users,
            SystemInfo systemInfo, List<AuditLog> auditLogs)?
        loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AdminStats stats, List<UserProfile> users,
            SystemInfo systemInfo, List<AuditLog> auditLogs)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminStateCopyWith<$Res> {
  factory $AdminStateCopyWith(
          AdminState value, $Res Function(AdminState) then) =
      _$AdminStateCopyWithImpl<$Res, AdminState>;
}

/// @nodoc
class _$AdminStateCopyWithImpl<$Res, $Val extends AdminState>
    implements $AdminStateCopyWith<$Res> {
  _$AdminStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$AdminStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'AdminState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AdminStats stats, List<UserProfile> users,
            SystemInfo systemInfo, List<AuditLog> auditLogs)
        loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AdminStats stats, List<UserProfile> users,
            SystemInfo systemInfo, List<AuditLog> auditLogs)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AdminStats stats, List<UserProfile> users,
            SystemInfo systemInfo, List<AuditLog> auditLogs)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AdminState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$AdminStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'AdminState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AdminStats stats, List<UserProfile> users,
            SystemInfo systemInfo, List<AuditLog> auditLogs)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AdminStats stats, List<UserProfile> users,
            SystemInfo systemInfo, List<AuditLog> auditLogs)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AdminStats stats, List<UserProfile> users,
            SystemInfo systemInfo, List<AuditLog> auditLogs)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements AdminState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {AdminStats stats,
      List<UserProfile> users,
      SystemInfo systemInfo,
      List<AuditLog> auditLogs});

  $AdminStatsCopyWith<$Res> get stats;
  $SystemInfoCopyWith<$Res> get systemInfo;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$AdminStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stats = null,
    Object? users = null,
    Object? systemInfo = null,
    Object? auditLogs = null,
  }) {
    return _then(_$LoadedImpl(
      null == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as AdminStats,
      null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserProfile>,
      null == systemInfo
          ? _value.systemInfo
          : systemInfo // ignore: cast_nullable_to_non_nullable
              as SystemInfo,
      null == auditLogs
          ? _value._auditLogs
          : auditLogs // ignore: cast_nullable_to_non_nullable
              as List<AuditLog>,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $AdminStatsCopyWith<$Res> get stats {
    return $AdminStatsCopyWith<$Res>(_value.stats, (value) {
      return _then(_value.copyWith(stats: value));
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SystemInfoCopyWith<$Res> get systemInfo {
    return $SystemInfoCopyWith<$Res>(_value.systemInfo, (value) {
      return _then(_value.copyWith(systemInfo: value));
    });
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(this.stats, final List<UserProfile> users, this.systemInfo,
      final List<AuditLog> auditLogs)
      : _users = users,
        _auditLogs = auditLogs;

  @override
  final AdminStats stats;
  final List<UserProfile> _users;
  @override
  List<UserProfile> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  final SystemInfo systemInfo;
  final List<AuditLog> _auditLogs;
  @override
  List<AuditLog> get auditLogs {
    if (_auditLogs is EqualUnmodifiableListView) return _auditLogs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_auditLogs);
  }

  @override
  String toString() {
    return 'AdminState.loaded(stats: $stats, users: $users, systemInfo: $systemInfo, auditLogs: $auditLogs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.stats, stats) || other.stats == stats) &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            (identical(other.systemInfo, systemInfo) ||
                other.systemInfo == systemInfo) &&
            const DeepCollectionEquality()
                .equals(other._auditLogs, _auditLogs));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      stats,
      const DeepCollectionEquality().hash(_users),
      systemInfo,
      const DeepCollectionEquality().hash(_auditLogs));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AdminStats stats, List<UserProfile> users,
            SystemInfo systemInfo, List<AuditLog> auditLogs)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(stats, users, systemInfo, auditLogs);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AdminStats stats, List<UserProfile> users,
            SystemInfo systemInfo, List<AuditLog> auditLogs)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(stats, users, systemInfo, auditLogs);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AdminStats stats, List<UserProfile> users,
            SystemInfo systemInfo, List<AuditLog> auditLogs)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(stats, users, systemInfo, auditLogs);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements AdminState {
  const factory _Loaded(
      final AdminStats stats,
      final List<UserProfile> users,
      final SystemInfo systemInfo,
      final List<AuditLog> auditLogs) = _$LoadedImpl;

  AdminStats get stats;
  List<UserProfile> get users;
  SystemInfo get systemInfo;
  List<AuditLog> get auditLogs;
  @JsonKey(ignore: true)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$AdminStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'AdminState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AdminStats stats, List<UserProfile> users,
            SystemInfo systemInfo, List<AuditLog> auditLogs)
        loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AdminStats stats, List<UserProfile> users,
            SystemInfo systemInfo, List<AuditLog> auditLogs)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AdminStats stats, List<UserProfile> users,
            SystemInfo systemInfo, List<AuditLog> auditLogs)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements AdminState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AdminStats {
  int get totalUsers => throw _privateConstructorUsedError;
  int get activeUsers => throw _privateConstructorUsedError;
  int get totalCompanies => throw _privateConstructorUsedError;
  int get todaySessions => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AdminStatsCopyWith<AdminStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminStatsCopyWith<$Res> {
  factory $AdminStatsCopyWith(
          AdminStats value, $Res Function(AdminStats) then) =
      _$AdminStatsCopyWithImpl<$Res, AdminStats>;
  @useResult
  $Res call(
      {int totalUsers, int activeUsers, int totalCompanies, int todaySessions});
}

/// @nodoc
class _$AdminStatsCopyWithImpl<$Res, $Val extends AdminStats>
    implements $AdminStatsCopyWith<$Res> {
  _$AdminStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalUsers = null,
    Object? activeUsers = null,
    Object? totalCompanies = null,
    Object? todaySessions = null,
  }) {
    return _then(_value.copyWith(
      totalUsers: null == totalUsers
          ? _value.totalUsers
          : totalUsers // ignore: cast_nullable_to_non_nullable
              as int,
      activeUsers: null == activeUsers
          ? _value.activeUsers
          : activeUsers // ignore: cast_nullable_to_non_nullable
              as int,
      totalCompanies: null == totalCompanies
          ? _value.totalCompanies
          : totalCompanies // ignore: cast_nullable_to_non_nullable
              as int,
      todaySessions: null == todaySessions
          ? _value.todaySessions
          : todaySessions // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdminStatsImplCopyWith<$Res>
    implements $AdminStatsCopyWith<$Res> {
  factory _$$AdminStatsImplCopyWith(
          _$AdminStatsImpl value, $Res Function(_$AdminStatsImpl) then) =
      __$$AdminStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalUsers, int activeUsers, int totalCompanies, int todaySessions});
}

/// @nodoc
class __$$AdminStatsImplCopyWithImpl<$Res>
    extends _$AdminStatsCopyWithImpl<$Res, _$AdminStatsImpl>
    implements _$$AdminStatsImplCopyWith<$Res> {
  __$$AdminStatsImplCopyWithImpl(
      _$AdminStatsImpl _value, $Res Function(_$AdminStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalUsers = null,
    Object? activeUsers = null,
    Object? totalCompanies = null,
    Object? todaySessions = null,
  }) {
    return _then(_$AdminStatsImpl(
      totalUsers: null == totalUsers
          ? _value.totalUsers
          : totalUsers // ignore: cast_nullable_to_non_nullable
              as int,
      activeUsers: null == activeUsers
          ? _value.activeUsers
          : activeUsers // ignore: cast_nullable_to_non_nullable
              as int,
      totalCompanies: null == totalCompanies
          ? _value.totalCompanies
          : totalCompanies // ignore: cast_nullable_to_non_nullable
              as int,
      todaySessions: null == todaySessions
          ? _value.todaySessions
          : todaySessions // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AdminStatsImpl implements _AdminStats {
  const _$AdminStatsImpl(
      {this.totalUsers = 0,
      this.activeUsers = 0,
      this.totalCompanies = 0,
      this.todaySessions = 0});

  @override
  @JsonKey()
  final int totalUsers;
  @override
  @JsonKey()
  final int activeUsers;
  @override
  @JsonKey()
  final int totalCompanies;
  @override
  @JsonKey()
  final int todaySessions;

  @override
  String toString() {
    return 'AdminStats(totalUsers: $totalUsers, activeUsers: $activeUsers, totalCompanies: $totalCompanies, todaySessions: $todaySessions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminStatsImpl &&
            (identical(other.totalUsers, totalUsers) ||
                other.totalUsers == totalUsers) &&
            (identical(other.activeUsers, activeUsers) ||
                other.activeUsers == activeUsers) &&
            (identical(other.totalCompanies, totalCompanies) ||
                other.totalCompanies == totalCompanies) &&
            (identical(other.todaySessions, todaySessions) ||
                other.todaySessions == todaySessions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, totalUsers, activeUsers, totalCompanies, todaySessions);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminStatsImplCopyWith<_$AdminStatsImpl> get copyWith =>
      __$$AdminStatsImplCopyWithImpl<_$AdminStatsImpl>(this, _$identity);
}

abstract class _AdminStats implements AdminStats {
  const factory _AdminStats(
      {final int totalUsers,
      final int activeUsers,
      final int totalCompanies,
      final int todaySessions}) = _$AdminStatsImpl;

  @override
  int get totalUsers;
  @override
  int get activeUsers;
  @override
  int get totalCompanies;
  @override
  int get todaySessions;
  @override
  @JsonKey(ignore: true)
  _$$AdminStatsImplCopyWith<_$AdminStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SystemInfo {
  String get version => throw _privateConstructorUsedError;
  DateTime get lastUpdate => throw _privateConstructorUsedError;
  String get uptime => throw _privateConstructorUsedError;
  String get memoryUsage => throw _privateConstructorUsedError;
  String get databaseStatus => throw _privateConstructorUsedError;
  String get apiStatus => throw _privateConstructorUsedError;
  String get storageStatus => throw _privateConstructorUsedError;
  String get authStatus => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SystemInfoCopyWith<SystemInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SystemInfoCopyWith<$Res> {
  factory $SystemInfoCopyWith(
          SystemInfo value, $Res Function(SystemInfo) then) =
      _$SystemInfoCopyWithImpl<$Res, SystemInfo>;
  @useResult
  $Res call(
      {String version,
      DateTime lastUpdate,
      String uptime,
      String memoryUsage,
      String databaseStatus,
      String apiStatus,
      String storageStatus,
      String authStatus});
}

/// @nodoc
class _$SystemInfoCopyWithImpl<$Res, $Val extends SystemInfo>
    implements $SystemInfoCopyWith<$Res> {
  _$SystemInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
    Object? lastUpdate = null,
    Object? uptime = null,
    Object? memoryUsage = null,
    Object? databaseStatus = null,
    Object? apiStatus = null,
    Object? storageStatus = null,
    Object? authStatus = null,
  }) {
    return _then(_value.copyWith(
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdate: null == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      uptime: null == uptime
          ? _value.uptime
          : uptime // ignore: cast_nullable_to_non_nullable
              as String,
      memoryUsage: null == memoryUsage
          ? _value.memoryUsage
          : memoryUsage // ignore: cast_nullable_to_non_nullable
              as String,
      databaseStatus: null == databaseStatus
          ? _value.databaseStatus
          : databaseStatus // ignore: cast_nullable_to_non_nullable
              as String,
      apiStatus: null == apiStatus
          ? _value.apiStatus
          : apiStatus // ignore: cast_nullable_to_non_nullable
              as String,
      storageStatus: null == storageStatus
          ? _value.storageStatus
          : storageStatus // ignore: cast_nullable_to_non_nullable
              as String,
      authStatus: null == authStatus
          ? _value.authStatus
          : authStatus // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SystemInfoImplCopyWith<$Res>
    implements $SystemInfoCopyWith<$Res> {
  factory _$$SystemInfoImplCopyWith(
          _$SystemInfoImpl value, $Res Function(_$SystemInfoImpl) then) =
      __$$SystemInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String version,
      DateTime lastUpdate,
      String uptime,
      String memoryUsage,
      String databaseStatus,
      String apiStatus,
      String storageStatus,
      String authStatus});
}

/// @nodoc
class __$$SystemInfoImplCopyWithImpl<$Res>
    extends _$SystemInfoCopyWithImpl<$Res, _$SystemInfoImpl>
    implements _$$SystemInfoImplCopyWith<$Res> {
  __$$SystemInfoImplCopyWithImpl(
      _$SystemInfoImpl _value, $Res Function(_$SystemInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
    Object? lastUpdate = null,
    Object? uptime = null,
    Object? memoryUsage = null,
    Object? databaseStatus = null,
    Object? apiStatus = null,
    Object? storageStatus = null,
    Object? authStatus = null,
  }) {
    return _then(_$SystemInfoImpl(
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdate: null == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      uptime: null == uptime
          ? _value.uptime
          : uptime // ignore: cast_nullable_to_non_nullable
              as String,
      memoryUsage: null == memoryUsage
          ? _value.memoryUsage
          : memoryUsage // ignore: cast_nullable_to_non_nullable
              as String,
      databaseStatus: null == databaseStatus
          ? _value.databaseStatus
          : databaseStatus // ignore: cast_nullable_to_non_nullable
              as String,
      apiStatus: null == apiStatus
          ? _value.apiStatus
          : apiStatus // ignore: cast_nullable_to_non_nullable
              as String,
      storageStatus: null == storageStatus
          ? _value.storageStatus
          : storageStatus // ignore: cast_nullable_to_non_nullable
              as String,
      authStatus: null == authStatus
          ? _value.authStatus
          : authStatus // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SystemInfoImpl implements _SystemInfo {
  const _$SystemInfoImpl(
      {required this.version,
      required this.lastUpdate,
      required this.uptime,
      required this.memoryUsage,
      required this.databaseStatus,
      required this.apiStatus,
      required this.storageStatus,
      required this.authStatus});

  @override
  final String version;
  @override
  final DateTime lastUpdate;
  @override
  final String uptime;
  @override
  final String memoryUsage;
  @override
  final String databaseStatus;
  @override
  final String apiStatus;
  @override
  final String storageStatus;
  @override
  final String authStatus;

  @override
  String toString() {
    return 'SystemInfo(version: $version, lastUpdate: $lastUpdate, uptime: $uptime, memoryUsage: $memoryUsage, databaseStatus: $databaseStatus, apiStatus: $apiStatus, storageStatus: $storageStatus, authStatus: $authStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SystemInfoImpl &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.lastUpdate, lastUpdate) ||
                other.lastUpdate == lastUpdate) &&
            (identical(other.uptime, uptime) || other.uptime == uptime) &&
            (identical(other.memoryUsage, memoryUsage) ||
                other.memoryUsage == memoryUsage) &&
            (identical(other.databaseStatus, databaseStatus) ||
                other.databaseStatus == databaseStatus) &&
            (identical(other.apiStatus, apiStatus) ||
                other.apiStatus == apiStatus) &&
            (identical(other.storageStatus, storageStatus) ||
                other.storageStatus == storageStatus) &&
            (identical(other.authStatus, authStatus) ||
                other.authStatus == authStatus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, version, lastUpdate, uptime,
      memoryUsage, databaseStatus, apiStatus, storageStatus, authStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SystemInfoImplCopyWith<_$SystemInfoImpl> get copyWith =>
      __$$SystemInfoImplCopyWithImpl<_$SystemInfoImpl>(this, _$identity);
}

abstract class _SystemInfo implements SystemInfo {
  const factory _SystemInfo(
      {required final String version,
      required final DateTime lastUpdate,
      required final String uptime,
      required final String memoryUsage,
      required final String databaseStatus,
      required final String apiStatus,
      required final String storageStatus,
      required final String authStatus}) = _$SystemInfoImpl;

  @override
  String get version;
  @override
  DateTime get lastUpdate;
  @override
  String get uptime;
  @override
  String get memoryUsage;
  @override
  String get databaseStatus;
  @override
  String get apiStatus;
  @override
  String get storageStatus;
  @override
  String get authStatus;
  @override
  @JsonKey(ignore: true)
  _$$SystemInfoImplCopyWith<_$SystemInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AuditLog {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get action => throw _privateConstructorUsedError;
  String get resource => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuditLogCopyWith<AuditLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuditLogCopyWith<$Res> {
  factory $AuditLogCopyWith(AuditLog value, $Res Function(AuditLog) then) =
      _$AuditLogCopyWithImpl<$Res, AuditLog>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String userName,
      String action,
      String resource,
      DateTime timestamp});
}

/// @nodoc
class _$AuditLogCopyWithImpl<$Res, $Val extends AuditLog>
    implements $AuditLogCopyWith<$Res> {
  _$AuditLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userName = null,
    Object? action = null,
    Object? resource = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      resource: null == resource
          ? _value.resource
          : resource // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuditLogImplCopyWith<$Res>
    implements $AuditLogCopyWith<$Res> {
  factory _$$AuditLogImplCopyWith(
          _$AuditLogImpl value, $Res Function(_$AuditLogImpl) then) =
      __$$AuditLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String userName,
      String action,
      String resource,
      DateTime timestamp});
}

/// @nodoc
class __$$AuditLogImplCopyWithImpl<$Res>
    extends _$AuditLogCopyWithImpl<$Res, _$AuditLogImpl>
    implements _$$AuditLogImplCopyWith<$Res> {
  __$$AuditLogImplCopyWithImpl(
      _$AuditLogImpl _value, $Res Function(_$AuditLogImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userName = null,
    Object? action = null,
    Object? resource = null,
    Object? timestamp = null,
  }) {
    return _then(_$AuditLogImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      resource: null == resource
          ? _value.resource
          : resource // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$AuditLogImpl implements _AuditLog {
  const _$AuditLogImpl(
      {required this.id,
      required this.userId,
      required this.userName,
      required this.action,
      required this.resource,
      required this.timestamp});

  @override
  final String id;
  @override
  final String userId;
  @override
  final String userName;
  @override
  final String action;
  @override
  final String resource;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'AuditLog(id: $id, userId: $userId, userName: $userName, action: $action, resource: $resource, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuditLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.resource, resource) ||
                other.resource == resource) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, userId, userName, action, resource, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuditLogImplCopyWith<_$AuditLogImpl> get copyWith =>
      __$$AuditLogImplCopyWithImpl<_$AuditLogImpl>(this, _$identity);
}

abstract class _AuditLog implements AuditLog {
  const factory _AuditLog(
      {required final String id,
      required final String userId,
      required final String userName,
      required final String action,
      required final String resource,
      required final DateTime timestamp}) = _$AuditLogImpl;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get userName;
  @override
  String get action;
  @override
  String get resource;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$AuditLogImplCopyWith<_$AuditLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

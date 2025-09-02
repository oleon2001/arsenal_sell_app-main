// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visits_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VisitsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Visit visit) activeVisit,
    required TResult Function(Visit visit) completed,
    required TResult Function(List<Visit> visits) history,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Visit visit)? activeVisit,
    TResult? Function(Visit visit)? completed,
    TResult? Function(List<Visit> visits)? history,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Visit visit)? activeVisit,
    TResult Function(Visit visit)? completed,
    TResult Function(List<Visit> visits)? history,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(VisitsActiveVisit value) activeVisit,
    required TResult Function(_Completed value) completed,
    required TResult Function(_History value) history,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(VisitsActiveVisit value)? activeVisit,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_History value)? history,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(VisitsActiveVisit value)? activeVisit,
    TResult Function(_Completed value)? completed,
    TResult Function(_History value)? history,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisitsStateCopyWith<$Res> {
  factory $VisitsStateCopyWith(
          VisitsState value, $Res Function(VisitsState) then) =
      _$VisitsStateCopyWithImpl<$Res, VisitsState>;
}

/// @nodoc
class _$VisitsStateCopyWithImpl<$Res, $Val extends VisitsState>
    implements $VisitsStateCopyWith<$Res> {
  _$VisitsStateCopyWithImpl(this._value, this._then);

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
    extends _$VisitsStateCopyWithImpl<$Res, _$InitialImpl>
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
    return 'VisitsState.initial()';
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
    required TResult Function(Visit visit) activeVisit,
    required TResult Function(Visit visit) completed,
    required TResult Function(List<Visit> visits) history,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Visit visit)? activeVisit,
    TResult? Function(Visit visit)? completed,
    TResult? Function(List<Visit> visits)? history,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Visit visit)? activeVisit,
    TResult Function(Visit visit)? completed,
    TResult Function(List<Visit> visits)? history,
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
    required TResult Function(VisitsActiveVisit value) activeVisit,
    required TResult Function(_Completed value) completed,
    required TResult Function(_History value) history,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(VisitsActiveVisit value)? activeVisit,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_History value)? history,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(VisitsActiveVisit value)? activeVisit,
    TResult Function(_Completed value)? completed,
    TResult Function(_History value)? history,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements VisitsState {
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
    extends _$VisitsStateCopyWithImpl<$Res, _$LoadingImpl>
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
    return 'VisitsState.loading()';
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
    required TResult Function(Visit visit) activeVisit,
    required TResult Function(Visit visit) completed,
    required TResult Function(List<Visit> visits) history,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Visit visit)? activeVisit,
    TResult? Function(Visit visit)? completed,
    TResult? Function(List<Visit> visits)? history,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Visit visit)? activeVisit,
    TResult Function(Visit visit)? completed,
    TResult Function(List<Visit> visits)? history,
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
    required TResult Function(VisitsActiveVisit value) activeVisit,
    required TResult Function(_Completed value) completed,
    required TResult Function(_History value) history,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(VisitsActiveVisit value)? activeVisit,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_History value)? history,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(VisitsActiveVisit value)? activeVisit,
    TResult Function(_Completed value)? completed,
    TResult Function(_History value)? history,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements VisitsState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$VisitsActiveVisitImplCopyWith<$Res> {
  factory _$$VisitsActiveVisitImplCopyWith(_$VisitsActiveVisitImpl value,
          $Res Function(_$VisitsActiveVisitImpl) then) =
      __$$VisitsActiveVisitImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Visit visit});
}

/// @nodoc
class __$$VisitsActiveVisitImplCopyWithImpl<$Res>
    extends _$VisitsStateCopyWithImpl<$Res, _$VisitsActiveVisitImpl>
    implements _$$VisitsActiveVisitImplCopyWith<$Res> {
  __$$VisitsActiveVisitImplCopyWithImpl(_$VisitsActiveVisitImpl _value,
      $Res Function(_$VisitsActiveVisitImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? visit = null,
  }) {
    return _then(_$VisitsActiveVisitImpl(
      null == visit
          ? _value.visit
          : visit // ignore: cast_nullable_to_non_nullable
              as Visit,
    ));
  }
}

/// @nodoc

class _$VisitsActiveVisitImpl implements VisitsActiveVisit {
  const _$VisitsActiveVisitImpl(this.visit);

  @override
  final Visit visit;

  @override
  String toString() {
    return 'VisitsState.activeVisit(visit: $visit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VisitsActiveVisitImpl &&
            (identical(other.visit, visit) || other.visit == visit));
  }

  @override
  int get hashCode => Object.hash(runtimeType, visit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VisitsActiveVisitImplCopyWith<_$VisitsActiveVisitImpl> get copyWith =>
      __$$VisitsActiveVisitImplCopyWithImpl<_$VisitsActiveVisitImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Visit visit) activeVisit,
    required TResult Function(Visit visit) completed,
    required TResult Function(List<Visit> visits) history,
    required TResult Function(String message) error,
  }) {
    return activeVisit(visit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Visit visit)? activeVisit,
    TResult? Function(Visit visit)? completed,
    TResult? Function(List<Visit> visits)? history,
    TResult? Function(String message)? error,
  }) {
    return activeVisit?.call(visit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Visit visit)? activeVisit,
    TResult Function(Visit visit)? completed,
    TResult Function(List<Visit> visits)? history,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (activeVisit != null) {
      return activeVisit(visit);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(VisitsActiveVisit value) activeVisit,
    required TResult Function(_Completed value) completed,
    required TResult Function(_History value) history,
    required TResult Function(_Error value) error,
  }) {
    return activeVisit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(VisitsActiveVisit value)? activeVisit,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_History value)? history,
    TResult? Function(_Error value)? error,
  }) {
    return activeVisit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(VisitsActiveVisit value)? activeVisit,
    TResult Function(_Completed value)? completed,
    TResult Function(_History value)? history,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (activeVisit != null) {
      return activeVisit(this);
    }
    return orElse();
  }
}

abstract class VisitsActiveVisit implements VisitsState {
  const factory VisitsActiveVisit(final Visit visit) = _$VisitsActiveVisitImpl;

  Visit get visit;
  @JsonKey(ignore: true)
  _$$VisitsActiveVisitImplCopyWith<_$VisitsActiveVisitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CompletedImplCopyWith<$Res> {
  factory _$$CompletedImplCopyWith(
          _$CompletedImpl value, $Res Function(_$CompletedImpl) then) =
      __$$CompletedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Visit visit});
}

/// @nodoc
class __$$CompletedImplCopyWithImpl<$Res>
    extends _$VisitsStateCopyWithImpl<$Res, _$CompletedImpl>
    implements _$$CompletedImplCopyWith<$Res> {
  __$$CompletedImplCopyWithImpl(
      _$CompletedImpl _value, $Res Function(_$CompletedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? visit = null,
  }) {
    return _then(_$CompletedImpl(
      null == visit
          ? _value.visit
          : visit // ignore: cast_nullable_to_non_nullable
              as Visit,
    ));
  }
}

/// @nodoc

class _$CompletedImpl implements _Completed {
  const _$CompletedImpl(this.visit);

  @override
  final Visit visit;

  @override
  String toString() {
    return 'VisitsState.completed(visit: $visit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompletedImpl &&
            (identical(other.visit, visit) || other.visit == visit));
  }

  @override
  int get hashCode => Object.hash(runtimeType, visit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CompletedImplCopyWith<_$CompletedImpl> get copyWith =>
      __$$CompletedImplCopyWithImpl<_$CompletedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Visit visit) activeVisit,
    required TResult Function(Visit visit) completed,
    required TResult Function(List<Visit> visits) history,
    required TResult Function(String message) error,
  }) {
    return completed(visit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Visit visit)? activeVisit,
    TResult? Function(Visit visit)? completed,
    TResult? Function(List<Visit> visits)? history,
    TResult? Function(String message)? error,
  }) {
    return completed?.call(visit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Visit visit)? activeVisit,
    TResult Function(Visit visit)? completed,
    TResult Function(List<Visit> visits)? history,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(visit);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(VisitsActiveVisit value) activeVisit,
    required TResult Function(_Completed value) completed,
    required TResult Function(_History value) history,
    required TResult Function(_Error value) error,
  }) {
    return completed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(VisitsActiveVisit value)? activeVisit,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_History value)? history,
    TResult? Function(_Error value)? error,
  }) {
    return completed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(VisitsActiveVisit value)? activeVisit,
    TResult Function(_Completed value)? completed,
    TResult Function(_History value)? history,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(this);
    }
    return orElse();
  }
}

abstract class _Completed implements VisitsState {
  const factory _Completed(final Visit visit) = _$CompletedImpl;

  Visit get visit;
  @JsonKey(ignore: true)
  _$$CompletedImplCopyWith<_$CompletedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HistoryImplCopyWith<$Res> {
  factory _$$HistoryImplCopyWith(
          _$HistoryImpl value, $Res Function(_$HistoryImpl) then) =
      __$$HistoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Visit> visits});
}

/// @nodoc
class __$$HistoryImplCopyWithImpl<$Res>
    extends _$VisitsStateCopyWithImpl<$Res, _$HistoryImpl>
    implements _$$HistoryImplCopyWith<$Res> {
  __$$HistoryImplCopyWithImpl(
      _$HistoryImpl _value, $Res Function(_$HistoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? visits = null,
  }) {
    return _then(_$HistoryImpl(
      null == visits
          ? _value._visits
          : visits // ignore: cast_nullable_to_non_nullable
              as List<Visit>,
    ));
  }
}

/// @nodoc

class _$HistoryImpl implements _History {
  const _$HistoryImpl(final List<Visit> visits) : _visits = visits;

  final List<Visit> _visits;
  @override
  List<Visit> get visits {
    if (_visits is EqualUnmodifiableListView) return _visits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_visits);
  }

  @override
  String toString() {
    return 'VisitsState.history(visits: $visits)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryImpl &&
            const DeepCollectionEquality().equals(other._visits, _visits));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_visits));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryImplCopyWith<_$HistoryImpl> get copyWith =>
      __$$HistoryImplCopyWithImpl<_$HistoryImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Visit visit) activeVisit,
    required TResult Function(Visit visit) completed,
    required TResult Function(List<Visit> visits) history,
    required TResult Function(String message) error,
  }) {
    return history(visits);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Visit visit)? activeVisit,
    TResult? Function(Visit visit)? completed,
    TResult? Function(List<Visit> visits)? history,
    TResult? Function(String message)? error,
  }) {
    return history?.call(visits);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Visit visit)? activeVisit,
    TResult Function(Visit visit)? completed,
    TResult Function(List<Visit> visits)? history,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (history != null) {
      return history(visits);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(VisitsActiveVisit value) activeVisit,
    required TResult Function(_Completed value) completed,
    required TResult Function(_History value) history,
    required TResult Function(_Error value) error,
  }) {
    return history(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(VisitsActiveVisit value)? activeVisit,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_History value)? history,
    TResult? Function(_Error value)? error,
  }) {
    return history?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(VisitsActiveVisit value)? activeVisit,
    TResult Function(_Completed value)? completed,
    TResult Function(_History value)? history,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (history != null) {
      return history(this);
    }
    return orElse();
  }
}

abstract class _History implements VisitsState {
  const factory _History(final List<Visit> visits) = _$HistoryImpl;

  List<Visit> get visits;
  @JsonKey(ignore: true)
  _$$HistoryImplCopyWith<_$HistoryImpl> get copyWith =>
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
    extends _$VisitsStateCopyWithImpl<$Res, _$ErrorImpl>
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
    return 'VisitsState.error(message: $message)';
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
    required TResult Function(Visit visit) activeVisit,
    required TResult Function(Visit visit) completed,
    required TResult Function(List<Visit> visits) history,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Visit visit)? activeVisit,
    TResult? Function(Visit visit)? completed,
    TResult? Function(List<Visit> visits)? history,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Visit visit)? activeVisit,
    TResult Function(Visit visit)? completed,
    TResult Function(List<Visit> visits)? history,
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
    required TResult Function(VisitsActiveVisit value) activeVisit,
    required TResult Function(_Completed value) completed,
    required TResult Function(_History value) history,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(VisitsActiveVisit value)? activeVisit,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_History value)? history,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(VisitsActiveVisit value)? activeVisit,
    TResult Function(_Completed value)? completed,
    TResult Function(_History value)? history,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements VisitsState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

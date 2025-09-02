// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payments_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PaymentsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PaymentModel> payments) loaded,
    required TResult Function(List<PaymentModel> pendingPayments) pendingLoaded,
    required TResult Function(List<PaymentModel> payments, String filter)
        filtered,
    required TResult Function(List<PaymentModel> payments, String query)
        searched,
    required TResult Function() processing,
    required TResult Function(PaymentModel payment, String message)
        paymentRegistered,
    required TResult Function(PaymentModel payment, String message)
        paymentProcessed,
    required TResult Function() generatingReport,
    required TResult Function(PaymentReport report) reportGenerated,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PaymentModel> payments)? loaded,
    TResult? Function(List<PaymentModel> pendingPayments)? pendingLoaded,
    TResult? Function(List<PaymentModel> payments, String filter)? filtered,
    TResult? Function(List<PaymentModel> payments, String query)? searched,
    TResult? Function()? processing,
    TResult? Function(PaymentModel payment, String message)? paymentRegistered,
    TResult? Function(PaymentModel payment, String message)? paymentProcessed,
    TResult? Function()? generatingReport,
    TResult? Function(PaymentReport report)? reportGenerated,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PaymentModel> payments)? loaded,
    TResult Function(List<PaymentModel> pendingPayments)? pendingLoaded,
    TResult Function(List<PaymentModel> payments, String filter)? filtered,
    TResult Function(List<PaymentModel> payments, String query)? searched,
    TResult Function()? processing,
    TResult Function(PaymentModel payment, String message)? paymentRegistered,
    TResult Function(PaymentModel payment, String message)? paymentProcessed,
    TResult Function()? generatingReport,
    TResult Function(PaymentReport report)? reportGenerated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(PaymentsLoaded value) loaded,
    required TResult Function(PaymentsPendingLoaded value) pendingLoaded,
    required TResult Function(PaymentsFiltered value) filtered,
    required TResult Function(PaymentsSearched value) searched,
    required TResult Function(_Processing value) processing,
    required TResult Function(_PaymentRegistered value) paymentRegistered,
    required TResult Function(_PaymentProcessed value) paymentProcessed,
    required TResult Function(_GeneratingReport value) generatingReport,
    required TResult Function(_ReportGenerated value) reportGenerated,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(PaymentsLoaded value)? loaded,
    TResult? Function(PaymentsPendingLoaded value)? pendingLoaded,
    TResult? Function(PaymentsFiltered value)? filtered,
    TResult? Function(PaymentsSearched value)? searched,
    TResult? Function(_Processing value)? processing,
    TResult? Function(_PaymentRegistered value)? paymentRegistered,
    TResult? Function(_PaymentProcessed value)? paymentProcessed,
    TResult? Function(_GeneratingReport value)? generatingReport,
    TResult? Function(_ReportGenerated value)? reportGenerated,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(PaymentsLoaded value)? loaded,
    TResult Function(PaymentsPendingLoaded value)? pendingLoaded,
    TResult Function(PaymentsFiltered value)? filtered,
    TResult Function(PaymentsSearched value)? searched,
    TResult Function(_Processing value)? processing,
    TResult Function(_PaymentRegistered value)? paymentRegistered,
    TResult Function(_PaymentProcessed value)? paymentProcessed,
    TResult Function(_GeneratingReport value)? generatingReport,
    TResult Function(_ReportGenerated value)? reportGenerated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentsStateCopyWith<$Res> {
  factory $PaymentsStateCopyWith(
          PaymentsState value, $Res Function(PaymentsState) then) =
      _$PaymentsStateCopyWithImpl<$Res, PaymentsState>;
}

/// @nodoc
class _$PaymentsStateCopyWithImpl<$Res, $Val extends PaymentsState>
    implements $PaymentsStateCopyWith<$Res> {
  _$PaymentsStateCopyWithImpl(this._value, this._then);

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
    extends _$PaymentsStateCopyWithImpl<$Res, _$InitialImpl>
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
    return 'PaymentsState.initial()';
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
    required TResult Function(List<PaymentModel> payments) loaded,
    required TResult Function(List<PaymentModel> pendingPayments) pendingLoaded,
    required TResult Function(List<PaymentModel> payments, String filter)
        filtered,
    required TResult Function(List<PaymentModel> payments, String query)
        searched,
    required TResult Function() processing,
    required TResult Function(PaymentModel payment, String message)
        paymentRegistered,
    required TResult Function(PaymentModel payment, String message)
        paymentProcessed,
    required TResult Function() generatingReport,
    required TResult Function(PaymentReport report) reportGenerated,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PaymentModel> payments)? loaded,
    TResult? Function(List<PaymentModel> pendingPayments)? pendingLoaded,
    TResult? Function(List<PaymentModel> payments, String filter)? filtered,
    TResult? Function(List<PaymentModel> payments, String query)? searched,
    TResult? Function()? processing,
    TResult? Function(PaymentModel payment, String message)? paymentRegistered,
    TResult? Function(PaymentModel payment, String message)? paymentProcessed,
    TResult? Function()? generatingReport,
    TResult? Function(PaymentReport report)? reportGenerated,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PaymentModel> payments)? loaded,
    TResult Function(List<PaymentModel> pendingPayments)? pendingLoaded,
    TResult Function(List<PaymentModel> payments, String filter)? filtered,
    TResult Function(List<PaymentModel> payments, String query)? searched,
    TResult Function()? processing,
    TResult Function(PaymentModel payment, String message)? paymentRegistered,
    TResult Function(PaymentModel payment, String message)? paymentProcessed,
    TResult Function()? generatingReport,
    TResult Function(PaymentReport report)? reportGenerated,
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
    required TResult Function(PaymentsLoaded value) loaded,
    required TResult Function(PaymentsPendingLoaded value) pendingLoaded,
    required TResult Function(PaymentsFiltered value) filtered,
    required TResult Function(PaymentsSearched value) searched,
    required TResult Function(_Processing value) processing,
    required TResult Function(_PaymentRegistered value) paymentRegistered,
    required TResult Function(_PaymentProcessed value) paymentProcessed,
    required TResult Function(_GeneratingReport value) generatingReport,
    required TResult Function(_ReportGenerated value) reportGenerated,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(PaymentsLoaded value)? loaded,
    TResult? Function(PaymentsPendingLoaded value)? pendingLoaded,
    TResult? Function(PaymentsFiltered value)? filtered,
    TResult? Function(PaymentsSearched value)? searched,
    TResult? Function(_Processing value)? processing,
    TResult? Function(_PaymentRegistered value)? paymentRegistered,
    TResult? Function(_PaymentProcessed value)? paymentProcessed,
    TResult? Function(_GeneratingReport value)? generatingReport,
    TResult? Function(_ReportGenerated value)? reportGenerated,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(PaymentsLoaded value)? loaded,
    TResult Function(PaymentsPendingLoaded value)? pendingLoaded,
    TResult Function(PaymentsFiltered value)? filtered,
    TResult Function(PaymentsSearched value)? searched,
    TResult Function(_Processing value)? processing,
    TResult Function(_PaymentRegistered value)? paymentRegistered,
    TResult Function(_PaymentProcessed value)? paymentProcessed,
    TResult Function(_GeneratingReport value)? generatingReport,
    TResult Function(_ReportGenerated value)? reportGenerated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements PaymentsState {
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
    extends _$PaymentsStateCopyWithImpl<$Res, _$LoadingImpl>
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
    return 'PaymentsState.loading()';
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
    required TResult Function(List<PaymentModel> payments) loaded,
    required TResult Function(List<PaymentModel> pendingPayments) pendingLoaded,
    required TResult Function(List<PaymentModel> payments, String filter)
        filtered,
    required TResult Function(List<PaymentModel> payments, String query)
        searched,
    required TResult Function() processing,
    required TResult Function(PaymentModel payment, String message)
        paymentRegistered,
    required TResult Function(PaymentModel payment, String message)
        paymentProcessed,
    required TResult Function() generatingReport,
    required TResult Function(PaymentReport report) reportGenerated,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PaymentModel> payments)? loaded,
    TResult? Function(List<PaymentModel> pendingPayments)? pendingLoaded,
    TResult? Function(List<PaymentModel> payments, String filter)? filtered,
    TResult? Function(List<PaymentModel> payments, String query)? searched,
    TResult? Function()? processing,
    TResult? Function(PaymentModel payment, String message)? paymentRegistered,
    TResult? Function(PaymentModel payment, String message)? paymentProcessed,
    TResult? Function()? generatingReport,
    TResult? Function(PaymentReport report)? reportGenerated,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PaymentModel> payments)? loaded,
    TResult Function(List<PaymentModel> pendingPayments)? pendingLoaded,
    TResult Function(List<PaymentModel> payments, String filter)? filtered,
    TResult Function(List<PaymentModel> payments, String query)? searched,
    TResult Function()? processing,
    TResult Function(PaymentModel payment, String message)? paymentRegistered,
    TResult Function(PaymentModel payment, String message)? paymentProcessed,
    TResult Function()? generatingReport,
    TResult Function(PaymentReport report)? reportGenerated,
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
    required TResult Function(PaymentsLoaded value) loaded,
    required TResult Function(PaymentsPendingLoaded value) pendingLoaded,
    required TResult Function(PaymentsFiltered value) filtered,
    required TResult Function(PaymentsSearched value) searched,
    required TResult Function(_Processing value) processing,
    required TResult Function(_PaymentRegistered value) paymentRegistered,
    required TResult Function(_PaymentProcessed value) paymentProcessed,
    required TResult Function(_GeneratingReport value) generatingReport,
    required TResult Function(_ReportGenerated value) reportGenerated,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(PaymentsLoaded value)? loaded,
    TResult? Function(PaymentsPendingLoaded value)? pendingLoaded,
    TResult? Function(PaymentsFiltered value)? filtered,
    TResult? Function(PaymentsSearched value)? searched,
    TResult? Function(_Processing value)? processing,
    TResult? Function(_PaymentRegistered value)? paymentRegistered,
    TResult? Function(_PaymentProcessed value)? paymentProcessed,
    TResult? Function(_GeneratingReport value)? generatingReport,
    TResult? Function(_ReportGenerated value)? reportGenerated,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(PaymentsLoaded value)? loaded,
    TResult Function(PaymentsPendingLoaded value)? pendingLoaded,
    TResult Function(PaymentsFiltered value)? filtered,
    TResult Function(PaymentsSearched value)? searched,
    TResult Function(_Processing value)? processing,
    TResult Function(_PaymentRegistered value)? paymentRegistered,
    TResult Function(_PaymentProcessed value)? paymentProcessed,
    TResult Function(_GeneratingReport value)? generatingReport,
    TResult Function(_ReportGenerated value)? reportGenerated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements PaymentsState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$PaymentsLoadedImplCopyWith<$Res> {
  factory _$$PaymentsLoadedImplCopyWith(_$PaymentsLoadedImpl value,
          $Res Function(_$PaymentsLoadedImpl) then) =
      __$$PaymentsLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<PaymentModel> payments});
}

/// @nodoc
class __$$PaymentsLoadedImplCopyWithImpl<$Res>
    extends _$PaymentsStateCopyWithImpl<$Res, _$PaymentsLoadedImpl>
    implements _$$PaymentsLoadedImplCopyWith<$Res> {
  __$$PaymentsLoadedImplCopyWithImpl(
      _$PaymentsLoadedImpl _value, $Res Function(_$PaymentsLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payments = null,
  }) {
    return _then(_$PaymentsLoadedImpl(
      null == payments
          ? _value._payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<PaymentModel>,
    ));
  }
}

/// @nodoc

class _$PaymentsLoadedImpl implements PaymentsLoaded {
  const _$PaymentsLoadedImpl(final List<PaymentModel> payments)
      : _payments = payments;

  final List<PaymentModel> _payments;
  @override
  List<PaymentModel> get payments {
    if (_payments is EqualUnmodifiableListView) return _payments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_payments);
  }

  @override
  String toString() {
    return 'PaymentsState.loaded(payments: $payments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentsLoadedImpl &&
            const DeepCollectionEquality().equals(other._payments, _payments));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_payments));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentsLoadedImplCopyWith<_$PaymentsLoadedImpl> get copyWith =>
      __$$PaymentsLoadedImplCopyWithImpl<_$PaymentsLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PaymentModel> payments) loaded,
    required TResult Function(List<PaymentModel> pendingPayments) pendingLoaded,
    required TResult Function(List<PaymentModel> payments, String filter)
        filtered,
    required TResult Function(List<PaymentModel> payments, String query)
        searched,
    required TResult Function() processing,
    required TResult Function(PaymentModel payment, String message)
        paymentRegistered,
    required TResult Function(PaymentModel payment, String message)
        paymentProcessed,
    required TResult Function() generatingReport,
    required TResult Function(PaymentReport report) reportGenerated,
    required TResult Function(String message) error,
  }) {
    return loaded(payments);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PaymentModel> payments)? loaded,
    TResult? Function(List<PaymentModel> pendingPayments)? pendingLoaded,
    TResult? Function(List<PaymentModel> payments, String filter)? filtered,
    TResult? Function(List<PaymentModel> payments, String query)? searched,
    TResult? Function()? processing,
    TResult? Function(PaymentModel payment, String message)? paymentRegistered,
    TResult? Function(PaymentModel payment, String message)? paymentProcessed,
    TResult? Function()? generatingReport,
    TResult? Function(PaymentReport report)? reportGenerated,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(payments);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PaymentModel> payments)? loaded,
    TResult Function(List<PaymentModel> pendingPayments)? pendingLoaded,
    TResult Function(List<PaymentModel> payments, String filter)? filtered,
    TResult Function(List<PaymentModel> payments, String query)? searched,
    TResult Function()? processing,
    TResult Function(PaymentModel payment, String message)? paymentRegistered,
    TResult Function(PaymentModel payment, String message)? paymentProcessed,
    TResult Function()? generatingReport,
    TResult Function(PaymentReport report)? reportGenerated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(payments);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(PaymentsLoaded value) loaded,
    required TResult Function(PaymentsPendingLoaded value) pendingLoaded,
    required TResult Function(PaymentsFiltered value) filtered,
    required TResult Function(PaymentsSearched value) searched,
    required TResult Function(_Processing value) processing,
    required TResult Function(_PaymentRegistered value) paymentRegistered,
    required TResult Function(_PaymentProcessed value) paymentProcessed,
    required TResult Function(_GeneratingReport value) generatingReport,
    required TResult Function(_ReportGenerated value) reportGenerated,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(PaymentsLoaded value)? loaded,
    TResult? Function(PaymentsPendingLoaded value)? pendingLoaded,
    TResult? Function(PaymentsFiltered value)? filtered,
    TResult? Function(PaymentsSearched value)? searched,
    TResult? Function(_Processing value)? processing,
    TResult? Function(_PaymentRegistered value)? paymentRegistered,
    TResult? Function(_PaymentProcessed value)? paymentProcessed,
    TResult? Function(_GeneratingReport value)? generatingReport,
    TResult? Function(_ReportGenerated value)? reportGenerated,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(PaymentsLoaded value)? loaded,
    TResult Function(PaymentsPendingLoaded value)? pendingLoaded,
    TResult Function(PaymentsFiltered value)? filtered,
    TResult Function(PaymentsSearched value)? searched,
    TResult Function(_Processing value)? processing,
    TResult Function(_PaymentRegistered value)? paymentRegistered,
    TResult Function(_PaymentProcessed value)? paymentProcessed,
    TResult Function(_GeneratingReport value)? generatingReport,
    TResult Function(_ReportGenerated value)? reportGenerated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class PaymentsLoaded implements PaymentsState {
  const factory PaymentsLoaded(final List<PaymentModel> payments) =
      _$PaymentsLoadedImpl;

  List<PaymentModel> get payments;
  @JsonKey(ignore: true)
  _$$PaymentsLoadedImplCopyWith<_$PaymentsLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PaymentsPendingLoadedImplCopyWith<$Res> {
  factory _$$PaymentsPendingLoadedImplCopyWith(
          _$PaymentsPendingLoadedImpl value,
          $Res Function(_$PaymentsPendingLoadedImpl) then) =
      __$$PaymentsPendingLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<PaymentModel> pendingPayments});
}

/// @nodoc
class __$$PaymentsPendingLoadedImplCopyWithImpl<$Res>
    extends _$PaymentsStateCopyWithImpl<$Res, _$PaymentsPendingLoadedImpl>
    implements _$$PaymentsPendingLoadedImplCopyWith<$Res> {
  __$$PaymentsPendingLoadedImplCopyWithImpl(_$PaymentsPendingLoadedImpl _value,
      $Res Function(_$PaymentsPendingLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pendingPayments = null,
  }) {
    return _then(_$PaymentsPendingLoadedImpl(
      null == pendingPayments
          ? _value._pendingPayments
          : pendingPayments // ignore: cast_nullable_to_non_nullable
              as List<PaymentModel>,
    ));
  }
}

/// @nodoc

class _$PaymentsPendingLoadedImpl implements PaymentsPendingLoaded {
  const _$PaymentsPendingLoadedImpl(final List<PaymentModel> pendingPayments)
      : _pendingPayments = pendingPayments;

  final List<PaymentModel> _pendingPayments;
  @override
  List<PaymentModel> get pendingPayments {
    if (_pendingPayments is EqualUnmodifiableListView) return _pendingPayments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendingPayments);
  }

  @override
  String toString() {
    return 'PaymentsState.pendingLoaded(pendingPayments: $pendingPayments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentsPendingLoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._pendingPayments, _pendingPayments));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_pendingPayments));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentsPendingLoadedImplCopyWith<_$PaymentsPendingLoadedImpl>
      get copyWith => __$$PaymentsPendingLoadedImplCopyWithImpl<
          _$PaymentsPendingLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PaymentModel> payments) loaded,
    required TResult Function(List<PaymentModel> pendingPayments) pendingLoaded,
    required TResult Function(List<PaymentModel> payments, String filter)
        filtered,
    required TResult Function(List<PaymentModel> payments, String query)
        searched,
    required TResult Function() processing,
    required TResult Function(PaymentModel payment, String message)
        paymentRegistered,
    required TResult Function(PaymentModel payment, String message)
        paymentProcessed,
    required TResult Function() generatingReport,
    required TResult Function(PaymentReport report) reportGenerated,
    required TResult Function(String message) error,
  }) {
    return pendingLoaded(pendingPayments);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PaymentModel> payments)? loaded,
    TResult? Function(List<PaymentModel> pendingPayments)? pendingLoaded,
    TResult? Function(List<PaymentModel> payments, String filter)? filtered,
    TResult? Function(List<PaymentModel> payments, String query)? searched,
    TResult? Function()? processing,
    TResult? Function(PaymentModel payment, String message)? paymentRegistered,
    TResult? Function(PaymentModel payment, String message)? paymentProcessed,
    TResult? Function()? generatingReport,
    TResult? Function(PaymentReport report)? reportGenerated,
    TResult? Function(String message)? error,
  }) {
    return pendingLoaded?.call(pendingPayments);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PaymentModel> payments)? loaded,
    TResult Function(List<PaymentModel> pendingPayments)? pendingLoaded,
    TResult Function(List<PaymentModel> payments, String filter)? filtered,
    TResult Function(List<PaymentModel> payments, String query)? searched,
    TResult Function()? processing,
    TResult Function(PaymentModel payment, String message)? paymentRegistered,
    TResult Function(PaymentModel payment, String message)? paymentProcessed,
    TResult Function()? generatingReport,
    TResult Function(PaymentReport report)? reportGenerated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (pendingLoaded != null) {
      return pendingLoaded(pendingPayments);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(PaymentsLoaded value) loaded,
    required TResult Function(PaymentsPendingLoaded value) pendingLoaded,
    required TResult Function(PaymentsFiltered value) filtered,
    required TResult Function(PaymentsSearched value) searched,
    required TResult Function(_Processing value) processing,
    required TResult Function(_PaymentRegistered value) paymentRegistered,
    required TResult Function(_PaymentProcessed value) paymentProcessed,
    required TResult Function(_GeneratingReport value) generatingReport,
    required TResult Function(_ReportGenerated value) reportGenerated,
    required TResult Function(_Error value) error,
  }) {
    return pendingLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(PaymentsLoaded value)? loaded,
    TResult? Function(PaymentsPendingLoaded value)? pendingLoaded,
    TResult? Function(PaymentsFiltered value)? filtered,
    TResult? Function(PaymentsSearched value)? searched,
    TResult? Function(_Processing value)? processing,
    TResult? Function(_PaymentRegistered value)? paymentRegistered,
    TResult? Function(_PaymentProcessed value)? paymentProcessed,
    TResult? Function(_GeneratingReport value)? generatingReport,
    TResult? Function(_ReportGenerated value)? reportGenerated,
    TResult? Function(_Error value)? error,
  }) {
    return pendingLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(PaymentsLoaded value)? loaded,
    TResult Function(PaymentsPendingLoaded value)? pendingLoaded,
    TResult Function(PaymentsFiltered value)? filtered,
    TResult Function(PaymentsSearched value)? searched,
    TResult Function(_Processing value)? processing,
    TResult Function(_PaymentRegistered value)? paymentRegistered,
    TResult Function(_PaymentProcessed value)? paymentProcessed,
    TResult Function(_GeneratingReport value)? generatingReport,
    TResult Function(_ReportGenerated value)? reportGenerated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (pendingLoaded != null) {
      return pendingLoaded(this);
    }
    return orElse();
  }
}

abstract class PaymentsPendingLoaded implements PaymentsState {
  const factory PaymentsPendingLoaded(
      final List<PaymentModel> pendingPayments) = _$PaymentsPendingLoadedImpl;

  List<PaymentModel> get pendingPayments;
  @JsonKey(ignore: true)
  _$$PaymentsPendingLoadedImplCopyWith<_$PaymentsPendingLoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PaymentsFilteredImplCopyWith<$Res> {
  factory _$$PaymentsFilteredImplCopyWith(_$PaymentsFilteredImpl value,
          $Res Function(_$PaymentsFilteredImpl) then) =
      __$$PaymentsFilteredImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<PaymentModel> payments, String filter});
}

/// @nodoc
class __$$PaymentsFilteredImplCopyWithImpl<$Res>
    extends _$PaymentsStateCopyWithImpl<$Res, _$PaymentsFilteredImpl>
    implements _$$PaymentsFilteredImplCopyWith<$Res> {
  __$$PaymentsFilteredImplCopyWithImpl(_$PaymentsFilteredImpl _value,
      $Res Function(_$PaymentsFilteredImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payments = null,
    Object? filter = null,
  }) {
    return _then(_$PaymentsFilteredImpl(
      null == payments
          ? _value._payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<PaymentModel>,
      null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PaymentsFilteredImpl implements PaymentsFiltered {
  const _$PaymentsFilteredImpl(final List<PaymentModel> payments, this.filter)
      : _payments = payments;

  final List<PaymentModel> _payments;
  @override
  List<PaymentModel> get payments {
    if (_payments is EqualUnmodifiableListView) return _payments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_payments);
  }

  @override
  final String filter;

  @override
  String toString() {
    return 'PaymentsState.filtered(payments: $payments, filter: $filter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentsFilteredImpl &&
            const DeepCollectionEquality().equals(other._payments, _payments) &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_payments), filter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentsFilteredImplCopyWith<_$PaymentsFilteredImpl> get copyWith =>
      __$$PaymentsFilteredImplCopyWithImpl<_$PaymentsFilteredImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PaymentModel> payments) loaded,
    required TResult Function(List<PaymentModel> pendingPayments) pendingLoaded,
    required TResult Function(List<PaymentModel> payments, String filter)
        filtered,
    required TResult Function(List<PaymentModel> payments, String query)
        searched,
    required TResult Function() processing,
    required TResult Function(PaymentModel payment, String message)
        paymentRegistered,
    required TResult Function(PaymentModel payment, String message)
        paymentProcessed,
    required TResult Function() generatingReport,
    required TResult Function(PaymentReport report) reportGenerated,
    required TResult Function(String message) error,
  }) {
    return filtered(payments, filter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PaymentModel> payments)? loaded,
    TResult? Function(List<PaymentModel> pendingPayments)? pendingLoaded,
    TResult? Function(List<PaymentModel> payments, String filter)? filtered,
    TResult? Function(List<PaymentModel> payments, String query)? searched,
    TResult? Function()? processing,
    TResult? Function(PaymentModel payment, String message)? paymentRegistered,
    TResult? Function(PaymentModel payment, String message)? paymentProcessed,
    TResult? Function()? generatingReport,
    TResult? Function(PaymentReport report)? reportGenerated,
    TResult? Function(String message)? error,
  }) {
    return filtered?.call(payments, filter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PaymentModel> payments)? loaded,
    TResult Function(List<PaymentModel> pendingPayments)? pendingLoaded,
    TResult Function(List<PaymentModel> payments, String filter)? filtered,
    TResult Function(List<PaymentModel> payments, String query)? searched,
    TResult Function()? processing,
    TResult Function(PaymentModel payment, String message)? paymentRegistered,
    TResult Function(PaymentModel payment, String message)? paymentProcessed,
    TResult Function()? generatingReport,
    TResult Function(PaymentReport report)? reportGenerated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (filtered != null) {
      return filtered(payments, filter);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(PaymentsLoaded value) loaded,
    required TResult Function(PaymentsPendingLoaded value) pendingLoaded,
    required TResult Function(PaymentsFiltered value) filtered,
    required TResult Function(PaymentsSearched value) searched,
    required TResult Function(_Processing value) processing,
    required TResult Function(_PaymentRegistered value) paymentRegistered,
    required TResult Function(_PaymentProcessed value) paymentProcessed,
    required TResult Function(_GeneratingReport value) generatingReport,
    required TResult Function(_ReportGenerated value) reportGenerated,
    required TResult Function(_Error value) error,
  }) {
    return filtered(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(PaymentsLoaded value)? loaded,
    TResult? Function(PaymentsPendingLoaded value)? pendingLoaded,
    TResult? Function(PaymentsFiltered value)? filtered,
    TResult? Function(PaymentsSearched value)? searched,
    TResult? Function(_Processing value)? processing,
    TResult? Function(_PaymentRegistered value)? paymentRegistered,
    TResult? Function(_PaymentProcessed value)? paymentProcessed,
    TResult? Function(_GeneratingReport value)? generatingReport,
    TResult? Function(_ReportGenerated value)? reportGenerated,
    TResult? Function(_Error value)? error,
  }) {
    return filtered?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(PaymentsLoaded value)? loaded,
    TResult Function(PaymentsPendingLoaded value)? pendingLoaded,
    TResult Function(PaymentsFiltered value)? filtered,
    TResult Function(PaymentsSearched value)? searched,
    TResult Function(_Processing value)? processing,
    TResult Function(_PaymentRegistered value)? paymentRegistered,
    TResult Function(_PaymentProcessed value)? paymentProcessed,
    TResult Function(_GeneratingReport value)? generatingReport,
    TResult Function(_ReportGenerated value)? reportGenerated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (filtered != null) {
      return filtered(this);
    }
    return orElse();
  }
}

abstract class PaymentsFiltered implements PaymentsState {
  const factory PaymentsFiltered(
          final List<PaymentModel> payments, final String filter) =
      _$PaymentsFilteredImpl;

  List<PaymentModel> get payments;
  String get filter;
  @JsonKey(ignore: true)
  _$$PaymentsFilteredImplCopyWith<_$PaymentsFilteredImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PaymentsSearchedImplCopyWith<$Res> {
  factory _$$PaymentsSearchedImplCopyWith(_$PaymentsSearchedImpl value,
          $Res Function(_$PaymentsSearchedImpl) then) =
      __$$PaymentsSearchedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<PaymentModel> payments, String query});
}

/// @nodoc
class __$$PaymentsSearchedImplCopyWithImpl<$Res>
    extends _$PaymentsStateCopyWithImpl<$Res, _$PaymentsSearchedImpl>
    implements _$$PaymentsSearchedImplCopyWith<$Res> {
  __$$PaymentsSearchedImplCopyWithImpl(_$PaymentsSearchedImpl _value,
      $Res Function(_$PaymentsSearchedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payments = null,
    Object? query = null,
  }) {
    return _then(_$PaymentsSearchedImpl(
      null == payments
          ? _value._payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<PaymentModel>,
      null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PaymentsSearchedImpl implements PaymentsSearched {
  const _$PaymentsSearchedImpl(final List<PaymentModel> payments, this.query)
      : _payments = payments;

  final List<PaymentModel> _payments;
  @override
  List<PaymentModel> get payments {
    if (_payments is EqualUnmodifiableListView) return _payments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_payments);
  }

  @override
  final String query;

  @override
  String toString() {
    return 'PaymentsState.searched(payments: $payments, query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentsSearchedImpl &&
            const DeepCollectionEquality().equals(other._payments, _payments) &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_payments), query);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentsSearchedImplCopyWith<_$PaymentsSearchedImpl> get copyWith =>
      __$$PaymentsSearchedImplCopyWithImpl<_$PaymentsSearchedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PaymentModel> payments) loaded,
    required TResult Function(List<PaymentModel> pendingPayments) pendingLoaded,
    required TResult Function(List<PaymentModel> payments, String filter)
        filtered,
    required TResult Function(List<PaymentModel> payments, String query)
        searched,
    required TResult Function() processing,
    required TResult Function(PaymentModel payment, String message)
        paymentRegistered,
    required TResult Function(PaymentModel payment, String message)
        paymentProcessed,
    required TResult Function() generatingReport,
    required TResult Function(PaymentReport report) reportGenerated,
    required TResult Function(String message) error,
  }) {
    return searched(payments, query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PaymentModel> payments)? loaded,
    TResult? Function(List<PaymentModel> pendingPayments)? pendingLoaded,
    TResult? Function(List<PaymentModel> payments, String filter)? filtered,
    TResult? Function(List<PaymentModel> payments, String query)? searched,
    TResult? Function()? processing,
    TResult? Function(PaymentModel payment, String message)? paymentRegistered,
    TResult? Function(PaymentModel payment, String message)? paymentProcessed,
    TResult? Function()? generatingReport,
    TResult? Function(PaymentReport report)? reportGenerated,
    TResult? Function(String message)? error,
  }) {
    return searched?.call(payments, query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PaymentModel> payments)? loaded,
    TResult Function(List<PaymentModel> pendingPayments)? pendingLoaded,
    TResult Function(List<PaymentModel> payments, String filter)? filtered,
    TResult Function(List<PaymentModel> payments, String query)? searched,
    TResult Function()? processing,
    TResult Function(PaymentModel payment, String message)? paymentRegistered,
    TResult Function(PaymentModel payment, String message)? paymentProcessed,
    TResult Function()? generatingReport,
    TResult Function(PaymentReport report)? reportGenerated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (searched != null) {
      return searched(payments, query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(PaymentsLoaded value) loaded,
    required TResult Function(PaymentsPendingLoaded value) pendingLoaded,
    required TResult Function(PaymentsFiltered value) filtered,
    required TResult Function(PaymentsSearched value) searched,
    required TResult Function(_Processing value) processing,
    required TResult Function(_PaymentRegistered value) paymentRegistered,
    required TResult Function(_PaymentProcessed value) paymentProcessed,
    required TResult Function(_GeneratingReport value) generatingReport,
    required TResult Function(_ReportGenerated value) reportGenerated,
    required TResult Function(_Error value) error,
  }) {
    return searched(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(PaymentsLoaded value)? loaded,
    TResult? Function(PaymentsPendingLoaded value)? pendingLoaded,
    TResult? Function(PaymentsFiltered value)? filtered,
    TResult? Function(PaymentsSearched value)? searched,
    TResult? Function(_Processing value)? processing,
    TResult? Function(_PaymentRegistered value)? paymentRegistered,
    TResult? Function(_PaymentProcessed value)? paymentProcessed,
    TResult? Function(_GeneratingReport value)? generatingReport,
    TResult? Function(_ReportGenerated value)? reportGenerated,
    TResult? Function(_Error value)? error,
  }) {
    return searched?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(PaymentsLoaded value)? loaded,
    TResult Function(PaymentsPendingLoaded value)? pendingLoaded,
    TResult Function(PaymentsFiltered value)? filtered,
    TResult Function(PaymentsSearched value)? searched,
    TResult Function(_Processing value)? processing,
    TResult Function(_PaymentRegistered value)? paymentRegistered,
    TResult Function(_PaymentProcessed value)? paymentProcessed,
    TResult Function(_GeneratingReport value)? generatingReport,
    TResult Function(_ReportGenerated value)? reportGenerated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (searched != null) {
      return searched(this);
    }
    return orElse();
  }
}

abstract class PaymentsSearched implements PaymentsState {
  const factory PaymentsSearched(
          final List<PaymentModel> payments, final String query) =
      _$PaymentsSearchedImpl;

  List<PaymentModel> get payments;
  String get query;
  @JsonKey(ignore: true)
  _$$PaymentsSearchedImplCopyWith<_$PaymentsSearchedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProcessingImplCopyWith<$Res> {
  factory _$$ProcessingImplCopyWith(
          _$ProcessingImpl value, $Res Function(_$ProcessingImpl) then) =
      __$$ProcessingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProcessingImplCopyWithImpl<$Res>
    extends _$PaymentsStateCopyWithImpl<$Res, _$ProcessingImpl>
    implements _$$ProcessingImplCopyWith<$Res> {
  __$$ProcessingImplCopyWithImpl(
      _$ProcessingImpl _value, $Res Function(_$ProcessingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ProcessingImpl implements _Processing {
  const _$ProcessingImpl();

  @override
  String toString() {
    return 'PaymentsState.processing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ProcessingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PaymentModel> payments) loaded,
    required TResult Function(List<PaymentModel> pendingPayments) pendingLoaded,
    required TResult Function(List<PaymentModel> payments, String filter)
        filtered,
    required TResult Function(List<PaymentModel> payments, String query)
        searched,
    required TResult Function() processing,
    required TResult Function(PaymentModel payment, String message)
        paymentRegistered,
    required TResult Function(PaymentModel payment, String message)
        paymentProcessed,
    required TResult Function() generatingReport,
    required TResult Function(PaymentReport report) reportGenerated,
    required TResult Function(String message) error,
  }) {
    return processing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PaymentModel> payments)? loaded,
    TResult? Function(List<PaymentModel> pendingPayments)? pendingLoaded,
    TResult? Function(List<PaymentModel> payments, String filter)? filtered,
    TResult? Function(List<PaymentModel> payments, String query)? searched,
    TResult? Function()? processing,
    TResult? Function(PaymentModel payment, String message)? paymentRegistered,
    TResult? Function(PaymentModel payment, String message)? paymentProcessed,
    TResult? Function()? generatingReport,
    TResult? Function(PaymentReport report)? reportGenerated,
    TResult? Function(String message)? error,
  }) {
    return processing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PaymentModel> payments)? loaded,
    TResult Function(List<PaymentModel> pendingPayments)? pendingLoaded,
    TResult Function(List<PaymentModel> payments, String filter)? filtered,
    TResult Function(List<PaymentModel> payments, String query)? searched,
    TResult Function()? processing,
    TResult Function(PaymentModel payment, String message)? paymentRegistered,
    TResult Function(PaymentModel payment, String message)? paymentProcessed,
    TResult Function()? generatingReport,
    TResult Function(PaymentReport report)? reportGenerated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(PaymentsLoaded value) loaded,
    required TResult Function(PaymentsPendingLoaded value) pendingLoaded,
    required TResult Function(PaymentsFiltered value) filtered,
    required TResult Function(PaymentsSearched value) searched,
    required TResult Function(_Processing value) processing,
    required TResult Function(_PaymentRegistered value) paymentRegistered,
    required TResult Function(_PaymentProcessed value) paymentProcessed,
    required TResult Function(_GeneratingReport value) generatingReport,
    required TResult Function(_ReportGenerated value) reportGenerated,
    required TResult Function(_Error value) error,
  }) {
    return processing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(PaymentsLoaded value)? loaded,
    TResult? Function(PaymentsPendingLoaded value)? pendingLoaded,
    TResult? Function(PaymentsFiltered value)? filtered,
    TResult? Function(PaymentsSearched value)? searched,
    TResult? Function(_Processing value)? processing,
    TResult? Function(_PaymentRegistered value)? paymentRegistered,
    TResult? Function(_PaymentProcessed value)? paymentProcessed,
    TResult? Function(_GeneratingReport value)? generatingReport,
    TResult? Function(_ReportGenerated value)? reportGenerated,
    TResult? Function(_Error value)? error,
  }) {
    return processing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(PaymentsLoaded value)? loaded,
    TResult Function(PaymentsPendingLoaded value)? pendingLoaded,
    TResult Function(PaymentsFiltered value)? filtered,
    TResult Function(PaymentsSearched value)? searched,
    TResult Function(_Processing value)? processing,
    TResult Function(_PaymentRegistered value)? paymentRegistered,
    TResult Function(_PaymentProcessed value)? paymentProcessed,
    TResult Function(_GeneratingReport value)? generatingReport,
    TResult Function(_ReportGenerated value)? reportGenerated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing(this);
    }
    return orElse();
  }
}

abstract class _Processing implements PaymentsState {
  const factory _Processing() = _$ProcessingImpl;
}

/// @nodoc
abstract class _$$PaymentRegisteredImplCopyWith<$Res> {
  factory _$$PaymentRegisteredImplCopyWith(_$PaymentRegisteredImpl value,
          $Res Function(_$PaymentRegisteredImpl) then) =
      __$$PaymentRegisteredImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PaymentModel payment, String message});
}

/// @nodoc
class __$$PaymentRegisteredImplCopyWithImpl<$Res>
    extends _$PaymentsStateCopyWithImpl<$Res, _$PaymentRegisteredImpl>
    implements _$$PaymentRegisteredImplCopyWith<$Res> {
  __$$PaymentRegisteredImplCopyWithImpl(_$PaymentRegisteredImpl _value,
      $Res Function(_$PaymentRegisteredImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payment = null,
    Object? message = null,
  }) {
    return _then(_$PaymentRegisteredImpl(
      null == payment
          ? _value.payment
          : payment // ignore: cast_nullable_to_non_nullable
              as PaymentModel,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PaymentRegisteredImpl implements _PaymentRegistered {
  const _$PaymentRegisteredImpl(this.payment, this.message);

  @override
  final PaymentModel payment;
  @override
  final String message;

  @override
  String toString() {
    return 'PaymentsState.paymentRegistered(payment: $payment, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentRegisteredImpl &&
            (identical(other.payment, payment) || other.payment == payment) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, payment, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentRegisteredImplCopyWith<_$PaymentRegisteredImpl> get copyWith =>
      __$$PaymentRegisteredImplCopyWithImpl<_$PaymentRegisteredImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PaymentModel> payments) loaded,
    required TResult Function(List<PaymentModel> pendingPayments) pendingLoaded,
    required TResult Function(List<PaymentModel> payments, String filter)
        filtered,
    required TResult Function(List<PaymentModel> payments, String query)
        searched,
    required TResult Function() processing,
    required TResult Function(PaymentModel payment, String message)
        paymentRegistered,
    required TResult Function(PaymentModel payment, String message)
        paymentProcessed,
    required TResult Function() generatingReport,
    required TResult Function(PaymentReport report) reportGenerated,
    required TResult Function(String message) error,
  }) {
    return paymentRegistered(payment, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PaymentModel> payments)? loaded,
    TResult? Function(List<PaymentModel> pendingPayments)? pendingLoaded,
    TResult? Function(List<PaymentModel> payments, String filter)? filtered,
    TResult? Function(List<PaymentModel> payments, String query)? searched,
    TResult? Function()? processing,
    TResult? Function(PaymentModel payment, String message)? paymentRegistered,
    TResult? Function(PaymentModel payment, String message)? paymentProcessed,
    TResult? Function()? generatingReport,
    TResult? Function(PaymentReport report)? reportGenerated,
    TResult? Function(String message)? error,
  }) {
    return paymentRegistered?.call(payment, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PaymentModel> payments)? loaded,
    TResult Function(List<PaymentModel> pendingPayments)? pendingLoaded,
    TResult Function(List<PaymentModel> payments, String filter)? filtered,
    TResult Function(List<PaymentModel> payments, String query)? searched,
    TResult Function()? processing,
    TResult Function(PaymentModel payment, String message)? paymentRegistered,
    TResult Function(PaymentModel payment, String message)? paymentProcessed,
    TResult Function()? generatingReport,
    TResult Function(PaymentReport report)? reportGenerated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (paymentRegistered != null) {
      return paymentRegistered(payment, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(PaymentsLoaded value) loaded,
    required TResult Function(PaymentsPendingLoaded value) pendingLoaded,
    required TResult Function(PaymentsFiltered value) filtered,
    required TResult Function(PaymentsSearched value) searched,
    required TResult Function(_Processing value) processing,
    required TResult Function(_PaymentRegistered value) paymentRegistered,
    required TResult Function(_PaymentProcessed value) paymentProcessed,
    required TResult Function(_GeneratingReport value) generatingReport,
    required TResult Function(_ReportGenerated value) reportGenerated,
    required TResult Function(_Error value) error,
  }) {
    return paymentRegistered(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(PaymentsLoaded value)? loaded,
    TResult? Function(PaymentsPendingLoaded value)? pendingLoaded,
    TResult? Function(PaymentsFiltered value)? filtered,
    TResult? Function(PaymentsSearched value)? searched,
    TResult? Function(_Processing value)? processing,
    TResult? Function(_PaymentRegistered value)? paymentRegistered,
    TResult? Function(_PaymentProcessed value)? paymentProcessed,
    TResult? Function(_GeneratingReport value)? generatingReport,
    TResult? Function(_ReportGenerated value)? reportGenerated,
    TResult? Function(_Error value)? error,
  }) {
    return paymentRegistered?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(PaymentsLoaded value)? loaded,
    TResult Function(PaymentsPendingLoaded value)? pendingLoaded,
    TResult Function(PaymentsFiltered value)? filtered,
    TResult Function(PaymentsSearched value)? searched,
    TResult Function(_Processing value)? processing,
    TResult Function(_PaymentRegistered value)? paymentRegistered,
    TResult Function(_PaymentProcessed value)? paymentProcessed,
    TResult Function(_GeneratingReport value)? generatingReport,
    TResult Function(_ReportGenerated value)? reportGenerated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (paymentRegistered != null) {
      return paymentRegistered(this);
    }
    return orElse();
  }
}

abstract class _PaymentRegistered implements PaymentsState {
  const factory _PaymentRegistered(
          final PaymentModel payment, final String message) =
      _$PaymentRegisteredImpl;

  PaymentModel get payment;
  String get message;
  @JsonKey(ignore: true)
  _$$PaymentRegisteredImplCopyWith<_$PaymentRegisteredImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PaymentProcessedImplCopyWith<$Res> {
  factory _$$PaymentProcessedImplCopyWith(_$PaymentProcessedImpl value,
          $Res Function(_$PaymentProcessedImpl) then) =
      __$$PaymentProcessedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PaymentModel payment, String message});
}

/// @nodoc
class __$$PaymentProcessedImplCopyWithImpl<$Res>
    extends _$PaymentsStateCopyWithImpl<$Res, _$PaymentProcessedImpl>
    implements _$$PaymentProcessedImplCopyWith<$Res> {
  __$$PaymentProcessedImplCopyWithImpl(_$PaymentProcessedImpl _value,
      $Res Function(_$PaymentProcessedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payment = null,
    Object? message = null,
  }) {
    return _then(_$PaymentProcessedImpl(
      null == payment
          ? _value.payment
          : payment // ignore: cast_nullable_to_non_nullable
              as PaymentModel,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PaymentProcessedImpl implements _PaymentProcessed {
  const _$PaymentProcessedImpl(this.payment, this.message);

  @override
  final PaymentModel payment;
  @override
  final String message;

  @override
  String toString() {
    return 'PaymentsState.paymentProcessed(payment: $payment, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentProcessedImpl &&
            (identical(other.payment, payment) || other.payment == payment) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, payment, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentProcessedImplCopyWith<_$PaymentProcessedImpl> get copyWith =>
      __$$PaymentProcessedImplCopyWithImpl<_$PaymentProcessedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PaymentModel> payments) loaded,
    required TResult Function(List<PaymentModel> pendingPayments) pendingLoaded,
    required TResult Function(List<PaymentModel> payments, String filter)
        filtered,
    required TResult Function(List<PaymentModel> payments, String query)
        searched,
    required TResult Function() processing,
    required TResult Function(PaymentModel payment, String message)
        paymentRegistered,
    required TResult Function(PaymentModel payment, String message)
        paymentProcessed,
    required TResult Function() generatingReport,
    required TResult Function(PaymentReport report) reportGenerated,
    required TResult Function(String message) error,
  }) {
    return paymentProcessed(payment, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PaymentModel> payments)? loaded,
    TResult? Function(List<PaymentModel> pendingPayments)? pendingLoaded,
    TResult? Function(List<PaymentModel> payments, String filter)? filtered,
    TResult? Function(List<PaymentModel> payments, String query)? searched,
    TResult? Function()? processing,
    TResult? Function(PaymentModel payment, String message)? paymentRegistered,
    TResult? Function(PaymentModel payment, String message)? paymentProcessed,
    TResult? Function()? generatingReport,
    TResult? Function(PaymentReport report)? reportGenerated,
    TResult? Function(String message)? error,
  }) {
    return paymentProcessed?.call(payment, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PaymentModel> payments)? loaded,
    TResult Function(List<PaymentModel> pendingPayments)? pendingLoaded,
    TResult Function(List<PaymentModel> payments, String filter)? filtered,
    TResult Function(List<PaymentModel> payments, String query)? searched,
    TResult Function()? processing,
    TResult Function(PaymentModel payment, String message)? paymentRegistered,
    TResult Function(PaymentModel payment, String message)? paymentProcessed,
    TResult Function()? generatingReport,
    TResult Function(PaymentReport report)? reportGenerated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (paymentProcessed != null) {
      return paymentProcessed(payment, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(PaymentsLoaded value) loaded,
    required TResult Function(PaymentsPendingLoaded value) pendingLoaded,
    required TResult Function(PaymentsFiltered value) filtered,
    required TResult Function(PaymentsSearched value) searched,
    required TResult Function(_Processing value) processing,
    required TResult Function(_PaymentRegistered value) paymentRegistered,
    required TResult Function(_PaymentProcessed value) paymentProcessed,
    required TResult Function(_GeneratingReport value) generatingReport,
    required TResult Function(_ReportGenerated value) reportGenerated,
    required TResult Function(_Error value) error,
  }) {
    return paymentProcessed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(PaymentsLoaded value)? loaded,
    TResult? Function(PaymentsPendingLoaded value)? pendingLoaded,
    TResult? Function(PaymentsFiltered value)? filtered,
    TResult? Function(PaymentsSearched value)? searched,
    TResult? Function(_Processing value)? processing,
    TResult? Function(_PaymentRegistered value)? paymentRegistered,
    TResult? Function(_PaymentProcessed value)? paymentProcessed,
    TResult? Function(_GeneratingReport value)? generatingReport,
    TResult? Function(_ReportGenerated value)? reportGenerated,
    TResult? Function(_Error value)? error,
  }) {
    return paymentProcessed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(PaymentsLoaded value)? loaded,
    TResult Function(PaymentsPendingLoaded value)? pendingLoaded,
    TResult Function(PaymentsFiltered value)? filtered,
    TResult Function(PaymentsSearched value)? searched,
    TResult Function(_Processing value)? processing,
    TResult Function(_PaymentRegistered value)? paymentRegistered,
    TResult Function(_PaymentProcessed value)? paymentProcessed,
    TResult Function(_GeneratingReport value)? generatingReport,
    TResult Function(_ReportGenerated value)? reportGenerated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (paymentProcessed != null) {
      return paymentProcessed(this);
    }
    return orElse();
  }
}

abstract class _PaymentProcessed implements PaymentsState {
  const factory _PaymentProcessed(
          final PaymentModel payment, final String message) =
      _$PaymentProcessedImpl;

  PaymentModel get payment;
  String get message;
  @JsonKey(ignore: true)
  _$$PaymentProcessedImplCopyWith<_$PaymentProcessedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GeneratingReportImplCopyWith<$Res> {
  factory _$$GeneratingReportImplCopyWith(_$GeneratingReportImpl value,
          $Res Function(_$GeneratingReportImpl) then) =
      __$$GeneratingReportImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GeneratingReportImplCopyWithImpl<$Res>
    extends _$PaymentsStateCopyWithImpl<$Res, _$GeneratingReportImpl>
    implements _$$GeneratingReportImplCopyWith<$Res> {
  __$$GeneratingReportImplCopyWithImpl(_$GeneratingReportImpl _value,
      $Res Function(_$GeneratingReportImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GeneratingReportImpl implements _GeneratingReport {
  const _$GeneratingReportImpl();

  @override
  String toString() {
    return 'PaymentsState.generatingReport()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GeneratingReportImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PaymentModel> payments) loaded,
    required TResult Function(List<PaymentModel> pendingPayments) pendingLoaded,
    required TResult Function(List<PaymentModel> payments, String filter)
        filtered,
    required TResult Function(List<PaymentModel> payments, String query)
        searched,
    required TResult Function() processing,
    required TResult Function(PaymentModel payment, String message)
        paymentRegistered,
    required TResult Function(PaymentModel payment, String message)
        paymentProcessed,
    required TResult Function() generatingReport,
    required TResult Function(PaymentReport report) reportGenerated,
    required TResult Function(String message) error,
  }) {
    return generatingReport();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PaymentModel> payments)? loaded,
    TResult? Function(List<PaymentModel> pendingPayments)? pendingLoaded,
    TResult? Function(List<PaymentModel> payments, String filter)? filtered,
    TResult? Function(List<PaymentModel> payments, String query)? searched,
    TResult? Function()? processing,
    TResult? Function(PaymentModel payment, String message)? paymentRegistered,
    TResult? Function(PaymentModel payment, String message)? paymentProcessed,
    TResult? Function()? generatingReport,
    TResult? Function(PaymentReport report)? reportGenerated,
    TResult? Function(String message)? error,
  }) {
    return generatingReport?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PaymentModel> payments)? loaded,
    TResult Function(List<PaymentModel> pendingPayments)? pendingLoaded,
    TResult Function(List<PaymentModel> payments, String filter)? filtered,
    TResult Function(List<PaymentModel> payments, String query)? searched,
    TResult Function()? processing,
    TResult Function(PaymentModel payment, String message)? paymentRegistered,
    TResult Function(PaymentModel payment, String message)? paymentProcessed,
    TResult Function()? generatingReport,
    TResult Function(PaymentReport report)? reportGenerated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (generatingReport != null) {
      return generatingReport();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(PaymentsLoaded value) loaded,
    required TResult Function(PaymentsPendingLoaded value) pendingLoaded,
    required TResult Function(PaymentsFiltered value) filtered,
    required TResult Function(PaymentsSearched value) searched,
    required TResult Function(_Processing value) processing,
    required TResult Function(_PaymentRegistered value) paymentRegistered,
    required TResult Function(_PaymentProcessed value) paymentProcessed,
    required TResult Function(_GeneratingReport value) generatingReport,
    required TResult Function(_ReportGenerated value) reportGenerated,
    required TResult Function(_Error value) error,
  }) {
    return generatingReport(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(PaymentsLoaded value)? loaded,
    TResult? Function(PaymentsPendingLoaded value)? pendingLoaded,
    TResult? Function(PaymentsFiltered value)? filtered,
    TResult? Function(PaymentsSearched value)? searched,
    TResult? Function(_Processing value)? processing,
    TResult? Function(_PaymentRegistered value)? paymentRegistered,
    TResult? Function(_PaymentProcessed value)? paymentProcessed,
    TResult? Function(_GeneratingReport value)? generatingReport,
    TResult? Function(_ReportGenerated value)? reportGenerated,
    TResult? Function(_Error value)? error,
  }) {
    return generatingReport?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(PaymentsLoaded value)? loaded,
    TResult Function(PaymentsPendingLoaded value)? pendingLoaded,
    TResult Function(PaymentsFiltered value)? filtered,
    TResult Function(PaymentsSearched value)? searched,
    TResult Function(_Processing value)? processing,
    TResult Function(_PaymentRegistered value)? paymentRegistered,
    TResult Function(_PaymentProcessed value)? paymentProcessed,
    TResult Function(_GeneratingReport value)? generatingReport,
    TResult Function(_ReportGenerated value)? reportGenerated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (generatingReport != null) {
      return generatingReport(this);
    }
    return orElse();
  }
}

abstract class _GeneratingReport implements PaymentsState {
  const factory _GeneratingReport() = _$GeneratingReportImpl;
}

/// @nodoc
abstract class _$$ReportGeneratedImplCopyWith<$Res> {
  factory _$$ReportGeneratedImplCopyWith(_$ReportGeneratedImpl value,
          $Res Function(_$ReportGeneratedImpl) then) =
      __$$ReportGeneratedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PaymentReport report});

  $PaymentReportCopyWith<$Res> get report;
}

/// @nodoc
class __$$ReportGeneratedImplCopyWithImpl<$Res>
    extends _$PaymentsStateCopyWithImpl<$Res, _$ReportGeneratedImpl>
    implements _$$ReportGeneratedImplCopyWith<$Res> {
  __$$ReportGeneratedImplCopyWithImpl(
      _$ReportGeneratedImpl _value, $Res Function(_$ReportGeneratedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? report = null,
  }) {
    return _then(_$ReportGeneratedImpl(
      null == report
          ? _value.report
          : report // ignore: cast_nullable_to_non_nullable
              as PaymentReport,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $PaymentReportCopyWith<$Res> get report {
    return $PaymentReportCopyWith<$Res>(_value.report, (value) {
      return _then(_value.copyWith(report: value));
    });
  }
}

/// @nodoc

class _$ReportGeneratedImpl implements _ReportGenerated {
  const _$ReportGeneratedImpl(this.report);

  @override
  final PaymentReport report;

  @override
  String toString() {
    return 'PaymentsState.reportGenerated(report: $report)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportGeneratedImpl &&
            (identical(other.report, report) || other.report == report));
  }

  @override
  int get hashCode => Object.hash(runtimeType, report);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportGeneratedImplCopyWith<_$ReportGeneratedImpl> get copyWith =>
      __$$ReportGeneratedImplCopyWithImpl<_$ReportGeneratedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PaymentModel> payments) loaded,
    required TResult Function(List<PaymentModel> pendingPayments) pendingLoaded,
    required TResult Function(List<PaymentModel> payments, String filter)
        filtered,
    required TResult Function(List<PaymentModel> payments, String query)
        searched,
    required TResult Function() processing,
    required TResult Function(PaymentModel payment, String message)
        paymentRegistered,
    required TResult Function(PaymentModel payment, String message)
        paymentProcessed,
    required TResult Function() generatingReport,
    required TResult Function(PaymentReport report) reportGenerated,
    required TResult Function(String message) error,
  }) {
    return reportGenerated(report);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PaymentModel> payments)? loaded,
    TResult? Function(List<PaymentModel> pendingPayments)? pendingLoaded,
    TResult? Function(List<PaymentModel> payments, String filter)? filtered,
    TResult? Function(List<PaymentModel> payments, String query)? searched,
    TResult? Function()? processing,
    TResult? Function(PaymentModel payment, String message)? paymentRegistered,
    TResult? Function(PaymentModel payment, String message)? paymentProcessed,
    TResult? Function()? generatingReport,
    TResult? Function(PaymentReport report)? reportGenerated,
    TResult? Function(String message)? error,
  }) {
    return reportGenerated?.call(report);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PaymentModel> payments)? loaded,
    TResult Function(List<PaymentModel> pendingPayments)? pendingLoaded,
    TResult Function(List<PaymentModel> payments, String filter)? filtered,
    TResult Function(List<PaymentModel> payments, String query)? searched,
    TResult Function()? processing,
    TResult Function(PaymentModel payment, String message)? paymentRegistered,
    TResult Function(PaymentModel payment, String message)? paymentProcessed,
    TResult Function()? generatingReport,
    TResult Function(PaymentReport report)? reportGenerated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (reportGenerated != null) {
      return reportGenerated(report);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(PaymentsLoaded value) loaded,
    required TResult Function(PaymentsPendingLoaded value) pendingLoaded,
    required TResult Function(PaymentsFiltered value) filtered,
    required TResult Function(PaymentsSearched value) searched,
    required TResult Function(_Processing value) processing,
    required TResult Function(_PaymentRegistered value) paymentRegistered,
    required TResult Function(_PaymentProcessed value) paymentProcessed,
    required TResult Function(_GeneratingReport value) generatingReport,
    required TResult Function(_ReportGenerated value) reportGenerated,
    required TResult Function(_Error value) error,
  }) {
    return reportGenerated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(PaymentsLoaded value)? loaded,
    TResult? Function(PaymentsPendingLoaded value)? pendingLoaded,
    TResult? Function(PaymentsFiltered value)? filtered,
    TResult? Function(PaymentsSearched value)? searched,
    TResult? Function(_Processing value)? processing,
    TResult? Function(_PaymentRegistered value)? paymentRegistered,
    TResult? Function(_PaymentProcessed value)? paymentProcessed,
    TResult? Function(_GeneratingReport value)? generatingReport,
    TResult? Function(_ReportGenerated value)? reportGenerated,
    TResult? Function(_Error value)? error,
  }) {
    return reportGenerated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(PaymentsLoaded value)? loaded,
    TResult Function(PaymentsPendingLoaded value)? pendingLoaded,
    TResult Function(PaymentsFiltered value)? filtered,
    TResult Function(PaymentsSearched value)? searched,
    TResult Function(_Processing value)? processing,
    TResult Function(_PaymentRegistered value)? paymentRegistered,
    TResult Function(_PaymentProcessed value)? paymentProcessed,
    TResult Function(_GeneratingReport value)? generatingReport,
    TResult Function(_ReportGenerated value)? reportGenerated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (reportGenerated != null) {
      return reportGenerated(this);
    }
    return orElse();
  }
}

abstract class _ReportGenerated implements PaymentsState {
  const factory _ReportGenerated(final PaymentReport report) =
      _$ReportGeneratedImpl;

  PaymentReport get report;
  @JsonKey(ignore: true)
  _$$ReportGeneratedImplCopyWith<_$ReportGeneratedImpl> get copyWith =>
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
    extends _$PaymentsStateCopyWithImpl<$Res, _$ErrorImpl>
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
    return 'PaymentsState.error(message: $message)';
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
    required TResult Function(List<PaymentModel> payments) loaded,
    required TResult Function(List<PaymentModel> pendingPayments) pendingLoaded,
    required TResult Function(List<PaymentModel> payments, String filter)
        filtered,
    required TResult Function(List<PaymentModel> payments, String query)
        searched,
    required TResult Function() processing,
    required TResult Function(PaymentModel payment, String message)
        paymentRegistered,
    required TResult Function(PaymentModel payment, String message)
        paymentProcessed,
    required TResult Function() generatingReport,
    required TResult Function(PaymentReport report) reportGenerated,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PaymentModel> payments)? loaded,
    TResult? Function(List<PaymentModel> pendingPayments)? pendingLoaded,
    TResult? Function(List<PaymentModel> payments, String filter)? filtered,
    TResult? Function(List<PaymentModel> payments, String query)? searched,
    TResult? Function()? processing,
    TResult? Function(PaymentModel payment, String message)? paymentRegistered,
    TResult? Function(PaymentModel payment, String message)? paymentProcessed,
    TResult? Function()? generatingReport,
    TResult? Function(PaymentReport report)? reportGenerated,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PaymentModel> payments)? loaded,
    TResult Function(List<PaymentModel> pendingPayments)? pendingLoaded,
    TResult Function(List<PaymentModel> payments, String filter)? filtered,
    TResult Function(List<PaymentModel> payments, String query)? searched,
    TResult Function()? processing,
    TResult Function(PaymentModel payment, String message)? paymentRegistered,
    TResult Function(PaymentModel payment, String message)? paymentProcessed,
    TResult Function()? generatingReport,
    TResult Function(PaymentReport report)? reportGenerated,
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
    required TResult Function(PaymentsLoaded value) loaded,
    required TResult Function(PaymentsPendingLoaded value) pendingLoaded,
    required TResult Function(PaymentsFiltered value) filtered,
    required TResult Function(PaymentsSearched value) searched,
    required TResult Function(_Processing value) processing,
    required TResult Function(_PaymentRegistered value) paymentRegistered,
    required TResult Function(_PaymentProcessed value) paymentProcessed,
    required TResult Function(_GeneratingReport value) generatingReport,
    required TResult Function(_ReportGenerated value) reportGenerated,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(PaymentsLoaded value)? loaded,
    TResult? Function(PaymentsPendingLoaded value)? pendingLoaded,
    TResult? Function(PaymentsFiltered value)? filtered,
    TResult? Function(PaymentsSearched value)? searched,
    TResult? Function(_Processing value)? processing,
    TResult? Function(_PaymentRegistered value)? paymentRegistered,
    TResult? Function(_PaymentProcessed value)? paymentProcessed,
    TResult? Function(_GeneratingReport value)? generatingReport,
    TResult? Function(_ReportGenerated value)? reportGenerated,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(PaymentsLoaded value)? loaded,
    TResult Function(PaymentsPendingLoaded value)? pendingLoaded,
    TResult Function(PaymentsFiltered value)? filtered,
    TResult Function(PaymentsSearched value)? searched,
    TResult Function(_Processing value)? processing,
    TResult Function(_PaymentRegistered value)? paymentRegistered,
    TResult Function(_PaymentProcessed value)? paymentProcessed,
    TResult Function(_GeneratingReport value)? generatingReport,
    TResult Function(_ReportGenerated value)? reportGenerated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements PaymentsState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PaymentReport {
  String get period => throw _privateConstructorUsedError;
  int get totalPayments => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  double get averagePayment => throw _privateConstructorUsedError;
  List<PaymentMethodSummary> get paymentsByMethod =>
      throw _privateConstructorUsedError;
  List<DailyPaymentSummary> get dailyPayments =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PaymentReportCopyWith<PaymentReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentReportCopyWith<$Res> {
  factory $PaymentReportCopyWith(
          PaymentReport value, $Res Function(PaymentReport) then) =
      _$PaymentReportCopyWithImpl<$Res, PaymentReport>;
  @useResult
  $Res call(
      {String period,
      int totalPayments,
      double totalAmount,
      double averagePayment,
      List<PaymentMethodSummary> paymentsByMethod,
      List<DailyPaymentSummary> dailyPayments});
}

/// @nodoc
class _$PaymentReportCopyWithImpl<$Res, $Val extends PaymentReport>
    implements $PaymentReportCopyWith<$Res> {
  _$PaymentReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? totalPayments = null,
    Object? totalAmount = null,
    Object? averagePayment = null,
    Object? paymentsByMethod = null,
    Object? dailyPayments = null,
  }) {
    return _then(_value.copyWith(
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      totalPayments: null == totalPayments
          ? _value.totalPayments
          : totalPayments // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      averagePayment: null == averagePayment
          ? _value.averagePayment
          : averagePayment // ignore: cast_nullable_to_non_nullable
              as double,
      paymentsByMethod: null == paymentsByMethod
          ? _value.paymentsByMethod
          : paymentsByMethod // ignore: cast_nullable_to_non_nullable
              as List<PaymentMethodSummary>,
      dailyPayments: null == dailyPayments
          ? _value.dailyPayments
          : dailyPayments // ignore: cast_nullable_to_non_nullable
              as List<DailyPaymentSummary>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentReportImplCopyWith<$Res>
    implements $PaymentReportCopyWith<$Res> {
  factory _$$PaymentReportImplCopyWith(
          _$PaymentReportImpl value, $Res Function(_$PaymentReportImpl) then) =
      __$$PaymentReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String period,
      int totalPayments,
      double totalAmount,
      double averagePayment,
      List<PaymentMethodSummary> paymentsByMethod,
      List<DailyPaymentSummary> dailyPayments});
}

/// @nodoc
class __$$PaymentReportImplCopyWithImpl<$Res>
    extends _$PaymentReportCopyWithImpl<$Res, _$PaymentReportImpl>
    implements _$$PaymentReportImplCopyWith<$Res> {
  __$$PaymentReportImplCopyWithImpl(
      _$PaymentReportImpl _value, $Res Function(_$PaymentReportImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? totalPayments = null,
    Object? totalAmount = null,
    Object? averagePayment = null,
    Object? paymentsByMethod = null,
    Object? dailyPayments = null,
  }) {
    return _then(_$PaymentReportImpl(
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      totalPayments: null == totalPayments
          ? _value.totalPayments
          : totalPayments // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      averagePayment: null == averagePayment
          ? _value.averagePayment
          : averagePayment // ignore: cast_nullable_to_non_nullable
              as double,
      paymentsByMethod: null == paymentsByMethod
          ? _value._paymentsByMethod
          : paymentsByMethod // ignore: cast_nullable_to_non_nullable
              as List<PaymentMethodSummary>,
      dailyPayments: null == dailyPayments
          ? _value._dailyPayments
          : dailyPayments // ignore: cast_nullable_to_non_nullable
              as List<DailyPaymentSummary>,
    ));
  }
}

/// @nodoc

class _$PaymentReportImpl implements _PaymentReport {
  const _$PaymentReportImpl(
      {required this.period,
      required this.totalPayments,
      required this.totalAmount,
      required this.averagePayment,
      required final List<PaymentMethodSummary> paymentsByMethod,
      required final List<DailyPaymentSummary> dailyPayments})
      : _paymentsByMethod = paymentsByMethod,
        _dailyPayments = dailyPayments;

  @override
  final String period;
  @override
  final int totalPayments;
  @override
  final double totalAmount;
  @override
  final double averagePayment;
  final List<PaymentMethodSummary> _paymentsByMethod;
  @override
  List<PaymentMethodSummary> get paymentsByMethod {
    if (_paymentsByMethod is EqualUnmodifiableListView)
      return _paymentsByMethod;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paymentsByMethod);
  }

  final List<DailyPaymentSummary> _dailyPayments;
  @override
  List<DailyPaymentSummary> get dailyPayments {
    if (_dailyPayments is EqualUnmodifiableListView) return _dailyPayments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailyPayments);
  }

  @override
  String toString() {
    return 'PaymentReport(period: $period, totalPayments: $totalPayments, totalAmount: $totalAmount, averagePayment: $averagePayment, paymentsByMethod: $paymentsByMethod, dailyPayments: $dailyPayments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentReportImpl &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.totalPayments, totalPayments) ||
                other.totalPayments == totalPayments) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.averagePayment, averagePayment) ||
                other.averagePayment == averagePayment) &&
            const DeepCollectionEquality()
                .equals(other._paymentsByMethod, _paymentsByMethod) &&
            const DeepCollectionEquality()
                .equals(other._dailyPayments, _dailyPayments));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      period,
      totalPayments,
      totalAmount,
      averagePayment,
      const DeepCollectionEquality().hash(_paymentsByMethod),
      const DeepCollectionEquality().hash(_dailyPayments));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentReportImplCopyWith<_$PaymentReportImpl> get copyWith =>
      __$$PaymentReportImplCopyWithImpl<_$PaymentReportImpl>(this, _$identity);
}

abstract class _PaymentReport implements PaymentReport {
  const factory _PaymentReport(
          {required final String period,
          required final int totalPayments,
          required final double totalAmount,
          required final double averagePayment,
          required final List<PaymentMethodSummary> paymentsByMethod,
          required final List<DailyPaymentSummary> dailyPayments}) =
      _$PaymentReportImpl;

  @override
  String get period;
  @override
  int get totalPayments;
  @override
  double get totalAmount;
  @override
  double get averagePayment;
  @override
  List<PaymentMethodSummary> get paymentsByMethod;
  @override
  List<DailyPaymentSummary> get dailyPayments;
  @override
  @JsonKey(ignore: true)
  _$$PaymentReportImplCopyWith<_$PaymentReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PaymentMethodSummary {
  String get method => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PaymentMethodSummaryCopyWith<PaymentMethodSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentMethodSummaryCopyWith<$Res> {
  factory $PaymentMethodSummaryCopyWith(PaymentMethodSummary value,
          $Res Function(PaymentMethodSummary) then) =
      _$PaymentMethodSummaryCopyWithImpl<$Res, PaymentMethodSummary>;
  @useResult
  $Res call({String method, int count, double amount});
}

/// @nodoc
class _$PaymentMethodSummaryCopyWithImpl<$Res,
        $Val extends PaymentMethodSummary>
    implements $PaymentMethodSummaryCopyWith<$Res> {
  _$PaymentMethodSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = null,
    Object? count = null,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentMethodSummaryImplCopyWith<$Res>
    implements $PaymentMethodSummaryCopyWith<$Res> {
  factory _$$PaymentMethodSummaryImplCopyWith(_$PaymentMethodSummaryImpl value,
          $Res Function(_$PaymentMethodSummaryImpl) then) =
      __$$PaymentMethodSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String method, int count, double amount});
}

/// @nodoc
class __$$PaymentMethodSummaryImplCopyWithImpl<$Res>
    extends _$PaymentMethodSummaryCopyWithImpl<$Res, _$PaymentMethodSummaryImpl>
    implements _$$PaymentMethodSummaryImplCopyWith<$Res> {
  __$$PaymentMethodSummaryImplCopyWithImpl(_$PaymentMethodSummaryImpl _value,
      $Res Function(_$PaymentMethodSummaryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = null,
    Object? count = null,
    Object? amount = null,
  }) {
    return _then(_$PaymentMethodSummaryImpl(
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$PaymentMethodSummaryImpl implements _PaymentMethodSummary {
  const _$PaymentMethodSummaryImpl(
      {required this.method, required this.count, required this.amount});

  @override
  final String method;
  @override
  final int count;
  @override
  final double amount;

  @override
  String toString() {
    return 'PaymentMethodSummary(method: $method, count: $count, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentMethodSummaryImpl &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, method, count, amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentMethodSummaryImplCopyWith<_$PaymentMethodSummaryImpl>
      get copyWith =>
          __$$PaymentMethodSummaryImplCopyWithImpl<_$PaymentMethodSummaryImpl>(
              this, _$identity);
}

abstract class _PaymentMethodSummary implements PaymentMethodSummary {
  const factory _PaymentMethodSummary(
      {required final String method,
      required final int count,
      required final double amount}) = _$PaymentMethodSummaryImpl;

  @override
  String get method;
  @override
  int get count;
  @override
  double get amount;
  @override
  @JsonKey(ignore: true)
  _$$PaymentMethodSummaryImplCopyWith<_$PaymentMethodSummaryImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DailyPaymentSummary {
  DateTime get date => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DailyPaymentSummaryCopyWith<DailyPaymentSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyPaymentSummaryCopyWith<$Res> {
  factory $DailyPaymentSummaryCopyWith(
          DailyPaymentSummary value, $Res Function(DailyPaymentSummary) then) =
      _$DailyPaymentSummaryCopyWithImpl<$Res, DailyPaymentSummary>;
  @useResult
  $Res call({DateTime date, int count, double amount});
}

/// @nodoc
class _$DailyPaymentSummaryCopyWithImpl<$Res, $Val extends DailyPaymentSummary>
    implements $DailyPaymentSummaryCopyWith<$Res> {
  _$DailyPaymentSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? count = null,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyPaymentSummaryImplCopyWith<$Res>
    implements $DailyPaymentSummaryCopyWith<$Res> {
  factory _$$DailyPaymentSummaryImplCopyWith(_$DailyPaymentSummaryImpl value,
          $Res Function(_$DailyPaymentSummaryImpl) then) =
      __$$DailyPaymentSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime date, int count, double amount});
}

/// @nodoc
class __$$DailyPaymentSummaryImplCopyWithImpl<$Res>
    extends _$DailyPaymentSummaryCopyWithImpl<$Res, _$DailyPaymentSummaryImpl>
    implements _$$DailyPaymentSummaryImplCopyWith<$Res> {
  __$$DailyPaymentSummaryImplCopyWithImpl(_$DailyPaymentSummaryImpl _value,
      $Res Function(_$DailyPaymentSummaryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? count = null,
    Object? amount = null,
  }) {
    return _then(_$DailyPaymentSummaryImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$DailyPaymentSummaryImpl implements _DailyPaymentSummary {
  const _$DailyPaymentSummaryImpl(
      {required this.date, required this.count, required this.amount});

  @override
  final DateTime date;
  @override
  final int count;
  @override
  final double amount;

  @override
  String toString() {
    return 'DailyPaymentSummary(date: $date, count: $count, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyPaymentSummaryImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date, count, amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyPaymentSummaryImplCopyWith<_$DailyPaymentSummaryImpl> get copyWith =>
      __$$DailyPaymentSummaryImplCopyWithImpl<_$DailyPaymentSummaryImpl>(
          this, _$identity);
}

abstract class _DailyPaymentSummary implements DailyPaymentSummary {
  const factory _DailyPaymentSummary(
      {required final DateTime date,
      required final int count,
      required final double amount}) = _$DailyPaymentSummaryImpl;

  @override
  DateTime get date;
  @override
  int get count;
  @override
  double get amount;
  @override
  @JsonKey(ignore: true)
  _$$DailyPaymentSummaryImplCopyWith<_$DailyPaymentSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

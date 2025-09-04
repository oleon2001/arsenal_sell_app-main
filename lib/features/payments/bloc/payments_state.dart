part of 'payments_cubit.dart';

@freezed
class PaymentsState with _$PaymentsState {
  const factory PaymentsState.initial() = _Initial;
  const factory PaymentsState.loading() = _Loading;
  const factory PaymentsState.loaded(List<Payment> payments) = PaymentsLoaded;
  const factory PaymentsState.pendingLoaded(List<Payment> pendingPayments) =
      PaymentsPendingLoaded;
  const factory PaymentsState.filtered(List<Payment> payments, String filter) =
      PaymentsFiltered;
  const factory PaymentsState.searched(List<Payment> payments, String query) =
      PaymentsSearched;
  const factory PaymentsState.processing() = _Processing;
  const factory PaymentsState.paymentRegistered(
      Payment payment, String message) = _PaymentRegistered;
  const factory PaymentsState.paymentProcessed(
      Payment payment, String message) = _PaymentProcessed;
  const factory PaymentsState.generatingReport() = _GeneratingReport;
  const factory PaymentsState.reportGenerated(PaymentReport report) =
      _ReportGenerated;
  const factory PaymentsState.error(String message) = _Error;
}

@freezed
class PaymentReport with _$PaymentReport {
  const factory PaymentReport({
    required String period,
    required int totalPayments,
    required double totalAmount,
    required double averagePayment,
    required List<PaymentMethodSummary> paymentsByMethod,
    required List<DailyPaymentSummary> dailyPayments,
  }) = _PaymentReport;
}

@freezed
class PaymentMethodSummary with _$PaymentMethodSummary {
  const factory PaymentMethodSummary({
    required String method,
    required int count,
    required double amount,
  }) = _PaymentMethodSummary;
}

@freezed
class DailyPaymentSummary with _$DailyPaymentSummary {
  const factory DailyPaymentSummary({
    required DateTime date,
    required int count,
    required double amount,
  }) = _DailyPaymentSummary;
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../config/logger.dart';
import '../../../data/repositories/payments_repository.dart';
import '../../../data/models/payments/payment.dart';

part 'payments_cubit.freezed.dart';
part 'payments_state.dart';

class PaymentsCubit extends Cubit<PaymentsState> {
  PaymentsCubit(this._repository) : super(const PaymentsState.initial());
  final PaymentsRepository _repository;

  Future<void> loadPayments({bool forceSync = false}) async {
    emit(const PaymentsState.loading());

    try {
      final payments = await _repository.getPayments(forceSync: forceSync);
      emit(PaymentsState.loaded(payments));
    } catch (e) {
      logger.e('Load payments error: $e');
      emit(PaymentsState.error(e.toString()));
    }
  }

  Future<void> loadPendingPayments() async {
    emit(const PaymentsState.loading());

    try {
      final pendingPayments = await _repository.getPendingPayments();
      emit(PaymentsState.pendingLoaded(pendingPayments));
    } catch (e) {
      logger.e('Load pending payments error: $e');
      emit(PaymentsState.error(e.toString()));
    }
  }

  Future<void> registerPayment({
    required String customerId,
    required double amount,
    PaymentMethod? method,
    String? orderId,
    String? notes,
    String? reference,
  }) async {
    try {
      emit(const PaymentsState.processing());

      final registeredPayment = await _repository.registerPayment(
        customerId: customerId,
        orderId: orderId,
        amount: amount,
        paymentMethod: method ?? PaymentMethod(id: '1', name: 'Efectivo'),
        reference: reference,
        notes: notes,
      );

      // Update the payments list
      final currentState = state;
      if (currentState is PaymentsLoaded) {
        final updatedPayments = [registeredPayment, ...currentState.payments];
        emit(PaymentsState.loaded(updatedPayments));
      } else {
        // If not loaded, just show success
        emit(PaymentsState.paymentRegistered(
          registeredPayment,
          'Pago registrado exitosamente',
        ));
      }
    } catch (e) {
      logger.e('Register payment error: $e');
      emit(PaymentsState.error(e.toString()));
    }
  }

  Future<void> processPayment({
    required String paymentId,
    required double receivedAmount,
    required PaymentMethod method,
    String? notes,
  }) async {
    try {
      emit(const PaymentsState.processing());

      // Find the payment to process
      final currentState = state;
      Payment? paymentToProcess;

      if (currentState is PaymentsPendingLoaded) {
        paymentToProcess =
            currentState.pendingPayments.firstWhere((p) => p.id == paymentId);
      }

      if (paymentToProcess == null) {
        throw Exception('Payment not found');
      }

      // Create processed payment
      final processedPayment = await _repository.registerPayment(
        customerId: paymentToProcess.customerId,
        orderId: paymentToProcess.orderId,
        amount: receivedAmount,
        paymentMethod: method,
        notes: notes,
      );

      emit(PaymentsState.paymentProcessed(
        processedPayment,
        'Pago procesado exitosamente',
      ));

      // Reload pending payments
      await loadPendingPayments();
    } catch (e) {
      logger.e('Process payment error: $e');
      emit(PaymentsState.error(e.toString()));
    }
  }

  Future<void> searchPayments(String query) async {
    try {
      final currentState = state;
      if (currentState is PaymentsLoaded) {
        if (query.isEmpty) {
          // Return to normal loaded state
          return;
        }

        final filteredPayments = currentState.payments.where((payment) {
          final searchFields = [
            payment.customerId,
            payment.paymentMethod.name,
            payment.amount.toString(),
            payment.notes ?? '',
            payment.reference ?? '',
          ];

          return searchFields.any(
              (field) => field.toLowerCase().contains(query.toLowerCase()));
        }).toList();

        emit(PaymentsState.searched(filteredPayments, query));
      }
    } catch (e) {
      logger.e('Search payments error: $e');
    }
  }

  Future<void> filterPaymentsByMethod(PaymentMethod method) async {
    try {
      final currentState = state;
      if (currentState is PaymentsLoaded) {
        final filteredPayments = currentState.payments
            .where((payment) => payment.paymentMethod.id == method.id)
            .toList();

        emit(PaymentsState.filtered(filteredPayments, method.name));
      }
    } catch (e) {
      logger.e('Filter payments by method error: $e');
    }
  }

  // PaymentType ya no existe en el nuevo modelo, este método se puede eliminar
  // o adaptar según necesidades específicas

  Future<void> filterPaymentsByDateRange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final currentState = state;
      if (currentState is PaymentsLoaded) {
        final filteredPayments = currentState.payments
            .where((payment) =>
                payment.createdAt != null &&
                payment.createdAt!.isAfter(startDate) &&
                payment.createdAt!
                    .isBefore(endDate.add(const Duration(days: 1))))
            .toList();

        emit(PaymentsState.filtered(
          filteredPayments,
          '${_formatDate(startDate)} - ${_formatDate(endDate)}',
        ));
      }
    } catch (e) {
      logger.e('Filter payments by date range error: $e');
    }
  }

  void clearFilters() {
    final currentState = state;
    if (currentState is PaymentsFiltered || currentState is PaymentsSearched) {
      // Reload all payments
      loadPayments();
    }
  }

  Future<void> generatePaymentReport({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      emit(const PaymentsState.generatingReport());

      final currentState = state;
      if (currentState is PaymentsLoaded) {
        // Filter payments by date range
        final payments = currentState.payments
            .where((payment) =>
                payment.createdAt != null &&
                payment.createdAt!.isAfter(startDate) &&
                payment.createdAt!
                    .isBefore(endDate.add(const Duration(days: 1))))
            .toList();

        // Calculate report data
        final totalAmount =
            payments.fold<double>(0, (sum, payment) => sum + payment.amount);

        final paymentsByMethod = <String, PaymentMethodSummary>{};
        for (final payment in payments) {
          final method = payment.paymentMethod.name;
          if (paymentsByMethod.containsKey(method)) {
            paymentsByMethod[method] = paymentsByMethod[method]!.copyWith(
              count: paymentsByMethod[method]!.count + 1,
              amount: paymentsByMethod[method]!.amount + payment.amount,
            );
          } else {
            paymentsByMethod[method] = PaymentMethodSummary(
              method: method,
              count: 1,
              amount: payment.amount,
            );
          }
        }

        final report = PaymentReport(
          period: '${_formatDate(startDate)} - ${_formatDate(endDate)}',
          totalPayments: payments.length,
          totalAmount: totalAmount,
          averagePayment:
              payments.isNotEmpty ? totalAmount / payments.length : 0,
          paymentsByMethod: paymentsByMethod.values.toList(),
          dailyPayments: _calculateDailyPayments(payments, startDate, endDate),
        );

        emit(PaymentsState.reportGenerated(report));
      }
    } catch (e) {
      logger.e('Generate payment report error: $e');
      emit(PaymentsState.error(e.toString()));
    }
  }

  List<DailyPaymentSummary> _calculateDailyPayments(
    List<Payment> payments,
    DateTime startDate,
    DateTime endDate,
  ) {
    final dailyPayments = <DateTime, DailyPaymentSummary>{};

    // Initialize all days with zero
    DateTime currentDate = startDate;
    while (currentDate.isBefore(endDate.add(const Duration(days: 1)))) {
      final dateKey =
          DateTime(currentDate.year, currentDate.month, currentDate.day);
      dailyPayments[dateKey] = DailyPaymentSummary(
        date: dateKey,
        count: 0,
        amount: 0,
      );
      currentDate = currentDate.add(const Duration(days: 1));
    }

    // Add actual payments
    for (final payment in payments) {
      if (payment.createdAt != null) {
        final dateKey = DateTime(
          payment.createdAt!.year,
          payment.createdAt!.month,
          payment.createdAt!.day,
        );

        if (dailyPayments.containsKey(dateKey)) {
          dailyPayments[dateKey] = dailyPayments[dateKey]!.copyWith(
            count: dailyPayments[dateKey]!.count + 1,
            amount: dailyPayments[dateKey]!.amount + payment.amount,
          );
        }
      }
    }

    return dailyPayments.values.toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  String _formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';
}

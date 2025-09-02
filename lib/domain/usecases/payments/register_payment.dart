import '../../../data/repositories/payments_repository.dart';
import '../../../data/models/customers/customer.dart';
import '../../../services/location/location_service.dart';
import '../../../config/logger.dart';

class RegisterPaymentUseCase {
  RegisterPaymentUseCase(this._repository, this._locationService);
  final PaymentsRepository _repository;
  final LocationService _locationService;

  Future<PaymentRegistrationResult> execute({
    required String customerId,
    required double amount,
    required PaymentMethod method,
    String? orderId,
    String? invoiceNumber,
    String? notes,
    String? referenceNumber,
    bool requiresLocation = true,
  }) async {
    try {
      // Validate payment data
      _validatePaymentData(amount, method);

      // Get current location if required
      double? latitude;
      double? longitude;
      double? accuracy;

      if (requiresLocation) {
        final currentLocation = await _locationService.getCurrentLocation();
        if (currentLocation != null) {
          latitude = currentLocation.latitude;
          longitude = currentLocation.longitude;
          accuracy = currentLocation.accuracy;
        } else {
          throw Exception(
              'No se pudo obtener la ubicación para registrar el pago');
        }
      }

      // Create payment record
      final payment = PaymentModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        customerId: customerId,
        orderId: orderId,
        userId: 'current_user_id', // TODO: Get from auth service
        amount: amount,
        method: method.name,
        paidAt: DateTime.now(),
        notes: notes,
        status: 'COMPLETED',
      );

      // Register payment
      final registeredPayment = await _repository.registerPayment(payment);

      // Create payment receipt data
      final receiptData = PaymentReceiptData(
        paymentId: registeredPayment.id,
        customerId: customerId,
        amount: amount,
        method: method,
        paidAt: registeredPayment.paidAt,
        location: latitude != null && longitude != null
            ? PaymentLocation(
                latitude: latitude,
                longitude: longitude,
                accuracy: accuracy,
              )
            : null,
        invoiceNumber: invoiceNumber,
        referenceNumber: referenceNumber,
        notes: notes,
      );

      // Generate payment confirmation
      final confirmation = await _generatePaymentConfirmation(receiptData);

      logger.i('Payment registered successfully: ${registeredPayment.id}');

      return PaymentRegistrationResult(
        payment: registeredPayment,
        receiptData: receiptData,
        confirmation: confirmation,
        message:
            'Pago registrado exitosamente por \$${amount.toStringAsFixed(2)}',
      );
    } catch (e) {
      logger.e('Register payment error: $e');
      rethrow;
    }
  }

  Future<PaymentValidationResult> validatePayment({
    required String customerId,
    required double amount,
    String? orderId,
  }) async {
    try {
      // Check customer credit status
      final creditStatus = await _checkCustomerCreditStatus(customerId);

      // Validate payment amount
      final bool isValidAmount = amount > 0;

      // Check if customer has pending payments
      final pendingPayments = await _repository.getPendingPayments();
      final customerPendingPayments =
          pendingPayments.where((p) => p.customerId == customerId).toList();

      // Calculate customer balance
      final totalPending = customerPendingPayments.fold<double>(
          0, (sum, payment) => sum + payment.amount);

      final validationResult = PaymentValidationResult(
        isValid: isValidAmount && creditStatus.isEligible,
        customerId: customerId,
        requestedAmount: amount,
        creditStatus: creditStatus,
        pendingAmount: totalPending,
        pendingPaymentsCount: customerPendingPayments.length,
        warnings:
            _generateValidationWarnings(amount, creditStatus, totalPending),
      );

      return validationResult;
    } catch (e) {
      logger.e('Validate payment error: $e');
      rethrow;
    }
  }

  Future<List<PaymentMethod>> getAvailablePaymentMethods({
    String? customerId,
    double? amount,
  }) async {
    try {
      // Base payment methods
      final methods = <PaymentMethod>[
        PaymentMethod.cash,
        PaymentMethod.card,
        PaymentMethod.transfer,
        PaymentMethod.check,
      ];

      // Filter methods based on customer or amount constraints
      if (customerId != null) {
        // TODO: Check customer-specific payment method restrictions
      }

      if (amount != null) {
        // TODO: Filter methods based on amount limits
        if (amount > 10000) {
          // Large amounts might require specific methods
          methods.removeWhere((method) => method == PaymentMethod.cash);
        }
      }

      return methods;
    } catch (e) {
      logger.e('Get available payment methods error: $e');
      return [PaymentMethod.cash]; // Default fallback
    }
  }

  Future<PaymentSummaryReport> generatePaymentSummary({
    required DateTime startDate,
    required DateTime endDate,
    String? userId,
    String? customerId,
  }) async {
    try {
      final payments = await _repository.getPayments(forceSync: true);

      // Filter payments by date range
      final filteredPayments = payments.where((payment) {
        final isInDateRange = payment.paidAt.isAfter(startDate) &&
            payment.paidAt.isBefore(endDate.add(const Duration(days: 1)));

        if (!isInDateRange) return false;

        if (userId != null && payment.userId != userId) return false;
        if (customerId != null && payment.customerId != customerId) {
          return false;
        }

        return true;
      }).toList();

      // Calculate summary statistics
      final totalAmount = filteredPayments.fold<double>(
          0, (sum, payment) => sum + payment.amount);

      final paymentsByMethod = <String, PaymentMethodSummary>{};
      for (final payment in filteredPayments) {
        final method = payment.method ?? 'UNKNOWN';
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

      return PaymentSummaryReport(
        startDate: startDate,
        endDate: endDate,
        totalPayments: filteredPayments.length,
        totalAmount: totalAmount,
        averagePayment: filteredPayments.isNotEmpty
            ? totalAmount / filteredPayments.length
            : 0,
        paymentsByMethod: paymentsByMethod.values.toList(),
        payments: filteredPayments,
      );
    } catch (e) {
      logger.e('Generate payment summary error: $e');
      rethrow;
    }
  }

  void _validatePaymentData(double amount, PaymentMethod method) {
    if (amount <= 0) {
      throw Exception('El monto del pago debe ser mayor a cero');
    }

    if (amount > 999999.99) {
      throw Exception('El monto del pago excede el límite máximo');
    }

    // Method-specific validations
    switch (method) {
      case PaymentMethod.cash:
        if (amount > 50000) {
          throw Exception(r'Pagos en efectivo no pueden exceder $50,000');
        }
        break;
      case PaymentMethod.check:
        if (amount < 100) {
          throw Exception(r'Pagos con cheque deben ser mínimo $100');
        }
        break;
      default:
        break;
    }
  }

  Future<CustomerCreditStatus> _checkCustomerCreditStatus(
      String customerId) async {
    try {
      // TODO: Implement actual credit check logic
      // For now, return a default status
      return CustomerCreditStatus(
        customerId: customerId,
        isEligible: true,
        creditLimit: 100000,
        currentBalance: 0,
        availableCredit: 100000,
        riskLevel: CreditRiskLevel.low,
      );
    } catch (e) {
      logger.e('Check customer credit status error: $e');
      return CustomerCreditStatus(
        customerId: customerId,
        isEligible: false,
        creditLimit: 0,
        currentBalance: 0,
        availableCredit: 0,
        riskLevel: CreditRiskLevel.high,
      );
    }
  }

  List<String> _generateValidationWarnings(
    double amount,
    CustomerCreditStatus creditStatus,
    double pendingAmount,
  ) {
    final warnings = <String>[];

    if (amount > creditStatus.availableCredit) {
      warnings.add('El monto excede el crédito disponible del cliente');
    }

    if (pendingAmount > 0) {
      warnings.add(
          'El cliente tiene pagos pendientes por \$${pendingAmount.toStringAsFixed(2)}');
    }

    if (creditStatus.riskLevel == CreditRiskLevel.high) {
      warnings.add('Cliente clasificado como alto riesgo crediticio');
    }

    return warnings;
  }

  Future<PaymentConfirmation> _generatePaymentConfirmation(
      PaymentReceiptData receiptData) async {
    try {
      return PaymentConfirmation(
        confirmationNumber:
            'PAY-${receiptData.paymentId.substring(0, 8).toUpperCase()}',
        paymentId: receiptData.paymentId,
        timestamp: DateTime.now(),
        amount: receiptData.amount,
        method: receiptData.method,
        status: PaymentConfirmationStatus.confirmed,
      );
    } catch (e) {
      logger.e('Generate payment confirmation error: $e');
      rethrow;
    }
  }
}

enum PaymentMethod {
  cash('EFECTIVO'),
  card('TARJETA'),
  transfer('TRANSFERENCIA'),
  check('CHEQUE'),
  digitalWallet('WALLET_DIGITAL'),
  creditNote('NOTA_CREDITO');

  const PaymentMethod(this.displayName);
  final String displayName;
}

enum CreditRiskLevel { low, medium, high }

enum PaymentConfirmationStatus { confirmed, pending, failed }

class PaymentRegistrationResult {
  PaymentRegistrationResult({
    required this.payment,
    required this.receiptData,
    required this.confirmation,
    required this.message,
  });
  final PaymentModel payment;
  final PaymentReceiptData receiptData;
  final PaymentConfirmation confirmation;
  final String message;
}

class PaymentReceiptData {
  PaymentReceiptData({
    required this.paymentId,
    required this.customerId,
    required this.amount,
    required this.method,
    required this.paidAt,
    this.location,
    this.invoiceNumber,
    this.referenceNumber,
    this.notes,
  });
  final String paymentId;
  final String customerId;
  final double amount;
  final PaymentMethod method;
  final DateTime paidAt;
  final PaymentLocation? location;
  final String? invoiceNumber;
  final String? referenceNumber;
  final String? notes;
}

class PaymentLocation {
  PaymentLocation({
    required this.latitude,
    required this.longitude,
    this.accuracy,
  });
  final double latitude;
  final double longitude;
  final double? accuracy;
}

class PaymentValidationResult {
  PaymentValidationResult({
    required this.isValid,
    required this.customerId,
    required this.requestedAmount,
    required this.creditStatus,
    required this.pendingAmount,
    required this.pendingPaymentsCount,
    required this.warnings,
  });
  final bool isValid;
  final String customerId;
  final double requestedAmount;
  final CustomerCreditStatus creditStatus;
  final double pendingAmount;
  final int pendingPaymentsCount;
  final List<String> warnings;
}

class CustomerCreditStatus {
  CustomerCreditStatus({
    required this.customerId,
    required this.isEligible,
    required this.creditLimit,
    required this.currentBalance,
    required this.availableCredit,
    required this.riskLevel,
  });
  final String customerId;
  final bool isEligible;
  final double creditLimit;
  final double currentBalance;
  final double availableCredit;
  final CreditRiskLevel riskLevel;
}

class PaymentConfirmation {
  PaymentConfirmation({
    required this.confirmationNumber,
    required this.paymentId,
    required this.timestamp,
    required this.amount,
    required this.method,
    required this.status,
  });
  final String confirmationNumber;
  final String paymentId;
  final DateTime timestamp;
  final double amount;
  final PaymentMethod method;
  final PaymentConfirmationStatus status;
}

class PaymentSummaryReport {
  PaymentSummaryReport({
    required this.startDate,
    required this.endDate,
    required this.totalPayments,
    required this.totalAmount,
    required this.averagePayment,
    required this.paymentsByMethod,
    required this.payments,
  });
  final DateTime startDate;
  final DateTime endDate;
  final int totalPayments;
  final double totalAmount;
  final double averagePayment;
  final List<PaymentMethodSummary> paymentsByMethod;
  final List<PaymentModel> payments;
}

class PaymentMethodSummary {
  PaymentMethodSummary({
    required this.method,
    required this.count,
    required this.amount,
  });
  final String method;
  final int count;
  final double amount;

  PaymentMethodSummary copyWith({
    String? method,
    int? count,
    double? amount,
  }) =>
      PaymentMethodSummary(
        method: method ?? this.method,
        count: count ?? this.count,
        amount: amount ?? this.amount,
      );
}

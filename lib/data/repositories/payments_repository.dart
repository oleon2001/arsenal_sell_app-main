import '../../config/logger.dart';
import '../models/payments/payment.dart';
import '../remote/supabase_client.dart';

class PaymentsRepository {
  final SupabaseService _supabase = SupabaseService();

  /// Obtener todos los pagos de una orden
  Future<List<Payment>> getPaymentsByOrder(String orderId) async {
    try {
      logger.i('🔍 Cargando pagos para orden: $orderId');
      final payments = await _supabase.getPaymentsByOrder(orderId);
      logger.i('✅ ${payments.length} pagos cargados');
      return payments;
    } catch (e) {
      logger.e('❌ Error cargando pagos: $e');
      rethrow;
    }
  }

  /// Obtener todos los pagos de un cliente
  Future<List<Payment>> getPaymentsByCustomer(String customerId) async {
    try {
      logger.i('🔍 Cargando pagos para cliente: $customerId');
      final payments = await _supabase.getPaymentsByCustomer(customerId);
      logger.i('✅ ${payments.length} pagos cargados');
      return payments;
    } catch (e) {
      logger.e('❌ Error cargando pagos: $e');
      rethrow;
    }
  }

  /// Obtener métodos de pago disponibles
  Future<List<PaymentMethod>> getPaymentMethods() async {
    try {
      logger.i('🔍 Cargando métodos de pago...');
      final methods = await _supabase.getPaymentMethods();
      logger.i('✅ ${methods.length} métodos de pago cargados');
      return methods;
    } catch (e) {
      logger.e('❌ Error cargando métodos de pago: $e');
      rethrow;
    }
  }

  /// Crear nuevo pago
  Future<Payment> createPayment(Payment payment) async {
    try {
      logger.i('🔍 Creando pago: \$${payment.amount}');
      final createdPayment = await _supabase.createPayment(payment);
      logger.i('✅ Pago creado: ${createdPayment.id}');
      return createdPayment;
    } catch (e) {
      logger.e('❌ Error creando pago: $e');
      rethrow;
    }
  }

  /// Actualizar pago
  Future<Payment> updatePayment(Payment payment) async {
    try {
      logger.i('🔍 Actualizando pago: ${payment.id}');
      final updatedPayment = await _supabase.updatePayment(payment);
      logger.i('✅ Pago actualizado: ${updatedPayment.id}');
      return updatedPayment;
    } catch (e) {
      logger.e('❌ Error actualizando pago: $e');
      rethrow;
    }
  }

  /// Marcar pago como completado
  Future<Payment> markPaymentAsCompleted(String paymentId,
      {String? reference}) async {
    try {
      logger.i('🔍 Marcando pago como completado: $paymentId');
      final payment = await _supabase.markPaymentAsCompleted(paymentId,
          reference: reference);
      logger.i('✅ Pago marcado como completado: $paymentId');
      return payment;
    } catch (e) {
      logger.e('❌ Error marcando pago como completado: $e');
      rethrow;
    }
  }

  /// Marcar pago como fallido
  Future<Payment> markPaymentAsFailed(String paymentId, {String? notes}) async {
    try {
      logger.i('🔍 Marcando pago como fallido: $paymentId');
      final payment =
          await _supabase.markPaymentAsFailed(paymentId, notes: notes);
      logger.i('✅ Pago marcado como fallido: $paymentId');
      return payment;
    } catch (e) {
      logger.e('❌ Error marcando pago como fallido: $e');
      rethrow;
    }
  }

  /// Obtener resumen de pagos de una orden
  Future<PaymentSummary> getPaymentSummary(String orderId) async {
    try {
      logger.i('🔍 Obteniendo resumen de pagos para orden: $orderId');
      final payments = await getPaymentsByOrder(orderId);

      final totalAmount =
          payments.fold(0.0, (sum, payment) => sum + payment.amount);
      final completedAmount = payments
          .where((p) => p.isCompleted)
          .fold(0.0, (sum, payment) => sum + payment.amount);
      final pendingAmount = totalAmount - completedAmount;

      final summary = PaymentSummary(
        orderId: orderId,
        totalAmount: totalAmount,
        completedAmount: completedAmount,
        pendingAmount: pendingAmount,
        payments: payments,
        isFullyPaid: pendingAmount <= 0 && payments.isNotEmpty,
      );

      logger.i(
          '✅ Resumen de pagos: \$${completedAmount.toStringAsFixed(2)} / \$${totalAmount.toStringAsFixed(2)}');
      return summary;
    } catch (e) {
      logger.e('❌ Error obteniendo resumen de pagos: $e');
      rethrow;
    }
  }

  /// Obtener todos los pagos (método requerido por PaymentsCubit)
  Future<List<Payment>> getPayments({bool forceSync = false}) async {
    try {
      logger.i('🔍 Cargando todos los pagos...');
      // Por ahora, obtener pagos de todos los clientes
      // TODO: Implementar lógica específica según el contexto
      final payments = await _supabase.getPaymentsByCustomer('all');
      logger.i('✅ ${payments.length} pagos cargados');
      return payments;
    } catch (e) {
      logger.e('❌ Error cargando pagos: $e');
      rethrow;
    }
  }

  /// Obtener pagos pendientes (método requerido por PaymentsCubit)
  Future<List<Payment>> getPendingPayments() async {
    try {
      logger.i('🔍 Cargando pagos pendientes...');
      final allPayments = await getPayments();
      final pendingPayments = allPayments.where((p) => p.isPending).toList();
      logger.i('✅ ${pendingPayments.length} pagos pendientes encontrados');
      return pendingPayments;
    } catch (e) {
      logger.e('❌ Error cargando pagos pendientes: $e');
      rethrow;
    }
  }

  /// Registrar nuevo pago (método requerido por PaymentsCubit)
  Future<Payment> registerPayment({
    required String customerId,
    String? orderId,
    required double amount,
    required PaymentMethod paymentMethod,
    String? reference,
    String? notes,
  }) async {
    try {
      logger
          .i('🔍 Registrando nuevo pago: \$${amount} para cliente $customerId');
      final payment = Payment(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        orderId: orderId ?? 'temp_order_id',
        customerId: customerId,
        amount: amount,
        paymentMethod: paymentMethod,
        status: PaymentStatus.pending,
        reference: reference,
        notes: notes,
        createdAt: DateTime.now(),
      );

      final createdPayment = await createPayment(payment);
      logger.i('✅ Pago registrado: ${createdPayment.id}');
      return createdPayment;
    } catch (e) {
      logger.e('❌ Error registrando pago: $e');
      rethrow;
    }
  }
}

/// Clase helper para resumen de pagos
class PaymentSummary {
  final String orderId;
  final double totalAmount;
  final double completedAmount;
  final double pendingAmount;
  final List<Payment> payments;
  final bool isFullyPaid;

  PaymentSummary({
    required this.orderId,
    required this.totalAmount,
    required this.completedAmount,
    required this.pendingAmount,
    required this.payments,
    required this.isFullyPaid,
  });

  /// Obtener porcentaje de pago completado
  double get completionPercentage {
    if (totalAmount == 0) return 0.0;
    return (completedAmount / totalAmount) * 100;
  }

  /// Obtener monto total formateado
  String get formattedTotalAmount => '\$${totalAmount.toStringAsFixed(2)}';

  /// Obtener monto completado formateado
  String get formattedCompletedAmount =>
      '\$${completedAmount.toStringAsFixed(2)}';

  /// Obtener monto pendiente formateado
  String get formattedPendingAmount => '\$${pendingAmount.toStringAsFixed(2)}';

  /// Obtener estado del pago
  String get paymentStatus {
    if (isFullyPaid) return 'Pagado';
    if (completedAmount > 0) return 'Pago Parcial';
    return 'Pendiente';
  }
}

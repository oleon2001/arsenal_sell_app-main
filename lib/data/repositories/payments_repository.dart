import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/customers/customer.dart';
import '../local/drift/db.dart';
import '../remote/supabase_client.dart';
import '../../config/logger.dart';

class PaymentModel {
  PaymentModel({
    required this.id,
    this.orderId,
    this.customerId,
    this.userId,
    required this.amount,
    this.method,
    required this.paidAt,
    this.notes,
    required this.status,
    this.customer,
  });
  final String id;
  final String? orderId;
  final String? customerId;
  final String? userId;
  final double amount;
  final String? method;
  final DateTime paidAt;
  final String? notes;
  final String status;
  final Customer? customer;
}

class PaymentsRepository {
  final DatabaseHelper _db = DatabaseHelper.instance;
  final SupabaseService _supabase = SupabaseService();

  Future<List<PaymentModel>> getPayments({bool forceSync = false}) async {
    try {
      final connectivity = await Connectivity().checkConnectivity();
      final isOnline = connectivity != ConnectivityResult.none;

      if (isOnline && forceSync) {
        await _syncPaymentsFromServer();
      }

      // For now, return mock data
      return [
        PaymentModel(
          id: '00000000-0000-0000-0000-000000000001',
          customerId: '00000000-0000-0000-0000-000000000002',
          amount: 2500,
          method: 'EFECTIVO',
          paidAt: DateTime.now().subtract(const Duration(hours: 1)),
          status: 'PENDING',
          customer: const Customer(
            id: '00000000-0000-0000-0000-000000000002',
            companyId: '705abd4b-c5a7-4a6b-be9c-e2da93df3987',
            name: 'Cliente Ejemplo 1',
          ),
        ),
        PaymentModel(
          id: '00000000-0000-0000-0000-000000000003',
          customerId: '00000000-0000-0000-0000-000000000004',
          amount: 1800,
          method: 'TARJETA',
          paidAt: DateTime.now().subtract(const Duration(days: 1)),
          status: 'COMPLETED',
          customer: const Customer(
            id: '00000000-0000-0000-0000-000000000004',
            companyId: '705abd4b-c5a7-4a6b-be9c-e2da93df3987',
            name: 'Cliente Ejemplo 2',
          ),
        ),
      ];
    } catch (e) {
      logger.e('Get payments error: $e');
      return [];
    }
  }

  Future<PaymentModel> registerPayment(PaymentModel payment) async {
    try {
      // TODO: Save locally first, then sync

      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity != ConnectivityResult.none) {
        await _syncPaymentToServer(payment);
      }

      return payment;
    } catch (e) {
      logger.e('Register payment error: $e');
      rethrow;
    }
  }

  Future<List<PaymentModel>> getPendingPayments() async {
    try {
      final payments = await getPayments();
      return payments.where((p) => p.status == 'PENDING').toList();
    } catch (e) {
      logger.e('Get pending payments error: $e');
      return [];
    }
  }

  Future<void> _syncPaymentsFromServer() async {
    try {
      // TODO: Implement sync from server
    } catch (e) {
      logger.e('Sync payments from server error: $e');
    }
  }

  Future<void> _syncPaymentToServer(PaymentModel payment) async {
    try {
      // TODO: Implement sync to server
    } catch (e) {
      logger.e('Sync payment to server error: $e');
    }
  }
}

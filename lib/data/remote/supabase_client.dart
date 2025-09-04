import 'dart:io';
import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../config/logger.dart';
import '../models/customers/customer.dart';
import '../models/geo/location_sample.dart';
import '../models/sales/order.dart';
import '../models/visits/visit.dart';
import '../../services/sync/customer_mapper.dart';
import '../models/companies/company.dart';
import '../models/products/product.dart';
import '../models/payments/payment.dart';

class SupabaseService {
  SupabaseService() : _client = Supabase.instance.client;

  final SupabaseClient _client;

  // Customers
  Future<List<Customer>> getCustomers() async {
    try {
      final response = await _client.from('customers').select();
      return (response as List<dynamic>)
          .map((data) =>
              CustomerMapper.fromSupabaseFormat(data as Map<String, dynamic>))
          .toList();
    } catch (e) {
      logger.e('Get customers error: $e');
      rethrow;
    }
  }

  Future<Customer> createCustomer(Customer customer) async {
    try {
      final response = await _client
          .from('customers')
          .insert(customer.toJson())
          .select()
          .single();
      return Customer.fromJson(response);
    } catch (e) {
      logger.e('Create customer error: $e');
      rethrow;
    }
  }

  Future<Customer> upsertCustomer(Customer customer) async {
    try {
      // Usar el mapper para convertir a formato Supabase
      final supabaseData = CustomerMapper.toSupabaseFormat(customer);

      // Verificar si el cliente ya existe por código
      if (customer.code != null && customer.code!.isNotEmpty) {
        try {
          // Buscar cliente existente por código
          final existingCustomer = await getCustomerByCode(
            customer.code!,
            customer.companyId,
          );

          if (existingCustomer != null) {
            // Si existe, actualizar
            logger.i('Customer with code ${customer.code} exists, updating...');
            return await updateCustomer(existingCustomer.id, customer);
          }
        } catch (e) {
          logger.w('Error checking existing customer: $e');
        }
      }

      // Si no existe o no tiene código, crear nuevo
      final response = await _client
          .from('customers')
          .insert(supabaseData)
          .select()
          .single();

      // Convertir la respuesta de vuelta al formato Flutter
      return CustomerMapper.fromSupabaseFormat(response);
    } catch (e) {
      logger.e('Upsert customer error: $e');
      rethrow;
    }
  }

  /// Busca un cliente por código y empresa
  Future<Customer?> getCustomerByCode(String code, String companyId) async {
    try {
      final response = await _client
          .from('customers')
          .select()
          .eq('code', code)
          .eq('company_id', companyId)
          .maybeSingle();

      if (response != null) {
        return CustomerMapper.fromSupabaseFormat(response);
      }
      return null;
    } catch (e) {
      logger.e('Get customer by code error: $e');
      return null;
    }
  }

  /// Actualiza un cliente existente
  Future<Customer> updateCustomer(String customerId, Customer customer) async {
    try {
      final supabaseData = CustomerMapper.toSupabaseFormat(customer);

      final response = await _client
          .from('customers')
          .update(supabaseData)
          .eq('id', customerId)
          .select()
          .single();

      return CustomerMapper.fromSupabaseFormat(response);
    } catch (e) {
      logger.e('Update customer error: $e');
      rethrow;
    }
  }

  // Companies
  Future<List<Company>> getCompanies() async {
    try {
      logger.i('🔍 Intentando cargar compañías desde Supabase...');

      // Verificar autenticación
      final user = _client.auth.currentUser;
      logger.i('👤 Usuario actual: ${user?.id ?? "NO AUTENTICADO"}');

      final response = await _client.from('companies').select();
      logger.i(
          '📊 Respuesta de Supabase: ${response.length} compañías encontradas');

      final companies = (response as List<dynamic>)
          .map((e) => Company.fromJson(e as Map<String, dynamic>))
          .toList();

      logger.i('✅ Compañías cargadas exitosamente: ${companies.length}');
      for (final company in companies) {
        logger.i('  - ${company.name} (${company.id})');
      }

      return companies;
    } catch (e) {
      logger.e('❌ Get companies error: $e');
      logger.e('🔍 Tipo de error: ${e.runtimeType}');
      if (e.toString().contains('RLS')) {
        logger.e(
            '🚨 PROBLEMA RLS: Las políticas de Row Level Security están bloqueando el acceso');
      }
      rethrow;
    }
  }

  Future<Company> createCompany(Company company) async {
    try {
      final response = await _client
          .from('companies')
          .insert(company.toJson())
          .select()
          .single();
      return Company.fromJson(response);
    } catch (e) {
      logger.e('Create company error: $e');
      rethrow;
    }
  }

  // Visits
  Future<Visit> createVisit(Visit visit) async {
    try {
      final response =
          await _client.from('visits').insert(visit.toJson()).select().single();
      return Visit.fromJson(response);
    } catch (e) {
      logger.e('Create visit error: $e');
      rethrow;
    }
  }

  Future<void> updateVisit(Visit visit) async {
    try {
      await _client.from('visits').update(visit.toJson()).eq('id', visit.id);
    } catch (e) {
      logger.e('Update visit error: $e');
      rethrow;
    }
  }

  // Orders
  Future<Order> createOrder(Order order) async {
    try {
      final response =
          await _client.from('orders').insert(order.toJson()).select().single();
      return Order.fromJson(response);
    } catch (e) {
      logger.e('Create order error: $e');
      rethrow;
    }
  }

  // Tracking
  Future<void> uploadTrackingLocations(List<LocationSample> locations) async {
    try {
      final data = locations.map((l) => l.toJson()).toList();
      await _client.from('tracking_locations').insert(data);
    } catch (e) {
      logger.e('Upload tracking locations error: $e');
      rethrow;
    }
  }

  Future<List<LocationSample>> getRealtimeLocations() async {
    try {
      final response = await _client
          .from('tracking_locations')
          .select()
          .gte(
              'at',
              DateTime.now()
                  .subtract(const Duration(minutes: 30))
                  .toIso8601String())
          .order('at', ascending: false);

      return (response as List<dynamic>)
          .map((e) => LocationSample.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      logger.e('Get realtime locations error: $e');
      return [];
    }
  }

  // File Upload
  Future<String> uploadPhoto(
      String path, String bucketName, String fileName) async {
    try {
      final response =
          await _client.storage.from(bucketName).upload(fileName, File(path));
      return response;
    } catch (e) {
      logger.e('Upload photo error: $e');
      rethrow;
    }
  }

  Future<String> uploadSignature(
      Uint8List signatureData, String bucketName, String fileName) async {
    try {
      final response = await _client.storage
          .from(bucketName)
          .uploadBinary(fileName, signatureData);
      return response;
    } catch (e) {
      logger.e('Upload signature error: $e');
      rethrow;
    }
  }

  // Products
  Future<List<Product>> getProducts({String? companyId}) async {
    try {
      logger.i('🔍 Obteniendo productos desde Supabase...');

      var query = _client.from('products').select();

      if (companyId != null) {
        query = query.eq('company_id', companyId);
      }

      final response = await query;
      logger.i(
          '📊 Respuesta de Supabase: ${response.length} productos encontrados');

      final products = (response as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();

      logger.i('✅ Productos cargados exitosamente: ${products.length}');
      for (final product in products) {
        logger.i('  - ${product.name} (${product.id})');
      }

      return products;
    } catch (e) {
      logger.e('❌ Get products error: $e');
      rethrow;
    }
  }

  Future<Product?> getProductById(String id) async {
    try {
      final response =
          await _client.from('products').select().eq('id', id).maybeSingle();

      if (response != null) {
        return Product.fromJson(response);
      }
      return null;
    } catch (e) {
      logger.e('Get product by ID error: $e');
      return null;
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    try {
      final response = await _client
          .from('products')
          .select()
          .or('name.ilike.%$query%,sku.ilike.%$query%')
          .eq('active', true);

      return (response as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      logger.e('Search products error: $e');
      rethrow;
    }
  }

  Future<List<Price>> getProductPrices(String productId) async {
    try {
      final response =
          await _client.from('prices').select().eq('product_id', productId);

      return (response as List<dynamic>)
          .map((e) => Price.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      logger.e('Get product prices error: $e');
      rethrow;
    }
  }

  Future<PriceList?> getDefaultPriceList({String? companyId}) async {
    try {
      var query = _client.from('price_lists').select();

      if (companyId != null) {
        query = query.eq('company_id', companyId);
      }

      final response = await query.limit(1).maybeSingle();

      if (response != null) {
        return PriceList.fromJson(response);
      }
      return null;
    } catch (e) {
      logger.e('Get default price list error: $e');
      return null;
    }
  }

  Future<Product> createProduct(Product product) async {
    try {
      final response = await _client
          .from('products')
          .insert(product.toJson())
          .select()
          .single();
      return Product.fromJson(response);
    } catch (e) {
      logger.e('Create product error: $e');
      rethrow;
    }
  }

  Future<Product> updateProduct(Product product) async {
    try {
      final response = await _client
          .from('products')
          .update(product.toJson())
          .eq('id', product.id)
          .select()
          .single();
      return Product.fromJson(response);
    } catch (e) {
      logger.e('Update product error: $e');
      rethrow;
    }
  }

  // Payments
  Future<List<Payment>> getPaymentsByOrder(String orderId) async {
    try {
      logger.i('🔍 Obteniendo pagos para orden: $orderId');
      final response = await _client
          .from('payments')
          .select()
          .eq('order_id', orderId)
          .order('created_at', ascending: false);

      final payments = (response as List<dynamic>)
          .map((e) => Payment.fromJson(e as Map<String, dynamic>))
          .toList();

      logger.i('✅ ${payments.length} pagos encontrados para orden $orderId');
      return payments;
    } catch (e) {
      logger.e('❌ Get payments by order error: $e');
      // Si hay error, retornar lista vacía en lugar de rethrow
      logger.w('⚠️ Retornando lista vacía de pagos debido al error');
      return [];
    }
  }

  Future<List<Payment>> getPaymentsByCustomer(String customerId) async {
    try {
      logger.i('🔍 Obteniendo pagos para cliente: $customerId');

      // Si customerId es 'all', obtener todos los pagos
      var query = _client.from('payments').select();

      if (customerId != 'all') {
        query = query.eq('customer_id', customerId);
      }

      final response = await query.order('created_at', ascending: false);

      final payments = (response as List<dynamic>)
          .map((e) => Payment.fromJson(e as Map<String, dynamic>))
          .toList();

      logger
          .i('✅ ${payments.length} pagos encontrados para cliente $customerId');
      return payments;
    } catch (e) {
      logger.e('❌ Get payments by customer error: $e');
      // Si hay error, retornar lista vacía en lugar de rethrow
      logger.w('⚠️ Retornando lista vacía de pagos debido al error');
      return [];
    }
  }

  Future<List<PaymentMethod>> getPaymentMethods() async {
    try {
      logger.i('🔍 Obteniendo métodos de pago...');
      final response = await _client
          .from('payment_methods')
          .select()
          .eq('active', true)
          .order('name');

      final methods = (response as List<dynamic>)
          .map((e) => PaymentMethod.fromJson(e as Map<String, dynamic>))
          .toList();

      logger.i('✅ ${methods.length} métodos de pago encontrados');
      return methods;
    } catch (e) {
      logger.e('❌ Get payment methods error: $e');
      // Si hay error, retornar lista vacía en lugar de rethrow
      logger.w('⚠️ Retornando lista vacía de métodos de pago debido al error');
      return [];
    }
  }

  Future<Payment> createPayment(Payment payment) async {
    try {
      logger.i('🔍 Creando pago: \$${payment.amount}');
      final response = await _client
          .from('payments')
          .insert(payment.toJson())
          .select()
          .single();
      return Payment.fromJson(response);
    } catch (e) {
      logger.e('❌ Create payment error: $e');
      rethrow;
    }
  }

  Future<Payment> updatePayment(Payment payment) async {
    try {
      logger.i('🔍 Actualizando pago: ${payment.id}');
      final response = await _client
          .from('payments')
          .update(payment.toJson())
          .eq('id', payment.id)
          .select()
          .single();
      return Payment.fromJson(response);
    } catch (e) {
      logger.e('❌ Update payment error: $e');
      rethrow;
    }
  }

  Future<Payment> markPaymentAsCompleted(String paymentId,
      {String? reference}) async {
    try {
      logger.i('🔍 Marcando pago como completado: $paymentId');
      final response = await _client
          .from('payments')
          .update({
            'payment_status': 'completed',
            'reference': reference,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', paymentId)
          .select()
          .single();
      return Payment.fromJson(response);
    } catch (e) {
      logger.e('❌ Mark payment as completed error: $e');
      rethrow;
    }
  }

  Future<Payment> markPaymentAsFailed(String paymentId, {String? notes}) async {
    try {
      logger.i('🔍 Marcando pago como fallido: $paymentId');
      final response = await _client
          .from('payments')
          .update({
            'payment_status': 'failed',
            'notes': notes,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', paymentId)
          .select()
          .single();
      return Payment.fromJson(response);
    } catch (e) {
      logger.e('❌ Mark payment as failed error: $e');
      rethrow;
    }
  }
}

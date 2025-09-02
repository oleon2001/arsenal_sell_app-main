import 'dart:io';
import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../config/logger.dart';
import '../models/customers/customer.dart';
import '../models/geo/location_sample.dart';
import '../models/sales/order.dart';
import '../models/visits/visit.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  // Customers
  Future<List<Customer>> getCustomers() async {
    try {
      final response = await _client.from('customers').select();
      return (response as List).map((e) => Customer.fromJson(e)).toList();
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

  Future<Customer> updateCustomer(Customer customer) async {
    try {
      final response = await _client
          .from('customers')
          .update(customer.toJson())
          .eq('id', customer.id)
          .select()
          .single();
      return Customer.fromJson(response);
    } catch (e) {
      logger.e('Update customer error: $e');
      rethrow;
    }
  }

  Future<Customer> upsertCustomer(Customer customer) async {
    try {
      final response = await _client
          .from('customers')
          .upsert(customer.toJson())
          .select()
          .single();
      return Customer.fromJson(response);
    } catch (e) {
      logger.e('Upsert customer error: $e');
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

      return (response as List).map((e) => LocationSample.fromJson(e)).toList();
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
}

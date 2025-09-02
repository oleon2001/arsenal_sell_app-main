import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/customers/customer.dart';
import '../local/drift/db.dart';
import '../remote/supabase_client.dart';
import '../../config/logger.dart';

class CustomersRepository {
  final DatabaseHelper _db = DatabaseHelper.instance;
  final SupabaseService _supabase = SupabaseService();

  Future<List<Customer>> getCustomers({bool forceSync = false}) async {
    try {
      final connectivity = await Connectivity().checkConnectivity();
      final isOnline = connectivity != ConnectivityResult.none;

      if (isOnline && forceSync) {
        await _syncCustomersFromServer();
      }

      final entities = await _db.getAllCustomers();
      return entities.map(_entityToModel).toList();
    } catch (e) {
      logger.e('Get customers error: $e');
      rethrow;
    }
  }

  Future<Customer?> getCustomerById(String id) async {
    try {
      final entity = await _db.getCustomerById(id);
      return entity != null ? _entityToModel(entity) : null;
    } catch (e) {
      logger.e('Get customer by id error: $e');
      return null;
    }
  }

  Future<Customer> createCustomer(Customer customer) async {
    try {
      final entity = _modelToEntity(customer);
      await _db.insertCustomer(entity);

      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity != ConnectivityResult.none) {
        await _syncCustomerToServer(customer);
      }

      return customer;
    } catch (e) {
      logger.e('Create customer error: $e');
      rethrow;
    }
  }

  Future<Customer> updateCustomer(Customer customer) async {
    try {
      final entity = _modelToEntity(customer);
      await _db
          .insertCustomer(entity); // insertOnConflictUpdate handles updates

      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity != ConnectivityResult.none) {
        await _syncCustomerToServer(customer);
      }

      return customer;
    } catch (e) {
      logger.e('Update customer error: $e');
      rethrow;
    }
  }

  Future<void> _syncCustomersFromServer() async {
    try {
      final customers = await _supabase.getCustomers();
      final entities = customers.map(_modelToEntity).toList();
      await _db.insertCustomers(entities);
      logger.i('Synced ${customers.length} customers from server');
    } catch (e) {
      logger.e('Sync customers from server error: $e');
    }
  }

  Future<void> syncPendingCustomers() async {
    try {
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity == ConnectivityResult.none) {
        logger.w('No internet connection, skipping sync');
        return;
      }

      // Get customers that need sync (this would require adding a needsSync field to Customer model)
      final customers = await getCustomers();
      int syncedCount = 0;

      for (final customer in customers) {
        try {
          await _syncCustomerToServer(customer);
          syncedCount++;
        } catch (e) {
          logger.e('Failed to sync customer ${customer.id}: $e');
        }
      }

      logger.i('Synced $syncedCount customers to server');
    } catch (e) {
      logger.e('Sync pending customers error: $e');
    }
  }

  Future<void> _syncCustomerToServer(Customer customer) async {
    try {
      // Get current user ID for created_by field
      final currentUser = Supabase.instance.client.auth.currentUser;
      final userId = currentUser?.id;

      // Get real company ID if customer has placeholder
      String realCompanyId = customer.companyId;
      if (customer.companyId == 'current_company_id') {
        realCompanyId = await _getRealCompanyId();
      }

      // Prepare customer data with created_by if not present
      Customer customerToSync = customer;
      if (customer.createdBy == null && userId != null) {
        customerToSync = customer.copyWith(
          createdBy: userId,
          companyId: realCompanyId,
        );
      } else if (customer.companyId == 'current_company_id') {
        customerToSync = customer.copyWith(companyId: realCompanyId);
      }

      // Use upsert to handle both create and update cases
      final syncedCustomer = await _supabase.upsertCustomer(customerToSync);

      // Mark as synced in local DB
      final entity = _modelToEntity(syncedCustomer);
      await _db.insertCustomer(entity);

      logger.i('Customer synced to server: ${customer.id}');
    } catch (e) {
      logger.e('Sync customer to server error: $e');
      // Mark as needing sync in case of failure
      final entity = _modelToEntity(customer);
      await _db.insertCustomer(entity);
    }
  }

  Future<String> _getRealCompanyId() async {
    try {
      // Get the first company from Supabase (assuming there's only one for now)
      final response = await Supabase.instance.client
          .from('companies')
          .select('id')
          .limit(1)
          .single();

      return response['id'] as String;
    } catch (e) {
      logger.e('Get real company ID error: $e');
      // Fallback to the correct UUID for the demo company
      // This should match the UUID format used in setup_users.sql
      return '705abd4b-c5a7-4a6b-be9c-e2da93df3987';
    }
  }

  Customer _entityToModel(CustomerEntity entity) => Customer(
        id: entity.id,
        companyId: entity.companyId,
        code: entity.code,
        name: entity.name,
        email: entity.email,
        phone: entity.phone,
        address: entity.address,
        latitude: entity.latitude,
        longitude: entity.longitude,
        geoAccuracyM: entity.geoAccuracyM,
        createdBy: entity.createdBy,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );

  CustomerEntity _modelToEntity(Customer model) => CustomerEntity(
        id: model.id,
        companyId: model.companyId,
        code: model.code,
        name: model.name,
        email: model.email,
        phone: model.phone,
        address: model.address,
        latitude: model.latitude,
        longitude: model.longitude,
        geoAccuracyM: model.geoAccuracyM,
        createdBy: model.createdBy,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
        needsSync: true,
      );
}

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/customers/customer.dart';
import '../../../data/repositories/customers_repository.dart';
import '../../../config/logger.dart';
import '../../../services/sync/sync_metrics.dart';

// Commented out until generated files are available
// part 'customers_state.dart';
// part 'customers_cubit.freezed.dart';

class CustomersCubit extends Cubit<CustomersState> {
  CustomersCubit(this._repository) : super(const CustomersState.initial());
  final CustomersRepository _repository;

  Future<void> loadCustomers({bool forceSync = false}) async {
    emit(const CustomersState.loading());

    try {
      final customers = await _repository.getCustomers(forceSync: forceSync);

      // ✅ DEBUG DETALLADO
      logger.i('=== CUSTOMER SYNC DEBUG ===');
      logger.i('Loaded ${customers.length} customers:');

      int customersWithCoords = 0;
      for (final customer in customers) {
        final hasCoords = customer.effectiveLatitude != null &&
            customer.effectiveLongitude != null;
        if (hasCoords) customersWithCoords++;

        logger.i('Customer: ${customer.name}');
        logger.i('  - Has coords: $hasCoords');
        logger.i('  - Lat: ${customer.effectiveLatitude}');
        logger.i('  - Lng: ${customer.effectiveLongitude}');
        logger.i('  - Location field: ${customer.location}');

        if (!hasCoords) {
          logger.w('  - ⚠️ MISSING COORDINATES');
        }
      }

      logger.i(
          'Customers with coordinates: $customersWithCoords/${customers.length}');
      logger.i('=== END DEBUG ===');

      // ✅ REGISTRAR MÉTRICAS
      SyncMetrics.recordSyncResult(customers);

      emit(CustomersState.loaded(customers));
    } catch (e) {
      logger.e('Load customers error: $e');
      // ✅ REGISTRAR ERROR EN MÉTRICAS
      SyncMetrics.recordSyncError(e.toString());
      emit(CustomersState.error(e.toString()));
    }
  }

  Future<void> createCustomer(Customer customer) async {
    try {
      final currentState = state;
      if (currentState is CustomersLoaded) {
        emit(const CustomersState.loading());

        final newCustomer = await _repository.createCustomer(customer);
        final updatedCustomers = [...currentState.customers, newCustomer];

        emit(CustomersState.loaded(updatedCustomers));
      }
    } catch (e) {
      logger.e('Create customer error: $e');
      emit(CustomersState.error(e.toString()));
    }
  }

  Future<void> updateCustomer(Customer customer) async {
    try {
      final currentState = state;
      if (currentState is CustomersLoaded) {
        emit(const CustomersState.loading());

        final updatedCustomer = await _repository.updateCustomer(customer);
        final updatedCustomers = currentState.customers
            .map((c) => c.id == customer.id ? updatedCustomer : c)
            .toList();

        emit(CustomersState.loaded(updatedCustomers));

        logger.i('Customer updated successfully: ${customer.id}');
      }
    } catch (e) {
      logger.e('Update customer error: $e');
      emit(CustomersState.error(e.toString()));
    }
  }

  Future<void> searchCustomers(String query) async {
    try {
      final currentState = state;
      if (currentState is CustomersLoaded) {
        final filteredCustomers = currentState.customers
            .where((customer) =>
                customer.name.toLowerCase().contains(query.toLowerCase()) ||
                (customer.code?.toLowerCase().contains(query.toLowerCase()) ??
                    false) ||
                (customer.email?.toLowerCase().contains(query.toLowerCase()) ??
                    false))
            .toList();

        emit(CustomersState.loaded(filteredCustomers));
      }
    } catch (e) {
      logger.e('Search customers error: $e');
    }
  }

  Future<void> syncCustomers() async {
    try {
      emit(const CustomersState.loading());

      await _repository.syncPendingCustomers();

      // Reload customers after sync
      await loadCustomers(forceSync: true);

      logger.i('Customers sync completed');
    } catch (e) {
      logger.e('Sync customers error: $e');
      emit(CustomersState.error(e.toString()));
    }
  }

  /// ✅ MOSTRAR MÉTRICAS DE SINCRONIZACIÓN
  void showSyncMetrics() {
    SyncMetrics.printSummary();
  }

  /// ✅ MÉTODO DE TESTING: Verificar sincronización de clientes
  Future<void> testCustomerSync() async {
    logger.i('=== TESTING CUSTOMER SYNC ===');

    try {
      // 1. Cargar clientes locales
      final localCustomers = await _repository.getCustomers();
      logger.i('Local customers: ${localCustomers.length}');

      // 2. Verificar coordenadas locales
      int localWithCoords = 0;
      for (final customer in localCustomers) {
        final hasCoords = customer.effectiveLatitude != null &&
            customer.effectiveLongitude != null;
        if (hasCoords) localWithCoords++;
        logger.i(
            'Local - ${customer.name}: Lat=${customer.latitude}, Lng=${customer.longitude}, Location=${customer.location}');
      }
      logger.i(
          'Local customers with coordinates: $localWithCoords/${localCustomers.length}');

      // 3. Forzar sincronización
      logger.i('Starting sync...');
      await _repository.syncPendingCustomers();

      // 4. Recargar desde servidor
      logger.i('Reloading from server...');
      final syncedCustomers = await _repository.getCustomers(forceSync: true);
      logger.i('Synced customers: ${syncedCustomers.length}');

      // 5. Verificar coordenadas después de sync
      int syncedWithCoords = 0;
      for (final customer in syncedCustomers) {
        final hasCoords = customer.effectiveLatitude != null &&
            customer.effectiveLongitude != null;
        if (hasCoords) syncedWithCoords++;
        logger.i(
            'Synced - ${customer.name}: Lat=${customer.latitude}, Lng=${customer.longitude}, Location=${customer.location}');
      }

      logger.i('✅ SYNC TEST COMPLETE:');
      logger.i(
          '  - Local: $localWithCoords/${localCustomers.length} customers with coordinates');
      logger.i(
          '  - Synced: $syncedWithCoords/${syncedCustomers.length} customers with coordinates');

      if (syncedWithCoords < syncedCustomers.length) {
        logger.w('⚠️ Some customers are missing coordinates after sync!');
      }

      logger.i('=== END SYNC TEST ===');
    } catch (e) {
      logger.e('❌ SYNC TEST FAILED: $e');
    }
  }

  /// Temporary function to add test locations to existing customers
  Future<void> addTestLocationsToCustomers() async {
    try {
      final currentState = state;
      if (currentState is CustomersLoaded) {
        emit(const CustomersState.loading());

        final updatedCustomers = <Customer>[];

        for (int i = 0; i < currentState.customers.length; i++) {
          final customer = currentState.customers[i];

          // If customer doesn't have location, add a test location around Valencia, Venezuela
          if (customer.latitude == null || customer.longitude == null) {
            final testLatitude =
                10.1621 + (i * 0.001); // Valencia, Venezuela area
            final testLongitude = -68.0077 + (i * 0.001);

            final updatedCustomer = Customer(
              id: customer.id,
              companyId: customer.companyId,
              code: customer.code,
              name: customer.name,
              email: customer.email,
              phone: customer.phone,
              address: customer.address,
              latitude: testLatitude,
              longitude: testLongitude,
              geoAccuracyM: 10,
              createdBy: customer.createdBy,
              createdAt: customer.createdAt,
              updatedAt: DateTime.now(),
            );

            // Update in repository
            await _repository.updateCustomer(updatedCustomer);
            updatedCustomers.add(updatedCustomer);

            logger.i(
                'Added test location to ${customer.name}: $testLatitude, $testLongitude');
          } else {
            updatedCustomers.add(customer);
          }
        }

        emit(CustomersState.loaded(updatedCustomers));
      }
    } catch (e) {
      logger.e('Add test locations error: $e');
      emit(CustomersState.error(e.toString()));
    }
  }
}

// Converted from @freezed to regular class
abstract class CustomersState {
  const CustomersState();

  const factory CustomersState.initial() = _Initial;
  const factory CustomersState.loading() = _Loading;
  const factory CustomersState.loaded(List<Customer> customers) =
      CustomersLoaded;
  const factory CustomersState.error(String message) = _Error;
}

class _Initial extends CustomersState {
  const _Initial();
}

class _Loading extends CustomersState {
  const _Loading();
}

class CustomersLoaded extends CustomersState {
  const CustomersLoaded(this.customers);
  final List<Customer> customers;
}

class _Error extends CustomersState {
  const _Error(this.message);
  final String message;
}

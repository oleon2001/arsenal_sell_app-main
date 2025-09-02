import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/customers/customer.dart';
import '../../../data/repositories/customers_repository.dart';
import '../../../config/logger.dart';

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

      // Debug: Print customer data
      logger.i('Loaded ${customers.length} customers:');
      for (final customer in customers) {
        logger.i(
            'Customer: ${customer.name} - Lat: ${customer.latitude}, Lng: ${customer.longitude}');
      }

      emit(CustomersState.loaded(customers));
    } catch (e) {
      logger.e('Load customers error: $e');
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
        final updatedCustomers = currentState.customers.map((c) {
          return c.id == customer.id ? updatedCustomer : c;
        }).toList();

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
              geoAccuracyM: 10.0,
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

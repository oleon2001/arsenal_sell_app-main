import '../../../config/logger.dart';
import '../../../data/repositories/customers_repository.dart';
import '../../entities.dart';

class FetchCustomersParams {
  const FetchCustomersParams({
    this.forceSync = false,
    this.searchQuery,
    this.filter,
    this.sort,
    this.limit,
    this.offset,
  });
  final bool forceSync;
  final String? searchQuery;
  final CustomerFilter? filter;
  final CustomerSort? sort;
  final int? limit;
  final int? offset;
}

class FetchCustomersResult {
  const FetchCustomersResult({
    required this.customers,
    required this.totalCount,
    required this.hasMore,
    required this.lastSyncAt,
  });
  final List<Customer> customers;
  final int totalCount;
  final bool hasMore;
  final DateTime lastSyncAt;
}

enum CustomerFilter {
  all,
  active,
  inactive,
  blocked,
  prospect,
  moroso,
  withPendingOrders,
  withoutRecentVisits,
  nearby,
}

enum CustomerSort {
  nameAsc,
  nameDesc,
  lastVisitAsc,
  lastVisitDesc,
  distanceAsc,
  distanceDesc,
  createdAsc,
  createdDesc,
}

class FetchCustomersUseCase
    implements UseCase<FetchCustomersResult, FetchCustomersParams> {
  const FetchCustomersUseCase(this._repository);
  final CustomersRepository _repository;

  @override
  Future<FetchCustomersResult> call(FetchCustomersParams params) async {
    try {
      logger.i('Fetching customers with params: ${params.toString()}');

      // Fetch customers from repository
      final customers =
          await _repository.getCustomers(forceSync: params.forceSync);

      // Apply filtering
      var filteredCustomers = _applyFilter(customers, params.filter);

      // Apply search
      if (params.searchQuery?.isNotEmpty == true) {
        filteredCustomers =
            _applySearch(filteredCustomers, params.searchQuery!);
      }

      // Apply sorting
      _applySort(filteredCustomers, params.sort);

      // Apply pagination
      final totalCount = filteredCustomers.length;
      if (params.offset != null || params.limit != null) {
        final start = params.offset ?? 0;
        final end = params.limit != null
            ? start + params.limit!
            : filteredCustomers.length;
        filteredCustomers = filteredCustomers.sublist(
          start,
          end.clamp(0, filteredCustomers.length),
        );
      }

      final hasMore = params.limit != null &&
          (params.offset ?? 0) + params.limit! < totalCount;

      logger.i(
          'Fetched ${filteredCustomers.length} customers (total: $totalCount)');

      return FetchCustomersResult(
        customers: filteredCustomers,
        totalCount: totalCount,
        hasMore: hasMore,
        lastSyncAt: DateTime.now(), // Would come from actual sync data
      );
    } catch (e) {
      logger.e('Fetch customers failed: $e');
      throw DomainException('Failed to fetch customers: ${e.toString()}');
    }
  }

  List<Customer> _applyFilter(
      List<Customer> customers, CustomerFilter? filter) {
    if (filter == null || filter == CustomerFilter.all) {
      return customers;
    }

    switch (filter) {
      case CustomerFilter.active:
        return customers.where(_isActiveCustomer).toList();
      case CustomerFilter.inactive:
        return customers.where((c) => !_isActiveCustomer(c)).toList();
      case CustomerFilter.blocked:
        return customers.where(_isBlockedCustomer).toList();
      case CustomerFilter.prospect:
        return customers.where(_isProspectCustomer).toList();
      case CustomerFilter.moroso:
        return customers.where(_isMorosoCustomer).toList();
      case CustomerFilter.withPendingOrders:
        return customers.where(_hasPendingOrders).toList();
      case CustomerFilter.withoutRecentVisits:
        return customers.where((c) => !_hasRecentVisits(c)).toList();
      case CustomerFilter.nearby:
        return customers.where(_isNearby).toList();
      case CustomerFilter.all:
        return customers;
    }
  }

  List<Customer> _applySearch(List<Customer> customers, String query) {
    final lowerQuery = query.toLowerCase();
    return customers
        .where((customer) =>
            customer.name.toLowerCase().contains(lowerQuery) ||
            (customer.code?.toLowerCase().contains(lowerQuery) ?? false) ||
            (customer.email?.toLowerCase().contains(lowerQuery) ?? false) ||
            (customer.phone?.contains(query) ?? false) ||
            (customer.address?.toLowerCase().contains(lowerQuery) ?? false))
        .toList();
  }

  void _applySort(List<Customer> customers, CustomerSort? sort) {
    if (sort == null) return;

    switch (sort) {
      case CustomerSort.nameAsc:
        customers.sort((a, b) => a.name.compareTo(b.name));
        break;
      case CustomerSort.nameDesc:
        customers.sort((a, b) => b.name.compareTo(a.name));
        break;
      case CustomerSort.lastVisitAsc:
        customers.sort(
            (a, b) => _getLastVisitDate(a).compareTo(_getLastVisitDate(b)));
        break;
      case CustomerSort.lastVisitDesc:
        customers.sort(
            (a, b) => _getLastVisitDate(b).compareTo(_getLastVisitDate(a)));
        break;
      case CustomerSort.distanceAsc:
        customers.sort((a, b) => _getDistance(a).compareTo(_getDistance(b)));
        break;
      case CustomerSort.distanceDesc:
        customers.sort((a, b) => _getDistance(b).compareTo(_getDistance(a)));
        break;
      case CustomerSort.createdAsc:
        customers
            .sort((a, b) => _getCreatedDate(a).compareTo(_getCreatedDate(b)));
        break;
      case CustomerSort.createdDesc:
        customers
            .sort((a, b) => _getCreatedDate(b).compareTo(_getCreatedDate(a)));
        break;
    }
  }

  // Helper methods for filtering and sorting
  bool _isActiveCustomer(Customer customer) {
    // Implement business logic for active customer
    return true; // Placeholder
  }

  bool _isBlockedCustomer(Customer customer) {
    // Implement business logic for blocked customer
    return false; // Placeholder
  }

  bool _isProspectCustomer(Customer customer) {
    // Implement business logic for prospect customer
    return false; // Placeholder
  }

  bool _isMorosoCustomer(Customer customer) {
    // Implement business logic for moroso customer
    return false; // Placeholder
  }

  bool _hasPendingOrders(Customer customer) {
    // Implement business logic for pending orders
    return false; // Placeholder
  }

  bool _hasRecentVisits(Customer customer) {
    // Implement business logic for recent visits
    return false; // Placeholder
  }

  bool _isNearby(Customer customer) {
    // Implement business logic for nearby customers (requires current location)
    return customer.latitude != null && customer.longitude != null;
  }

  DateTime _getLastVisitDate(Customer customer) {
    // Get last visit date from customer data or related visits
    return customer.updatedAt ?? customer.createdAt ?? DateTime(1970);
  }

  double _getDistance(Customer customer) {
    // Calculate distance from current location (would need current location)
    return 0; // Placeholder
  }

  DateTime _getCreatedDate(Customer customer) =>
      customer.createdAt ?? DateTime(1970);
}

class FetchNearbyCustomersUseCase
    implements UseCase<List<Customer>, FetchNearbyCustomersParams> {
  const FetchNearbyCustomersUseCase(this._repository);
  final CustomersRepository _repository;

  @override
  Future<List<Customer>> call(FetchNearbyCustomersParams params) async {
    try {
      final customers = await _repository.getCustomers();

      final nearbyCustomers = customers.where((customer) {
        if (customer.latitude == null || customer.longitude == null) {
          return false;
        }

        final distance = Coordinates(
          latitude: params.currentLatitude,
          longitude: params.currentLongitude,
        ).distanceTo(Coordinates(
          latitude: customer.latitude!,
          longitude: customer.longitude!,
        ));

        return distance <= params.radiusMeters;
      }).toList();

      // Sort by distance
      nearbyCustomers.sort((a, b) {
        final distanceA = Coordinates(
          latitude: params.currentLatitude,
          longitude: params.currentLongitude,
        ).distanceTo(Coordinates(
          latitude: a.latitude!,
          longitude: a.longitude!,
        ));

        final distanceB = Coordinates(
          latitude: params.currentLatitude,
          longitude: params.currentLongitude,
        ).distanceTo(Coordinates(
          latitude: b.latitude!,
          longitude: b.longitude!,
        ));

        return distanceA.compareTo(distanceB);
      });

      if (params.limit != null && nearbyCustomers.length > params.limit!) {
        return nearbyCustomers.take(params.limit!).toList();
      }

      return nearbyCustomers;
    } catch (e) {
      logger.e('Fetch nearby customers failed: $e');
      throw DomainException(
          'Failed to fetch nearby customers: ${e.toString()}');
    }
  }
}

class FetchNearbyCustomersParams {
  const FetchNearbyCustomersParams({
    required this.currentLatitude,
    required this.currentLongitude,
    this.radiusMeters = 1000, // 1km default
    this.limit,
  });
  final double currentLatitude;
  final double currentLongitude;
  final double radiusMeters;
  final int? limit;
}

class SearchCustomersUseCase implements UseCase<List<Customer>, String> {
  const SearchCustomersUseCase(this._repository);
  final CustomersRepository _repository;

  @override
  Future<List<Customer>> call(String query) async {
    try {
      if (query.isEmpty) {
        return [];
      }

      final fetchParams = FetchCustomersParams(searchQuery: query, limit: 20);
      final useCase = FetchCustomersUseCase(_repository);
      final result = await useCase.call(fetchParams);

      return result.customers;
    } catch (e) {
      logger.e('Search customers failed: $e');
      throw DomainException('Failed to search customers: ${e.toString()}');
    }
  }
}

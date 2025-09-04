import '../../entities.dart';
import '../../../data/repositories/visits_repository.dart';
import '../../../data/repositories/customers_repository.dart';
import '../../../data/models/visits/visit.dart';
import '../../../data/models/customers/customer.dart';
import '../../../services/location/location_service.dart';
import '../../../config/logger.dart';
import '../../../config/app_constants.dart';

class StartVisitParams {
  const StartVisitParams({
    required this.customerId,
    required this.purpose,
    this.notes,
    this.forceStart = false,
    this.metadata,
  });
  final String customerId;
  final VisitPurpose purpose;
  final String? notes;
  final bool forceStart;
  final Map<String, dynamic>? metadata;
}

class StartVisitResult {
  const StartVisitResult({
    required this.visit,
    required this.customer,
    required this.distanceToCustomer,
    required this.withinGeofence,
    this.warnings = const [],
  });
  final Visit visit;
  final Customer customer;
  final double distanceToCustomer;
  final bool withinGeofence;
  final List<String> warnings;
}

class StartVisitUseCase implements UseCase<StartVisitResult, StartVisitParams> {
  const StartVisitUseCase(
    this._visitsRepository,
    this._customersRepository,
    this._locationService,
  );
  final VisitsRepository _visitsRepository;
  final CustomersRepository _customersRepository;
  final LocationService _locationService;

  @override
  Future<StartVisitResult> call(StartVisitParams params) async {
    try {
      logger.i('Starting visit for customer: ${params.customerId}');

      // Validate parameters
      _validateParams(params);

      // Get customer information
      final customer =
          await _customersRepository.getCustomerById(params.customerId);
      if (customer == null) {
        throw const DomainException('Customer not found');
      }

      // Get current location
      final currentLocation = await _locationService.getCurrentLocation();
      if (currentLocation == null) {
        throw const DomainException(
            'Unable to get current location. Location services may be disabled.');
      }

      // Validate location and geofence
      final locationValidation =
          await _validateLocation(customer, currentLocation, params.forceStart);

      // Check for existing active visits
      if (!params.forceStart) {
        await _checkForActiveVisits();
      }

      // Validate business rules
      await _validateBusinessRules(customer, params);

      // Create the visit
      final visit = await _createVisit(customer, currentLocation, params);

      // Log visit start
      await _logVisitStart(visit, customer);

      logger.i('Visit started successfully: ${visit.id}');

      return StartVisitResult(
        visit: visit,
        customer: customer,
        distanceToCustomer: locationValidation.distance,
        withinGeofence: locationValidation.withinGeofence,
        warnings: locationValidation.warnings,
      );
    } catch (e) {
      logger.e('Start visit failed: $e');

      if (e is DomainException) {
        rethrow;
      }

      throw DomainException('Failed to start visit: ${e.toString()}');
    }
  }

  void _validateParams(StartVisitParams params) {
    if (params.customerId.isEmpty) {
      throw const ValidationException('Customer ID is required');
    }

    if (params.notes != null && params.notes!.length > 1000) {
      throw const ValidationException('Notes cannot exceed 1000 characters');
    }
  }

  Future<LocationValidationResult> _validateLocation(
    Customer customer,
    currentLocation,
    bool forceStart,
  ) async {
    final warnings = <String>[];
    double distance = 0;
    bool withinGeofence = true;

    // Check if customer has valid coordinates
    if (customer.latitude == null || customer.longitude == null) {
      if (!forceStart) {
        throw const BusinessRuleException(
            'Customer location not set. Cannot validate geofence.');
      }
      warnings.add('Customer location not set - geofence validation skipped');
      return LocationValidationResult(
        distance: 0,
        withinGeofence: false,
        warnings: warnings,
      );
    }

    // Calculate distance to customer
    distance = _locationService.calculateDistance(
      currentLocation.latitude,
      currentLocation.longitude,
      customer.latitude!,
      customer.longitude!,
    );

    // Check geofence
    final geofenceRadius =
        customer.geoAccuracyM ?? AppConstants.defaultGeofenceRadius;
    withinGeofence = distance <= geofenceRadius;

    if (!withinGeofence) {
      final message =
          'You are ${distance.toStringAsFixed(1)}m away from customer. '
          'Must be within ${geofenceRadius.toStringAsFixed(0)}m to start visit.';

      if (!forceStart) {
        throw BusinessRuleException(message);
      }
      warnings.add(message);
    }

    // Check location accuracy (using 50m as max acceptable accuracy)
    const maxLocationAccuracy = 50.0;
    if (currentLocation.accuracy > maxLocationAccuracy) {
      warnings.add(
          'Location accuracy is low (${currentLocation.accuracy.toStringAsFixed(0)}m). '
          'Consider moving to a location with better GPS signal.');
    }

    return LocationValidationResult(
      distance: distance,
      withinGeofence: withinGeofence,
      warnings: warnings,
    );
  }

  Future<void> _checkForActiveVisits() async {
    // TODO: Check if user has any active visits
    // This would require getting current user ID and checking for unfinished visits

    // For now, we'll implement a simple check
    try {
      // final activeVisits = await _visitsRepository.getActiveVisits(currentUserId);
      // if (activeVisits.isNotEmpty) {
      //   throw BusinessRuleException('You have an active visit in progress. Please finish it before starting a new one.');
      // }
    } catch (e) {
      logger.w('Could not check for active visits: $e');
    }
  }

  Future<void> _validateBusinessRules(
      Customer customer, StartVisitParams params) async {
    // Check if customer is active
    // TODO: Implement customer status check
    // if (!customer.isActive) {
    //   throw BusinessRuleException('Customer is inactive');
    // }

    // Check visit purpose rules
    await _validateVisitPurpose(customer, params.purpose);

    // Check time restrictions
    _validateVisitTiming();

    // Check user permissions for this customer
    await _validateUserPermissions(customer);
  }

  Future<void> _validateVisitPurpose(
      Customer customer, VisitPurpose purpose) async {
    switch (purpose) {
      case VisitPurpose.cobro:
        // Check if customer has outstanding balance
        // TODO: Implement balance check
        break;
      case VisitPurpose.entrega:
        // Check if customer has pending deliveries
        // TODO: Implement delivery check
        break;
      case VisitPurpose.devolucion:
        // Check if customer has items to return
        // TODO: Implement return check
        break;
      default:
        // General visits are usually allowed
        break;
    }
  }

  void _validateVisitTiming() {
    final now = DateTime.now();
    final hour = now.hour;

    // Check business hours (example: 8 AM to 6 PM)
    if (hour < 8 || hour > 18) {
      throw const BusinessRuleException(
          'Visits can only be started during business hours (8 AM - 6 PM)');
    }

    // Check if it's a business day
    final weekday = now.weekday;
    if (weekday == DateTime.saturday || weekday == DateTime.sunday) {
      throw const BusinessRuleException('Visits cannot be started on weekends');
    }
  }

  Future<void> _validateUserPermissions(Customer customer) async {
    // TODO: Check if current user has permission to visit this customer
    // This might involve checking territory assignments, customer assignments, etc.
  }

  Future<Visit> _createVisit(
    Customer customer,
    currentLocation,
    StartVisitParams params,
  ) async {
    final now = DateTime.now();
    const currentUserId = 'current_user_id'; // TODO: Get from auth service

    final visit = Visit(
      id: now.millisecondsSinceEpoch.toString(),
      companyId: customer.companyId,
      customerId: customer.id,
      userId: currentUserId,
      purpose: params.purpose,
      startedAt: now,
      checkinLatitude: currentLocation.latitude,
      checkinLongitude: currentLocation.longitude,
      checkinAccuracyM: currentLocation.accuracy,
      notes: params.notes,
      customer: customer,
    );

    return _visitsRepository.startVisit(visit);
  }

  Future<void> _logVisitStart(Visit visit, Customer customer) async {
    try {
      // TODO: Log visit start in audit trail
      logger.i(
          'Visit ${visit.id} started for customer ${customer.name} (${customer.id})');
    } catch (e) {
      logger.w('Failed to log visit start: $e');
    }
  }
}

class LocationValidationResult {
  const LocationValidationResult({
    required this.distance,
    required this.withinGeofence,
    required this.warnings,
  });
  final double distance;
  final bool withinGeofence;
  final List<String> warnings;
}

class QuickStartVisitUseCase
    implements UseCase<StartVisitResult, QuickStartVisitParams> {
  const QuickStartVisitUseCase(this._startVisitUseCase);
  final StartVisitUseCase _startVisitUseCase;

  @override
  Future<StartVisitResult> call(QuickStartVisitParams params) async {
    final startParams = StartVisitParams(
      customerId: params.customerId,
      purpose: VisitPurpose.visita, // Default purpose
      notes: 'Quick visit',
      forceStart: true, // Quick visits bypass some validations
    );

    return _startVisitUseCase.call(startParams);
  }
}

class QuickStartVisitParams {
  const QuickStartVisitParams({
    required this.customerId,
  });
  final String customerId;
}

class ScheduledStartVisitUseCase
    implements UseCase<StartVisitResult, ScheduledStartVisitParams> {
  const ScheduledStartVisitUseCase(this._startVisitUseCase);
  final StartVisitUseCase _startVisitUseCase;

  @override
  Future<StartVisitResult> call(ScheduledStartVisitParams params) async {
    // Check if this is the scheduled time
    final now = DateTime.now();
    final scheduledTime = params.scheduledTime;

    final timeDifference = now.difference(scheduledTime).abs();
    if (timeDifference.inMinutes > 30) {
      throw BusinessRuleException(
          'Visit can only be started within 30 minutes of scheduled time. '
          'Scheduled: ${scheduledTime.toString()}, Current: ${now.toString()}');
    }

    final startParams = StartVisitParams(
      customerId: params.customerId,
      purpose: params.purpose,
      notes: 'Scheduled visit: ${params.notes ?? ''}',
      metadata: {
        'scheduled_time': scheduledTime.toIso8601String(),
        'route_id': params.routeId,
      },
    );

    return _startVisitUseCase.call(startParams);
  }
}

class ScheduledStartVisitParams {
  const ScheduledStartVisitParams({
    required this.customerId,
    required this.purpose,
    required this.scheduledTime,
    this.routeId,
    this.notes,
  });
  final String customerId;
  final VisitPurpose purpose;
  final DateTime scheduledTime;
  final String? routeId;
  final String? notes;
}

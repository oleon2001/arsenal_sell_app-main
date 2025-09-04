import '../../../config/logger.dart';
import '../../../core/utils/uuid_generator.dart';
import '../../../data/repositories/customers_repository.dart';
import '../../entities.dart';

class CreateCustomerParams {
  const CreateCustomerParams({
    required this.name,
    this.code,
    this.email,
    this.phone,
    this.address,
    this.latitude,
    this.longitude,
    this.geoAccuracyM,
    this.customFields,
  });
  final String name;
  final String? code;
  final String? email;
  final String? phone;
  final String? address;
  final double? latitude;
  final double? longitude;
  final double? geoAccuracyM;
  final Map<String, dynamic>? customFields;

  Customer toCustomer({
    required String companyId,
    required String createdBy,
  }) =>
      Customer(
        id: UuidGenerator.generateFromNow(),
        companyId: companyId,
        code: code,
        name: name,
        email: email,
        phone: phone,
        address: address,
        latitude: latitude,
        longitude: longitude,
        geoAccuracyM: geoAccuracyM,
        createdBy: createdBy,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
}

class CreateCustomerResult {
  const CreateCustomerResult({
    required this.customer,
    required this.wasCreatedOnline,
    this.validationMessage,
  });
  final Customer customer;
  final bool wasCreatedOnline;
  final String? validationMessage;
}

class CreateCustomerUseCase
    implements UseCase<CreateCustomerResult, CreateCustomerParams> {
  const CreateCustomerUseCase(this._repository);
  final CustomersRepository _repository;

  @override
  Future<CreateCustomerResult> call(CreateCustomerParams params) async {
    try {
      // Validate input parameters
      final validationResult = _validateParams(params);
      if (!validationResult.isValid) {
        throw ValidationException(validationResult.errors.join(', '));
      }

      // Check for duplicate customers
      await _checkForDuplicates(params);

      // Get current user context (would come from auth service)
      const companyId = 'current_company_id'; // TODO: Get from auth
      const createdBy = 'current_user_id'; // TODO: Get from auth

      // Create customer entity
      final customer = params.toCustomer(
        companyId: companyId,
        createdBy: createdBy,
      );

      // Validate business rules
      _validateBusinessRules(customer);

      // Save customer
      final createdCustomer = await _repository.createCustomer(customer);

      logger.i('Customer created successfully: ${createdCustomer.id}');

      return CreateCustomerResult(
        customer: createdCustomer,
        wasCreatedOnline: true, // TODO: Determine based on connectivity
        validationMessage: validationResult.warnings.isNotEmpty
            ? validationResult.warnings.join(', ')
            : null,
      );
    } catch (e) {
      logger.e('Create customer failed: $e');

      if (e is DomainException) {
        rethrow;
      }

      throw DomainException('Failed to create customer: ${e.toString()}');
    }
  }

  ValidationResult _validateParams(CreateCustomerParams params) {
    final errors = <String>[];
    final warnings = <String>[];

    // Required fields
    if (params.name.trim().isEmpty) {
      errors.add('Customer name is required');
    }

    if (params.name.trim().length < 2) {
      errors.add('Customer name must be at least 2 characters');
    }

    if (params.name.length > 100) {
      errors.add('Customer name cannot exceed 100 characters');
    }

    // Email validation
    if (params.email != null && params.email!.isNotEmpty) {
      if (!_isValidEmail(params.email!)) {
        errors.add('Invalid email format');
      }
    }

    // Phone validation
    if (params.phone != null && params.phone!.isNotEmpty) {
      if (!_isValidPhone(params.phone!)) {
        warnings.add('Phone number format may be invalid');
      }
    }

    // Coordinate validation
    if (params.latitude != null || params.longitude != null) {
      if (params.latitude == null || params.longitude == null) {
        errors.add('Both latitude and longitude must be provided');
      } else {
        final coordinates = Coordinates(
          latitude: params.latitude!,
          longitude: params.longitude!,
        );
        if (!coordinates.isValid()) {
          errors.add('Invalid coordinates');
        }
      }
    }

    // Code validation
    if (params.code != null && params.code!.isNotEmpty) {
      if (params.code!.length > 20) {
        errors.add('Customer code cannot exceed 20 characters');
      }
      if (!RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(params.code!)) {
        errors.add(
            'Customer code can only contain letters, numbers, underscores and hyphens');
      }
    }

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
      warnings: warnings,
    );
  }

  Future<void> _checkForDuplicates(CreateCustomerParams params) async {
    try {
      final existingCustomers = await _repository.getCustomers();

      // Check for duplicate name
      final duplicateByName = existingCustomers.any((customer) =>
          customer.name.toLowerCase().trim() ==
          params.name.toLowerCase().trim());

      if (duplicateByName) {
        throw const BusinessRuleException(
            'A customer with this name already exists');
      }

      // Check for duplicate code
      if (params.code != null && params.code!.isNotEmpty) {
        final duplicateByCode = existingCustomers.any((customer) =>
            customer.code?.toLowerCase() == params.code!.toLowerCase());

        if (duplicateByCode) {
          throw const BusinessRuleException(
              'A customer with this code already exists');
        }
      }

      // Check for duplicate email
      if (params.email != null && params.email!.isNotEmpty) {
        final duplicateByEmail = existingCustomers.any((customer) =>
            customer.email?.toLowerCase() == params.email!.toLowerCase());

        if (duplicateByEmail) {
          throw const BusinessRuleException(
              'A customer with this email already exists');
        }
      }

      // Check for duplicate phone
      if (params.phone != null && params.phone!.isNotEmpty) {
        final duplicateByPhone =
            existingCustomers.any((customer) => customer.phone == params.phone);

        if (duplicateByPhone) {
          throw const BusinessRuleException(
              'A customer with this phone number already exists');
        }
      }
    } catch (e) {
      if (e is BusinessRuleException) {
        rethrow;
      }
      // If we can't check for duplicates (e.g., offline), we proceed with creation
      logger.w('Could not check for duplicate customers: $e');
    }
  }

  void _validateBusinessRules(Customer customer) {
    // Check if customer location is within service area
    if (customer.latitude != null && customer.longitude != null) {
      if (!_isWithinServiceArea(customer.latitude!, customer.longitude!)) {
        throw const BusinessRuleException(
            'Customer location is outside service area');
      }
    }

    // Validate customer type based on business rules
    // Add more business rule validations as needed
  }

  bool _isValidEmail(String email) =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);

  bool _isValidPhone(String phone) {
    // Basic phone validation - can be enhanced based on requirements
    final cleanPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');
    return cleanPhone.length >= 7 && cleanPhone.length <= 15;
  }

  bool _isWithinServiceArea(double latitude, double longitude) {
    // Implement service area validation logic
    // For now, return true
    return true;
  }
}

class ValidationResult {
  const ValidationResult({
    required this.isValid,
    required this.errors,
    required this.warnings,
  });
  final bool isValid;
  final List<String> errors;
  final List<String> warnings;
}

class BulkCreateCustomersUseCase
    implements UseCase<BulkCreateCustomersResult, List<CreateCustomerParams>> {
  const BulkCreateCustomersUseCase(this._repository);
  final CustomersRepository _repository;

  @override
  Future<BulkCreateCustomersResult> call(
      List<CreateCustomerParams> params) async {
    try {
      final results = <CreateCustomerResult>[];
      final errors = <String>[];

      for (int i = 0; i < params.length; i++) {
        try {
          final useCase = CreateCustomerUseCase(_repository);
          final result = await useCase.call(params[i]);
          results.add(result);
        } catch (e) {
          errors.add('Row ${i + 1}: ${e.toString()}');
          logger.e('Failed to create customer at index $i: $e');
        }
      }

      return BulkCreateCustomersResult(
        successful: results,
        failed: errors,
        totalProcessed: params.length,
      );
    } catch (e) {
      logger.e('Bulk create customers failed: $e');
      throw DomainException('Bulk customer creation failed: ${e.toString()}');
    }
  }
}

class BulkCreateCustomersResult {
  const BulkCreateCustomersResult({
    required this.successful,
    required this.failed,
    required this.totalProcessed,
  });
  final List<CreateCustomerResult> successful;
  final List<String> failed;
  final int totalProcessed;

  int get successCount => successful.length;
  int get failureCount => failed.length;
  double get successRate =>
      totalProcessed > 0 ? successCount / totalProcessed : 0.0;
}

class ValidateCustomerDataUseCase
    implements UseCase<ValidationResult, CreateCustomerParams> {
  const ValidateCustomerDataUseCase();

  @override
  Future<ValidationResult> call(CreateCustomerParams params) async {
    final useCase = CreateCustomerUseCase(
      // We create a dummy repository for validation only
      _DummyCustomersRepository(),
    );

    return useCase._validateParams(params);
  }
}

// Dummy repository for validation only
class _DummyCustomersRepository implements CustomersRepository {
  @override
  Future<List<Customer>> getCustomers({bool forceSync = false}) async => [];

  @override
  Future<Customer?> getCustomerById(String i) async => null;

  @override
  Future<Customer> createCustomer(Customer customer) async => customer;

  @override
  Future<Customer> updateCustomer(Customer customer) async => customer;

  @override
  Future<void> syncPendingCustomers() async {
    // Dummy implementation for validation
  }
}

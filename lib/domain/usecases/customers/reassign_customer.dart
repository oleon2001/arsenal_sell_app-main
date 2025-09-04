import '../../../config/logger.dart';
import '../../../data/repositories/customers_repository.dart';
import '../../entities.dart';

class ReassignCustomerParams {
  const ReassignCustomerParams({
    required this.customerId,
    required this.newAssigneeId,
    required this.reason,
    this.transferHistory = true,
    this.notifyPreviousAssignee = true,
    this.notifyNewAssignee = true,
    this.effectiveDate,
  });
  final String customerId;
  final String newAssigneeId;
  final String reason;
  final bool transferHistory;
  final bool notifyPreviousAssignee;
  final bool notifyNewAssignee;
  final DateTime? effectiveDate;
}

class ReassignCustomerResult {
  const ReassignCustomerResult({
    required this.customer,
    required this.previousAssigneeId,
    required this.newAssigneeId,
    required this.reassignedAt,
    required this.historyTransferred,
    this.warnings = const [],
  });
  final Customer customer;
  final String previousAssigneeId;
  final String newAssigneeId;
  final DateTime reassignedAt;
  final bool historyTransferred;
  final List<String> warnings;
}

class ReassignCustomerUseCase
    implements UseCase<ReassignCustomerResult, ReassignCustomerParams> {
  // final UsersRepository _usersRepository; // Would need this for user validation
  // final NotificationsService _notificationsService; // For notifications

  const ReassignCustomerUseCase(this._customersRepository);
  final CustomersRepository _customersRepository;

  @override
  Future<ReassignCustomerResult> call(ReassignCustomerParams params) async {
    try {
      logger.i(
          'Starting customer reassignment: ${params.customerId} -> ${params.newAssigneeId}');

      // Validate parameters
      await _validateParams(params);

      // Get current customer
      final customer =
          await _customersRepository.getCustomerById(params.customerId);
      if (customer == null) {
        throw const DomainException('Customer not found');
      }

      // Validate business rules
      await _validateBusinessRules(customer, params);

      // Perform the reassignment
      final result = await _performReassignment(customer, params);

      // Send notifications if requested
      if (params.notifyPreviousAssignee || params.notifyNewAssignee) {
        await _sendNotifications(result, params);
      }

      // Log the reassignment
      await _logReassignment(result, params);

      logger.i('Customer reassignment completed successfully');

      return result;
    } catch (e) {
      logger.e('Customer reassignment failed: $e');

      if (e is DomainException) {
        rethrow;
      }

      throw DomainException('Failed to reassign customer: ${e.toString()}');
    }
  }

  Future<void> _validateParams(ReassignCustomerParams params) async {
    // Validate customer ID
    if (params.customerId.isEmpty) {
      throw const ValidationException('Customer ID is required');
    }

    // Validate new assignee ID
    if (params.newAssigneeId.isEmpty) {
      throw const ValidationException('New assignee ID is required');
    }

    // Validate reason
    if (params.reason.trim().isEmpty) {
      throw const ValidationException('Reassignment reason is required');
    }

    if (params.reason.length > 500) {
      throw const ValidationException('Reason cannot exceed 500 characters');
    }

    // Validate effective date
    if (params.effectiveDate != null) {
      final now = DateTime.now();
      final effectiveDate = params.effectiveDate!;

      if (effectiveDate.isBefore(now.subtract(const Duration(days: 30)))) {
        throw const ValidationException(
            'Effective date cannot be more than 30 days in the past');
      }

      if (effectiveDate.isAfter(now.add(const Duration(days: 365)))) {
        throw const ValidationException(
            'Effective date cannot be more than 1 year in the future');
      }
    }

    // TODO: Validate that new assignee exists and is active
    // final newAssignee = await _usersRepository.getUserById(params.newAssigneeId);
    // if (newAssignee == null || !newAssignee.isActive) {
    //   throw ValidationException('New assignee not found or inactive');
    // }
  }

  Future<void> _validateBusinessRules(
      Customer customer, ReassignCustomerParams params) async {
    // Check if customer is currently assigned to someone else
    final currentAssigneeId =
        customer.createdBy; // This might need to be different field

    if (currentAssigneeId == params.newAssigneeId) {
      throw const BusinessRuleException(
          'Customer is already assigned to this user');
    }

    // Check if customer has active visits
    if (await _hasActiveVisits(customer.id)) {
      throw const BusinessRuleException(
          'Cannot reassign customer with active visits');
    }

    // Check if customer has pending orders
    if (await _hasPendingOrders(customer.id)) {
      throw const BusinessRuleException(
          'Cannot reassign customer with pending orders');
    }

    // Check territorial restrictions
    if (!await _canAssignToTerritory(params.newAssigneeId, customer)) {
      throw const BusinessRuleException(
          'New assignee cannot be assigned customers in this territory');
    }

    // Check workload limits
    if (!await _isWithinWorkloadLimits(params.newAssigneeId)) {
      throw const BusinessRuleException(
          'New assignee has reached maximum customer limit');
    }
  }

  Future<ReassignCustomerResult> _performReassignment(
    Customer customer,
    ReassignCustomerParams params,
  ) async {
    final previousAssigneeId = customer.createdBy ?? 'unknown';
    final reassignedAt = params.effectiveDate ?? DateTime.now();
    final warnings = <String>[];

    try {
      // Update customer assignment
      final updatedCustomer = customer.copyWith(
        createdBy: params.newAssigneeId,
        updatedAt: reassignedAt,
      );

      // Save updated customer
      await _customersRepository.createCustomer(updatedCustomer);

      // Transfer history if requested
      bool historyTransferred = false;
      if (params.transferHistory) {
        try {
          await _transferCustomerHistory(customer.id, params.newAssigneeId);
          historyTransferred = true;
        } catch (e) {
          warnings.add('Failed to transfer customer history: ${e.toString()}');
          logger.w('History transfer failed: $e');
        }
      }

      return ReassignCustomerResult(
        customer: updatedCustomer,
        previousAssigneeId: previousAssigneeId,
        newAssigneeId: params.newAssigneeId,
        reassignedAt: reassignedAt,
        historyTransferred: historyTransferred,
        warnings: warnings,
      );
    } catch (e) {
      throw DomainException('Failed to perform reassignment: ${e.toString()}');
    }
  }

  Future<void> _sendNotifications(
    ReassignCustomerResult result,
    ReassignCustomerParams params,
  ) async {
    try {
      if (params.notifyPreviousAssignee) {
        // TODO: Send notification to previous assignee
        // await _notificationsService.sendReassignmentNotification(
        //   userId: result.previousAssigneeId,
        //   type: NotificationType.customerRemoved,
        //   customerId: result.customer.id,
        //   customerName: result.customer.name,
        //   reason: params.reason,
        // );
      }

      if (params.notifyNewAssignee) {
        // TODO: Send notification to new assignee
        // await _notificationsService.sendReassignmentNotification(
        //   userId: result.newAssigneeId,
        //   type: NotificationType.customerAssigned,
        //   customerId: result.customer.id,
        //   customerName: result.customer.name,
        //   reason: params.reason,
        // );
      }
    } catch (e) {
      logger.w('Failed to send reassignment notifications: $e');
      // Don't fail the whole operation if notifications fail
    }
  }

  Future<void> _logReassignment(
    ReassignCustomerResult result,
    ReassignCustomerParams params,
  ) async {
    try {
      // TODO: Log reassignment in audit trail
      // await _auditService.logCustomerReassignment(
      //   customerId: result.customer.id,
      //   previousAssigneeId: result.previousAssigneeId,
      //   newAssigneeId: result.newAssigneeId,
      //   reason: params.reason,
      //   performedBy: getCurrentUserId(),
      //   performedAt: result.reassignedAt,
      // );
    } catch (e) {
      logger.w('Failed to log reassignment: $e');
      // Don't fail the operation if logging fails
    }
  }

  // Helper methods that would need actual implementation
  Future<bool> _hasActiveVisits(String customerId) async {
    // TODO: Check for active visits
    return false;
  }

  Future<bool> _hasPendingOrders(String customerId) async {
    // TODO: Check for pending orders
    return false;
  }

  Future<bool> _canAssignToTerritory(String userId, Customer customer) async {
    // TODO: Check territorial restrictions
    return true;
  }

  Future<bool> _isWithinWorkloadLimits(String userId) async {
    // TODO: Check user's current customer count against limits
    return true;
  }

  Future<void> _transferCustomerHistory(
      String customerId, String newAssigneeId) async {
    // TODO: Transfer visit history, order history, etc.
    // This might involve updating multiple tables
  }
}

class BulkReassignCustomersUseCase
    implements UseCase<BulkReassignResult, BulkReassignParams> {
  const BulkReassignCustomersUseCase(this._customersRepository);
  final CustomersRepository _customersRepository;

  @override
  Future<BulkReassignResult> call(BulkReassignParams params) async {
    try {
      final results = <ReassignCustomerResult>[];
      final errors = <BulkReassignError>[];

      for (int i = 0; i < params.customerIds.length; i++) {
        final customerId = params.customerIds[i];

        try {
          final reassignParams = ReassignCustomerParams(
            customerId: customerId,
            newAssigneeId: params.newAssigneeId,
            reason: params.reason,
            transferHistory: params.transferHistory,
            notifyPreviousAssignee: params.notifyPreviousAssignee,
            notifyNewAssignee: false, // Don't spam notifications in bulk
            effectiveDate: params.effectiveDate,
          );

          final useCase = ReassignCustomerUseCase(_customersRepository);
          final result = await useCase.call(reassignParams);
          results.add(result);
        } catch (e) {
          errors.add(BulkReassignError(
            customerId: customerId,
            error: e.toString(),
          ));
          logger.e('Failed to reassign customer $customerId: $e');
        }
      }

      // Send single notification to new assignee about bulk assignment
      if (params.notifyNewAssignee && results.isNotEmpty) {
        await _sendBulkAssignmentNotification(params.newAssigneeId, results);
      }

      return BulkReassignResult(
        successful: results,
        failed: errors,
        totalProcessed: params.customerIds.length,
      );
    } catch (e) {
      logger.e('Bulk reassignment failed: $e');
      throw DomainException('Bulk reassignment failed: ${e.toString()}');
    }
  }

  Future<void> _sendBulkAssignmentNotification(
    String userId,
    List<ReassignCustomerResult> assignments,
  ) async {
    try {
      // TODO: Send bulk assignment notification
      // await _notificationsService.sendBulkAssignmentNotification(
      //   userId: userId,
      //   customerCount: assignments.length,
      //   customerNames: assignments.map((a) => a.customer.name).take(5).toList(),
      // );
    } catch (e) {
      logger.w('Failed to send bulk assignment notification: $e');
    }
  }
}

class BulkReassignParams {
  const BulkReassignParams({
    required this.customerIds,
    required this.newAssigneeId,
    required this.reason,
    this.transferHistory = true,
    this.notifyPreviousAssignee = true,
    this.notifyNewAssignee = true,
    this.effectiveDate,
  });
  final List<String> customerIds;
  final String newAssigneeId;
  final String reason;
  final bool transferHistory;
  final bool notifyPreviousAssignee;
  final bool notifyNewAssignee;
  final DateTime? effectiveDate;
}

class BulkReassignResult {
  const BulkReassignResult({
    required this.successful,
    required this.failed,
    required this.totalProcessed,
  });
  final List<ReassignCustomerResult> successful;
  final List<BulkReassignError> failed;
  final int totalProcessed;

  int get successCount => successful.length;
  int get failureCount => failed.length;
  double get successRate =>
      totalProcessed > 0 ? successCount / totalProcessed : 0.0;
}

class BulkReassignError {
  const BulkReassignError({
    required this.customerId,
    required this.error,
  });
  final String customerId;
  final String error;
}

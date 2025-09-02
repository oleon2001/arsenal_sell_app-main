import '../../../data/repositories/visits_repository.dart';
import '../../../data/models/visits/visit.dart';
import '../../../services/location/location_service.dart';
import '../../../data/remote/edge_functions.dart';
import '../../../config/logger.dart';

class CompleteVisitUseCase {
  CompleteVisitUseCase(
    this._visitsRepository,
    this._locationService,
    this._edgeFunctions,
  );
  final VisitsRepository _visitsRepository;
  final LocationService _locationService;
  final EdgeFunctionsService _edgeFunctions;

  Future<VisitCompletionResult> execute({
    required String visitId,
    String? notes,
    List<String>? photoUrls,
    String? signatureUrl,
    String? signedBy,
    Map<String, dynamic>? formResponses,
    VisitOutcome outcome = VisitOutcome.successful,
  }) async {
    try {
      // Get current location for checkout
      final currentLocation = await _locationService.getCurrentLocation();

      // Create completion data
      final completionData = VisitCompletionData(
        visitId: visitId,
        completedAt: DateTime.now(),
        checkoutLatitude: currentLocation?.latitude,
        checkoutLongitude: currentLocation?.longitude,
        checkoutAccuracy: currentLocation?.accuracy,
        notes: notes,
        photoUrls: photoUrls ?? [],
        signatureUrl: signatureUrl,
        signedBy: signedBy,
        formResponses: formResponses ?? {},
        outcome: outcome,
      );

      // Validate completion requirements
      _validateCompletionRequirements(completionData);

      // Complete the visit
      final completedVisit = await _finishVisit(completionData);

      // Calculate visit statistics
      final statistics = _calculateVisitStatistics(completedVisit);

      // Send visit summary email if customer email is available
      await _sendVisitSummaryEmail(completedVisit, completionData);

      // Generate visit report
      final report = await _generateVisitReport(completedVisit, statistics);

      logger.i('Visit completed successfully: $visitId');

      return VisitCompletionResult(
        visit: completedVisit,
        completionData: completionData,
        statistics: statistics,
        report: report,
        message: _generateCompletionMessage(outcome, statistics),
      );
    } catch (e) {
      logger.e('Complete visit error: $e');
      rethrow;
    }
  }

  Future<VisitValidationResult> validateVisitCompletion({
    required String visitId,
    bool requirePhotos = false,
    bool requireSignature = false,
    bool requireForms = false,
  }) async {
    try {
      final issues = <String>[];
      final warnings = <String>[];

      // TODO: Get visit from repository to validate
      // For now, create basic validation

      if (requirePhotos) {
        // Check if photos are required but not provided
        warnings.add('Se recomienda tomar al menos una foto como evidencia');
      }

      if (requireSignature) {
        // Check if signature is required but not provided
        issues.add('Firma del cliente requerida para completar la visita');
      }

      if (requireForms) {
        // Check if forms are required but not completed
        warnings.add('Algunos formularios pueden estar incompletos');
      }

      final isValid = issues.isEmpty;

      return VisitValidationResult(
        isValid: isValid,
        visitId: visitId,
        issues: issues,
        warnings: warnings,
        canComplete: isValid,
      );
    } catch (e) {
      logger.e('Validate visit completion error: $e');
      rethrow;
    }
  }

  Future<List<VisitTemplate>> getVisitTemplates({
    required VisitPurpose purpose,
    String? companyId,
  }) async {
    try {
      // TODO: Get visit templates from repository
      // For now, return basic templates
      return _getDefaultTemplates(purpose);
    } catch (e) {
      logger.e('Get visit templates error: $e');
      return [];
    }
  }

  Future<VisitSummary> generateVisitSummary({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      startDate ??= DateTime.now().subtract(const Duration(days: 30));
      endDate ??= DateTime.now();

      // TODO: Get visits from repository and calculate summary
      // For now, return mock summary
      return VisitSummary(
        userId: userId,
        period: VisitPeriod(start: startDate, end: endDate),
        totalVisits: 0,
        completedVisits: 0,
        cancelledVisits: 0,
        averageDuration: Duration.zero,
        totalDistance: 0,
        visitsByPurpose: {},
        visitsByOutcome: {},
        topCustomers: [],
      );
    } catch (e) {
      logger.e('Generate visit summary error: $e');
      rethrow;
    }
  }

  void _validateCompletionRequirements(VisitCompletionData data) {
    // Basic validation
    if (data.outcome == VisitOutcome.successful) {
      // Successful visits might need more evidence
      if (data.photoUrls.isEmpty && data.signatureUrl == null) {
        logger.w('Visit completed without photos or signature');
      }
    }

    if (data.outcome == VisitOutcome.cancelled &&
        (data.notes?.isEmpty ?? true)) {
      throw Exception('Notas requeridas para visitas canceladas');
    }

    if (data.outcome == VisitOutcome.rejected &&
        (data.notes?.isEmpty ?? true)) {
      throw Exception('Motivo requerido para visitas rechazadas');
    }
  }

  Future<Visit> _finishVisit(VisitCompletionData data) async {
    try {
      // TODO: Get existing visit and update it
      // For now, create a basic completed visit
      final visit = Visit(
        id: data.visitId,
        companyId: 'current_company_id',
        customerId: 'customer_id',
        purpose: VisitPurpose.visita,
        startedAt: DateTime.now().subtract(const Duration(hours: 1)),
        finishedAt: data.completedAt,
        checkoutLatitude: data.checkoutLatitude,
        checkoutLongitude: data.checkoutLongitude,
        checkoutAccuracyM: data.checkoutAccuracy,
        notes: data.notes,
        isSynced: false,
      );

      return await _visitsRepository.finishVisit(visit);
    } catch (e) {
      logger.e('Finish visit error: $e');
      rethrow;
    }
  }

  VisitStatistics _calculateVisitStatistics(Visit visit) {
    final duration = visit.finishedAt != null && visit.startedAt != null
        ? visit.finishedAt!.difference(visit.startedAt!)
        : Duration.zero;

    double? distance;
    if (visit.checkinLatitude != null &&
        visit.checkinLongitude != null &&
        visit.checkoutLatitude != null &&
        visit.checkoutLongitude != null) {
      distance = _locationService.calculateDistance(
        visit.checkinLatitude!,
        visit.checkinLongitude!,
        visit.checkoutLatitude!,
        visit.checkoutLongitude!,
      );
    }

    return VisitStatistics(
      visitId: visit.id,
      duration: duration,
      distanceCovered: distance,
      checkinAccuracy: visit.checkinAccuracyM,
      checkoutAccuracy: visit.checkoutAccuracyM,
      hasPhotos: visit.photos.isNotEmpty,
      hasSignature: visit.signature != null,
      completedAt: visit.finishedAt,
    );
  }

  Future<void> _sendVisitSummaryEmail(
      Visit visit, VisitCompletionData data) async {
    try {
      if (visit.customer?.email == null) {
        logger.i('No customer email available for visit summary');
        return;
      }

      final success = await _edgeFunctions.sendVisitEmail(
        visitId: visit.id,
        customerEmail: visit.customer!.email!,
        customerName: visit.customer!.name,
        userFullName: 'Current User', // TODO: Get from auth
        visitDate: visit.startedAt ?? DateTime.now(),
        notes: data.notes,
        photoUrls: data.photoUrls,
        signatureUrl: data.signatureUrl,
      );

      if (success) {
        logger.i('Visit summary email sent successfully');
      } else {
        logger.w('Failed to send visit summary email');
      }
    } catch (e) {
      logger.e('Send visit summary email error: $e');
      // Don't rethrow - email failure shouldn't fail visit completion
    }
  }

  Future<VisitReport> _generateVisitReport(
      Visit visit, VisitStatistics statistics) async {
    try {
      return VisitReport(
        visitId: visit.id,
        customerId: visit.customerId,
        customerName: visit.customer?.name ?? 'Cliente',
        purpose: visit.purpose,
        startedAt: visit.startedAt,
        finishedAt: visit.finishedAt,
        duration: statistics.duration,
        location:
            visit.checkinLatitude != null && visit.checkinLongitude != null
                ? VisitLocation(
                    latitude: visit.checkinLatitude!,
                    longitude: visit.checkinLongitude!,
                    address: visit.customer?.address,
                  )
                : null,
        evidence: VisitEvidence(
          photoCount: visit.photos.length,
          hasSignature: visit.signature != null,
          signedBy: visit.signature?.signedBy,
        ),
        notes: visit.notes,
        outcome: VisitOutcome.successful, // TODO: Determine actual outcome
        createdAt: DateTime.now(),
      );
    } catch (e) {
      logger.e('Generate visit report error: $e');
      rethrow;
    }
  }

  String _generateCompletionMessage(
      VisitOutcome outcome, VisitStatistics statistics) {
    switch (outcome) {
      case VisitOutcome.successful:
        return 'Visita completada exitosamente. Duración: ${_formatDuration(statistics.duration)}';
      case VisitOutcome.cancelled:
        return 'Visita cancelada';
      case VisitOutcome.rejected:
        return 'Visita rechazada por el cliente';
      case VisitOutcome.rescheduled:
        return 'Visita reprogramada';
      case VisitOutcome.partial:
        return 'Visita completada parcialmente';
    }
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  List<VisitTemplate> _getDefaultTemplates(VisitPurpose purpose) {
    switch (purpose) {
      case VisitPurpose.venta:
        return [
          VisitTemplate(
            id: 'sales_template',
            name: 'Visita de Ventas',
            purpose: purpose,
            requiredFields: ['cliente_satisfaccion', 'productos_interes'],
            recommendedPhotos: 2,
            requireSignature: true,
          ),
        ];
      case VisitPurpose.cobro:
        return [
          VisitTemplate(
            id: 'collection_template',
            name: 'Visita de Cobranza',
            purpose: purpose,
            requiredFields: ['estado_pago', 'compromiso_pago'],
            recommendedPhotos: 1,
            requireSignature: true,
          ),
        ];
      default:
        return [
          VisitTemplate(
            id: 'general_template',
            name: 'Visita General',
            purpose: purpose,
            requiredFields: ['observaciones'],
            recommendedPhotos: 1,
            requireSignature: false,
          ),
        ];
    }
  }
}

enum VisitOutcome {
  successful,
  cancelled,
  rejected,
  rescheduled,
  partial,
}

class VisitCompletionData {
  VisitCompletionData({
    required this.visitId,
    required this.completedAt,
    this.checkoutLatitude,
    this.checkoutLongitude,
    this.checkoutAccuracy,
    this.notes,
    required this.photoUrls,
    this.signatureUrl,
    this.signedBy,
    required this.formResponses,
    required this.outcome,
  });
  final String visitId;
  final DateTime completedAt;
  final double? checkoutLatitude;
  final double? checkoutLongitude;
  final double? checkoutAccuracy;
  final String? notes;
  final List<String> photoUrls;
  final String? signatureUrl;
  final String? signedBy;
  final Map<String, dynamic> formResponses;
  final VisitOutcome outcome;
}

class VisitCompletionResult {
  VisitCompletionResult({
    required this.visit,
    required this.completionData,
    required this.statistics,
    required this.report,
    required this.message,
  });
  final Visit visit;
  final VisitCompletionData completionData;
  final VisitStatistics statistics;
  final VisitReport report;
  final String message;
}

class VisitValidationResult {
  VisitValidationResult({
    required this.isValid,
    required this.visitId,
    required this.issues,
    required this.warnings,
    required this.canComplete,
  });
  final bool isValid;
  final String visitId;
  final List<String> issues;
  final List<String> warnings;
  final bool canComplete;
}

class VisitStatistics {
  VisitStatistics({
    required this.visitId,
    required this.duration,
    this.distanceCovered,
    this.checkinAccuracy,
    this.checkoutAccuracy,
    required this.hasPhotos,
    required this.hasSignature,
    this.completedAt,
  });
  final String visitId;
  final Duration duration;
  final double? distanceCovered;
  final double? checkinAccuracy;
  final double? checkoutAccuracy;
  final bool hasPhotos;
  final bool hasSignature;
  final DateTime? completedAt;
}

class VisitReport {
  VisitReport({
    required this.visitId,
    required this.customerId,
    required this.customerName,
    required this.purpose,
    this.startedAt,
    this.finishedAt,
    required this.duration,
    this.location,
    required this.evidence,
    this.notes,
    required this.outcome,
    required this.createdAt,
  });
  final String visitId;
  final String customerId;
  final String customerName;
  final VisitPurpose purpose;
  final DateTime? startedAt;
  final DateTime? finishedAt;
  final Duration duration;
  final VisitLocation? location;
  final VisitEvidence evidence;
  final String? notes;
  final VisitOutcome outcome;
  final DateTime createdAt;
}

class VisitLocation {
  VisitLocation({
    required this.latitude,
    required this.longitude,
    this.address,
  });
  final double latitude;
  final double longitude;
  final String? address;
}

class VisitEvidence {
  VisitEvidence({
    required this.photoCount,
    required this.hasSignature,
    this.signedBy,
  });
  final int photoCount;
  final bool hasSignature;
  final String? signedBy;
}

class VisitTemplate {
  VisitTemplate({
    required this.id,
    required this.name,
    required this.purpose,
    required this.requiredFields,
    required this.recommendedPhotos,
    required this.requireSignature,
  });
  final String id;
  final String name;
  final VisitPurpose purpose;
  final List<String> requiredFields;
  final int recommendedPhotos;
  final bool requireSignature;
}

class VisitSummary {
  VisitSummary({
    required this.userId,
    required this.period,
    required this.totalVisits,
    required this.completedVisits,
    required this.cancelledVisits,
    required this.averageDuration,
    required this.totalDistance,
    required this.visitsByPurpose,
    required this.visitsByOutcome,
    required this.topCustomers,
  });
  final String userId;
  final VisitPeriod period;
  final int totalVisits;
  final int completedVisits;
  final int cancelledVisits;
  final Duration averageDuration;
  final double totalDistance;
  final Map<VisitPurpose, int> visitsByPurpose;
  final Map<VisitOutcome, int> visitsByOutcome;
  final List<String> topCustomers;

  double get completionRate =>
      totalVisits > 0 ? completedVisits / totalVisits : 0;
}

class VisitPeriod {
  VisitPeriod({
    required this.start,
    required this.end,
  });
  final DateTime start;
  final DateTime end;

  Duration get duration => end.difference(start);
}

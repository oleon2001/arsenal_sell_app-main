import 'package:connectivity_plus/connectivity_plus.dart';

import '../../config/logger.dart';
import '../local/drift/db.dart';
import '../models/visits/visit.dart';
import '../remote/supabase_client.dart';

class VisitsRepository {
  final DatabaseHelper _db = DatabaseHelper.instance;
  final SupabaseService _supabase = SupabaseService();

  Future<List<Visit>> getVisitsByCustomer(String customerId) async {
    try {
      final entities = await _db.getVisitsByCustomer(customerId);
      return entities.map(_entityToModel).toList();
    } catch (e) {
      logger.e('Get visits by customer error: $e');
      return [];
    }
  }

  Future<Visit> startVisit(Visit visit) async {
    try {
      final entity = _modelToEntity(visit);
      await _db.insertVisit(entity);

      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity != ConnectivityResult.none) {
        await _syncVisitToServer(visit);
      }

      return visit;
    } catch (e) {
      logger.e('Start visit error: $e');
      rethrow;
    }
  }

  Future<Visit> finishVisit(Visit visit) async {
    try {
      final entity = _modelToEntity(visit);
      await _db.insertVisit(entity);

      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity != ConnectivityResult.none) {
        await _syncVisitToServer(visit);
      }

      return visit;
    } catch (e) {
      logger.e('Finish visit error: $e');
      rethrow;
    }
  }

  Future<void> syncPendingVisits() async {
    try {
      final pendingVisits = await _db.getPendingSyncVisits();

      for (final entity in pendingVisits) {
        final visit = _entityToModel(entity);
        await _syncVisitToServer(visit);
        await _db.markVisitSynced(visit.id);
      }
    } catch (e) {
      logger.e('Sync pending visits error: $e');
    }
  }

  Future<void> _syncVisitToServer(Visit visit) async {
    try {
      await _supabase.createVisit(visit);
    } catch (e) {
      logger.e('Sync visit to server error: $e');
    }
  }

  Visit _entityToModel(VisitEntity entity) => Visit(
        id: entity.id,
        companyId: entity.companyId,
        customerId: entity.customerId,
        userId: entity.userId,
        purpose: _stringToVisitPurpose(entity.purpose),
        startedAt: entity.startedAt,
        finishedAt: entity.finishedAt,
        checkinLatitude: entity.checkinLatitude,
        checkinLongitude: entity.checkinLongitude,
        checkoutLatitude: entity.checkoutLatitude,
        checkoutLongitude: entity.checkoutLongitude,
        checkinAccuracyM: entity.checkinAccuracyM,
        checkoutAccuracyM: entity.checkoutAccuracyM,
        distanceM: entity.distanceM,
        notes: entity.notes,
        isSynced: entity.isSynced,
      );

  VisitEntity _modelToEntity(Visit model) => VisitEntity(
        id: model.id,
        companyId: model.companyId,
        customerId: model.customerId,
        userId: model.userId,
        purpose: model.purpose.name.toUpperCase(),
        startedAt: model.startedAt,
        finishedAt: model.finishedAt,
        checkinLatitude: model.checkinLatitude,
        checkinLongitude: model.checkinLongitude,
        checkoutLatitude: model.checkoutLatitude,
        checkoutLongitude: model.checkoutLongitude,
        checkinAccuracyM: model.checkinAccuracyM,
        checkoutAccuracyM: model.checkoutAccuracyM,
        distanceM: model.distanceM,
        notes: model.notes,
        isSynced: model.isSynced,
      );

  VisitPurpose _stringToVisitPurpose(String purpose) {
    switch (purpose.toUpperCase()) {
      case 'VENTA':
        return VisitPurpose.venta;
      case 'COBRO':
        return VisitPurpose.cobro;
      case 'ENTREGA':
        return VisitPurpose.entrega;
      case 'VISITA':
        return VisitPurpose.visita;
      case 'AUDITORIA':
        return VisitPurpose.auditoria;
      case 'DEVOLUCION':
        return VisitPurpose.devolucion;
      default:
        return VisitPurpose.otro;
    }
  }
}

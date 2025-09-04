import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../config/app_constants.dart';
import '../../../config/logger.dart';
import '../../../data/models/customers/customer.dart';
import '../../../data/models/visits/visit.dart';
import '../../../data/repositories/visits_repository.dart';
import '../../../services/location/location_service.dart';

part 'visits_cubit.freezed.dart';
part 'visits_state.dart';

class VisitsCubit extends Cubit<VisitsState> {
  VisitsCubit(this._repository, this._locationService)
      : super(const VisitsState.initial());
  final VisitsRepository _repository;
  final LocationService _locationService;

  Future<void> startVisit({
    required Customer customer,
    required VisitPurpose purpose,
    String? notes,
  }) async {
    emit(const VisitsState.loading());

    try {
      final position = await _locationService.getCurrentLocation();
      if (position == null) {
        emit(const VisitsState.error('No se pudo obtener la ubicación actual'));
        return;
      }

      // Validate geofence
      if (customer.latitude != null && customer.longitude != null) {
        final distance = _locationService.calculateDistance(
          position.latitude,
          position.longitude,
          customer.latitude!,
          customer.longitude!,
        );

        if (distance > AppConstants.defaultGeofenceRadius) {
          emit(VisitsState.error(
              'Estás a ${distance.toStringAsFixed(1)}m del cliente. '
              'Debes estar dentro de ${AppConstants.defaultGeofenceRadius.toInt()}m para iniciar la visita.'));
          return;
        }
      }

      final visit = Visit(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        companyId: customer.companyId,
        customerId: customer.id,
        purpose: purpose,
        startedAt: DateTime.now(),
        checkinLatitude: position.latitude,
        checkinLongitude: position.longitude,
        checkinAccuracyM: position.accuracy,
        notes: notes,
        customer: customer,
      );

      final createdVisit = await _repository.startVisit(visit);
      emit(VisitsState.activeVisit(createdVisit));
    } catch (e) {
      logger.e('Start visit error: $e');
      emit(VisitsState.error(e.toString()));
    }
  }

  Future<void> finishVisit({
    required String visitId,
    String? notes,
  }) async {
    try {
      final currentState = state;
      if (currentState is VisitsActiveVisit) {
        final position = await _locationService.getCurrentLocation();

        final updatedVisit = Visit(
          id: currentState.visit.id,
          companyId: currentState.visit.companyId,
          customerId: currentState.visit.customerId,
          userId: currentState.visit.userId,
          purpose: currentState.visit.purpose,
          startedAt: currentState.visit.startedAt,
          finishedAt: DateTime.now(),
          checkinLatitude: currentState.visit.checkinLatitude,
          checkinLongitude: currentState.visit.checkinLongitude,
          checkoutLatitude: position?.latitude,
          checkoutLongitude: position?.longitude,
          checkinAccuracyM: currentState.visit.checkinAccuracyM,
          checkoutAccuracyM: position?.accuracy,
          distanceM: currentState.visit.distanceM,
          notes: notes ?? currentState.visit.notes,
          isSynced: currentState.visit.isSynced,
          customer: currentState.visit.customer,
          photos: currentState.visit.photos,
          signature: currentState.visit.signature,
        );

        await _repository.finishVisit(updatedVisit);
        emit(VisitsState.completed(updatedVisit));
      }
    } catch (e) {
      logger.e('Finish visit error: $e');
      emit(VisitsState.error(e.toString()));
    }
  }

  Future<void> loadVisitHistory(String customerId) async {
    emit(const VisitsState.loading());

    try {
      final visits = await _repository.getVisitsByCustomer(customerId);
      emit(VisitsState.history(visits));
    } catch (e) {
      logger.e('Load visit history error: $e');
      emit(VisitsState.error(e.toString()));
    }
  }

  void resetState() {
    emit(const VisitsState.initial());
  }
}

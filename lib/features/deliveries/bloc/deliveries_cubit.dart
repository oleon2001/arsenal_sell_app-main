import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/logger.dart';
import '../../../data/repositories/deliveries_repository.dart';
import '../../../data/models/sales/delivery.dart';

// Commented out until generated files are available
// part 'deliveries_state.dart';
// part 'deliveries_cubit.freezed.dart';

class DeliveriesCubit extends Cubit<DeliveriesState> {
  DeliveriesCubit(this._repository) : super(const DeliveriesState.initial());
  final DeliveriesRepository _repository;

  Future<void> loadDeliveries({bool forceSync = false}) async {
    emit(const DeliveriesState.loading());

    try {
      final deliveries = await _repository.getDeliveries(forceSync: forceSync);
      emit(DeliveriesState.loaded(deliveries));
    } catch (e) {
      logger.e('Load deliveries error: $e');
      emit(DeliveriesState.error(e.toString()));
    }
  }

  Future<void> confirmDelivery({
    required String deliveryId,
    required DeliveryStatus status,
    String? notes,
  }) async {
    try {
      final currentState = state;
      if (currentState is DeliveriesLoaded) {
        emit(const DeliveriesState.processing());

        final updatedDelivery = await _repository.confirmDelivery(
          deliveryId,
          status,
          notes,
        );

        // Update the delivery in the list
        final updatedDeliveries = currentState.deliveries.map((delivery) {
          if (delivery.id == deliveryId) {
            return updatedDelivery;
          }
          return delivery;
        }).toList();

        emit(DeliveriesState.loaded(updatedDeliveries));

        // Show success message
        final message = status == DeliveryStatus.delivered
            ? 'Entrega confirmada exitosamente'
            : status == DeliveryStatus.rejected
                ? 'Entrega rechazada'
                : 'Estado de entrega actualizado';

        emit(DeliveriesState.deliveryConfirmed(updatedDelivery, message));

        // Return to loaded state
        emit(DeliveriesState.loaded(updatedDeliveries));
      }
    } catch (e) {
      logger.e('Confirm delivery error: $e');
      emit(DeliveriesState.error(e.toString()));
    }
  }

  Future<void> markPartialDelivery({
    required String deliveryId,
    required List<Map<String, dynamic>> deliveredItems,
    String? notes,
  }) async {
    try {
      final currentState = state;
      if (currentState is DeliveriesLoaded) {
        emit(const DeliveriesState.processing());

        final updatedDelivery = await _repository.confirmDelivery(
          deliveryId,
          DeliveryStatus.partial,
          notes,
        );

        // Update the delivery in the list
        final updatedDeliveries = currentState.deliveries.map((delivery) {
          if (delivery.id == deliveryId) {
            return updatedDelivery;
          }
          return delivery;
        }).toList();

        emit(DeliveriesState.loaded(updatedDeliveries));
      }
    } catch (e) {
      logger.e('Mark partial delivery error: $e');
      emit(DeliveriesState.error(e.toString()));
    }
  }

  Future<void> startDeliveryRoute() async {
    try {
      // Start delivery route - could involve GPS tracking
      logger.i('Starting delivery route');

      // Load pending deliveries
      await loadDeliveries();
    } catch (e) {
      logger.e('Start delivery route error: $e');
      emit(DeliveriesState.error(e.toString()));
    }
  }

  Future<void> completeDeliveryRoute() async {
    try {
      // Complete delivery route
      logger.i('Completing delivery route');

      // Generate delivery summary
      final currentState = state;
      if (currentState is DeliveriesLoaded) {
        final completed = currentState.deliveries
            .where((d) => d.status == DeliveryStatus.delivered)
            .length;
        final total = currentState.deliveries.length;

        emit(DeliveriesState.routeCompleted(
          'Ruta completada: $completed de $total entregas realizadas',
        ));
      }
    } catch (e) {
      logger.e('Complete delivery route error: $e');
      emit(DeliveriesState.error(e.toString()));
    }
  }

  void filterDeliveries(DeliveryStatus status) {
    final currentState = state;
    if (currentState is DeliveriesLoaded) {
      final filteredDeliveries = currentState.deliveries
          .where((delivery) => delivery.status == status)
          .toList();

      emit(DeliveriesState.filtered(filteredDeliveries, status));
    }
  }

  void clearFilter() {
    final currentState = state;
    if (currentState is DeliveriesFiltered) {
      emit(DeliveriesState.loaded(currentState.allDeliveries));
    }
  }

  void searchDeliveries(String query) {
    final currentState = state;
    if (currentState is DeliveriesLoaded) {
      if (query.isEmpty) {
        // Show all deliveries
        return;
      }

      final filteredDeliveries = currentState.deliveries.where((delivery) {
        // Search in order ID, notes, etc.
        final searchFields = [
          delivery.orderId,
          delivery.notes ?? '',
          delivery.id,
        ];

        return searchFields
            .any((field) => field.toLowerCase().contains(query.toLowerCase()));
      }).toList();

      emit(DeliveriesState.searched(filteredDeliveries, query));
    }
  }

  Future<void> generateDeliveryReport({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      emit(const DeliveriesState.generatingReport());

      // Generate delivery report
      final currentState = state;
      if (currentState is DeliveriesLoaded) {
        final report = DeliveryReport(
          period: '${_formatDate(startDate)} - ${_formatDate(endDate)}',
          totalDeliveries: currentState.deliveries.length,
          successfulDeliveries: currentState.deliveries
              .where((d) => d.status == DeliveryStatus.delivered)
              .length,
          rejectedDeliveries: currentState.deliveries
              .where((d) => d.status == DeliveryStatus.rejected)
              .length,
          partialDeliveries: currentState.deliveries
              .where((d) => d.status == DeliveryStatus.partial)
              .length,
          averageDeliveryTime: 25, // Mock data
          deliveryRate: 0.85, // Mock data
        );

        emit(DeliveriesState.reportGenerated(report));
      }
    } catch (e) {
      logger.e('Generate delivery report error: $e');
      emit(DeliveriesState.error(e.toString()));
    }
  }

  String _formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';
}

// Converted from @freezed to regular class
abstract class DeliveriesState {
  const DeliveriesState();

  const factory DeliveriesState.initial() = _Initial;
  const factory DeliveriesState.loading() = _Loading;
  const factory DeliveriesState.loaded(List<Delivery> deliveries) =
      DeliveriesLoaded;
  const factory DeliveriesState.filtered(
      List<Delivery> deliveries, DeliveryStatus filter) = DeliveriesFiltered;
  const factory DeliveriesState.searched(
      List<Delivery> deliveries, String query) = DeliveriesSearched;
  const factory DeliveriesState.processing() = _Processing;
  const factory DeliveriesState.deliveryConfirmed(
      Delivery delivery, String message) = _DeliveryConfirmed;
  const factory DeliveriesState.routeCompleted(String message) =
      _RouteCompleted;
  const factory DeliveriesState.generatingReport() = _GeneratingReport;
  const factory DeliveriesState.reportGenerated(DeliveryReport report) =
      _ReportGenerated;
  const factory DeliveriesState.error(String message) = _Error;
}

class _Initial extends DeliveriesState {
  const _Initial();
}

class _Loading extends DeliveriesState {
  const _Loading();
}

class DeliveriesLoaded extends DeliveriesState {
  const DeliveriesLoaded(this.deliveries);
  final List<Delivery> deliveries;
}

class DeliveriesFiltered extends DeliveriesState {
  const DeliveriesFiltered(this.deliveries, this.filter);
  final List<Delivery> deliveries;
  final DeliveryStatus filter;
  List<Delivery> get allDeliveries => deliveries; // Simplified
}

class DeliveriesSearched extends DeliveriesState {
  const DeliveriesSearched(this.deliveries, this.query);
  final List<Delivery> deliveries;
  final String query;
}

class _Processing extends DeliveriesState {
  const _Processing();
}

class _DeliveryConfirmed extends DeliveriesState {
  const _DeliveryConfirmed(this.delivery, this.message);
  final Delivery delivery;
  final String message;
}

class _RouteCompleted extends DeliveriesState {
  const _RouteCompleted(this.message);
  final String message;
}

class _GeneratingReport extends DeliveriesState {
  const _GeneratingReport();
}

class _ReportGenerated extends DeliveriesState {
  const _ReportGenerated(this.report);
  final DeliveryReport report;
}

class _Error extends DeliveriesState {
  const _Error(this.message);
  final String message;
}

// Extension to get all deliveries from filtered state
extension DeliveriesStateX on DeliveriesState {
  List<Delivery> get allDeliveries {
    if (this is DeliveriesLoaded) {
      return (this as DeliveriesLoaded).deliveries;
    } else if (this is DeliveriesFiltered) {
      return (this as DeliveriesFiltered).deliveries;
    } else if (this is DeliveriesSearched) {
      return (this as DeliveriesSearched).deliveries;
    }
    return [];
  }
}

class DeliveryReport {
  const DeliveryReport({
    required this.period,
    required this.totalDeliveries,
    required this.successfulDeliveries,
    required this.rejectedDeliveries,
    required this.partialDeliveries,
    required this.averageDeliveryTime,
    required this.deliveryRate,
  });

  final String period;
  final int totalDeliveries;
  final int successfulDeliveries;
  final int rejectedDeliveries;
  final int partialDeliveries;
  final int averageDeliveryTime;
  final double deliveryRate;
}

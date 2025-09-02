import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../../data/models/geo/location_sample.dart';
import '../../../data/models/customers/customer.dart';
import '../../../services/location/location_service.dart';
import '../../../data/repositories/tracking_repository.dart';
import '../../../data/repositories/customers_repository.dart';
import '../../../config/logger.dart';

// Commented out until generated files are available
// part 'map_state.dart';
// part 'map_cubit.freezed.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit(this._locationService, this._trackingRepository,
      this._customersRepository)
      : super(const MapState.initial());
  final LocationService _locationService;
  final TrackingRepository _trackingRepository;
  final CustomersRepository _customersRepository;

  StreamSubscription<Position>? _locationSubscription;
  GoogleMapController? _mapController;

  Future<void> initializeMap() async {
    emit(const MapState.loading());

    try {
      final hasPermission = await _locationService.requestPermissions();
      if (!hasPermission) {
        emit(const MapState.error('Permisos de ubicación requeridos'));
        return;
      }

      final position = await _locationService.getCurrentLocation();
      if (position == null) {
        emit(const MapState.error('No se pudo obtener la ubicación'));
        return;
      }

      // Load customers automatically
      final customers = await _loadCustomers();

      emit(MapState.ready(
        currentPosition: LatLng(position.latitude, position.longitude),
        customers: customers,
        teamLocations: [],
      ));

      _startLocationTracking();
    } catch (e) {
      logger.e('Initialize map error: $e');
      emit(MapState.error(e.toString()));
    }
  }

  void _startLocationTracking() {
    _locationSubscription = _locationService.locationStream.listen(
      (position) {
        final currentState = state;
        if (currentState is MapReady) {
          final newPosition = LatLng(position.latitude, position.longitude);
          emit(currentState.copyWith(currentPosition: newPosition));

          // Save tracking data
          _saveLocationSample(position);

          // Update map camera
          _mapController?.animateCamera(
            CameraUpdate.newLatLng(newPosition),
          );
        }
      },
      onError: (error) {
        logger.e('Location tracking error: $error');
      },
    );
  }

  Future<void> _saveLocationSample(Position position) async {
    try {
      // This would get the current user ID from auth
      const userId = 'current_user_id'; // TODO: Get from auth
      const companyId = 'current_company_id'; // TODO: Get from auth

      final sample = LocationSample(
        id: DateTime.now().millisecondsSinceEpoch,
        companyId: companyId,
        userId: userId,
        at: DateTime.now(),
        latitude: position.latitude,
        longitude: position.longitude,
        speedMs: position.speed,
        accuracyM: position.accuracy,
      );

      await _trackingRepository.saveLocationSample(sample);
    } catch (e) {
      logger.e('Save location sample error: $e');
    }
  }

  void updateCustomers(List<Customer> customers) {
    final currentState = state;
    if (currentState is MapReady) {
      emit(currentState.copyWith(customers: customers));
    }
  }

  void updateTeamLocations(List<LocationSample> locations) {
    final currentState = state;
    if (currentState is MapReady) {
      emit(currentState.copyWith(teamLocations: locations));
    }
  }

  void setMapController(GoogleMapController controller) {
    _mapController = controller;
  }

  Future<List<Customer>> _loadCustomers() async {
    try {
      final customers = await _customersRepository.getCustomers();
      logger.i('MapCubit loaded ${customers.length} customers for map');
      return customers;
    } catch (e) {
      logger.e('Load customers in map error: $e');
      return [];
    }
  }

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    return super.close();
  }
}

// Converted from @freezed to regular class
abstract class MapState {
  const MapState();

  const factory MapState.initial() = _Initial;
  const factory MapState.loading() = _Loading;
  const factory MapState.ready({
    required LatLng currentPosition,
    required List<Customer> customers,
    required List<LocationSample> teamLocations,
  }) = MapReady;
  const factory MapState.error(String message) = _Error;
}

class _Initial extends MapState {
  const _Initial();
}

class _Loading extends MapState {
  const _Loading();
}

class MapReady extends MapState {
  const MapReady({
    required this.currentPosition,
    required this.customers,
    required this.teamLocations,
  });

  final LatLng currentPosition;
  final List<Customer> customers;
  final List<LocationSample> teamLocations;

  MapReady copyWith({
    LatLng? currentPosition,
    List<Customer>? customers,
    List<LocationSample>? teamLocations,
  }) =>
      MapReady(
        currentPosition: currentPosition ?? this.currentPosition,
        customers: customers ?? this.customers,
        teamLocations: teamLocations ?? this.teamLocations,
      );
}

class _Error extends MapState {
  const _Error(this.message);
  final String message;
}

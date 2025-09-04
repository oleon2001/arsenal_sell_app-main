import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/geo/location_sample.dart';
import '../../../data/models/customers/customer.dart';
import '../../../data/models/visits/visit.dart';
import '../../../data/models/sales/order.dart';
import '../../../data/models/auth/user_profile.dart';
import '../../../data/repositories/tracking_repository.dart';
import '../../../data/repositories/customers_repository.dart';
import '../../../data/repositories/visits_repository.dart';
import '../../../data/repositories/orders_repository.dart';
import '../../../config/logger.dart';

part 'supervisor_cubit.freezed.dart';

class SupervisorCubit extends Cubit<SupervisorState> {
  SupervisorCubit(
    this._trackingRepository,
    this._customersRepository,
    this._visitsRepository,
    this._ordersRepository,
  ) : super(const SupervisorState.initial());
  final TrackingRepository _trackingRepository;
  final CustomersRepository _customersRepository;
  final VisitsRepository _visitsRepository;
  final OrdersRepository _ordersRepository;

  Timer? _locationUpdateTimer;

  Future<void> initializeDashboard() async {
    emit(const SupervisorState.loading());

    try {
      // Load initial data
      await Future.wait([
        _loadTeamLocations(),
        _loadTodayStats(),
        _loadActiveVisits(),
      ]);

      // Start real-time location updates
      _startLocationUpdates();

      emit(const SupervisorState.loaded(
        teamLocations: [],
        todayStats: SupervisorStats(),
        activeVisits: [],
        teamMembers: [],
      ));
    } catch (e) {
      logger.e('Initialize supervisor dashboard error: $e');
      emit(SupervisorState.error(e.toString()));
    }
  }

  Future<void> _loadTeamLocations() async {
    try {
      final locations = await _trackingRepository.getRealtimeLocations();
      final currentState = state;

      if (currentState is SupervisorLoaded) {
        emit(currentState.copyWith(teamLocations: locations));
      }
    } catch (e) {
      logger.e('Load team locations error: $e');
    }
  }

  Future<void> _loadTodayStats() async {
    try {
      // Mock stats - implement actual stats calculation
      const stats = SupervisorStats(
        totalVisits: 25,
        completedVisits: 18,
        pendingVisits: 7,
        totalOrders: 12,
        totalSales: 15480.50,
        teamMembersActive: 8,
        averageVisitDuration: 35,
      );

      final currentState = state;
      if (currentState is SupervisorLoaded) {
        emit(currentState.copyWith(todayStats: stats));
      }
    } catch (e) {
      logger.e('Load today stats error: $e');
    }
  }

  Future<void> _loadActiveVisits() async {
    try {
      // Get active visits for today
      final today = DateTime.now();
      final startOfDay = DateTime(today.year, today.month, today.day);

      // Mock active visits - implement actual query
      final activeVisits = <Visit>[];

      final currentState = state;
      if (currentState is SupervisorLoaded) {
        emit(currentState.copyWith(activeVisits: activeVisits));
      }
    } catch (e) {
      logger.e('Load active visits error: $e');
    }
  }

  void _startLocationUpdates() {
    _locationUpdateTimer?.cancel();
    _locationUpdateTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => _loadTeamLocations(),
    );
  }

  Future<void> refreshData() async {
    final currentState = state;
    if (currentState is SupervisorLoaded) {
      emit(currentState.copyWith(isRefreshing: true));
    }

    await Future.wait([
      _loadTeamLocations(),
      _loadTodayStats(),
      _loadActiveVisits(),
    ]);

    if (currentState is SupervisorLoaded) {
      emit(currentState.copyWith(isRefreshing: false));
    }
  }

  Future<void> loadTeamMember(String userId) async {
    try {
      final currentState = state;
      if (currentState is SupervisorLoaded) {
        emit(currentState.copyWith(isLoadingMember: true));

        // Load team member details, visits, and performance
        // Mock data for now
        final memberDetails = TeamMemberDetails(
          user: UserProfile(
            id: userId,
            fullName: 'Juan Pérez',
          ),
          todayVisits: [],
          todayOrders: [],
          performance: const MemberPerformance(
            visitsToday: 5,
            ordersToday: 3,
            salesAmount: 2500,
            visitDuration: 42,
            efficiency: 85.5,
          ),
        );

        emit(currentState.copyWith(
          isLoadingMember: false,
          selectedMemberDetails: memberDetails,
        ));
      }
    } catch (e) {
      logger.e('Load team member error: $e');
      final currentState = state;
      if (currentState is SupervisorLoaded) {
        emit(currentState.copyWith(isLoadingMember: false));
      }
    }
  }

  Future<void> loadPerformanceReport({
    required DateTime startDate,
    required DateTime endDate,
    String? userId,
  }) async {
    try {
      emit(const SupervisorState.loadingReport());

      // Generate performance report
      final report = PerformanceReport(
        period: '${_formatDate(startDate)} - ${_formatDate(endDate)}',
        totalVisits: 150,
        completedVisits: 135,
        totalOrders: 89,
        totalSales: 125680.50,
        averageOrderValue: 1412.58,
        topPerformers: [
          const TeamPerformance(
            userId: 'user1',
            userName: 'Juan Pérez',
            visits: 25,
            orders: 18,
            sales: 22500,
          ),
          const TeamPerformance(
            userId: 'user2',
            userName: 'María García',
            visits: 22,
            orders: 16,
            sales: 19800,
          ),
        ],
        visitsByDay: [
          DayPerformance(date: startDate, visits: 20, orders: 15),
          DayPerformance(
              date: startDate.add(const Duration(days: 1)),
              visits: 18,
              orders: 12),
        ],
      );

      emit(SupervisorState.reportLoaded(report));
    } catch (e) {
      logger.e('Load performance report error: $e');
      emit(SupervisorState.error(e.toString()));
    }
  }

  Future<void> sendTeamMessage({
    required String message,
    List<String>? targetUserIds,
  }) async {
    try {
      // Send message to team members
      // This would integrate with FCM or another messaging service

      // For now, just show success
      logger.i('Team message sent: $message');
    } catch (e) {
      logger.e('Send team message error: $e');
    }
  }

  Future<void> approveOrder(String orderId) async {
    try {
      // Approve order logic
      logger.i('Order approved: $orderId');
    } catch (e) {
      logger.e('Approve order error: $e');
    }
  }

  Future<void> rejectOrder(String orderId, String reason) async {
    try {
      // Reject order logic
      logger.i('Order rejected: $orderId, reason: $reason');
    } catch (e) {
      logger.e('Reject order error: $e');
    }
  }

  Future<void> reassignCustomer({
    required String customerId,
    required String newUserId,
  }) async {
    try {
      // Reassign customer to another team member
      logger.i('Customer $customerId reassigned to $newUserId');
    } catch (e) {
      logger.e('Reassign customer error: $e');
    }
  }

  Future<void> setGeofenceAlert({
    required String userId,
    required double lat,
    required double lng,
    required double radiusM,
  }) async {
    try {
      // Set geofence alert for team member
      logger.i('Geofence alert set for user $userId');
    } catch (e) {
      logger.e('Set geofence alert error: $e');
    }
  }

  void clearSelectedMember() {
    final currentState = state;
    if (currentState is SupervisorLoaded) {
      emit(currentState.copyWith(selectedMemberDetails: null));
    }
  }

  String _formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';

  @override
  Future<void> close() {
    _locationUpdateTimer?.cancel();
    return super.close();
  }
}

@freezed
class SupervisorState with _$SupervisorState {
  const factory SupervisorState.initial() = _Initial;
  const factory SupervisorState.loading() = _Loading;
  const factory SupervisorState.loaded({
    required List<LocationSample> teamLocations,
    required SupervisorStats todayStats,
    required List<Visit> activeVisits,
    required List<UserProfile> teamMembers,
    @Default(false) bool isRefreshing,
    @Default(false) bool isLoadingMember,
    TeamMemberDetails? selectedMemberDetails,
  }) = SupervisorLoaded;
  const factory SupervisorState.loadingReport() = _LoadingReport;
  const factory SupervisorState.reportLoaded(PerformanceReport report) =
      _ReportLoaded;
  const factory SupervisorState.error(String message) = _Error;
}

@freezed
class SupervisorStats with _$SupervisorStats {
  const factory SupervisorStats({
    @Default(0) int totalVisits,
    @Default(0) int completedVisits,
    @Default(0) int pendingVisits,
    @Default(0) int totalOrders,
    @Default(0.0) double totalSales,
    @Default(0) int teamMembersActive,
    @Default(0) int averageVisitDuration,
  }) = _SupervisorStats;
}

@freezed
class TeamMemberDetails with _$TeamMemberDetails {
  const factory TeamMemberDetails({
    required UserProfile user,
    required List<Visit> todayVisits,
    required List<Order> todayOrders,
    LocationSample? currentLocation,
    required MemberPerformance performance,
  }) = _TeamMemberDetails;
}

@freezed
class MemberPerformance with _$MemberPerformance {
  const factory MemberPerformance({
    required int visitsToday,
    required int ordersToday,
    required double salesAmount,
    required int visitDuration,
    required double efficiency,
  }) = _MemberPerformance;
}

@freezed
class PerformanceReport with _$PerformanceReport {
  const factory PerformanceReport({
    required String period,
    required int totalVisits,
    required int completedVisits,
    required int totalOrders,
    required double totalSales,
    required double averageOrderValue,
    required List<TeamPerformance> topPerformers,
    required List<DayPerformance> visitsByDay,
  }) = _PerformanceReport;
}

@freezed
class TeamPerformance with _$TeamPerformance {
  const factory TeamPerformance({
    required String userId,
    required String userName,
    required int visits,
    required int orders,
    required double sales,
  }) = _TeamPerformance;
}

@freezed
class DayPerformance with _$DayPerformance {
  const factory DayPerformance({
    required DateTime date,
    required int visits,
    required int orders,
  }) = _DayPerformance;
}

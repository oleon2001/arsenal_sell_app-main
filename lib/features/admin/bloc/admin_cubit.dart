import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/auth/user_profile.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/companies_repository.dart';
import '../../../config/logger.dart';

part 'admin_cubit.freezed.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit(
    this._authRepository,
    this._companiesRepository,
  ) : super(const AdminState.initial());

  final AuthRepository _authRepository;
  final CompaniesRepository _companiesRepository;

  Timer? _refreshTimer;

  Future<void> initializeDashboard() async {
    emit(const AdminState.loading());

    try {
      // Load all dashboard data in parallel
      await Future.wait([
        _loadAdminStats(),
        _loadAllUsers(),
        _loadSystemInfo(),
        _loadAuditLogs(),
      ]);

      // Start periodic refresh
      _startPeriodicRefresh();

      logger.i('Admin dashboard initialized successfully');
    } catch (e) {
      logger.e('Failed to initialize admin dashboard: $e');
      emit(AdminState.error(e.toString()));
    }
  }

  Future<void> _loadAdminStats() async {
    try {
      final users = await _authRepository.getAllUsers();
      final companies = await _companiesRepository.getCompanies();

      final stats = AdminStats(
        totalUsers: users.length,
        activeUsers: users.where((u) => u.isActive).length,
        totalCompanies: companies.length,
        todaySessions: await _getTodaySessions(),
      );

      // Update state with stats
      state.whenOrNull(
        loaded: (_, users, systemInfo, auditLogs) {
          emit(AdminState.loaded(stats, users, systemInfo, auditLogs));
        },
      );
    } catch (e) {
      logger.e('Failed to load admin stats: $e');
      rethrow;
    }
  }

  Future<void> _loadAllUsers() async {
    try {
      final users = await _authRepository.getAllUsers();

      // Update state with users
      state.whenOrNull(
        loaded: (stats, _, systemInfo, auditLogs) {
          emit(AdminState.loaded(stats, users, systemInfo, auditLogs));
        },
      );
    } catch (e) {
      logger.e('Failed to load users: $e');
      rethrow;
    }
  }

  Future<void> _loadSystemInfo() async {
    try {
      final systemInfo = SystemInfo(
        version: '1.0.0',
        lastUpdate: DateTime.now().subtract(const Duration(days: 2)),
        uptime: '5 días, 12 horas',
        memoryUsage: '2.1 GB / 8 GB',
        databaseStatus: 'OK',
        apiStatus: 'OK',
        storageStatus: 'OK',
        authStatus: 'OK',
      );

      // Update state with system info
      state.whenOrNull(
        loaded: (stats, users, _, auditLogs) {
          emit(AdminState.loaded(stats, users, systemInfo, auditLogs));
        },
      );
    } catch (e) {
      logger.e('Failed to load system info: $e');
      rethrow;
    }
  }

  Future<void> _loadAuditLogs() async {
    try {
      // TODO: Implement actual audit log loading
      final auditLogs = <AuditLog>[
        AuditLog(
          id: '1',
          userId: 'user1',
          userName: 'Admin User',
          action: 'CREATE',
          resource: 'User',
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
        AuditLog(
          id: '2',
          userId: 'user2',
          userName: 'John Doe',
          action: 'LOGIN',
          resource: 'System',
          timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        ),
        AuditLog(
          id: '3',
          userId: 'user1',
          userName: 'Admin User',
          action: 'UPDATE',
          resource: 'Company',
          timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        ),
      ];

      // Update state with audit logs
      state.whenOrNull(
        loaded: (stats, users, systemInfo, _) {
          emit(AdminState.loaded(stats, users, systemInfo, auditLogs));
        },
      );
    } catch (e) {
      logger.e('Failed to load audit logs: $e');
      rethrow;
    }
  }

  Future<int> _getTodaySessions() async {
    // TODO: Implement actual session counting
    return 42;
  }

  void _startPeriodicRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      refreshData();
    });
  }

  Future<void> refreshData() async {
    try {
      await _loadAdminStats();
      await _loadAllUsers();
      await _loadSystemInfo();
      await _loadAuditLogs();
    } catch (e) {
      logger.e('Failed to refresh admin data: $e');
      emit(AdminState.error(e.toString()));
    }
  }

  Future<void> createUser({
    required String email,
    required String fullName,
    required UserRole role,
    String? phone,
  }) async {
    try {
      // TODO: Implement user creation
      logger.i('Creating user: $email');

      // Refresh users list
      await _loadAllUsers();
    } catch (e) {
      logger.e('Failed to create user: $e');
      emit(AdminState.error('Error al crear usuario: $e'));
    }
  }

  Future<void> updateUser(
    String userId, {
    String? email,
    String? fullName,
    UserRole? role,
    String? phone,
    bool? isActive,
  }) async {
    try {
      // TODO: Implement user update
      logger.i('Updating user: $userId');

      // Refresh users list
      await _loadAllUsers();
    } catch (e) {
      logger.e('Failed to update user: $e');
      emit(AdminState.error('Error al actualizar usuario: $e'));
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      // TODO: Implement user deletion
      logger.i('Deleting user: $userId');

      // Refresh users list
      await _loadAllUsers();
    } catch (e) {
      logger.e('Failed to delete user: $e');
      emit(AdminState.error('Error al eliminar usuario: $e'));
    }
  }

  Future<void> toggleUserStatus(String userId) async {
    try {
      // TODO: Implement user status toggle
      logger.i('Toggling user status: $userId');

      // Refresh users list
      await _loadAllUsers();
    } catch (e) {
      logger.e('Failed to toggle user status: $e');
      emit(AdminState.error('Error al cambiar estado del usuario: $e'));
    }
  }

  Future<void> resetUserPassword(String userId) async {
    try {
      // TODO: Implement password reset
      logger.i('Resetting password for user: $userId');
    } catch (e) {
      logger.e('Failed to reset user password: $e');
      emit(AdminState.error('Error al resetear contraseña: $e'));
    }
  }

  Future<void> testDatabaseConnection() async {
    try {
      // TODO: Implement database connection test
      logger.i('Testing database connection');
    } catch (e) {
      logger.e('Database connection test failed: $e');
      emit(AdminState.error('Error en la conexión a la base de datos: $e'));
    }
  }

  Future<void> createBackup() async {
    try {
      // TODO: Implement backup creation
      logger.i('Creating system backup');
    } catch (e) {
      logger.e('Failed to create backup: $e');
      emit(AdminState.error('Error al crear respaldo: $e'));
    }
  }

  Future<void> restoreBackup() async {
    try {
      // TODO: Implement backup restoration
      logger.i('Restoring system backup');
    } catch (e) {
      logger.e('Failed to restore backup: $e');
      emit(AdminState.error('Error al restaurar respaldo: $e'));
    }
  }

  Future<void> clearCache() async {
    try {
      // TODO: Implement cache clearing
      logger.i('Clearing system cache');
    } catch (e) {
      logger.e('Failed to clear cache: $e');
      emit(AdminState.error('Error al limpiar cache: $e'));
    }
  }

  Future<void> exportAuditLogs() async {
    try {
      // TODO: Implement audit logs export
      logger.i('Exporting audit logs');
    } catch (e) {
      logger.e('Failed to export audit logs: $e');
      emit(AdminState.error('Error al exportar logs: $e'));
    }
  }

  @override
  Future<void> close() {
    _refreshTimer?.cancel();
    return super.close();
  }
}

@freezed
class AdminState with _$AdminState {
  const factory AdminState.initial() = _Initial;
  const factory AdminState.loading() = _Loading;
  const factory AdminState.loaded(
    AdminStats stats,
    List<UserProfile> users,
    SystemInfo systemInfo,
    List<AuditLog> auditLogs,
  ) = _Loaded;
  const factory AdminState.error(String message) = _Error;
}

@freezed
class AdminStats with _$AdminStats {
  const factory AdminStats({
    @Default(0) int totalUsers,
    @Default(0) int activeUsers,
    @Default(0) int totalCompanies,
    @Default(0) int todaySessions,
  }) = _AdminStats;
}

@freezed
class SystemInfo with _$SystemInfo {
  const factory SystemInfo({
    required String version,
    required DateTime lastUpdate,
    required String uptime,
    required String memoryUsage,
    required String databaseStatus,
    required String apiStatus,
    required String storageStatus,
    required String authStatus,
  }) = _SystemInfo;
}

@freezed
class AuditLog with _$AuditLog {
  const factory AuditLog({
    required String id,
    required String userId,
    required String userName,
    required String action,
    required String resource,
    required DateTime timestamp,
  }) = _AuditLog;
}

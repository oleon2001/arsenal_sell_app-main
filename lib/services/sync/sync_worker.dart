import 'dart:async';
import 'dart:isolate';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../config/logger.dart';
import '../../config/app_constants.dart';
import '../../data/repositories/customers_repository.dart';
import '../../data/repositories/visits_repository.dart';
import '../../data/repositories/orders_repository.dart';
import '../../data/repositories/tracking_repository.dart';
import '../../data/repositories/payments_repository.dart';
import 'sync_queue.dart';

enum SyncStatus {
  idle,
  syncing,
  success,
  error,
  paused,
}

class SyncWorker {
  factory SyncWorker() => _instance;
  SyncWorker._internal();
  static final SyncWorker _instance = SyncWorker._internal();

  Timer? _syncTimer;
  StreamController<SyncStatus>? _statusController;
  StreamController<SyncProgress>? _progressController;

  bool _isInitialized = false;
  bool _isSyncing = false;
  SyncStatus _currentStatus = SyncStatus.idle;

  // Repositories
  late CustomersRepository _customersRepo;
  late VisitsRepository _visitsRepo;
  late OrdersRepository _ordersRepo;
  late TrackingRepository _trackingRepo;
  late PaymentsRepository _paymentsRepo;
  late SyncQueue _syncQueue;

  Stream<SyncStatus> get statusStream =>
      _statusController?.stream ?? const Stream.empty();
  Stream<SyncProgress> get progressStream =>
      _progressController?.stream ?? const Stream.empty();

  SyncStatus get currentStatus => _currentStatus;
  bool get isSyncing => _isSyncing;

  Future<void> initialize({
    required CustomersRepository customersRepo,
    required VisitsRepository visitsRepo,
    required OrdersRepository ordersRepo,
    required TrackingRepository trackingRepo,
    required PaymentsRepository paymentsRepo,
    required SyncQueue syncQueue,
  }) async {
    if (_isInitialized) return;

    _customersRepo = customersRepo;
    _visitsRepo = visitsRepo;
    _ordersRepo = ordersRepo;
    _trackingRepo = trackingRepo;
    _paymentsRepo = paymentsRepo;
    _syncQueue = syncQueue;

    _statusController = StreamController<SyncStatus>.broadcast();
    _progressController = StreamController<SyncProgress>.broadcast();

    _startPeriodicSync();
    _listenToConnectivityChanges();

    _isInitialized = true;
    logger.i('SyncWorker initialized');
  }

  void _startPeriodicSync() {
    _syncTimer?.cancel();
    _syncTimer = Timer.periodic(AppConstants.syncInterval, (_) {
      if (!_isSyncing) {
        syncNow();
      }
    });
  }

  void _listenToConnectivityChanges() {
    Connectivity().onConnectivityChanged.listen((connectivity) {
      if (connectivity != ConnectivityResult.none && !_isSyncing) {
        // Connection restored, try to sync
        syncNow();
      }
    });
  }

  Future<void> syncNow({bool force = false}) async {
    if (_isSyncing && !force) {
      logger.d('Sync already in progress');
      return;
    }

    if (!await _isOnline()) {
      _updateStatus(SyncStatus.paused);
      logger.d('No internet connection, sync paused');
      return;
    }

    try {
      _isSyncing = true;
      _updateStatus(SyncStatus.syncing);
      _updateProgress(SyncProgress(
          current: 0, total: 5, operation: 'Iniciando sincronización...'));

      logger.i('Starting sync process');

      // 1. Sync pending visits
      _updateProgress(SyncProgress(
          current: 1, total: 5, operation: 'Sincronizando visitas...'));
      await _visitsRepo.syncPendingVisits();

      // 2. Sync pending orders
      _updateProgress(SyncProgress(
          current: 2, total: 5, operation: 'Sincronizando pedidos...'));
      await _ordersRepo.syncPendingOrders();

      // 3. Sync tracking locations
      _updateProgress(SyncProgress(
          current: 3, total: 5, operation: 'Sincronizando ubicaciones...'));
      await _trackingRepo.syncPendingLocations();

      // 4. Sync payments
      _updateProgress(SyncProgress(
          current: 4, total: 5, operation: 'Sincronizando pagos...'));
      // await _paymentsRepo.syncPendingPayments();

      // 5. Process sync queue
      _updateProgress(
          SyncProgress(current: 5, total: 5, operation: 'Finalizando...'));
      // Additional sync queue processing if needed

      _updateStatus(SyncStatus.success);
      _updateProgress(SyncProgress(
          current: 5, total: 5, operation: 'Sincronización completada'));

      logger.i('Sync completed successfully');
    } catch (e) {
      logger.e('Sync error: $e');
      _updateStatus(SyncStatus.error);
      _updateProgress(SyncProgress(
          current: 0, total: 5, operation: 'Error en sincronización'));
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> syncSpecificData(SyncDataType dataType) async {
    if (!await _isOnline()) {
      throw Exception('No internet connection');
    }

    try {
      _updateStatus(SyncStatus.syncing);

      switch (dataType) {
        case SyncDataType.visits:
          _updateProgress(SyncProgress(
              current: 1, total: 1, operation: 'Sincronizando visitas...'));
          await _visitsRepo.syncPendingVisits();
          break;
        case SyncDataType.orders:
          _updateProgress(SyncProgress(
              current: 1, total: 1, operation: 'Sincronizando pedidos...'));
          await _ordersRepo.syncPendingOrders();
          break;
        case SyncDataType.tracking:
          _updateProgress(SyncProgress(
              current: 1, total: 1, operation: 'Sincronizando ubicaciones...'));
          await _trackingRepo.syncPendingLocations();
          break;
        case SyncDataType.customers:
          _updateProgress(SyncProgress(
              current: 1, total: 1, operation: 'Sincronizando clientes...'));
          await _customersRepo.getCustomers(forceSync: true);
          break;
        case SyncDataType.payments:
          _updateProgress(SyncProgress(
              current: 1, total: 1, operation: 'Sincronizando pagos...'));
          // await _paymentsRepo.syncPendingPayments();
          break;
      }

      _updateStatus(SyncStatus.success);
    } catch (e) {
      logger.e('Sync specific data error: $e');
      _updateStatus(SyncStatus.error);
      rethrow;
    }
  }

  Future<SyncStatus> checkPendingSync() async {
    try {
      final pendingCount = await _syncQueue.getPendingCount();
      return pendingCount > 0 ? SyncStatus.paused : SyncStatus.idle;
    } catch (e) {
      logger.e('Check pending sync error: $e');
      return SyncStatus.error;
    }
  }

  Future<int> getPendingSyncCount() async {
    try {
      return await _syncQueue.getPendingCount();
    } catch (e) {
      logger.e('Get pending sync count error: $e');
      return 0;
    }
  }

  void pauseSync() {
    _syncTimer?.cancel();
    if (_currentStatus == SyncStatus.syncing) {
      _updateStatus(SyncStatus.paused);
    }
    logger.i('Sync paused');
  }

  void resumeSync() {
    _startPeriodicSync();
    if (_currentStatus == SyncStatus.paused) {
      _updateStatus(SyncStatus.idle);
    }
    logger.i('Sync resumed');
  }

  Future<void> forceSyncAll() async {
    await syncNow(force: true);
  }

  Future<bool> _isOnline() async {
    try {
      final connectivity = await Connectivity().checkConnectivity();
      return connectivity != ConnectivityResult.none;
    } catch (e) {
      logger.e('Check connectivity error: $e');
      return false;
    }
  }

  void _updateStatus(SyncStatus status) {
    _currentStatus = status;
    _statusController?.add(status);
  }

  void _updateProgress(SyncProgress progress) {
    _progressController?.add(progress);
  }

  Future<void> runInBackground() async {
    // This would be used for background sync
    // Could be implemented with workmanager or similar
    if (!await _isOnline()) return;

    try {
      await _trackingRepo.syncPendingLocations();
      await _visitsRepo.syncPendingVisits();
    } catch (e) {
      logger.e('Background sync error: $e');
    }
  }

  void dispose() {
    _syncTimer?.cancel();
    _statusController?.close();
    _progressController?.close();
    _isInitialized = false;
    logger.i('SyncWorker disposed');
  }
}

class SyncProgress {
  SyncProgress({
    required this.current,
    required this.total,
    required this.operation,
    this.percentage,
  });
  final int current;
  final int total;
  final String operation;
  final double? percentage;

  double get calculatedPercentage =>
      percentage ?? (total > 0 ? (current / total) * 100 : 0);

  @override
  String toString() =>
      'SyncProgress(current: $current, total: $total, operation: $operation, percentage: ${calculatedPercentage.toStringAsFixed(1)}%)';
}

enum SyncDataType {
  visits,
  orders,
  customers,
  tracking,
  payments,
}

// Background isolate for sync (if needed)
class BackgroundSyncIsolate {
  static void entryPoint(SendPort sendPort) {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);

    receivePort.listen((message) async {
      if (message is Map<String, dynamic>) {
        final command = message['command'] as String;

        switch (command) {
          case 'sync_tracking':
            // Perform tracking sync in background
            break;
          case 'sync_visits':
            // Perform visits sync in background
            break;
          case 'stop':
            Isolate.exit();
            break;
        }
      }
    });
  }
}

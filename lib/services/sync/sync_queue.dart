import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../../config/app_constants.dart';
import '../../config/logger.dart';
import '../../data/local/hive/boxes.dart';
import '../../data/repositories/customers_repository.dart';
import '../../data/repositories/orders_repository.dart';
import '../../data/repositories/tracking_repository.dart';
import '../../data/repositories/visits_repository.dart';

enum SyncItemType { customer, visit, order, tracking }

class SyncItem {
  SyncItem({
    required this.id,
    required this.type,
    required this.data,
    required this.createdAt,
    this.retryCount = 0,
  });

  factory SyncItem.fromJson(Map<String, dynamic> json) => SyncItem(
        id: json['id'],
        type: SyncItemType.values.byName(json['type']),
        data: json['data'],
        createdAt: DateTime.parse(json['createdAt']),
        retryCount: json['retryCount'] ?? 0,
      );
  final String id;
  final SyncItemType type;
  final Map<String, dynamic> data;
  final DateTime createdAt;
  final int retryCount;

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.name,
        'data': data,
        'createdAt': createdAt.toIso8601String(),
        'retryCount': retryCount,
      };
}

class SyncQueue {
  factory SyncQueue() => _instance;
  SyncQueue._internal();
  static final SyncQueue _instance = SyncQueue._internal();

  Timer? _syncTimer;
  bool _isSyncing = false;

  // Repositories
  late CustomersRepository _customersRepo;
  late VisitsRepository _visitsRepo;
  late OrdersRepository _ordersRepo;
  late TrackingRepository _trackingRepo;

  void initialize({
    required CustomersRepository customersRepo,
    required VisitsRepository visitsRepo,
    required OrdersRepository ordersRepo,
    required TrackingRepository trackingRepo,
  }) {
    _customersRepo = customersRepo;
    _visitsRepo = visitsRepo;
    _ordersRepo = ordersRepo;
    _trackingRepo = trackingRepo;

    _startPeriodicSync();
  }

  Future<void> addToQueue(SyncItem item) async {
    try {
      final box = HiveBoxes.syncQueueBox;
      await box.put(item.id, item.toJson());

      // Try immediate sync if online
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity != ConnectivityResult.none && !_isSyncing) {
        unawaited(_processQueue());
      }
    } catch (e) {
      logger.e('Add to sync queue error: $e');
    }
  }

  Future<void> _processQueue() async {
    if (_isSyncing) return;

    try {
      _isSyncing = true;

      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity == ConnectivityResult.none) {
        logger.i('No internet connection, skipping sync');
        return;
      }

      final box = HiveBoxes.syncQueueBox;
      final keys = box.keys.toList();

      for (final key in keys) {
        final itemData = box.get(key);
        if (itemData == null) continue;

        try {
          final item = SyncItem.fromJson(Map<String, dynamic>.from(itemData));

          if (item.retryCount >= AppConstants.maxRetryAttempts) {
            logger.w('Max retry attempts reached for sync item ${item.id}');
            await box.delete(key);
            continue;
          }

          final success = await _syncItem(item);

          if (success) {
            await box.delete(key);
            logger.d('Synced item ${item.id} successfully');
          } else {
            // Increment retry count
            final updatedItem = SyncItem(
              id: item.id,
              type: item.type,
              data: item.data,
              createdAt: item.createdAt,
              retryCount: item.retryCount + 1,
            );
            await box.put(key, updatedItem.toJson());
          }
        } catch (e) {
          logger.e('Process sync item error: $e');
        }
      }
    } catch (e) {
      logger.e('Process sync queue error: $e');
    } finally {
      _isSyncing = false;
    }
  }

  Future<bool> _syncItem(SyncItem item) async {
    try {
      switch (item.type) {
        case SyncItemType.customer:
          // Handle customer sync
          break;
        case SyncItemType.visit:
          // Handle visit sync
          break;
        case SyncItemType.order:
          // Handle order sync
          break;
        case SyncItemType.tracking:
          await _trackingRepo.syncPendingLocations();
          break;
      }
      return true;
    } catch (e) {
      logger.e('Sync item ${item.id} error: $e');
      return false;
    }
  }

  void _startPeriodicSync() {
    _syncTimer?.cancel();
    _syncTimer = Timer.periodic(AppConstants.syncInterval, (_) {
      if (!_isSyncing) {
        unawaited(_processQueue());
      }
    });
  }

  Future<int> getPendingCount() async => HiveBoxes.syncQueueBox.length;

  void dispose() {
    _syncTimer?.cancel();
  }
}

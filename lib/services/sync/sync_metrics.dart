import '../../config/logger.dart';
import '../../data/models/customers/customer.dart';

/// Clase para monitorear métricas de sincronización
class SyncMetrics {
  static int totalCustomers = 0;
  static int customersWithCoords = 0;
  static int syncErrors = 0;
  static DateTime? lastSyncTime;
  static String? lastSyncError;

  /// Registrar resultado de sincronización
  static void recordSyncResult(List<Customer> customers) {
    totalCustomers = customers.length;
    customersWithCoords = customers
        .where(
            (c) => c.effectiveLatitude != null && c.effectiveLongitude != null)
        .length;
    lastSyncTime = DateTime.now();

    logger.i(
        '📊 Sync Metrics: $customersWithCoords/$totalCustomers customers with coordinates');

    if (customersWithCoords < totalCustomers) {
      final missingCoords = totalCustomers - customersWithCoords;
      logger.w('⚠️ $missingCoords customers missing coordinates');
    }
  }

  /// Registrar error de sincronización
  static void recordSyncError(String error) {
    syncErrors++;
    lastSyncError = error;
    logger.e('❌ Sync Error #$syncErrors: $error');
  }

  /// Obtener resumen de métricas
  static Map<String, dynamic> getSummary() {
    return {
      'totalCustomers': totalCustomers,
      'customersWithCoords': customersWithCoords,
      'coordinatePercentage': totalCustomers > 0
          ? (customersWithCoords / totalCustomers * 100).toStringAsFixed(1)
          : '0.0',
      'syncErrors': syncErrors,
      'lastSyncTime': lastSyncTime?.toIso8601String(),
      'lastSyncError': lastSyncError,
    };
  }

  /// Imprimir resumen completo
  static void printSummary() {
    final summary = getSummary();
    logger.i('=== SYNC METRICS SUMMARY ===');
    logger.i('Total customers: ${summary['totalCustomers']}');
    logger.i('Customers with coordinates: ${summary['customersWithCoords']}');
    logger.i('Coordinate percentage: ${summary['coordinatePercentage']}%');
    logger.i('Sync errors: ${summary['syncErrors']}');
    logger.i('Last sync: ${summary['lastSyncTime']}');
    if (summary['lastSyncError'] != null) {
      logger.i('Last error: ${summary['lastSyncError']}');
    }
    logger.i('=== END METRICS ===');
  }

  /// Resetear métricas
  static void reset() {
    totalCustomers = 0;
    customersWithCoords = 0;
    syncErrors = 0;
    lastSyncTime = null;
    lastSyncError = null;
    logger.i('🔄 Sync metrics reset');
  }
}

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'kpi.freezed.dart';
part 'kpi.g.dart';

@freezed
class KPI with _$KPI {
  const factory KPI({
    required String id,
    required String name,
    required String description,
    required KPIType type,
    required double value,
    required double target,
    String? unit,
    required DateTime period,
    String? userId,
    String? companyId,
    DateTime? createdAt,
    KPITrend? trend,
    double? previousValue,
    @Default([]) List<KPIDataPoint> dataPoints,
  }) = _KPI;

  factory KPI.fromJson(Map<String, dynamic> json) => _$KPIFromJson(json);
}

@freezed
class KPIDataPoint with _$KPIDataPoint {
  const factory KPIDataPoint({
    required DateTime date,
    required double value,
    String? label,
    Map<String, dynamic>? metadata,
  }) = _KPIDataPoint;

  factory KPIDataPoint.fromJson(Map<String, dynamic> json) =>
      _$KPIDataPointFromJson(json);
}

@freezed
class KPIDashboard with _$KPIDashboard {
  const factory KPIDashboard({
    required String userId,
    required DateTime period,
    required List<KPI> kpis,
    required KPISummary summary,
    @Default([]) List<KPIAlert> alerts,
    DateTime? lastUpdated,
  }) = _KPIDashboard;

  factory KPIDashboard.fromJson(Map<String, dynamic> json) =>
      _$KPIDashboardFromJson(json);
}

@freezed
class KPISummary with _$KPISummary {
  const factory KPISummary({
    required int totalKPIs,
    required int kpisOnTarget,
    required int kpisAboveTarget,
    required int kpisBelowTarget,
    required double overallPerformance,
    KPITrend? overallTrend,
  }) = _KPISummary;

  factory KPISummary.fromJson(Map<String, dynamic> json) =>
      _$KPISummaryFromJson(json);
}

@freezed
class KPIAlert with _$KPIAlert {
  const factory KPIAlert({
    required String kpiId,
    required String kpiName,
    required KPIAlertType type,
    required String message,
    required KPIAlertSeverity severity,
    DateTime? createdAt,
    bool? acknowledged,
  }) = _KPIAlert;

  factory KPIAlert.fromJson(Map<String, dynamic> json) =>
      _$KPIAlertFromJson(json);
}

enum KPIType {
  @JsonValue('VISITS_COUNT')
  visitsCount,
  @JsonValue('VISITS_COMPLETION_RATE')
  visitsCompletionRate,
  @JsonValue('AVERAGE_VISIT_DURATION')
  averageVisitDuration,
  @JsonValue('SALES_AMOUNT')
  salesAmount,
  @JsonValue('ORDERS_COUNT')
  ordersCount,
  @JsonValue('AVERAGE_ORDER_VALUE')
  averageOrderValue,
  @JsonValue('CUSTOMER_SATISFACTION')
  customerSatisfaction,
  @JsonValue('ROUTE_EFFICIENCY')
  routeEfficiency,
  @JsonValue('COLLECTION_RATE')
  collectionRate,
  @JsonValue('NEW_CUSTOMERS')
  newCustomers,
  @JsonValue('CUSTOMER_RETENTION')
  customerRetention,
  @JsonValue('DELIVERY_ON_TIME')
  deliveryOnTime,
  @JsonValue('INVENTORY_TURNOVER')
  inventoryTurnover,
  @JsonValue('PROFIT_MARGIN')
  profitMargin,
  @JsonValue('CONVERSION_RATE')
  conversionRate,
}

enum KPITrend {
  @JsonValue('UP')
  up,
  @JsonValue('DOWN')
  down,
  @JsonValue('STABLE')
  stable,
}

enum KPIAlertType {
  @JsonValue('TARGET_MISSED')
  targetMissed,
  @JsonValue('PERFORMANCE_DROP')
  performanceDrop,
  @JsonValue('UNUSUAL_ACTIVITY')
  unusualActivity,
  @JsonValue('THRESHOLD_EXCEEDED')
  thresholdExceeded,
}

enum KPIAlertSeverity {
  @JsonValue('LOW')
  low,
  @JsonValue('MEDIUM')
  medium,
  @JsonValue('HIGH')
  high,
  @JsonValue('CRITICAL')
  critical,
}

// Extensions for easier usage
extension KPIX on KPI {
  /// Calculate performance percentage against target
  double get performancePercentage {
    if (target == 0) return 0;
    return (value / target) * 100;
  }

  /// Check if KPI is on target (within 5% tolerance)
  bool get isOnTarget {
    const tolerance = 5.0; // 5% tolerance
    final performance = performancePercentage;
    return performance >= (100 - tolerance) && performance <= (100 + tolerance);
  }

  /// Check if KPI is above target
  bool get isAboveTarget => performancePercentage > 105;

  /// Check if KPI is below target
  bool get isBelowTarget => performancePercentage < 95;

  /// Get KPI status
  KPIStatus get status {
    if (isAboveTarget) return KPIStatus.aboveTarget;
    if (isBelowTarget) return KPIStatus.belowTarget;
    return KPIStatus.onTarget;
  }

  /// Calculate trend percentage
  double? get trendPercentage {
    if (previousValue == null || previousValue == 0) return null;
    return ((value - previousValue!) / previousValue!) * 100;
  }

  /// Get formatted value with unit
  String get formattedValue {
    switch (type) {
      case KPIType.salesAmount:
      case KPIType.averageOrderValue:
        return '\$${value.toStringAsFixed(2)}';
      case KPIType.visitsCompletionRate:
      case KPIType.collectionRate:
      case KPIType.customerRetention:
      case KPIType.deliveryOnTime:
      case KPIType.profitMargin:
      case KPIType.conversionRate:
        return '${value.toStringAsFixed(1)}%';
      case KPIType.averageVisitDuration:
        return '${value.toStringAsFixed(0)} min';
      default:
        return value.toStringAsFixed(0) + (unit ?? '');
    }
  }

  /// Get formatted target with unit
  String get formattedTarget {
    switch (type) {
      case KPIType.salesAmount:
      case KPIType.averageOrderValue:
        return '\$${target.toStringAsFixed(2)}';
      case KPIType.visitsCompletionRate:
      case KPIType.collectionRate:
      case KPIType.customerRetention:
      case KPIType.deliveryOnTime:
      case KPIType.profitMargin:
      case KPIType.conversionRate:
        return '${target.toStringAsFixed(1)}%';
      case KPIType.averageVisitDuration:
        return '${target.toStringAsFixed(0)} min';
      default:
        return target.toStringAsFixed(0) + (unit ?? '');
    }
  }
}

extension KPITypeX on KPIType {
  String get displayName {
    switch (this) {
      case KPIType.visitsCount:
        return 'Número de Visitas';
      case KPIType.visitsCompletionRate:
        return 'Tasa de Finalización de Visitas';
      case KPIType.averageVisitDuration:
        return 'Duración Promedio de Visita';
      case KPIType.salesAmount:
        return 'Monto de Ventas';
      case KPIType.ordersCount:
        return 'Número de Pedidos';
      case KPIType.averageOrderValue:
        return 'Valor Promedio de Pedido';
      case KPIType.customerSatisfaction:
        return 'Satisfacción del Cliente';
      case KPIType.routeEfficiency:
        return 'Eficiencia de Ruta';
      case KPIType.collectionRate:
        return 'Tasa de Cobranza';
      case KPIType.newCustomers:
        return 'Nuevos Clientes';
      case KPIType.customerRetention:
        return 'Retención de Clientes';
      case KPIType.deliveryOnTime:
        return 'Entregas a Tiempo';
      case KPIType.inventoryTurnover:
        return 'Rotación de Inventario';
      case KPIType.profitMargin:
        return 'Margen de Ganancia';
      case KPIType.conversionRate:
        return 'Tasa de Conversión';
    }
  }

  String get description {
    switch (this) {
      case KPIType.visitsCount:
        return 'Total de visitas realizadas';
      case KPIType.visitsCompletionRate:
        return 'Porcentaje de visitas completadas';
      case KPIType.averageVisitDuration:
        return 'Tiempo promedio por visita';
      case KPIType.salesAmount:
        return 'Monto total de ventas';
      case KPIType.ordersCount:
        return 'Cantidad de pedidos generados';
      case KPIType.averageOrderValue:
        return 'Valor promedio por pedido';
      case KPIType.customerSatisfaction:
        return 'Calificación promedio de satisfacción';
      case KPIType.routeEfficiency:
        return 'Eficiencia en recorrido de rutas';
      case KPIType.collectionRate:
        return 'Porcentaje de cobranza exitosa';
      case KPIType.newCustomers:
        return 'Cantidad de clientes nuevos';
      case KPIType.customerRetention:
        return 'Porcentaje de retención de clientes';
      case KPIType.deliveryOnTime:
        return 'Porcentaje de entregas puntuales';
      case KPIType.inventoryTurnover:
        return 'Rotación de inventario';
      case KPIType.profitMargin:
        return 'Margen de ganancia porcentual';
      case KPIType.conversionRate:
        return 'Tasa de conversión de visitas a ventas';
    }
  }

  IconData get icon {
    switch (this) {
      case KPIType.visitsCount:
        return Icons.location_on;
      case KPIType.visitsCompletionRate:
        return Icons.check_circle;
      case KPIType.averageVisitDuration:
        return Icons.timer;
      case KPIType.salesAmount:
        return Icons.attach_money;
      case KPIType.ordersCount:
        return Icons.shopping_cart;
      case KPIType.averageOrderValue:
        return Icons.receipt_long;
      case KPIType.customerSatisfaction:
        return Icons.sentiment_satisfied;
      case KPIType.routeEfficiency:
        return Icons.route;
      case KPIType.collectionRate:
        return Icons.payment;
      case KPIType.newCustomers:
        return Icons.person_add;
      case KPIType.customerRetention:
        return Icons.favorite;
      case KPIType.deliveryOnTime:
        return Icons.local_shipping;
      case KPIType.inventoryTurnover:
        return Icons.inventory;
      case KPIType.profitMargin:
        return Icons.trending_up;
      case KPIType.conversionRate:
        return Icons.transform;
    }
  }

  Color get color {
    switch (this) {
      case KPIType.visitsCount:
      case KPIType.visitsCompletionRate:
        return Colors.blue;
      case KPIType.salesAmount:
      case KPIType.averageOrderValue:
      case KPIType.profitMargin:
        return Colors.green;
      case KPIType.ordersCount:
      case KPIType.conversionRate:
        return Colors.orange;
      case KPIType.customerSatisfaction:
      case KPIType.customerRetention:
        return Colors.purple;
      case KPIType.deliveryOnTime:
      case KPIType.routeEfficiency:
        return Colors.teal;
      case KPIType.collectionRate:
        return Colors.indigo;
      case KPIType.newCustomers:
        return Colors.cyan;
      default:
        return Colors.grey;
    }
  }
}

extension KPITrendX on KPITrend {
  String get displayName {
    switch (this) {
      case KPITrend.up:
        return 'Al Alza';
      case KPITrend.down:
        return 'A la Baja';
      case KPITrend.stable:
        return 'Estable';
    }
  }

  IconData get icon {
    switch (this) {
      case KPITrend.up:
        return Icons.trending_up;
      case KPITrend.down:
        return Icons.trending_down;
      case KPITrend.stable:
        return Icons.trending_flat;
    }
  }

  Color get color {
    switch (this) {
      case KPITrend.up:
        return Colors.green;
      case KPITrend.down:
        return Colors.red;
      case KPITrend.stable:
        return Colors.orange;
    }
  }
}

extension KPIAlertSeverityX on KPIAlertSeverity {
  String get displayName {
    switch (this) {
      case KPIAlertSeverity.low:
        return 'Baja';
      case KPIAlertSeverity.medium:
        return 'Media';
      case KPIAlertSeverity.high:
        return 'Alta';
      case KPIAlertSeverity.critical:
        return 'Crítica';
    }
  }

  Color get color {
    switch (this) {
      case KPIAlertSeverity.low:
        return Colors.yellow;
      case KPIAlertSeverity.medium:
        return Colors.orange;
      case KPIAlertSeverity.high:
        return Colors.red;
      case KPIAlertSeverity.critical:
        return Colors.purple;
    }
  }

  IconData get icon {
    switch (this) {
      case KPIAlertSeverity.low:
        return Icons.info;
      case KPIAlertSeverity.medium:
        return Icons.warning;
      case KPIAlertSeverity.high:
        return Icons.error;
      case KPIAlertSeverity.critical:
        return Icons.crisis_alert;
    }
  }
}

enum KPIStatus { onTarget, aboveTarget, belowTarget }

extension KPIStatusX on KPIStatus {
  String get displayName {
    switch (this) {
      case KPIStatus.onTarget:
        return 'En Meta';
      case KPIStatus.aboveTarget:
        return 'Sobre Meta';
      case KPIStatus.belowTarget:
        return 'Bajo Meta';
    }
  }

  Color get color {
    switch (this) {
      case KPIStatus.onTarget:
        return Colors.green;
      case KPIStatus.aboveTarget:
        return Colors.blue;
      case KPIStatus.belowTarget:
        return Colors.red;
    }
  }

  IconData get icon {
    switch (this) {
      case KPIStatus.onTarget:
        return Icons.check_circle;
      case KPIStatus.aboveTarget:
        return Icons.trending_up;
      case KPIStatus.belowTarget:
        return Icons.trending_down;
    }
  }
}

// KPI Calculator utilities
class KPICalculator {
  /// Calculate visits completion rate
  static double calculateVisitsCompletionRate({
    required int completedVisits,
    required int totalVisits,
  }) {
    if (totalVisits == 0) return 0;
    return (completedVisits / totalVisits) * 100;
  }

  /// Calculate average order value
  static double calculateAverageOrderValue({
    required double totalSales,
    required int totalOrders,
  }) {
    if (totalOrders == 0) return 0;
    return totalSales / totalOrders;
  }

  /// Calculate conversion rate
  static double calculateConversionRate({
    required int orders,
    required int visits,
  }) {
    if (visits == 0) return 0;
    return (orders / visits) * 100;
  }

  /// Calculate route efficiency
  static double calculateRouteEfficiency({
    required double plannedDistance,
    required double actualDistance,
    required double plannedTime,
    required double actualTime,
  }) {
    if (actualDistance == 0 || actualTime == 0) return 0;

    final distanceEfficiency = plannedDistance / actualDistance;
    final timeEfficiency = plannedTime / actualTime;

    return ((distanceEfficiency + timeEfficiency) / 2) * 100;
  }

  /// Calculate collection rate
  static double calculateCollectionRate({
    required double collectedAmount,
    required double totalDue,
  }) {
    if (totalDue == 0) return 0;
    return (collectedAmount / totalDue) * 100;
  }

  /// Calculate customer retention rate
  static double calculateCustomerRetentionRate({
    required int customersAtStart,
    required int customersAtEnd,
    required int newCustomers,
  }) {
    if (customersAtStart == 0) return 0;
    final retainedCustomers = customersAtEnd - newCustomers;
    return (retainedCustomers / customersAtStart) * 100;
  }

  /// Calculate trend based on current and previous values
  static KPITrend calculateTrend({
    required double currentValue,
    required double previousValue,
    double threshold = 5.0, // 5% threshold for trend detection
  }) {
    if (previousValue == 0) return KPITrend.stable;

    final changePercentage =
        ((currentValue - previousValue) / previousValue) * 100;

    if (changePercentage > threshold) {
      return KPITrend.up;
    } else if (changePercentage < -threshold) {
      return KPITrend.down;
    } else {
      return KPITrend.stable;
    }
  }
}

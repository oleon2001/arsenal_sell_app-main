// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kpi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KPIImpl _$$KPIImplFromJson(Map<String, dynamic> json) => _$KPIImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$KPITypeEnumMap, json['type']),
      value: (json['value'] as num).toDouble(),
      target: (json['target'] as num).toDouble(),
      unit: json['unit'] as String?,
      period: DateTime.parse(json['period'] as String),
      userId: json['userId'] as String?,
      companyId: json['companyId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      trend: $enumDecodeNullable(_$KPITrendEnumMap, json['trend']),
      previousValue: (json['previousValue'] as num?)?.toDouble(),
      dataPoints: (json['dataPoints'] as List<dynamic>?)
              ?.map((e) => KPIDataPoint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$KPIImplToJson(_$KPIImpl instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': _$KPITypeEnumMap[instance.type]!,
      'value': instance.value,
      'target': instance.target,
      'unit': instance.unit,
      'period': instance.period.toIso8601String(),
      'userId': instance.userId,
      'companyId': instance.companyId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'trend': _$KPITrendEnumMap[instance.trend],
      'previousValue': instance.previousValue,
      'dataPoints': instance.dataPoints,
    };

const _$KPITypeEnumMap = {
  KPIType.visitsCount: 'VISITS_COUNT',
  KPIType.visitsCompletionRate: 'VISITS_COMPLETION_RATE',
  KPIType.averageVisitDuration: 'AVERAGE_VISIT_DURATION',
  KPIType.salesAmount: 'SALES_AMOUNT',
  KPIType.ordersCount: 'ORDERS_COUNT',
  KPIType.averageOrderValue: 'AVERAGE_ORDER_VALUE',
  KPIType.customerSatisfaction: 'CUSTOMER_SATISFACTION',
  KPIType.routeEfficiency: 'ROUTE_EFFICIENCY',
  KPIType.collectionRate: 'COLLECTION_RATE',
  KPIType.newCustomers: 'NEW_CUSTOMERS',
  KPIType.customerRetention: 'CUSTOMER_RETENTION',
  KPIType.deliveryOnTime: 'DELIVERY_ON_TIME',
  KPIType.inventoryTurnover: 'INVENTORY_TURNOVER',
  KPIType.profitMargin: 'PROFIT_MARGIN',
  KPIType.conversionRate: 'CONVERSION_RATE',
};

const _$KPITrendEnumMap = {
  KPITrend.up: 'UP',
  KPITrend.down: 'DOWN',
  KPITrend.stable: 'STABLE',
};

_$KPIDataPointImpl _$$KPIDataPointImplFromJson(Map<String, dynamic> json) =>
    _$KPIDataPointImpl(
      date: DateTime.parse(json['date'] as String),
      value: (json['value'] as num).toDouble(),
      label: json['label'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$KPIDataPointImplToJson(_$KPIDataPointImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'value': instance.value,
      'label': instance.label,
      'metadata': instance.metadata,
    };

_$KPIDashboardImpl _$$KPIDashboardImplFromJson(Map<String, dynamic> json) =>
    _$KPIDashboardImpl(
      userId: json['userId'] as String,
      period: DateTime.parse(json['period'] as String),
      kpis: (json['kpis'] as List<dynamic>)
          .map((e) => KPI.fromJson(e as Map<String, dynamic>))
          .toList(),
      summary: KPISummary.fromJson(json['summary'] as Map<String, dynamic>),
      alerts: (json['alerts'] as List<dynamic>?)
              ?.map((e) => KPIAlert.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$KPIDashboardImplToJson(_$KPIDashboardImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'period': instance.period.toIso8601String(),
      'kpis': instance.kpis,
      'summary': instance.summary,
      'alerts': instance.alerts,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
    };

_$KPISummaryImpl _$$KPISummaryImplFromJson(Map<String, dynamic> json) =>
    _$KPISummaryImpl(
      totalKPIs: (json['totalKPIs'] as num).toInt(),
      kpisOnTarget: (json['kpisOnTarget'] as num).toInt(),
      kpisAboveTarget: (json['kpisAboveTarget'] as num).toInt(),
      kpisBelowTarget: (json['kpisBelowTarget'] as num).toInt(),
      overallPerformance: (json['overallPerformance'] as num).toDouble(),
      overallTrend:
          $enumDecodeNullable(_$KPITrendEnumMap, json['overallTrend']),
    );

Map<String, dynamic> _$$KPISummaryImplToJson(_$KPISummaryImpl instance) =>
    <String, dynamic>{
      'totalKPIs': instance.totalKPIs,
      'kpisOnTarget': instance.kpisOnTarget,
      'kpisAboveTarget': instance.kpisAboveTarget,
      'kpisBelowTarget': instance.kpisBelowTarget,
      'overallPerformance': instance.overallPerformance,
      'overallTrend': _$KPITrendEnumMap[instance.overallTrend],
    };

_$KPIAlertImpl _$$KPIAlertImplFromJson(Map<String, dynamic> json) =>
    _$KPIAlertImpl(
      kpiId: json['kpiId'] as String,
      kpiName: json['kpiName'] as String,
      type: $enumDecode(_$KPIAlertTypeEnumMap, json['type']),
      message: json['message'] as String,
      severity: $enumDecode(_$KPIAlertSeverityEnumMap, json['severity']),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      acknowledged: json['acknowledged'] as bool?,
    );

Map<String, dynamic> _$$KPIAlertImplToJson(_$KPIAlertImpl instance) =>
    <String, dynamic>{
      'kpiId': instance.kpiId,
      'kpiName': instance.kpiName,
      'type': _$KPIAlertTypeEnumMap[instance.type]!,
      'message': instance.message,
      'severity': _$KPIAlertSeverityEnumMap[instance.severity]!,
      'createdAt': instance.createdAt?.toIso8601String(),
      'acknowledged': instance.acknowledged,
    };

const _$KPIAlertTypeEnumMap = {
  KPIAlertType.targetMissed: 'TARGET_MISSED',
  KPIAlertType.performanceDrop: 'PERFORMANCE_DROP',
  KPIAlertType.unusualActivity: 'UNUSUAL_ACTIVITY',
  KPIAlertType.thresholdExceeded: 'THRESHOLD_EXCEEDED',
};

const _$KPIAlertSeverityEnumMap = {
  KPIAlertSeverity.low: 'LOW',
  KPIAlertSeverity.medium: 'MEDIUM',
  KPIAlertSeverity.high: 'HIGH',
  KPIAlertSeverity.critical: 'CRITICAL',
};

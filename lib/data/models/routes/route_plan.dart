import 'package:freezed_annotation/freezed_annotation.dart';
import '../customers/customer.dart';

part 'route_plan.freezed.dart';
part 'route_plan.g.dart';

@freezed
class RoutePlan with _$RoutePlan {
  const factory RoutePlan({
    required String id,
    required String companyId,
    required String name,
    required DateTime date,
    String? ownerId,
    DateTime? createdAt,
    @Default([]) List<RouteStop> stops,
  }) = _RoutePlan;

  factory RoutePlan.fromJson(Map<String, dynamic> json) =>
      _$RoutePlanFromJson(json);
}

@freezed
class RouteStop with _$RouteStop {
  const factory RouteStop({
    required String id,
    required String routeId,
    required String customerId,
    DateTime? plannedTime,
    int? sequence,
    String? notes,
    Customer? customer,
  }) = _RouteStop;

  factory RouteStop.fromJson(Map<String, dynamic> json) =>
      _$RouteStopFromJson(json);
}

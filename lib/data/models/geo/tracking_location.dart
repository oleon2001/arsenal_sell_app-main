import 'package:freezed_annotation/freezed_annotation.dart';

part 'tracking_location.freezed.dart';
part 'tracking_location.g.dart';

@freezed
class TrackingLocation with _$TrackingLocation {
  const factory TrackingLocation({
    required int id,
    required String companyId,
    required String userId,
    required DateTime at,
    required Map<String, dynamic> point, // geography(Point,4326)
    double? speedMS,
    double? accuracyM,
  }) = _TrackingLocation;

  factory TrackingLocation.fromJson(Map<String, dynamic> json) =>
      _$TrackingLocationFromJson(json);
}

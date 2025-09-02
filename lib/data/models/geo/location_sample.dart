import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_sample.freezed.dart';
part 'location_sample.g.dart';

@freezed
class LocationSample with _$LocationSample {
  const factory LocationSample({
    required int id,
    required String companyId,
    required String userId,
    required DateTime at,
    required double latitude,
    required double longitude,
    double? speedMs,
    double? accuracyM,
  }) = _LocationSample;

  factory LocationSample.fromJson(Map<String, dynamic> json) =>
      _$LocationSampleFromJson(json);
}

part of 'visits_cubit.dart';

@freezed
class VisitsState with _$VisitsState {
  const factory VisitsState.initial() = _Initial;
  const factory VisitsState.loading() = _Loading;
  const factory VisitsState.activeVisit(Visit visit) = VisitsActiveVisit;
  const factory VisitsState.completed(Visit visit) = _Completed;
  const factory VisitsState.history(List<Visit> visits) = _History;
  const factory VisitsState.error(String message) = _Error;
}

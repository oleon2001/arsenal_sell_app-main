part of 'order_cubit.dart';

@freezed
class OrderState with _$OrderState {
  const factory OrderState.initial() = _Initial;
  const factory OrderState.loading() = _Loading;
  const factory OrderState.editing(Order order) = OrderEditing;
  const factory OrderState.saving() = _Saving;
  const factory OrderState.saved(Order order) = _Saved;
  const factory OrderState.error(String message) = _Error;
}

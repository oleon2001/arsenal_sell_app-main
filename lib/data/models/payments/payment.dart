import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment.freezed.dart';
part 'payment.g.dart';

@freezed
class Payment with _$Payment {
  const factory Payment({
    required String id,
    @JsonKey(name: 'order_id') required String orderId,
    @JsonKey(name: 'customer_id') required String customerId,
    required double amount,
    @JsonKey(name: 'payment_method') required PaymentMethod paymentMethod,
    @JsonKey(name: 'payment_status')
    @Default(PaymentStatus.pending)
    PaymentStatus status,
    String? reference,
    String? notes,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Payment;

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
}

@freezed
class PaymentMethod with _$PaymentMethod {
  const factory PaymentMethod({
    required String id,
    required String name,
    @Default(true) bool active,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _PaymentMethod;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);
}

enum PaymentStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('completed')
  completed,
  @JsonValue('failed')
  failed,
  @JsonValue('cancelled')
  cancelled,
}

// Extension para funcionalidades adicionales
extension PaymentX on Payment {
  /// Verificar si el pago está completado
  bool get isCompleted => status == PaymentStatus.completed;

  /// Verificar si el pago está pendiente
  bool get isPending => status == PaymentStatus.pending;

  /// Verificar si el pago falló
  bool get isFailed => status == PaymentStatus.failed;

  /// Obtener monto formateado
  String get formattedAmount => '\$${amount.toStringAsFixed(2)}';

  /// Obtener estado formateado
  String get formattedStatus {
    switch (status) {
      case PaymentStatus.pending:
        return 'Pendiente';
      case PaymentStatus.completed:
        return 'Completado';
      case PaymentStatus.failed:
        return 'Fallido';
      case PaymentStatus.cancelled:
        return 'Cancelado';
    }
  }

  /// Obtener color del estado
  int get statusColor {
    switch (status) {
      case PaymentStatus.pending:
        return 0xFFFF9800; // Orange
      case PaymentStatus.completed:
        return 0xFF4CAF50; // Green
      case PaymentStatus.failed:
        return 0xFFF44336; // Red
      case PaymentStatus.cancelled:
        return 0xFF9E9E9E; // Grey
    }
  }
}

extension PaymentMethodX on PaymentMethod {
  /// Verificar si el método está activo
  bool get isActive => active;

  /// Obtener nombre formateado
  String get displayName => name;
}

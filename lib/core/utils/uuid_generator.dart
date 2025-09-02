import 'dart:math';

class UuidGenerator {
  static const String _chars = '0123456789abcdef';
  static final Random _random = Random.secure();

  /// Genera un UUID v4 válido
  static String generateV4() {
    return '${_generateHex(8)}-${_generateHex(4)}-4${_generateHex(3)}-${_generateHex(4)}-${_generateHex(12)}';
  }

  /// Genera un UUID basado en timestamp (para compatibilidad con datos existentes)
  static String generateFromTimestamp(int timestamp) {
    final hexTimestamp = timestamp.toRadixString(16).padLeft(12, '0');
    return '00000000-0000-0000-0000-$hexTimestamp';
  }

  /// Genera un UUID basado en DateTime.now().millisecondsSinceEpoch
  static String generateFromNow() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return generateFromTimestamp(timestamp);
  }

  /// Genera una cadena hexadecimal aleatoria de la longitud especificada
  static String _generateHex(int length) {
    return String.fromCharCodes(
      Iterable.generate(
          length, (_) => _chars.codeUnitAt(_random.nextInt(_chars.length))),
    );
  }

  /// Valida si una cadena es un UUID válido
  static bool isValidUuid(String uuid) {
    final uuidRegex = RegExp(
      r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
      caseSensitive: false,
    );
    return uuidRegex.hasMatch(uuid);
  }

  /// Convierte un timestamp a UUID válido
  static String timestampToUuid(int timestamp) {
    final hexTimestamp = timestamp.toRadixString(16).padLeft(12, '0');
    return '00000000-0000-0000-0000-$hexTimestamp';
  }
}

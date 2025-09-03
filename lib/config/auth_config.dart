/// Configuración de autenticación para diferentes entornos
class AuthConfig {
  /// Si es true, no se requiere confirmación de email para desarrollo
  static const bool skipEmailConfirmation = true;

  /// Tiempo de espera entre intentos de registro (en segundos)
  static const int registrationCooldownSeconds = 60;

  /// Si es true, se crea una compañía por defecto para nuevos usuarios
  static const bool createDefaultCompany = true;

  /// Nombre de la compañía por defecto
  static const String defaultCompanySuffix = ' - Empresa';

  /// Roles permitidos para registro
  static const List<String> allowedRoles = [
    'VENDEDOR',
    'REPARTIDOR',
  ];

  /// Validaciones de contraseña
  static const int minPasswordLength = 6;
  static const bool requireSpecialChars = false;
  static const bool requireNumbers = false;
  static const bool requireUppercase = false;

  /// Configuración de sesión
  static const bool autoSignInAfterSignUp = true;
  static const bool rememberUserSession = true;
}

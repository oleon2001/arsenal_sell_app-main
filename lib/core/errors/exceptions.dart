class AppException implements Exception {
  const AppException(this.message, {this.code, this.details});
  final String message;
  final String? code;
  final dynamic details;

  @override
  String toString() =>
      'AppException: $message${code != null ? ' (Code: $code)' : ''}';
}

class NetworkException extends AppException {
  const NetworkException(super.message, {super.code, super.details});
}

class ServerException extends AppException {
  const ServerException(super.message, {super.code, super.details});
}

class CacheException extends AppException {
  const CacheException(super.message, {super.code, super.details});
}

class AuthException extends AppException {
  const AuthException(super.message, {super.code, super.details});
}

class LocationException extends AppException {
  const LocationException(super.message, {super.code, super.details});
}

class GeofenceException extends AppException {
  const GeofenceException(super.message, {super.code, super.details});
}

class ValidationException extends AppException {
  const ValidationException(super.message, {super.code, super.details});
}

class SyncException extends AppException {
  const SyncException(super.message, {super.code, super.details});
}

class StorageException extends AppException {
  const StorageException(super.message, {super.code, super.details});
}

abstract class Failure {
  const Failure(this.message, {this.code});
  final String message;
  final String? code;

  @override
  String toString() =>
      'Failure: $message${code != null ? ' (Code: $code)' : ''}';
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message, {super.code});
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.code});
}

class CacheFailure extends Failure {
  const CacheFailure(super.message, {super.code});
}

class AuthFailure extends Failure {
  const AuthFailure(super.message, {super.code});
}

class LocationFailure extends Failure {
  const LocationFailure(super.message, {super.code});
}

class GeofenceFailure extends Failure {
  const GeofenceFailure(super.message, {super.code});
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {super.code});
}

class SyncFailure extends Failure {
  const SyncFailure(super.message, {super.code});
}

class StorageFailure extends Failure {
  const StorageFailure(super.message, {super.code});
}

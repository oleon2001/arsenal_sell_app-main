import '../../../config/logger.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../entities.dart';

class SignInParams {
  const SignInParams({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
}

class SignInResult {
  const SignInResult({
    required this.user,
    this.isFirstLogin = false,
  });
  final UserProfile user;
  final bool isFirstLogin;
}

class SignInUseCase implements UseCase<SignInResult, SignInParams> {
  const SignInUseCase(this._repository);
  final AuthRepository _repository;

  @override
  Future<SignInResult> call(SignInParams params) async {
    try {
      // Validate email format
      if (!_isValidEmail(params.email)) {
        throw const ValidationException('Invalid email format');
      }

      // Validate password
      if (params.password.length < 6) {
        throw const ValidationException(
            'Password must be at least 6 characters');
      }

      // Attempt sign in
      final user = await _repository.signIn(params.email, params.password);

      if (user == null) {
        throw const AuthorizationException('Invalid credentials');
      }

      // Check if user is active
      if (!user.isActive) {
        throw const AuthorizationException('User account is deactivated');
      }

      // Determine if this is first login (could be based on last login date)
      final isFirstLogin = user.createdAt != null &&
          DateTime.now().difference(user.createdAt!).inMinutes < 5;

      logger.i('User signed in successfully: ${user.email}');

      return SignInResult(
        user: user,
        isFirstLogin: isFirstLogin,
      );
    } catch (e) {
      logger.e('Sign in failed: $e');

      if (e is DomainException) {
        rethrow;
      }

      throw DomainException('Sign in failed: ${e.toString()}');
    }
  }

  bool _isValidEmail(String email) =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
}

class SignInWithBiometricsUseCase implements UseCase<SignInResult, NoParams> {
  const SignInWithBiometricsUseCase(this._repository);
  final AuthRepository _repository;

  @override
  Future<SignInResult> call(NoParams params) async {
    try {
      // TODO: Implement biometric methods in AuthRepository
      throw const DomainException(
          'Biometric authentication not yet implemented');

      // Get current user (should be stored locally)
      final user = await _repository.getCurrentUser();
      if (user == null) {
        throw const AuthorizationException(
            'No user found for biometric authentication');
      }

      logger.i('User signed in with biometrics: ${user.email}');

      return SignInResult(user: user);
    } catch (e) {
      logger.e('Biometric sign in failed: $e');

      if (e is DomainException) {
        rethrow;
      }

      throw DomainException('Biometric sign in failed: ${e.toString()}');
    }
  }
}

class NoParams {
  const NoParams();
}

// Extension methods for additional validation
extension SignInValidation on SignInParams {
  bool get isValid => _isValidEmail() && _isValidPassword();

  bool _isValidEmail() =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);

  bool _isValidPassword() => password.isNotEmpty && password.length >= 6;

  List<String> get validationErrors {
    final errors = <String>[];

    if (!_isValidEmail()) {
      errors.add('Invalid email format');
    }

    if (!_isValidPassword()) {
      errors.add('Password must be at least 6 characters');
    }

    return errors;
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/auth/user_profile.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../config/logger.dart';

// Commented out until generated files are available
// part 'auth_state.dart';
// part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(const AuthState.initial());
  final AuthRepository _authRepository;

  Future<void> checkAuthStatus() async {
    emit(const AuthState.loading());

    try {
      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        emit(AuthState.authenticated(user));
      } else {
        emit(const AuthState.unauthenticated());
      }
    } catch (e) {
      logger.e('Check auth status error: $e');
      emit(AuthState.error(e.toString()));
    }
  }

  Future<void> signIn(String email, String password) async {
    emit(const AuthState.loading());

    try {
      final user = await _authRepository.signIn(email, password);
      if (user != null) {
        emit(AuthState.authenticated(user));
        logger.i('User signed in successfully: ${user.email}');
      } else {
        emit(const AuthState.error('Credenciales inválidas'));
      }
    } catch (e) {
      logger.e('Sign in error: $e');
      emit(AuthState.error(e.toString()));
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    String? phone,
    String? companyId,
    UserRole role = UserRole.vendedor,
  }) async {
    emit(const AuthState.loading());

    try {
      final user = await _authRepository.signUp(
        email: email,
        password: password,
        fullName: fullName,
        phone: phone,
        companyId: companyId,
        role: role,
      );

      if (user != null) {
        emit(AuthState.authenticated(user));
        logger.i('User registered successfully: ${user.email}');
      } else {
        emit(const AuthState.error('Error al registrar usuario'));
      }
    } catch (e) {
      logger.e('Sign up error: $e');
      emit(AuthState.error(e.toString()));
    }
  }

  Future<void> resetPassword(String email) async {
    emit(const AuthState.loading());

    try {
      await _authRepository.resetPassword(email);
      emit(const AuthState.passwordResetSent());
    } catch (e) {
      logger.e('Reset password error: $e');
      emit(AuthState.error(e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      await _authRepository.signOut();
      emit(const AuthState.unauthenticated());
    } catch (e) {
      logger.e('Sign out error: $e');
      emit(AuthState.error(e.toString()));
    }
  }
}

// Converted from @freezed to regular class
abstract class AuthState {
  const AuthState();

  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(UserProfile user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error(String message) = _Error;
  const factory AuthState.passwordResetSent() = _PasswordResetSent;
}

class _Initial extends AuthState {
  const _Initial();
}

class _Loading extends AuthState {
  const _Loading();
}

class _Authenticated extends AuthState {
  const _Authenticated(this.user);
  final UserProfile user;
}

// Export the authenticated state for type checking
typedef Authenticated = _Authenticated;

class _Unauthenticated extends AuthState {
  const _Unauthenticated();
}

class _Error extends AuthState {
  const _Error(this.message);
  final String message;
}

class _PasswordResetSent extends AuthState {
  const _PasswordResetSent();
}

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../config/logger.dart';
import '../local/preferences.dart';
import '../models/auth/user_profile.dart';

class AuthRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<UserProfile?> signIn(String email, String password) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        final profile = await _fetchUserProfile(response.user!.id);
        if (profile != null) {
          await AppPreferences.setUserId(profile.id);
          await AppPreferences.setUserRole(profile.role.name);
        }
        return profile;
      }
      return null;
    } catch (e) {
      logger.e('Sign in error: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
      await AppPreferences.clear();
    } catch (e) {
      logger.e('Sign out error: $e');
      rethrow;
    }
  }

  Future<UserProfile?> getCurrentUser() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user != null) {
        return await _fetchUserProfile(user.id);
      }
      return null;
    } catch (e) {
      logger.e('Get current user error: $e');
      return null;
    }
  }

  Future<UserProfile?> _fetchUserProfile(String userId) async {
    try {
      // Usar la vista 'me' que ya incluye el email desde auth.users
      final response =
          await _supabase.from('me').select().eq('id', userId).maybeSingle();

      if (response != null) {
        return UserProfile.fromJson(response);
      }
      return null;
    } catch (e) {
      logger.e('Fetch user profile error: $e');
      return null;
    }
  }

  Future<UserProfile?> signUp({
    required String email,
    required String password,
    required String fullName,
    String? phone,
    String? companyId,
    UserRole role = UserRole.vendedor,
  }) async {
    try {
      // Create user in Supabase Auth
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        emailRedirectTo: null, // No redirección de email
      );

      if (response.user != null) {
        // Si no se proporciona companyId, crear una compañía por defecto
        String? finalCompanyId = companyId;
        if (finalCompanyId == null) {
          finalCompanyId = await _createDefaultCompany(fullName);
        }

        // Create profile in profiles table
        final profile = UserProfile(
          id: response.user!.id,
          email: email,
          fullName: fullName,
          phone: phone,
          companyId: finalCompanyId,
          role: role,
          isActive: true,
          createdAt: DateTime.now(),
        );

        await _createUserProfile(profile);

        // Para desarrollo: confirmar email automáticamente
        if (response.session == null) {
          // Si no hay sesión, el usuario necesita confirmar email
          logger.i('User created successfully. Email confirmation required.');
          // Retornar perfil pero indicar que necesita confirmación
          return profile;
        }

        // Set local preferences
        await AppPreferences.setUserId(profile.id);
        await AppPreferences.setUserRole(profile.role.name);

        return profile;
      }
      return null;
    } catch (e) {
      logger.e('Sign up error: $e');
      rethrow;
    }
  }

  Future<void> _createUserProfile(UserProfile profile) async {
    try {
      await _supabase.from('profiles').insert({
        'id': profile.id,
        'company_id': profile.companyId,
        'full_name': profile.fullName,
        'phone': profile.phone,
        'role': profile.role.name.toUpperCase(),
        'is_active': profile.isActive,
        'created_at': profile.createdAt?.toIso8601String(),
      });
    } catch (e) {
      logger.e('Create user profile error: $e');
      rethrow;
    }
  }

  Future<String?> _createDefaultCompany(String companyName) async {
    try {
      final response = await _supabase
          .from('companies')
          .insert({
            'name': '$companyName - Empresa',
            'created_at': DateTime.now().toIso8601String(),
          })
          .select('id')
          .single();

      return response['id'] as String;
    } catch (e) {
      logger.e('Create default company error: $e');
      return null;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
      logger.i('Password reset email sent to: $email');
    } catch (e) {
      logger.e('Reset password error: $e');
      rethrow;
    }
  }

  /// Para desarrollo: confirmar email manualmente
  Future<void> confirmEmail(String email, String token) async {
    try {
      await _supabase.auth.verifyOTP(
        type: OtpType.signup,
        email: email,
        token: token,
      );
      logger.i('Email confirmed successfully for: $email');
    } catch (e) {
      logger.e('Email confirmation error: $e');
      rethrow;
    }
  }

  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;
}

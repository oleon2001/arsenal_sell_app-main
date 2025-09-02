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
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (response != null) {
        return UserProfile.fromJson({
          ...response,
          'email': _supabase.auth.currentUser?.email,
        });
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
      );

      if (response.user != null) {
        // Create profile in profiles table
        final profile = UserProfile(
          id: response.user!.id,
          email: email,
          fullName: fullName,
          phone: phone,
          companyId: companyId,
          role: role,
          isActive: true,
          createdAt: DateTime.now(),
        );

        await _createUserProfile(profile);

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
        'email': profile.email,
        'role': profile.role.name,
        'is_active': profile.isActive,
        'created_at': profile.createdAt?.toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      logger.e('Create user profile error: $e');
      rethrow;
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

  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;
}

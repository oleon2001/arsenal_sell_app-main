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
      logger.i('🔍 Intentando obtener perfil de usuario: $userId');

      // Intentar primero con la vista 'me'
      try {
        final response =
            await _supabase.from('me').select().eq('id', userId).maybeSingle();

        if (response != null) {
          logger.i('✅ Perfil obtenido desde vista "me"');
          return UserProfile.fromJson(response);
        }
      } catch (e) {
        logger.w('⚠️ Error con vista "me": $e');
        logger.i('🔄 Intentando método alternativo...');
      }

      // Método alternativo: consultar directamente profiles + auth.users
      final profileResponse = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (profileResponse != null) {
        // Obtener email desde auth.users
        final user = _supabase.auth.currentUser;
        if (user != null && user.email != null) {
          final profileData = Map<String, dynamic>.from(profileResponse);
          profileData['email'] = user.email;

          logger.i('✅ Perfil obtenido con método alternativo');
          return UserProfile.fromJson(profileData);
        }
      }

      logger.w('⚠️ No se pudo obtener perfil para usuario: $userId');
      return null;
    } catch (e) {
      logger.e('❌ Fetch user profile error: $e');
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
        // Si no se proporciona companyId, crear una compañía por defecto
        String? finalCompanyId = companyId;
        finalCompanyId ??= await _createDefaultCompany(fullName);

        // Create profile in profiles table
        final profile = UserProfile(
          id: response.user!.id,
          email: email,
          fullName: fullName,
          phone: phone,
          companyId: finalCompanyId,
          role: role,
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

  Future<List<UserProfile>> getAllUsers() async {
    try {
      logger.i('🔍 Obteniendo todos los usuarios...');
      
      final response = await _supabase
          .from('profiles')
          .select('''
            *,
            companies!inner(name)
          ''')
          .order('created_at', ascending: false);

      final users = <UserProfile>[];
      
      for (final userData in response) {
        try {
          // Obtener email desde auth.users si es posible
          final authUser = await _supabase.auth.admin.getUserById(userData['id']);
          if (authUser.user?.email != null) {
            userData['email'] = authUser.user!.email;
          }
          
          users.add(UserProfile.fromJson(userData));
        } catch (e) {
          logger.w('⚠️ Error procesando usuario ${userData['id']}: $e');
          // Continuar con el siguiente usuario
        }
      }
      
      logger.i('✅ ${users.length} usuarios obtenidos exitosamente');
      return users;
    } catch (e) {
      logger.e('❌ Error obteniendo usuarios: $e');
      rethrow;
    }
  }

  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;
}

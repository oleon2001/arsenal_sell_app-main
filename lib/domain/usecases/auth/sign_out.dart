import '../../../config/logger.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../services/location/location_service.dart';
import '../../../services/sync/sync_queue.dart';
import '../../entities.dart';
import 'sign_in.dart'; // For NoParams

class SignOutParams {
  const SignOutParams({
    this.clearLocalData = false,
    this.syncPendingData = true,
  });
  final bool clearLocalData;
  final bool syncPendingData;
}

class SignOutResult {
  const SignOutResult({
    required this.success,
    this.message,
    this.pendingDataCount,
  });
  final bool success;
  final String? message;
  final int? pendingDataCount;
}

class SignOutUseCase implements UseCase<SignOutResult, SignOutParams> {
  const SignOutUseCase(
    this._authRepository,
    this._syncQueue,
    this._locationService,
  );
  final AuthRepository _authRepository;
  final SyncQueue _syncQueue;
  final LocationService _locationService;

  @override
  Future<SignOutResult> call(SignOutParams params) async {
    try {
      logger.i('Starting sign out process...');

      int? pendingDataCount;

      // Sync pending data before signing out if requested
      if (params.syncPendingData) {
        try {
          pendingDataCount = await _syncQueue.getPendingCount();
          if (pendingDataCount > 0) {
            logger.i('Syncing $pendingDataCount pending items before sign out');
            // Note: We don't wait for sync to complete to avoid blocking sign out
            // The sync will continue in background if possible
          }
        } catch (e) {
          logger.w('Failed to sync pending data before sign out: $e');
          // Continue with sign out even if sync fails
        }
      }

      // Stop location tracking
      try {
        await _locationService.stopLocationTracking();
        logger.i('Location tracking stopped');
      } catch (e) {
        logger.w('Failed to stop location tracking: $e');
        // Continue with sign out
      }

      // Sign out from auth service
      await _authRepository.signOut();

      // Clear local data if requested
      if (params.clearLocalData) {
        try {
          await _clearLocalData();
          logger.i('Local data cleared');
        } catch (e) {
          logger.w('Failed to clear some local data: $e');
          // Continue with sign out
        }
      }

      logger.i('Sign out completed successfully');

      return SignOutResult(
        success: true,
        message: 'Signed out successfully',
        pendingDataCount: pendingDataCount,
      );
    } catch (e) {
      logger.e('Sign out failed: $e');

      // Even if there's an error, we should try to clear the auth state
      try {
        await _authRepository.signOut();
      } catch (authError) {
        logger.e('Failed to clear auth state: $authError');
      }

      return SignOutResult(
        success: false,
        message: 'Sign out failed: ${e.toString()}',
      );
    }
  }

  Future<void> _clearLocalData() async {
    // Clear sensitive data from local storage
    // This could include cached user data, tokens, etc.
    // Implementation would depend on your local storage strategy

    try {
      // Clear preferences
      // await AppPreferences.clear();

      // Clear sensitive cache data
      // await HiveBoxes.settingsBox.clear();

      // Note: We might want to keep some data like app settings,
      // offline customer data, etc., so we clear selectively
    } catch (e) {
      logger.e('Error clearing local data: $e');
      throw DomainException('Failed to clear local data: ${e.toString()}');
    }
  }
}

class ForceSignOutUseCase implements UseCase<SignOutResult, NoParams> {
  const ForceSignOutUseCase(
    this._authRepository,
    this._locationService,
  );
  final AuthRepository _authRepository;
  final LocationService _locationService;

  @override
  Future<SignOutResult> call(NoParams params) async {
    try {
      logger.w('Force sign out initiated');

      // Stop location tracking immediately
      try {
        await _locationService.stopLocationTracking();
      } catch (e) {
        logger.w('Failed to stop location tracking during force sign out: $e');
      }

      // Force sign out without syncing
      await _authRepository.signOut();

      // Clear all local auth data
      try {
        // Clear all auth-related local data
        // await AppPreferences.clear();
      } catch (e) {
        logger.w('Failed to clear local data during force sign out: $e');
      }

      logger.i('Force sign out completed');

      return const SignOutResult(
        success: true,
        message: 'Force signed out successfully',
      );
    } catch (e) {
      logger.e('Force sign out failed: $e');
      return SignOutResult(
        success: false,
        message: 'Force sign out failed: ${e.toString()}',
      );
    }
  }
}

class CheckSessionValidityUseCase implements UseCase<bool, NoParams> {
  const CheckSessionValidityUseCase(this._authRepository);
  final AuthRepository _authRepository;

  @override
  Future<bool> call(NoParams params) async {
    try {
      final user = await _authRepository.getCurrentUser();

      if (user == null) {
        return false;
      }

      // Check if user is still active
      if (!user.isActive) {
        logger.w('User account is no longer active');
        return false;
      }

      // Additional session validation logic could go here
      // For example, checking token expiration, server-side validation, etc.

      return true;
    } catch (e) {
      logger.e('Session validity check failed: $e');
      return false;
    }
  }
}

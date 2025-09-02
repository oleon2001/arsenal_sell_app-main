import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const String _keyIsFirstRun = 'is_first_run';
  static const String _keyUserId = 'user_id';
  static const String _keyUserRole = 'user_role';
  static const String _keyLocationEnabled = 'location_enabled';
  static const String _keyBackgroundLocationEnabled =
      'background_location_enabled';
  static const String _keyLastSyncAt = 'last_sync_at';

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception(
          'Preferences not initialized. Call AppPreferences.init() first.');
    }
    return _prefs!;
  }

  // Getters
  static bool get isFirstRun => prefs.getBool(_keyIsFirstRun) ?? true;
  static String? get userId => prefs.getString(_keyUserId);
  static String? get userRole => prefs.getString(_keyUserRole);
  static bool get isLocationEnabled =>
      prefs.getBool(_keyLocationEnabled) ?? false;
  static bool get isBackgroundLocationEnabled =>
      prefs.getBool(_keyBackgroundLocationEnabled) ?? false;
  static DateTime? get lastSyncAt {
    final timestamp = prefs.getInt(_keyLastSyncAt);
    return timestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(timestamp)
        : null;
  }

  // Setters
  static Future<void> setIsFirstRun(bool value) =>
      prefs.setBool(_keyIsFirstRun, value);
  static Future<void> setUserId(String? value) => value != null
      ? prefs.setString(_keyUserId, value)
      : prefs.remove(_keyUserId);
  static Future<void> setUserRole(String? value) => value != null
      ? prefs.setString(_keyUserRole, value)
      : prefs.remove(_keyUserRole);
  static Future<void> setLocationEnabled(bool value) =>
      prefs.setBool(_keyLocationEnabled, value);
  static Future<void> setBackgroundLocationEnabled(bool value) =>
      prefs.setBool(_keyBackgroundLocationEnabled, value);
  static Future<void> setLastSyncAt(DateTime? value) => value != null
      ? prefs.setInt(_keyLastSyncAt, value.millisecondsSinceEpoch)
      : prefs.remove(_keyLastSyncAt);

  static Future<void> clear() => prefs.clear();
}

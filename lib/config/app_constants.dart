class AppConstants {
  static const String appName = 'Arsenal Sell App';
  static const String version = '1.0.0';

  // Geofence
  static const double defaultGeofenceRadius = 10; // meters
  static const double maxGeofenceRadius = 100;

  // Location
  static const double locationAccuracyThreshold = 10; // meters
  static const int locationUpdateInterval = 30; // seconds
  static const int backgroundLocationInterval = 60; // seconds

  // Sync
  static const int syncBatchSize = 50;
  static const int maxRetryAttempts = 3;
  static const Duration syncInterval = Duration(minutes: 5);

  // UI
  static const double defaultPadding = 16;
  static const double defaultRadius = 8;

  // File Upload
  static const int maxPhotoSize = 5 * 1024 * 1024; // 5MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png'];
}

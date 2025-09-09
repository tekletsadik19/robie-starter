/// Application-wide constants
class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();
  // API Configuration
  static const String baseUrl = 'https://api.example.com';
  static const String apiVersion = 'v1';
  static const Duration defaultTimeout = Duration(seconds: 30);
  static const Duration cacheTimeout = Duration(hours: 1);

  // Database Configuration
  static const String databaseName = 'app_database.db';
  static const int databaseVersion = 1;

  // Cache Configuration
  static const String cacheBoxName = 'app_cache';
  static const int maxCacheSize = 1000;

  // UI Configuration
  static const double defaultPadding = 16;
  static const double defaultBorderRadius = 8;
  static const int maxRetryAttempts = 3;

  // Validation
  static const int minPasswordLength = 8;
  static const int maxUsernameLength = 50;

  // Feature Flags
  static const bool enableLogging = true;
  static const bool enableCaching = true;
  static const bool enableAnalytics = true;
}

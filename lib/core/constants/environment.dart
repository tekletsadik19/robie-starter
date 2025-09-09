/// Environment configuration
enum Environment {
  development,
  staging,
  production;

  /// Current environment
  static Environment current = Environment.development;

  /// Check if current environment is development
  static bool get isDevelopment => current == Environment.development;

  /// Check if current environment is staging
  static bool get isStaging => current == Environment.staging;

  /// Check if current environment is production
  static bool get isProduction => current == Environment.production;

  /// Get base URL for current environment
  String get baseUrl {
    switch (this) {
      case Environment.development:
        return 'https://dev-api.example.com';
      case Environment.staging:
        return 'https://staging-api.example.com';
      case Environment.production:
        return 'https://api.example.com';
    }
  }

  /// Get database name for current environment
  String get databaseName {
    switch (this) {
      case Environment.development:
        return 'app_dev.db';
      case Environment.staging:
        return 'app_staging.db';
      case Environment.production:
        return 'app_prod.db';
    }
  }

  /// Get logging level for current environment
  bool get enableDebugLogging {
    switch (this) {
      case Environment.development:
      case Environment.staging:
        return true;
      case Environment.production:
        return false;
    }
  }
}

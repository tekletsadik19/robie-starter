import 'package:robbie_starter/core/constants/environment.dart';

/// Application configuration based on environment
class AppConfig {
  const AppConfig._();

  /// Get current configuration
  static AppConfigData get current {
    switch (Environment.current) {
      case Environment.development:
        return _developmentConfig;
      case Environment.staging:
        return _stagingConfig;
      case Environment.production:
        return _productionConfig;
    }
  }

  static const AppConfigData _developmentConfig = AppConfigData(
    appName: 'DDD Flutter App (Dev)',
    apiBaseUrl: 'https://dev-api.example.com',
    enableLogging: true,
    enableAnalytics: false,
    enableCaching: true,
    logLevel: LogLevel.debug,
    apiTimeout: Duration(seconds: 30),
    retryAttempts: 3,
  );

  static const AppConfigData _stagingConfig = AppConfigData(
    appName: 'DDD Flutter App (Staging)',
    apiBaseUrl: 'https://staging-api.example.com',
    enableLogging: true,
    enableAnalytics: true,
    enableCaching: true,
    logLevel: LogLevel.info,
    apiTimeout: Duration(seconds: 30),
    retryAttempts: 3,
  );

  static const AppConfigData _productionConfig = AppConfigData(
    appName: 'DDD Flutter App',
    apiBaseUrl: 'https://api.example.com',
    enableLogging: false,
    enableAnalytics: true,
    enableCaching: true,
    logLevel: LogLevel.warning,
    apiTimeout: Duration(seconds: 15),
    retryAttempts: 2,
  );
}

/// Configuration data structure
class AppConfigData {
  const AppConfigData({
    required this.appName,
    required this.apiBaseUrl,
    required this.enableLogging,
    required this.enableAnalytics,
    required this.enableCaching,
    required this.logLevel,
    required this.apiTimeout,
    required this.retryAttempts,
  });

  final String appName;
  final String apiBaseUrl;
  final bool enableLogging;
  final bool enableAnalytics;
  final bool enableCaching;
  final LogLevel logLevel;
  final Duration apiTimeout;
  final int retryAttempts;
}

/// Log levels
enum LogLevel {
  debug,
  info,
  warning,
  error,
  critical;

  int get value {
    switch (this) {
      case LogLevel.debug:
        return 500;
      case LogLevel.info:
        return 800;
      case LogLevel.warning:
        return 900;
      case LogLevel.error:
        return 1000;
      case LogLevel.critical:
        return 1200;
    }
  }
}

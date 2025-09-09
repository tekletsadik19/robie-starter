import 'package:robbie_starter/core/constants/environment.dart';

/// Application configuration based on flavors/environments
enum AppConfig {
  /// Development configuration
  _developmentConfig._(
    appName: 'Shemanit Dev',
    appSuffix: '.dev',
    environment: Environment.development,
    apiConfig: ApiConfig(
      baseUrl: 'https://dev-api.shemanit.co',
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
      enableLogging: true,
      enableMockData: true,
      rateLimitPerMinute: 1000,
    ),
    databaseConfig: DatabaseConfig(
      name: 'shemanit_dev.db',
      version: 1,
      enableEncryption: true,
      enableWAL: true,
      cacheSize: 2000,
    ),
    loggingConfig: LoggingConfig(
      enableConsoleLogging: true,
      enableFileLogging: true,
      logLevel: LogLevel.debug,
      enableCrashReporting: false,
      enablePerformanceLogging: true,
    ),
    analyticsConfig: AnalyticsConfig(
      enableAnalytics: false,
      enableCrashlytics: false,
      sampleRate: 1,
    ),
    debugConfig: DebugConfig(
      enableDebugMode: true,
      enableInspector: true,
      enablePerformanceOverlay: true,
      enableDebugBanner: true,
      enableSlowAnimations: false,
    ),
    securityConfig: SecurityConfig(
      enableCertificatePinning: false,
      enableBiometrics: true,
      sessionTimeout: Duration(hours: 24),
      enableSecureStorage: true,
    ),
    performanceConfig: PerformanceConfig(
      enableLazyLoading: true,
      cacheTimeout: Duration(minutes: 30),
      imageCacheSize: 100,
      enablePreloading: true,
    ),
  ),

  /// Staging configuration
  _stagingConfig._(
    appName: 'Shemanit Staging',
    appSuffix: '.staging',
    environment: Environment.staging,
    apiConfig: ApiConfig(
      baseUrl: 'https://staging-api.shemanit.co',
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
      enableLogging: true,
      enableMockData: false,
      rateLimitPerMinute: 500,
    ),
    databaseConfig: DatabaseConfig(
      name: 'shemanit_staging.db',
      version: 1,
      enableEncryption: true,
      enableWAL: true,
      cacheSize: 1000,
    ),
    loggingConfig: LoggingConfig(
      enableConsoleLogging: true,
      enableFileLogging: true,
      logLevel: LogLevel.info,
      enableCrashReporting: true,
      enablePerformanceLogging: true,
    ),
    analyticsConfig: AnalyticsConfig(
      enableAnalytics: true,
      enableCrashlytics: true,
      sampleRate: 0.5,
    ),
    debugConfig: DebugConfig(
      enableDebugMode: false,
      enableInspector: false,
      enablePerformanceOverlay: false,
      enableDebugBanner: true,
      enableSlowAnimations: false,
    ),
    securityConfig: SecurityConfig(
      enableCertificatePinning: true,
      enableBiometrics: true,
      sessionTimeout: Duration(hours: 8),
      enableSecureStorage: true,
    ),
    performanceConfig: PerformanceConfig(
      enableLazyLoading: true,
      cacheTimeout: Duration(hours: 1),
      imageCacheSize: 200,
      enablePreloading: true,
    ),
  ),

  /// Production configuration
  _productionConfig._(
    appName: 'Shemanit',
    appSuffix: '',
    environment: Environment.production,
    apiConfig: ApiConfig(
      baseUrl: 'https://api.shemanit.co',
      connectTimeout: Duration(seconds: 15),
      receiveTimeout: Duration(seconds: 15),
      enableLogging: false,
      enableMockData: false,
      rateLimitPerMinute: 100,
    ),
    databaseConfig: DatabaseConfig(
      name: 'shemanit.db',
      version: 1,
      enableEncryption: true,
      enableWAL: true,
      cacheSize: 500,
    ),
    loggingConfig: LoggingConfig(
      enableConsoleLogging: false,
      enableFileLogging: false,
      logLevel: LogLevel.error,
      enableCrashReporting: true,
      enablePerformanceLogging: false,
    ),
    analyticsConfig: AnalyticsConfig(
      enableAnalytics: true,
      enableCrashlytics: true,
      sampleRate: 0.1,
    ),
    debugConfig: DebugConfig(
      enableDebugMode: false,
      enableInspector: false,
      enablePerformanceOverlay: false,
      enableDebugBanner: false,
      enableSlowAnimations: false,
    ),
    securityConfig: SecurityConfig(
      enableCertificatePinning: true,
      enableBiometrics: true,
      sessionTimeout: Duration(hours: 4),
      enableSecureStorage: true,
    ),
    performanceConfig: PerformanceConfig(
      enableLazyLoading: true,
      cacheTimeout: Duration(hours: 6),
      imageCacheSize: 500,
      enablePreloading: false,
    ),
  );

  const AppConfig._({
    required this.appName,
    required this.appSuffix,
    required this.environment,
    required this.apiConfig,
    required this.databaseConfig,
    required this.loggingConfig,
    required this.analyticsConfig,
    required this.debugConfig,
    required this.securityConfig,
    required this.performanceConfig,
  });

  final String appName;
  final String appSuffix;
  final Environment environment;
  final ApiConfig apiConfig;
  final DatabaseConfig databaseConfig;
  final LoggingConfig loggingConfig;
  final AnalyticsConfig analyticsConfig;
  final DebugConfig debugConfig;
  final SecurityConfig securityConfig;
  final PerformanceConfig performanceConfig;

  static AppConfig? _instance;

  /// Get current app configuration
  static AppConfig get instance {
    assert(_instance != null, 'AppConfig must be initialized first');
    return _instance!;
  }

  /// Initialize app configuration for specific environment
  static void initialize(Environment environment) {
    switch (environment) {
      case Environment.development:
        _instance = _developmentConfig;
      case Environment.staging:
        _instance = _stagingConfig;
      case Environment.production:
        _instance = _productionConfig;
    }
  }

  /// Get full app name with suffix
  String get fullAppName => appName + appSuffix;

  /// Check if current environment is development
  bool get isDevelopment => environment == Environment.development;

  /// Check if current environment is staging
  bool get isStaging => environment == Environment.staging;

  /// Check if current environment is production
  bool get isProduction => environment == Environment.production;
}

/// API configuration
class ApiConfig {
  const ApiConfig({
    required this.baseUrl,
    required this.connectTimeout,
    required this.receiveTimeout,
    required this.enableLogging,
    required this.enableMockData,
    required this.rateLimitPerMinute,
  });

  final String baseUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final bool enableLogging;
  final bool enableMockData;
  final int rateLimitPerMinute;
}

/// Database configuration
class DatabaseConfig {
  const DatabaseConfig({
    required this.name,
    required this.version,
    required this.enableEncryption,
    required this.enableWAL,
    required this.cacheSize,
  });

  final String name;
  final int version;
  final bool enableEncryption;
  final bool enableWAL;
  final int cacheSize;
}

/// Logging configuration
class LoggingConfig {
  const LoggingConfig({
    required this.enableConsoleLogging,
    required this.enableFileLogging,
    required this.logLevel,
    required this.enableCrashReporting,
    required this.enablePerformanceLogging,
  });

  final bool enableConsoleLogging;
  final bool enableFileLogging;
  final LogLevel logLevel;
  final bool enableCrashReporting;
  final bool enablePerformanceLogging;
}

/// Log levels
enum LogLevel {
  debug,
  info,
  warning,
  error,
}

/// Analytics configuration
class AnalyticsConfig {
  const AnalyticsConfig({
    required this.enableAnalytics,
    required this.enableCrashlytics,
    required this.sampleRate,
  });

  final bool enableAnalytics;
  final bool enableCrashlytics;
  final double sampleRate;
}

/// Debug configuration
class DebugConfig {
  const DebugConfig({
    required this.enableDebugMode,
    required this.enableInspector,
    required this.enablePerformanceOverlay,
    required this.enableDebugBanner,
    required this.enableSlowAnimations,
  });

  final bool enableDebugMode;
  final bool enableInspector;
  final bool enablePerformanceOverlay;
  final bool enableDebugBanner;
  final bool enableSlowAnimations;
}

/// Security configuration
class SecurityConfig {
  const SecurityConfig({
    required this.enableCertificatePinning,
    required this.enableBiometrics,
    required this.sessionTimeout,
    required this.enableSecureStorage,
  });

  final bool enableCertificatePinning;
  final bool enableBiometrics;
  final Duration sessionTimeout;
  final bool enableSecureStorage;
}

/// Performance configuration
class PerformanceConfig {
  const PerformanceConfig({
    required this.enableLazyLoading,
    required this.cacheTimeout,
    required this.imageCacheSize,
    required this.enablePreloading,
  });

  final bool enableLazyLoading;
  final Duration cacheTimeout;
  final int imageCacheSize;
  final bool enablePreloading;
}

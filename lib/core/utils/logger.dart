import 'dart:developer' as dev;

/// Centralized logging utility
class Logger {
  static const String _tag = 'DDD_FLUTTER_APP';

  /// Log debug message
  static void debug(String message, [Object? error, StackTrace? stackTrace]) {
    dev.log(
      message,
      name: _tag,
      level: 500, // Debug level
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log info message
  static void info(String message, [Object? error, StackTrace? stackTrace]) {
    dev.log(
      message,
      name: _tag,
      level: 800, // Info level
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log warning message
  static void warning(String message, [Object? error, StackTrace? stackTrace]) {
    dev.log(
      message,
      name: _tag,
      level: 900, // Warning level
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log error message
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    dev.log(
      message,
      name: _tag,
      level: 1000, // Error level
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log critical error message
  static void critical(
    String message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    dev.log(
      message,
      name: _tag,
      level: 1200, // Critical level
      error: error,
      stackTrace: stackTrace,
    );
  }
}

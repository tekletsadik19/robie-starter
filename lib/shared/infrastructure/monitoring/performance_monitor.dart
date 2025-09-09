import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:shemanit/core/utils/logger.dart';
import 'package:shemanit/shared/infrastructure/monitoring/analytics_service.dart';

/// Performance metrics
class PerformanceMetrics {
  const PerformanceMetrics({
    required this.operation,
    required this.duration,
    required this.success,
    this.errorMessage,
    this.additionalData = const {},
  });

  final String operation;
  final Duration duration;
  final bool success;
  final String? errorMessage;
  final Map<String, dynamic> additionalData;

  Map<String, dynamic> toJson() => {
        'operation': operation,
        'duration_ms': duration.inMilliseconds,
        'success': success,
        'error_message': errorMessage,
        'additional_data': additionalData,
      };
}

/// Performance monitor interface
abstract class PerformanceMonitor {
  /// Start timing an operation
  PerformanceTimer startTimer(String operation);

  /// Track performance metrics
  Future<void> trackPerformance(PerformanceMetrics metrics);

  /// Monitor async operation
  Future<T> monitorOperation<T>(
    String operationName,
    Future<T> Function() operation, {
    Map<String, dynamic>? additionalData,
  });
}

/// Performance timer for measuring operation duration
class PerformanceTimer {
  PerformanceTimer(this.operation) : _stopwatch = Stopwatch()..start();

  final String operation;
  final Stopwatch _stopwatch;

  /// Stop timer and return duration
  Duration stop() {
    _stopwatch.stop();
    return _stopwatch.elapsed;
  }

  /// Get current elapsed time
  Duration get elapsed => _stopwatch.elapsed;
}

@Singleton(as: PerformanceMonitor)
class PerformanceMonitorImpl implements PerformanceMonitor {
  PerformanceMonitorImpl(this._analyticsService);

  final AnalyticsService _analyticsService;

  @override
  PerformanceTimer startTimer(String operation) {
    Logger.debug('Starting performance timer for: $operation');
    return PerformanceTimer(operation);
  }

  @override
  Future<void> trackPerformance(PerformanceMetrics metrics) async {
    try {
      Logger.info('Performance: ${metrics.toJson()}');

      // Track in analytics
      await _analyticsService.trackEvent(
        AnalyticsEvent(
          name: 'performance_metric',
          parameters: metrics.toJson(),
        ),
      );

      // Log warning for slow operations (>1 second)
      if (metrics.duration.inMilliseconds > 1000) {
        Logger.warning(
          'Slow operation detected: ${metrics.operation} took ${metrics.duration.inMilliseconds}ms',
        );
      }
    } catch (e) {
      Logger.error('Error tracking performance metrics', e);
    }
  }

  @override
  Future<T> monitorOperation<T>(
    String operationName,
    Future<T> Function() operation, {
    Map<String, dynamic>? additionalData,
  }) async {
    final timer = startTimer(operationName);

    try {
      final result = await operation();
      final duration = timer.stop();

      await trackPerformance(
        PerformanceMetrics(
          operation: operationName,
          duration: duration,
          success: true,
          additionalData: additionalData ?? {},
        ),
      );

      return result;
    } catch (e, stackTrace) {
      final duration = timer.stop();

      await trackPerformance(
        PerformanceMetrics(
          operation: operationName,
          duration: duration,
          success: false,
          errorMessage: e.toString(),
          additionalData: additionalData ?? {},
        ),
      );

      Logger.error('Operation failed: $operationName', e, stackTrace);
      rethrow;
    }
  }
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:robbie_starter/core/config/app_config.dart';
import 'package:robbie_starter/core/debug/debug_utils.dart';

/// Performance monitoring utilities
class PerformanceMonitor {
  PerformanceMonitor._();

  static final Map<String, DateTime> _timers = {};
  static final List<PerformanceMetric> _metrics = [];
  static Timer? _frameRateTimer;

  /// Initialize performance monitoring
  static void initialize() {
    if (!kDebugMode ||
        !AppConfig.instance.loggingConfig.enablePerformanceLogging) {
      return;
    }

    _startFrameRateMonitoring();
    DebugUtils.logInfo('Performance monitoring initialized');
  }

  /// Start timing an operation
  static void startTimer(String name) {
    if (!kDebugMode) return;

    _timers[name] = DateTime.now();
    DebugUtils.logDebug('Timer started: $name');
  }

  /// End timing an operation
  static Duration? endTimer(String name) {
    if (!kDebugMode) return null;

    final startTime = _timers.remove(name);
    if (startTime == null) {
      DebugUtils.logWarning('Timer not found: $name');
      return null;
    }

    final duration = DateTime.now().difference(startTime);
    final metric = PerformanceMetric(
      name: name,
      duration: duration,
      timestamp: DateTime.now(),
    );

    _metrics.add(metric);
    DebugUtils.logInfo('Timer ended: $name - ${duration.inMilliseconds}ms');

    // Keep only last 100 metrics
    if (_metrics.length > 100) {
      _metrics.removeAt(0);
    }

    return duration;
  }

  /// Measure execution time of a function
  static Future<T> measure<T>(
    String name,
    Future<T> Function() function,
  ) async {
    startTimer(name);
    try {
      final result = await function();
      return result;
    } finally {
      endTimer(name);
    }
  }

  /// Measure synchronous execution time
  static T measureSync<T>(String name, T Function() function) {
    startTimer(name);
    try {
      return function();
    } finally {
      endTimer(name);
    }
  }

  /// Get performance metrics
  static List<PerformanceMetric> getMetrics() => List.unmodifiable(_metrics);

  /// Clear performance metrics
  static void clearMetrics() {
    _metrics.clear();
    DebugUtils.logInfo('Performance metrics cleared');
  }

  /// Start frame rate monitoring
  static void _startFrameRateMonitoring() {
    if (_frameRateTimer != null) return;

    var frameCount = 0;
    var lastTime = DateTime.now();

    void onFrame(Duration timestamp) {
      frameCount++;
      final now = DateTime.now();
      final elapsed = now.difference(lastTime);

      if (elapsed.inSeconds >= 5) {
        final fps = frameCount / elapsed.inSeconds;
        DebugUtils.logInfo('FPS: ${fps.toStringAsFixed(1)}');

        if (fps < 30) {
          DebugUtils.logWarning('Low FPS detected: ${fps.toStringAsFixed(1)}');
        }

        frameCount = 0;
        lastTime = now;
      }

      SchedulerBinding.instance.addPostFrameCallback(onFrame);
    }

    SchedulerBinding.instance.addPostFrameCallback(onFrame);
  }

  /// Stop frame rate monitoring
  static void stopFrameRateMonitoring() {
    _frameRateTimer?.cancel();
    _frameRateTimer = null;
  }

  /// Widget to monitor build performance
  static Widget buildMonitor({
    required Widget child,
    required String name,
  }) {
    if (!kDebugMode) return child;

    return _BuildMonitorWidget(
      name: name,
      child: child,
    );
  }

  /// Print performance summary
  static void printSummary() {
    if (!kDebugMode || _metrics.isEmpty) return;

    DebugUtils.logInfo('Performance Summary:');
    DebugUtils.logInfo('Total operations: ${_metrics.length}');

    final grouped = <String, List<PerformanceMetric>>{};
    for (final metric in _metrics) {
      grouped.putIfAbsent(metric.name, () => []).add(metric);
    }

    for (final entry in grouped.entries) {
      final operations = entry.value;
      final totalTime = operations.fold<int>(
        0,
        (sum, metric) => sum + metric.duration.inMilliseconds,
      );
      final avgTime = totalTime / operations.length;
      final maxTime = operations
          .map((m) => m.duration.inMilliseconds)
          .reduce((a, b) => a > b ? a : b);
      final minTime = operations
          .map((m) => m.duration.inMilliseconds)
          .reduce((a, b) => a < b ? a : b);

      DebugUtils.logInfo('${entry.key}:');
      DebugUtils.logInfo('  Count: ${operations.length}');
      DebugUtils.logInfo('  Avg: ${avgTime.toStringAsFixed(2)}ms');
      DebugUtils.logInfo('  Min: ${minTime}ms');
      DebugUtils.logInfo('  Max: ${maxTime}ms');
      DebugUtils.logInfo('  Total: ${totalTime}ms');
    }
  }
}

/// Performance metric data class
class PerformanceMetric {
  const PerformanceMetric({
    required this.name,
    required this.duration,
    required this.timestamp,
  });

  final String name;
  final Duration duration;
  final DateTime timestamp;
}

/// Widget that monitors build performance
class _BuildMonitorWidget extends StatefulWidget {
  const _BuildMonitorWidget({
    required this.name,
    required this.child,
  });

  final String name;
  final Widget child;

  @override
  State<_BuildMonitorWidget> createState() => _BuildMonitorWidgetState();
}

class _BuildMonitorWidgetState extends State<_BuildMonitorWidget> {
  int _buildCount = 0;
  DateTime? _lastBuild;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    if (_lastBuild != null) {
      final timeSinceLastBuild = now.difference(_lastBuild!);
      if (timeSinceLastBuild.inMilliseconds < 16) {
        DebugUtils.logWarning(
          'Rapid rebuild detected in ${widget.name}: ${timeSinceLastBuild.inMilliseconds}ms since last build',
        );
      }
    }

    _buildCount++;
    _lastBuild = now;

    if (_buildCount % 10 == 0) {
      DebugUtils.logInfo('${widget.name} has built $_buildCount times');
    }

    return widget.child;
  }
}

/// Performance overlay widget
class PerformanceOverlay extends StatefulWidget {
  const PerformanceOverlay({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<PerformanceOverlay> createState() => _PerformanceOverlayState();
}

class _PerformanceOverlayState extends State<PerformanceOverlay> {
  bool _showOverlay = false;

  @override
  void initState() {
    super.initState();
    _showOverlay = AppConfig.instance.debugConfig.enablePerformanceOverlay;
  }

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode || !_showOverlay) {
      return widget.child;
    }

    return Stack(
      children: [
        widget.child,
        const Positioned(
          top: 100,
          right: 10,
          child: _PerformanceInfoPanel(),
        ),
      ],
    );
  }
}

/// Performance information panel
class _PerformanceInfoPanel extends StatefulWidget {
  const _PerformanceInfoPanel();

  @override
  State<_PerformanceInfoPanel> createState() => _PerformanceInfoPanelState();
}

class _PerformanceInfoPanelState extends State<_PerformanceInfoPanel> {
  Timer? _updateTimer;
  int _frameCount = 0;

  @override
  void initState() {
    super.initState();
    _updateTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          _updateMemoryUsage();
          _frameCount++;
        });
      }
    });
  }

  @override
  void dispose() {
    _updateTimer?.cancel();
    super.dispose();
  }

  void _updateMemoryUsage() {
    // Memory usage tracking removed for simplicity
  }

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.green.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'PERF',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Frames: $_frameCount',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                ),
              ),
              Text(
                'Metrics: ${PerformanceMonitor.getMetrics().length}',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      );
}

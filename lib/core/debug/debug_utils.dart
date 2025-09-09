import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shemanit/core/config/app_config.dart';

/// Debug utilities for development
class DebugUtils {
  DebugUtils._();

  static bool _initialized = false;

  /// Initialize debug utilities
  static void initialize() {
    if (_initialized) return;

    final config = AppConfig.instance;

    if (config.debugConfig.enableDebugMode && kDebugMode) {
      _setupDebugFeatures();
    }

    _initialized = true;
  }

  /// Setup debug features
  static void _setupDebugFeatures() {
    // Enable debug painting for layout debugging
    // debugPaintSizeEnabled = true; // Uncomment to enable

    // Log app lifecycle
    WidgetsBinding.instance.addObserver(_AppLifecycleObserver());

    developer.log('🐛 Debug utilities initialized');
  }

  /// Log a debug message
  static void logDebug(
    String message, {
    String? name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      developer.log(
        message,
        name: name ?? 'DEBUG',
        error: error,
        stackTrace: stackTrace,
        level: 700, // Debug level
      );
    }
  }

  /// Log an info message
  static void logInfo(String message, {String? name}) {
    if (kDebugMode) {
      developer.log(
        message,
        name: name ?? 'INFO',
        level: 800, // Info level
      );
    }
  }

  /// Log a warning message
  static void logWarning(String message, {String? name, Object? error}) {
    if (kDebugMode) {
      developer.log(
        message,
        name: name ?? 'WARNING',
        error: error,
        level: 900, // Warning level
      );
    }
  }

  /// Log an error message
  static void logError(
    String message, {
    String? name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: name ?? 'ERROR',
      error: error,
      stackTrace: stackTrace,
      level: 1000, // Error level
    );
  }

  /// Print memory usage
  static void printMemoryUsage() {
    if (kDebugMode) {
      final info = ProcessInfo.currentRss;
      logDebug('Memory usage: ${(info / 1024 / 1024).toStringAsFixed(2)} MB');
    }
  }

  /// Print widget tree
  static void printWidgetTree(BuildContext context) {
    if (kDebugMode) {
      debugDumpApp();
      logDebug('Widget tree dumped to console');
    }
  }

  /// Print render tree
  static void printRenderTree() {
    if (kDebugMode) {
      debugDumpRenderTree();
      logDebug('Render tree dumped to console');
    }
  }

  /// Print layer tree
  static void printLayerTree() {
    if (kDebugMode) {
      debugDumpLayerTree();
      logDebug('Layer tree dumped to console');
    }
  }

  /// Show debug overlay
  static Widget debugOverlay({required Widget child}) {
    if (!kDebugMode || !AppConfig.instance.debugConfig.enableDebugMode) {
      return child;
    }

    return Stack(
      children: [
        child,
        const Positioned(
          top: 50,
          right: 10,
          child: _DebugInfoPanel(),
        ),
      ],
    );
  }

  /// Create a debug floating action button
  static Widget? debugFab(BuildContext context) {
    if (!kDebugMode || !AppConfig.instance.debugConfig.enableDebugMode) {
      return null;
    }

    return FloatingActionButton(
      mini: true,
      backgroundColor: Colors.red.withValues(alpha: 0.8),
      onPressed: () => _showDebugMenu(context),
      child: const Icon(Icons.bug_report, color: Colors.white),
    );
  }

  /// Show debug menu
  static void _showDebugMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => const _DebugMenuSheet(),
    );
  }

  /// Trigger haptic feedback for debugging
  static void debugHaptic() {
    if (kDebugMode) {
      HapticFeedback.mediumImpact();
    }
  }

  /// Copy text to clipboard for debugging
  static void debugCopy(String text) {
    if (kDebugMode) {
      Clipboard.setData(ClipboardData(text: text));
      logDebug('Copied to clipboard: $text');
    }
  }
}

/// App lifecycle observer for debugging
class _AppLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    DebugUtils.logInfo('App lifecycle changed to: $state');
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
    DebugUtils.logInfo('Locales changed to: $locales');
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    DebugUtils.logInfo('Platform brightness changed');
  }

  @override
  void didHaveMemoryPressure() {
    super.didHaveMemoryPressure();
    DebugUtils.logWarning('Memory pressure detected');
    DebugUtils.printMemoryUsage();
  }
}

/// Debug information panel
class _DebugInfoPanel extends StatefulWidget {
  const _DebugInfoPanel();

  @override
  State<_DebugInfoPanel> createState() => _DebugInfoPanelState();
}

class _DebugInfoPanelState extends State<_DebugInfoPanel> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.black.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => setState(() => _expanded = !_expanded),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _expanded ? Icons.expand_less : Icons.expand_more,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'DEBUG',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              if (_expanded) ...[
                const SizedBox(height: 8),
                _buildInfoRow('Env', AppConfig.instance.environment.name),
                _buildInfoRow(
                  'Debug',
                  AppConfig.instance.debugConfig.enableDebugMode.toString(),
                ),
                _buildInfoRow('Platform', defaultTargetPlatform.name),
                _buildInfoRow(
                  'Mode',
                  kDebugMode
                      ? 'Debug'
                      : kProfileMode
                          ? 'Profile'
                          : 'Release',
                ),
              ],
            ],
          ),
        ),
      );

  Widget _buildInfoRow(String label, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Text(
          '$label: $value',
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 10,
          ),
        ),
      );
}

/// Debug menu bottom sheet
class _DebugMenuSheet extends StatelessWidget {
  const _DebugMenuSheet();

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Debug Menu',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            _buildDebugButton(
              'Print Widget Tree',
              () {
                DebugUtils.printWidgetTree(context);
                Navigator.pop(context);
              },
            ),
            _buildDebugButton(
              'Print Render Tree',
              () {
                DebugUtils.printRenderTree();
                Navigator.pop(context);
              },
            ),
            _buildDebugButton(
              'Print Layer Tree',
              () {
                DebugUtils.printLayerTree();
                Navigator.pop(context);
              },
            ),
            _buildDebugButton(
              'Memory Usage',
              () {
                DebugUtils.printMemoryUsage();
                Navigator.pop(context);
              },
            ),
            _buildDebugButton(
              'App Info',
              () {
                final config = AppConfig.instance;
                DebugUtils.debugCopy('''
App: ${config.fullAppName}
Environment: ${config.environment.name}
Base URL: ${config.apiConfig.baseUrl}
Debug Mode: ${config.debugConfig.enableDebugMode}
Platform: ${defaultTargetPlatform.name}
''');
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      );

  Widget _buildDebugButton(String title, VoidCallback onPressed) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(title),
        ),
      );
}

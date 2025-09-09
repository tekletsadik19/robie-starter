import 'package:injectable/injectable.dart';
import 'package:shemanit/core/constants/app_constants.dart';
import 'package:shemanit/core/utils/logger.dart';

/// Analytics event data
class AnalyticsEvent {
  const AnalyticsEvent({
    required this.name,
    this.parameters = const {},
    this.timestamp,
  });

  final String name;
  final Map<String, dynamic> parameters;
  final DateTime? timestamp;

  Map<String, dynamic> toJson() => {
        'name': name,
        'parameters': parameters,
        'timestamp': (timestamp ?? DateTime.now()).toIso8601String(),
      };
}

/// Analytics service interface
abstract class AnalyticsService {
  /// Track an event
  Future<void> trackEvent(AnalyticsEvent event);

  /// Track screen view
  Future<void> trackScreenView(String screenName);

  /// Track user action
  Future<void> trackUserAction(String action, Map<String, dynamic>? parameters);

  /// Track error
  Future<void> trackError(String error, StackTrace? stackTrace);

  /// Set user properties
  Future<void> setUserProperties(Map<String, dynamic> properties);

  /// Enable/disable analytics
  Future<void> setAnalyticsEnabled({required bool enabled});
}

@Singleton(as: AnalyticsService)
class AnalyticsServiceImpl implements AnalyticsService {
  AnalyticsServiceImpl();

  bool _isEnabled = AppConstants.enableAnalytics;

  @override
  Future<void> trackEvent(AnalyticsEvent event) async {
    if (!_isEnabled) return;

    try {
      // In production, integrate with Firebase Analytics, Mixpanel, etc.
      Logger.info('Analytics Event: ${event.toJson()}');
    } catch (e) {
      Logger.error('Error tracking analytics event', e);
    }
  }

  @override
  Future<void> trackScreenView(String screenName) async {
    await trackEvent(
      AnalyticsEvent(
        name: 'screen_view',
        parameters: {'screen_name': screenName},
      ),
    );
  }

  @override
  Future<void> trackUserAction(
    String action,
    Map<String, dynamic>? parameters,
  ) async {
    await trackEvent(
      AnalyticsEvent(
        name: 'user_action',
        parameters: {
          'action': action,
          ...?parameters,
        },
      ),
    );
  }

  @override
  Future<void> trackError(String error, StackTrace? stackTrace) async {
    await trackEvent(
      AnalyticsEvent(
        name: 'error',
        parameters: {
          'error_message': error,
          'stack_trace': stackTrace?.toString(),
        },
      ),
    );
  }

  @override
  Future<void> setUserProperties(Map<String, dynamic> properties) async {
    if (!_isEnabled) return;

    try {
      // In production, set user properties in analytics service
      Logger.info('User Properties: $properties');
    } catch (e) {
      Logger.error('Error setting user properties', e);
    }
  }

  @override
  Future<void> setAnalyticsEnabled({required bool enabled}) async {
    _isEnabled = enabled;
    Logger.info('Analytics ${enabled ? 'enabled' : 'disabled'}');
  }
}

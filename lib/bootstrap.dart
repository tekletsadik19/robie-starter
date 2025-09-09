import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:shemanit/core/cache/cache_service.dart';
import 'package:shemanit/core/config/app_config.dart';
import 'package:shemanit/core/debug/debug_utils.dart';
import 'package:shemanit/core/debug/performance_monitor.dart';
import 'package:shemanit/core/di/injection_container.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  // Ensure Flutter binding is initialized before accessing platform services
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  // Initialize dependency injection
  await configureDependencies();

  // Initialize cache service
  try {
    final cacheService = getIt<CacheService>();
    await cacheService.initialize();
    log('✅ Cache service initialized');
  } catch (e) {
    log('❌ Failed to initialize cache service: $e');
  }

  // Initialize development tools
  if (kDebugMode) {
    DebugUtils.initialize();
    PerformanceMonitor.initialize();

    final config = AppConfig.instance;
    log('🚀 App initialized for ${config.environment.name} environment');
    log('🔧 Debug mode: ${config.debugConfig.enableDebugMode}');
    log('📊 Performance monitoring: ${config.loggingConfig.enablePerformanceLogging}');
  }

  runApp(await builder());
}

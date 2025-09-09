import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:robbie_starter/core/di/injection_container.config.dart';
import 'package:robbie_starter/shared/infrastructure/security/encryption_service.dart';

/// Service locator instance
final GetIt sl = GetIt.instance;

/// Alias for service locator to match standard naming
final GetIt getIt = sl;

/// Initialize dependency injection
@InjectableInit()
Future<void> configureDependencies() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Initialize dependency injection
  sl.init();

  // Initialize encryption manager after DI setup
  final encryptionManager = sl<HiveEncryptionManager>();
  encryptionManager.initialize();
}

/// Register external dependencies that can't use @injectable
@module
abstract class RegisterModule {
  @singleton
  Dio get dio => Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
        ),
      );

  @preResolve
  @singleton
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}

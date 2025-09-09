// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:device_info_plus/device_info_plus.dart' as _i833;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:package_info_plus/package_info_plus.dart' as _i655;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:robbie_starter/core/cache/cache_service.dart' as _i105;
import 'package:robbie_starter/core/di/injection_container.dart' as _i67;
import 'package:robbie_starter/core/theme/theme_cubit.dart' as _i819;
import 'package:robbie_starter/features/counter/application/use_cases/decrement_counter_use_case.dart'
    as _i112;
import 'package:robbie_starter/features/counter/application/use_cases/get_counter_use_case.dart'
    as _i820;
import 'package:robbie_starter/features/counter/application/use_cases/increment_counter_use_case.dart'
    as _i730;
import 'package:robbie_starter/features/counter/application/use_cases/reset_counter_use_case.dart'
    as _i387;
import 'package:robbie_starter/features/counter/domain/repositories/counter_repository.dart'
    as _i79;
import 'package:robbie_starter/features/counter/domain/services/counter_domain_service.dart'
    as _i345;
import 'package:robbie_starter/features/counter/infrastructure/datasources/counter_local_data_source.dart'
    as _i322;
import 'package:robbie_starter/features/counter/infrastructure/repositories/counter_repository_impl.dart'
    as _i476;
import 'package:robbie_starter/features/counter/presentation/cubits/counter_cubit.dart'
    as _i148;
import 'package:robbie_starter/features/security/application/blocs/security_bloc.dart'
    as _i844;
import 'package:robbie_starter/features/security/di/security_injection.dart' as _i777;
import 'package:robbie_starter/features/security/domain/repositories/app_update_repository.dart'
    as _i89;
import 'package:robbie_starter/features/security/domain/repositories/security_repository.dart'
    as _i215;
import 'package:robbie_starter/features/security/domain/services/app_update_service.dart'
    as _i31;
import 'package:robbie_starter/features/security/domain/services/security_assessment_service.dart'
    as _i638;
import 'package:robbie_starter/features/security/domain/usecases/check_for_updates.dart'
    as _i719;
import 'package:robbie_starter/features/security/domain/usecases/check_security_status.dart'
    as _i1072;
import 'package:robbie_starter/features/security/infrastructure/services/device_fingerprint_service.dart'
    as _i841;
import 'package:robbie_starter/shared/infrastructure/caching/cache_manager.dart'
    as _i93;
import 'package:robbie_starter/shared/infrastructure/monitoring/analytics_service.dart'
    as _i63;
import 'package:robbie_starter/shared/infrastructure/monitoring/performance_monitor.dart'
    as _i363;
import 'package:robbie_starter/shared/infrastructure/network/api_client.dart'
    as _i491;
import 'package:robbie_starter/shared/infrastructure/security/encryption_service.dart'
    as _i649;
import 'package:robbie_starter/shared/infrastructure/security/secure_storage.dart'
    as _i24;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    final securityModule = _$SecurityModule();
    gh.singleton<_i361.Dio>(() => registerModule.dio);
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    await gh.singletonAsync<_i655.PackageInfo>(
      () => securityModule.packageInfo,
      preResolve: true,
    );
    gh.singleton<_i833.DeviceInfoPlugin>(() => securityModule.deviceInfoPlugin);
    gh.singleton<_i345.CounterDomainService>(
        () => _i345.CounterDomainService());
    gh.singleton<_i649.EncryptionService>(() => _i649.EncryptionService());
    gh.singleton<_i649.HiveEncryptionManager>(
        () => _i649.HiveEncryptionManager());
    gh.factory<_i819.ThemeCubit>(
        () => _i819.ThemeCubit(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i841.DeviceFingerprintService>(
        () => securityModule.deviceFingerprintService(
              gh<_i833.DeviceInfoPlugin>(),
              gh<_i655.PackageInfo>(),
            ));
    gh.singleton<_i105.CacheService>(() => _i105.HiveCacheService());
    gh.singleton<_i491.ApiClient>(() => _i491.ApiClient(gh<_i361.Dio>()));
    gh.singleton<_i63.AnalyticsService>(() => _i63.AnalyticsServiceImpl());
    gh.singleton<_i93.CacheManager>(
        () => _i93.CacheManagerImpl(gh<_i649.HiveEncryptionManager>()));
    gh.singleton<_i24.SecureStorage>(
        () => _i24.SecureStorageImpl(gh<_i649.HiveEncryptionManager>()));
    gh.singleton<_i322.CounterLocalDataSource>(() =>
        _i322.CounterLocalDataSourceImpl(gh<_i649.HiveEncryptionManager>()));
    gh.lazySingleton<_i31.IAppVersionRepository>(
        () => securityModule.appVersionService(
              gh<_i361.Dio>(),
              gh<_i655.PackageInfo>(),
            ));
    gh.singleton<_i79.CounterRepository>(
        () => _i476.CounterRepositoryImpl(gh<_i322.CounterLocalDataSource>()));
    gh.lazySingleton<_i638.ISecurityDetectionService>(() =>
        securityModule.securityDetectionService(gh<_i833.DeviceInfoPlugin>()));
    gh.singleton<_i820.GetCounterUseCase>(
        () => _i820.GetCounterUseCase(gh<_i79.CounterRepository>()));
    gh.singleton<_i387.ResetCounterUseCase>(
        () => _i387.ResetCounterUseCase(gh<_i79.CounterRepository>()));
    gh.lazySingleton<_i638.SecurityAssessmentService>(() => securityModule
        .securityAssessmentService(gh<_i638.ISecurityDetectionService>()));
    gh.singleton<_i730.IncrementCounterUseCase>(
        () => _i730.IncrementCounterUseCase(
              gh<_i79.CounterRepository>(),
              gh<_i345.CounterDomainService>(),
            ));
    gh.singleton<_i112.DecrementCounterUseCase>(
        () => _i112.DecrementCounterUseCase(
              gh<_i79.CounterRepository>(),
              gh<_i345.CounterDomainService>(),
            ));
    gh.singleton<_i363.PerformanceMonitor>(
        () => _i363.PerformanceMonitorImpl(gh<_i63.AnalyticsService>()));
    gh.lazySingleton<_i31.AppUpdateService>(() =>
        securityModule.appUpdateService(gh<_i31.IAppVersionRepository>()));
    gh.singleton<_i148.CounterCubit>(() => _i148.CounterCubit(
          gh<_i820.GetCounterUseCase>(),
          gh<_i730.IncrementCounterUseCase>(),
          gh<_i112.DecrementCounterUseCase>(),
          gh<_i387.ResetCounterUseCase>(),
        ));
    gh.lazySingleton<_i215.SecurityRepository>(
        () => securityModule.securityRepository(
              gh<_i638.SecurityAssessmentService>(),
              gh<_i841.DeviceFingerprintService>(),
            ));
    gh.lazySingleton<_i1072.PerformSecurityAssessment>(() => securityModule
        .performSecurityAssessment(gh<_i215.SecurityRepository>()));
    gh.lazySingleton<_i89.AppUpdateRepository>(
        () => securityModule.appUpdateRepository(gh<_i31.AppUpdateService>()));
    gh.lazySingleton<_i719.EvaluateUpdatePolicy>(() =>
        securityModule.evaluateUpdatePolicy(gh<_i89.AppUpdateRepository>()));
    gh.factory<_i844.SecurityBloc>(() => securityModule.securityBloc(
          gh<_i1072.PerformSecurityAssessment>(),
          gh<_i719.EvaluateUpdatePolicy>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i67.RegisterModule {}

class _$SecurityModule extends _i777.SecurityModule {}

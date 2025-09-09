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
import 'package:robbie_starter/core/cache/cache_service.dart' as _i276;
import 'package:robbie_starter/core/di/injection_container.dart' as _i829;
import 'package:robbie_starter/core/theme/theme_cubit.dart' as _i837;
import 'package:robbie_starter/features/counter/application/use_cases/decrement_counter_use_case.dart'
    as _i0;
import 'package:robbie_starter/features/counter/application/use_cases/get_counter_use_case.dart'
    as _i151;
import 'package:robbie_starter/features/counter/application/use_cases/increment_counter_use_case.dart'
    as _i560;
import 'package:robbie_starter/features/counter/application/use_cases/reset_counter_use_case.dart'
    as _i654;
import 'package:robbie_starter/features/counter/domain/repositories/counter_repository.dart'
    as _i583;
import 'package:robbie_starter/features/counter/domain/services/counter_domain_service.dart'
    as _i807;
import 'package:robbie_starter/features/counter/infrastructure/datasources/counter_local_data_source.dart'
    as _i803;
import 'package:robbie_starter/features/counter/infrastructure/repositories/counter_repository_impl.dart'
    as _i313;
import 'package:robbie_starter/features/counter/presentation/cubits/counter_cubit.dart'
    as _i251;
import 'package:robbie_starter/features/security/application/blocs/security_bloc.dart'
    as _i948;
import 'package:robbie_starter/features/security/di/security_injection.dart'
    as _i276;
import 'package:robbie_starter/features/security/domain/repositories/app_update_repository.dart'
    as _i597;
import 'package:robbie_starter/features/security/domain/repositories/security_repository.dart'
    as _i274;
import 'package:robbie_starter/features/security/domain/services/app_update_service.dart'
    as _i238;
import 'package:robbie_starter/features/security/domain/services/security_assessment_service.dart'
    as _i796;
import 'package:robbie_starter/features/security/domain/usecases/check_for_updates.dart'
    as _i809;
import 'package:robbie_starter/features/security/domain/usecases/check_security_status.dart'
    as _i161;
import 'package:robbie_starter/features/security/infrastructure/services/device_fingerprint_service.dart'
    as _i491;
import 'package:robbie_starter/features/spacex/application/blocs/spacex_bloc.dart'
    as _i284;
import 'package:robbie_starter/features/spacex/domain/repositories/spacex_repository.dart'
    as _i468;
import 'package:robbie_starter/features/spacex/domain/usecases/get_latest_launch.dart'
    as _i786;
import 'package:robbie_starter/features/spacex/domain/usecases/get_past_launches.dart'
    as _i384;
import 'package:robbie_starter/features/spacex/domain/usecases/get_upcoming_launches.dart'
    as _i256;
import 'package:robbie_starter/features/spacex/infrastructure/datasources/spacex_datasource.dart'
    as _i862;
import 'package:robbie_starter/features/spacex/infrastructure/repositories/spacex_repository_impl.dart'
    as _i452;
import 'package:robbie_starter/shared/infrastructure/caching/cache_manager.dart'
    as _i1050;
import 'package:robbie_starter/shared/infrastructure/graphql/graphql_client.dart'
    as _i655;
import 'package:robbie_starter/shared/infrastructure/monitoring/analytics_service.dart'
    as _i713;
import 'package:robbie_starter/shared/infrastructure/monitoring/performance_monitor.dart'
    as _i584;
import 'package:robbie_starter/shared/infrastructure/network/api_client.dart'
    as _i605;
import 'package:robbie_starter/shared/infrastructure/security/encryption_service.dart'
    as _i212;
import 'package:robbie_starter/shared/infrastructure/security/secure_storage.dart'
    as _i334;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

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
    gh.singleton<_i807.CounterDomainService>(
        () => _i807.CounterDomainService());
    gh.singleton<_i212.EncryptionService>(() => _i212.EncryptionService());
    gh.singleton<_i212.HiveEncryptionManager>(
        () => _i212.HiveEncryptionManager());
    gh.singleton<_i655.GraphQLClientService>(
        () => _i655.GraphQLClientService());
    gh.factory<_i837.ThemeCubit>(
        () => _i837.ThemeCubit(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i491.DeviceFingerprintService>(
        () => securityModule.deviceFingerprintService(
              gh<_i833.DeviceInfoPlugin>(),
              gh<_i655.PackageInfo>(),
            ));
    gh.lazySingleton<_i796.ISecurityDetectionService>(
        () => securityModule.securityDetectionService());
    gh.singleton<_i713.AnalyticsService>(() => _i713.AnalyticsServiceImpl());
    gh.singleton<_i605.ApiClient>(() => _i605.ApiClient(gh<_i361.Dio>()));
    gh.singleton<_i276.CacheService>(() => _i276.HiveCacheService());
    gh.factory<_i862.SpaceXDataSource>(
        () => _i862.SpaceXDataSource(gh<_i655.GraphQLClientService>()));
    gh.singleton<_i803.CounterLocalDataSource>(() =>
        _i803.CounterLocalDataSourceImpl(gh<_i212.HiveEncryptionManager>()));
    gh.singleton<_i584.PerformanceMonitor>(
        () => _i584.PerformanceMonitorImpl(gh<_i713.AnalyticsService>()));
    gh.singleton<_i334.SecureStorage>(
        () => _i334.SecureStorageImpl(gh<_i212.HiveEncryptionManager>()));
    gh.singleton<_i1050.CacheManager>(
        () => _i1050.CacheManagerImpl(gh<_i212.HiveEncryptionManager>()));
    gh.lazySingleton<_i238.IAppVersionRepository>(
        () => securityModule.appVersionService(gh<_i655.PackageInfo>()));
    gh.lazySingleton<_i796.SecurityAssessmentService>(() => securityModule
        .securityAssessmentService(gh<_i796.ISecurityDetectionService>()));
    gh.lazySingleton<_i238.AppUpdateService>(() =>
        securityModule.appUpdateService(gh<_i238.IAppVersionRepository>()));
    gh.lazySingleton<_i468.SpaceXRepository>(
        () => _i452.SpaceXRepositoryImpl(gh<_i862.SpaceXDataSource>()));
    gh.singleton<_i583.CounterRepository>(
        () => _i313.CounterRepositoryImpl(gh<_i803.CounterLocalDataSource>()));
    gh.lazySingleton<_i274.SecurityRepository>(
        () => securityModule.securityRepository(
              gh<_i796.SecurityAssessmentService>(),
              gh<_i491.DeviceFingerprintService>(),
            ));
    gh.lazySingleton<_i161.PerformSecurityAssessment>(() => securityModule
        .performSecurityAssessment(gh<_i274.SecurityRepository>()));
    gh.lazySingleton<_i597.AppUpdateRepository>(
        () => securityModule.appUpdateRepository(gh<_i238.AppUpdateService>()));
    gh.singleton<_i560.IncrementCounterUseCase>(
        () => _i560.IncrementCounterUseCase(
              gh<_i583.CounterRepository>(),
              gh<_i807.CounterDomainService>(),
            ));
    gh.singleton<_i0.DecrementCounterUseCase>(() => _i0.DecrementCounterUseCase(
          gh<_i583.CounterRepository>(),
          gh<_i807.CounterDomainService>(),
        ));
    gh.singleton<_i151.GetCounterUseCase>(
        () => _i151.GetCounterUseCase(gh<_i583.CounterRepository>()));
    gh.singleton<_i654.ResetCounterUseCase>(
        () => _i654.ResetCounterUseCase(gh<_i583.CounterRepository>()));
    gh.lazySingleton<_i809.EvaluateUpdatePolicy>(() =>
        securityModule.evaluateUpdatePolicy(gh<_i597.AppUpdateRepository>()));
    gh.factory<_i384.GetPastLaunches>(
        () => _i384.GetPastLaunches(gh<_i468.SpaceXRepository>()));
    gh.factory<_i256.GetUpcomingLaunches>(
        () => _i256.GetUpcomingLaunches(gh<_i468.SpaceXRepository>()));
    gh.factory<_i786.GetLatestLaunch>(
        () => _i786.GetLatestLaunch(gh<_i468.SpaceXRepository>()));
    gh.factory<_i948.SecurityBloc>(() => securityModule.securityBloc(
          gh<_i161.PerformSecurityAssessment>(),
          gh<_i809.EvaluateUpdatePolicy>(),
        ));
    gh.singleton<_i251.CounterCubit>(() => _i251.CounterCubit(
          gh<_i151.GetCounterUseCase>(),
          gh<_i560.IncrementCounterUseCase>(),
          gh<_i0.DecrementCounterUseCase>(),
          gh<_i654.ResetCounterUseCase>(),
        ));
    gh.factory<_i284.SpaceXBloc>(() => _i284.SpaceXBloc(
          gh<_i384.GetPastLaunches>(),
          gh<_i256.GetUpcomingLaunches>(),
          gh<_i786.GetLatestLaunch>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i829.RegisterModule {}

class _$SecurityModule extends _i276.SecurityModule {}

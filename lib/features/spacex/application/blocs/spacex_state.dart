part of 'spacex_bloc.dart';

/// Status enum for SpaceX operations
enum SpaceXStatus {
  initial,
  loading,
  success,
  failure,
}

/// State for SpaceX BLoC
@freezed
class SpaceXState with _$SpaceXState {
  const factory SpaceXState({
    @Default(SpaceXStatus.initial) SpaceXStatus pastLaunchesStatus,
    @Default(SpaceXStatus.initial) SpaceXStatus upcomingLaunchesStatus,
    @Default(SpaceXStatus.initial) SpaceXStatus latestLaunchStatus,
    @Default([]) List<LaunchEntity> pastLaunches,
    @Default([]) List<LaunchEntity> upcomingLaunches,
    LaunchEntity? latestLaunch,
    String? errorMessage,
  }) = _SpaceXState;

  const SpaceXState._();

  /// Factory for initial state
  factory SpaceXState.initial() => const SpaceXState();

  /// Check if any data is loading
  bool get isLoading =>
      pastLaunchesStatus == SpaceXStatus.loading ||
      upcomingLaunchesStatus == SpaceXStatus.loading ||
      latestLaunchStatus == SpaceXStatus.loading;

  /// Check if all data has been loaded successfully
  bool get hasAllDataLoaded =>
      pastLaunchesStatus == SpaceXStatus.success &&
      upcomingLaunchesStatus == SpaceXStatus.success &&
      latestLaunchStatus == SpaceXStatus.success;

  /// Check if any operation failed
  bool get hasError =>
      pastLaunchesStatus == SpaceXStatus.failure ||
      upcomingLaunchesStatus == SpaceXStatus.failure ||
      latestLaunchStatus == SpaceXStatus.failure;

  /// Get the most recent successful launches (past launches)
  List<LaunchEntity> get recentLaunches {
    return pastLaunches.take(5).toList();
  }

  /// Get the next upcoming launches
  List<LaunchEntity> get nextLaunches {
    return upcomingLaunches.take(5).toList();
  }
}

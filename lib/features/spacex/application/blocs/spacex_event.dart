part of 'spacex_bloc.dart';

/// Events for SpaceX BLoC
@freezed
class SpaceXEvent with _$SpaceXEvent {
  /// Load past launches
  const factory SpaceXEvent.loadPastLaunches({
    @Default(10) int limit,
    @Default(0) int offset,
  }) = _LoadPastLaunches;

  /// Load upcoming launches
  const factory SpaceXEvent.loadUpcomingLaunches({
    @Default(10) int limit,
    @Default(0) int offset,
  }) = _LoadUpcomingLaunches;

  /// Load latest launch
  const factory SpaceXEvent.loadLatestLaunch() = _LoadLatestLaunch;

  /// Load all data at once
  const factory SpaceXEvent.loadAllData() = _LoadAllData;

  /// Refresh all data
  const factory SpaceXEvent.refreshData() = _RefreshData;
}

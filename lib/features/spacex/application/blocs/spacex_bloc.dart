import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:robbie_starter/core/errors/failures.dart';
import 'package:robbie_starter/features/spacex/domain/entities/launch_entity.dart';
import 'package:robbie_starter/features/spacex/domain/usecases/get_latest_launch.dart';
import 'package:robbie_starter/features/spacex/domain/usecases/get_past_launches.dart';
import 'package:robbie_starter/features/spacex/domain/usecases/get_upcoming_launches.dart';
import 'package:robbie_starter/shared/application/use_cases/base_use_case.dart';

part 'spacex_bloc.freezed.dart';
part 'spacex_event.dart';
part 'spacex_state.dart';

/// BLoC for managing SpaceX data
@injectable
class SpaceXBloc extends Bloc<SpaceXEvent, SpaceXState> {
  SpaceXBloc(
    this._getPastLaunches,
    this._getUpcomingLaunches,
    this._getLatestLaunch,
  ) : super(SpaceXState.initial()) {
    on<_LoadPastLaunches>(_onLoadPastLaunches);
    on<_LoadUpcomingLaunches>(_onLoadUpcomingLaunches);
    on<_LoadLatestLaunch>(_onLoadLatestLaunch);
    on<_LoadAllData>(_onLoadAllData);
    on<_RefreshData>(_onRefreshData);
  }

  final GetPastLaunches _getPastLaunches;
  final GetUpcomingLaunches _getUpcomingLaunches;
  final GetLatestLaunch _getLatestLaunch;

  Future<void> _onLoadPastLaunches(
    _LoadPastLaunches event,
    Emitter<SpaceXState> emit,
  ) async {
    emit(state.copyWith(pastLaunchesStatus: SpaceXStatus.loading));

    final result = await _getPastLaunches(
      GetPastLaunchesParams(
        limit: event.limit,
        offset: event.offset,
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          pastLaunchesStatus: SpaceXStatus.failure,
          errorMessage: _mapFailureToMessage(failure),
        ),
      ),
      (launches) => emit(
        state.copyWith(
          pastLaunchesStatus: SpaceXStatus.success,
          pastLaunches: launches,
        ),
      ),
    );
  }

  Future<void> _onLoadUpcomingLaunches(
    _LoadUpcomingLaunches event,
    Emitter<SpaceXState> emit,
  ) async {
    emit(state.copyWith(upcomingLaunchesStatus: SpaceXStatus.loading));

    final result = await _getUpcomingLaunches(
      GetUpcomingLaunchesParams(
        limit: event.limit,
        offset: event.offset,
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          upcomingLaunchesStatus: SpaceXStatus.failure,
          errorMessage: _mapFailureToMessage(failure),
        ),
      ),
      (launches) => emit(
        state.copyWith(
          upcomingLaunchesStatus: SpaceXStatus.success,
          upcomingLaunches: launches,
        ),
      ),
    );
  }

  Future<void> _onLoadLatestLaunch(
    _LoadLatestLaunch event,
    Emitter<SpaceXState> emit,
  ) async {
    emit(state.copyWith(latestLaunchStatus: SpaceXStatus.loading));

    final result = await _getLatestLaunch(const NoParams());

    result.fold(
      (failure) => emit(
        state.copyWith(
          latestLaunchStatus: SpaceXStatus.failure,
          errorMessage: _mapFailureToMessage(failure),
        ),
      ),
      (launch) => emit(
        state.copyWith(
          latestLaunchStatus: SpaceXStatus.success,
          latestLaunch: launch,
        ),
      ),
    );
  }

  Future<void> _onLoadAllData(
    _LoadAllData event,
    Emitter<SpaceXState> emit,
  ) async {
    emit(
      SpaceXState.initial().copyWith(
        pastLaunchesStatus: SpaceXStatus.loading,
        upcomingLaunchesStatus: SpaceXStatus.loading,
        latestLaunchStatus: SpaceXStatus.loading,
      ),
    );

    // Load all data in parallel
    final results = await Future.wait([
      _getPastLaunches(const GetPastLaunchesParams()),
      _getUpcomingLaunches(const GetUpcomingLaunchesParams()),
      _getLatestLaunch(const NoParams()),
    ]);

    final pastLaunchesResult = results[0];
    final upcomingLaunchesResult = results[1];
    final latestLaunchResult = results[2];

    var newState = state;

    // Handle past launches result
    pastLaunchesResult.fold(
      (failure) => newState = newState.copyWith(
        pastLaunchesStatus: SpaceXStatus.failure,
        errorMessage: _mapFailureToMessage(failure),
      ),
      (launches) => newState = newState.copyWith(
        pastLaunchesStatus: SpaceXStatus.success,
        pastLaunches: launches! as List<LaunchEntity>,
      ),
    );

    // Handle upcoming launches result
    upcomingLaunchesResult.fold(
      (failure) => newState = newState.copyWith(
        upcomingLaunchesStatus: SpaceXStatus.failure,
        errorMessage: _mapFailureToMessage(failure),
      ),
      (launches) => newState = newState.copyWith(
        upcomingLaunchesStatus: SpaceXStatus.success,
        upcomingLaunches: launches! as List<LaunchEntity>,
      ),
    );

    // Handle latest launch result
    latestLaunchResult.fold(
      (failure) => newState = newState.copyWith(
        latestLaunchStatus: SpaceXStatus.failure,
        errorMessage: _mapFailureToMessage(failure),
      ),
      (launch) => newState = newState.copyWith(
        latestLaunchStatus: SpaceXStatus.success,
        latestLaunch: launch as LaunchEntity?,
      ),
    );

    emit(newState);
  }

  Future<void> _onRefreshData(
    _RefreshData event,
    Emitter<SpaceXState> emit,
  ) async {
    add(const SpaceXEvent.loadAllData());
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return 'Network error. Please check your connection.';
      case ServerFailure:
        return 'Server error. Please try again later.';
      default:
        return 'An unexpected error occurred.';
    }
  }
}

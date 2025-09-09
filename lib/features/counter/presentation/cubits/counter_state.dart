part of 'counter_cubit.dart';

@freezed
class CounterState with _$CounterState {
  /// Initial state
  const factory CounterState.initial() = CounterInitial;

  /// Loading state
  const factory CounterState.loading() = CounterLoading;

  /// Loaded state with counter data
  const factory CounterState.loaded(CounterEntity counter) = CounterLoaded;

  /// Error state
  const factory CounterState.error(String message) = CounterError;
}

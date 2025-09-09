import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shemanit/core/utils/logger.dart';
import 'package:shemanit/features/counter/application/use_cases/decrement_counter_use_case.dart';
import 'package:shemanit/features/counter/application/use_cases/get_counter_use_case.dart';
import 'package:shemanit/features/counter/application/use_cases/increment_counter_use_case.dart';
import 'package:shemanit/features/counter/application/use_cases/reset_counter_use_case.dart';
import 'package:shemanit/features/counter/domain/entities/counter_entity.dart';
import 'package:shemanit/shared/application/use_cases/base_use_case.dart';

part 'counter_cubit.freezed.dart';
part 'counter_state.dart';

@singleton
class CounterCubit extends Cubit<CounterState> {
  CounterCubit(
    this._getCounterUseCase,
    this._incrementCounterUseCase,
    this._decrementCounterUseCase,
    this._resetCounterUseCase,
  ) : super(const CounterState.initial()) {
    loadCounter();
  }

  final GetCounterUseCase _getCounterUseCase;
  final IncrementCounterUseCase _incrementCounterUseCase;
  final DecrementCounterUseCase _decrementCounterUseCase;
  final ResetCounterUseCase _resetCounterUseCase;

  /// Load current counter
  Future<void> loadCounter() async {
    emit(const CounterState.loading());

    final result = await _getCounterUseCase(const NoParams());

    result.fold(
      (failure) {
        Logger.error('Failed to load counter: ${failure.message}');
        emit(CounterState.error(failure.message ?? 'Unknown error'));
      },
      (counter) {
        Logger.info('Counter loaded successfully');
        emit(CounterState.loaded(counter));
      },
    );
  }

  /// Increment counter
  Future<void> increment() async {
    final currentState = state;
    if (currentState is! CounterLoaded) return;

    emit(const CounterState.loading());

    final result = await _incrementCounterUseCase(const NoParams());

    result.fold(
      (failure) {
        Logger.error('Failed to increment counter: ${failure.message}');
        emit(CounterState.error(failure.message ?? 'Failed to increment'));
        // Restore previous state after a delay
        Future.delayed(const Duration(seconds: 2), () {
          emit(CounterState.loaded(currentState.counter));
        });
      },
      (counter) {
        Logger.info('Counter incremented to: ${counter.value}');
        emit(CounterState.loaded(counter));
      },
    );
  }

  /// Decrement counter
  Future<void> decrement() async {
    final currentState = state;
    if (currentState is! CounterLoaded) return;

    emit(const CounterState.loading());

    final result = await _decrementCounterUseCase(const NoParams());

    result.fold(
      (failure) {
        Logger.error('Failed to decrement counter: ${failure.message}');
        emit(CounterState.error(failure.message ?? 'Failed to decrement'));
        // Restore previous state after a delay
        Future.delayed(const Duration(seconds: 2), () {
          emit(CounterState.loaded(currentState.counter));
        });
      },
      (counter) {
        Logger.info('Counter decremented to: ${counter.value}');
        emit(CounterState.loaded(counter));
      },
    );
  }

  /// Reset counter
  Future<void> reset() async {
    final currentState = state;
    if (currentState is! CounterLoaded) return;

    emit(const CounterState.loading());

    final result = await _resetCounterUseCase(
      ResetCounterParams(counterId: currentState.counter.id),
    );

    result.fold(
      (failure) {
        Logger.error('Failed to reset counter: ${failure.message}');
        emit(CounterState.error(failure.message ?? 'Failed to reset'));
        // Restore previous state after a delay
        Future.delayed(const Duration(seconds: 2), () {
          emit(CounterState.loaded(currentState.counter));
        });
      },
      (counter) {
        Logger.info('Counter reset successfully');
        emit(CounterState.loaded(counter));
      },
    );
  }
}

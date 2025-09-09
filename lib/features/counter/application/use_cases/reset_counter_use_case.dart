import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shemanit/core/errors/failures.dart';
import 'package:shemanit/core/utils/logger.dart';
import 'package:shemanit/features/counter/domain/entities/counter_entity.dart';
import 'package:shemanit/features/counter/domain/repositories/counter_repository.dart';
import 'package:shemanit/shared/application/use_cases/base_use_case.dart';

/// Parameters for reset counter use case
class ResetCounterParams extends UseCaseParams {
  const ResetCounterParams({required this.counterId});

  final String counterId;

  @override
  List<Object?> get props => [counterId];
}

/// Use case for resetting counter
@singleton
class ResetCounterUseCase
    implements UseCase<CounterEntity, ResetCounterParams> {
  const ResetCounterUseCase(this._counterRepository);

  final CounterRepository _counterRepository;

  @override
  String get useCaseName => 'ResetCounterUseCase';

  @override
  Future<Either<Failure, CounterEntity>> call(ResetCounterParams params) async {
    Logger.info(
      'Executing ResetCounterUseCase for counter: ${params.counterId}',
    );

    try {
      final result = await _counterRepository.resetCounter(params.counterId);

      return result.fold(
        (failure) {
          Logger.warning('Failed to reset counter: ${failure.message}');
          return Left(failure);
        },
        (counter) {
          Logger.info('Counter reset successfully: ${counter.value}');
          return Right(counter);
        },
      );
    } catch (e, stackTrace) {
      Logger.error('Error in ResetCounterUseCase', e, stackTrace);
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}

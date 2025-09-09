import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shemanit/core/errors/failures.dart';
import 'package:shemanit/core/utils/logger.dart';
import 'package:shemanit/features/counter/domain/entities/counter_entity.dart';
import 'package:shemanit/features/counter/domain/repositories/counter_repository.dart';
import 'package:shemanit/features/counter/domain/services/counter_domain_service.dart';
import 'package:shemanit/shared/application/use_cases/base_use_case.dart';

/// Use case for decrementing counter
@singleton
class DecrementCounterUseCase implements UseCase<CounterEntity, NoParams> {
  const DecrementCounterUseCase(
    this._counterRepository,
    this._counterDomainService,
  );

  final CounterRepository _counterRepository;
  final CounterDomainService _counterDomainService;

  @override
  String get useCaseName => 'DecrementCounterUseCase';

  @override
  Future<Either<Failure, CounterEntity>> call(NoParams params) async {
    Logger.info('Executing DecrementCounterUseCase');

    try {
      // Get current counter
      final currentCounterResult = await _counterRepository.getCurrentCounter();

      return await currentCounterResult.fold(
        (failure) async => Left(failure),
        (currentCounter) async {
          // Validate decrement operation
          final validationResult =
              _counterDomainService.validateDecrement(currentCounter);

          return await validationResult.fold(
            (failure) async => Left(failure),
            (decrementedCounter) async {
              // Save updated counter
              final saveResult =
                  await _counterRepository.saveCounter(decrementedCounter);

              return saveResult.fold(
                Left.new,
                (savedCounter) {
                  Logger.info(
                    'Counter decremented successfully: ${savedCounter.value}',
                  );
                  return Right(savedCounter);
                },
              );
            },
          );
        },
      );
    } catch (e, stackTrace) {
      Logger.error('Error in DecrementCounterUseCase', e, stackTrace);
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:robbie_starter/core/errors/failures.dart';
import 'package:robbie_starter/core/utils/logger.dart';
import 'package:robbie_starter/features/counter/domain/entities/counter_entity.dart';
import 'package:robbie_starter/features/counter/domain/repositories/counter_repository.dart';
import 'package:robbie_starter/features/counter/domain/services/counter_domain_service.dart';
import 'package:robbie_starter/shared/application/use_cases/base_use_case.dart';

/// Use case for incrementing counter
@singleton
class IncrementCounterUseCase implements UseCase<CounterEntity, NoParams> {
  const IncrementCounterUseCase(
    this._counterRepository,
    this._counterDomainService,
  );

  final CounterRepository _counterRepository;
  final CounterDomainService _counterDomainService;

  @override
  String get useCaseName => 'IncrementCounterUseCase';

  @override
  Future<Either<Failure, CounterEntity>> call(NoParams params) async {
    Logger.info('Executing IncrementCounterUseCase');

    try {
      // Get current counter
      final currentCounterResult = await _counterRepository.getCurrentCounter();

      return await currentCounterResult.fold(
        (failure) async => Left(failure),
        (currentCounter) async {
          // Validate increment operation
          final validationResult =
              _counterDomainService.validateIncrement(currentCounter);

          return await validationResult.fold(
            (failure) async => Left(failure),
            (incrementedCounter) async {
              // Save updated counter
              final saveResult =
                  await _counterRepository.saveCounter(incrementedCounter);

              return saveResult.fold(
                Left.new,
                (savedCounter) {
                  Logger.info(
                    'Counter incremented successfully: ${savedCounter.value}',
                  );

                  // Check for milestone
                  if (_counterDomainService.hasReachedMilestone(savedCounter)) {
                    Logger.info('Milestone reached: ${savedCounter.value}');
                  }

                  return Right(savedCounter);
                },
              );
            },
          );
        },
      );
    } catch (e, stackTrace) {
      Logger.error('Error in IncrementCounterUseCase', e, stackTrace);
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}

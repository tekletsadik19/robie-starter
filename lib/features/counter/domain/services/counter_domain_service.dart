import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shemanit/core/errors/failures.dart';
import 'package:shemanit/features/counter/domain/entities/counter_entity.dart';
import 'package:shemanit/features/counter/domain/value_objects/counter_value.dart';
import 'package:shemanit/shared/domain/services/base_domain_service.dart';

/// Domain service for counter business logic
@singleton
class CounterDomainService extends BaseDomainService
    with DomainServiceValidation {
  @override
  String get serviceName => 'CounterDomainService';

  /// Validate if counter can be incremented
  Either<ValidationFailure, CounterEntity> validateIncrement(
    CounterEntity counter,
  ) {
    final newValue = counter.value + 1;
    return CounterValue.create(newValue).fold(
      Left.new,
      (counterValue) => Right(counter.increment()),
    );
  }

  /// Validate if counter can be decremented
  Either<ValidationFailure, CounterEntity> validateDecrement(
    CounterEntity counter,
  ) {
    final newValue = counter.value - 1;
    return CounterValue.create(newValue).fold(
      Left.new,
      (counterValue) => Right(counter.decrement()),
    );
  }

  /// Check if counter has reached a milestone
  bool hasReachedMilestone(CounterEntity counter) =>
      counter.value % 10 == 0 && counter.value > 0;

  /// Calculate counter statistics
  CounterStatistics calculateStatistics(List<CounterEntity> history) {
    if (history.isEmpty) {
      return const CounterStatistics(
        totalOperations: 0,
        maxValue: 0,
        minValue: 0,
        averageValue: 0,
      );
    }

    final values = history.map((e) => e.value).toList();
    final maxValue = values.reduce((a, b) => a > b ? a : b);
    final minValue = values.reduce((a, b) => a < b ? a : b);
    final averageValue = values.reduce((a, b) => a + b) / values.length;

    return CounterStatistics(
      totalOperations: history.length,
      maxValue: maxValue,
      minValue: minValue,
      averageValue: averageValue,
    );
  }
}

/// Counter statistics value object
class CounterStatistics {
  const CounterStatistics({
    required this.totalOperations,
    required this.maxValue,
    required this.minValue,
    required this.averageValue,
  });

  final int totalOperations;
  final int maxValue;
  final int minValue;
  final double averageValue;
}

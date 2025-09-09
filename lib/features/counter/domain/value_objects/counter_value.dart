import 'package:dartz/dartz.dart';
import 'package:robbie_starter/core/errors/failures.dart';
import 'package:robbie_starter/shared/domain/value_objects/base_value_object.dart';

/// Counter value object with validation
class CounterValue extends ValidatedValueObject<int> {
  const CounterValue._(super.value);

  /// Factory constructor with validation
  static Either<ValidationFailure, CounterValue> create(int value) =>
      _validate(value).map(CounterValue._);

  /// Validate counter value
  static Either<ValidationFailure, int> _validate(int value) {
    // Counter can be negative, but let's set reasonable bounds
    if (value < -1000000) {
      return const Left(
        ValidationFailure(
          message: 'Counter value cannot be less than -1,000,000',
        ),
      );
    }

    if (value > 1000000) {
      return const Left(
        ValidationFailure(message: 'Counter value cannot exceed 1,000,000'),
      );
    }

    return Right(value);
  }

  @override
  Either<ValidationFailure, ValidatedValueObject<int>> validate() =>
      _validate(value).map(CounterValue._);

  /// Create initial counter value (zero)
  static CounterValue get initial => const CounterValue._(0);

  /// Check if counter is at zero
  bool get isZero => value == 0;

  /// Check if counter is positive
  bool get isPositive => value > 0;

  /// Check if counter is negative
  bool get isNegative => value < 0;
}

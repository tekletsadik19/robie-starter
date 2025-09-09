import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shemanit/core/errors/failures.dart';

/// Base class for all value objects
abstract class BaseValueObject<T> extends Equatable {
  const BaseValueObject(this.value);

  final T value;

  @override
  List<Object?> get props => [value];

  @override
  String toString() => '$runtimeType($value)';
}

/// Base class for validated value objects
abstract class ValidatedValueObject<T> extends BaseValueObject<T> {
  const ValidatedValueObject(super.value);

  /// Validates the value and returns either a failure or the value object
  static Either<ValidationFailure, ValidatedValueObject<T>> create<T>(
    T value,
    Either<ValidationFailure, ValidatedValueObject<T>> Function(T) validator,
  ) =>
      validator(value);

  /// Abstract validation method to be implemented by subclasses
  Either<ValidationFailure, ValidatedValueObject<T>> validate();
}

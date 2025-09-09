import 'package:dartz/dartz.dart';
import 'package:robbie_starter/core/errors/failures.dart';

/// Collection of input validation functions
class InputValidators {
  /// Validate email format
  static Either<ValidationFailure, String> validateEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (email.isEmpty) {
      return const Left(ValidationFailure(message: 'Email cannot be empty'));
    }

    if (!emailRegex.hasMatch(email)) {
      return const Left(ValidationFailure(message: 'Invalid email format'));
    }

    return Right(email);
  }

  /// Validate password strength
  static Either<ValidationFailure, String> validatePassword(String password) {
    if (password.isEmpty) {
      return const Left(ValidationFailure(message: 'Password cannot be empty'));
    }

    if (password.length < 8) {
      return const Left(
        ValidationFailure(message: 'Password must be at least 8 characters'),
      );
    }

    if (!password.contains(RegExp('[A-Z]'))) {
      return const Left(
        ValidationFailure(message: 'Password must contain uppercase letter'),
      );
    }

    if (!password.contains(RegExp('[a-z]'))) {
      return const Left(
        ValidationFailure(message: 'Password must contain lowercase letter'),
      );
    }

    if (!password.contains(RegExp('[0-9]'))) {
      return const Left(
        ValidationFailure(message: 'Password must contain a number'),
      );
    }

    return Right(password);
  }

  /// Validate required string
  static Either<ValidationFailure, String> validateRequired(
    String value,
    String fieldName,
  ) {
    if (value.trim().isEmpty) {
      return Left(
        ValidationFailure(message: '$fieldName cannot be empty'),
      );
    }
    return Right(value.trim());
  }

  /// Validate string length
  static Either<ValidationFailure, String> validateLength(
    String value,
    int minLength,
    int maxLength,
    String fieldName,
  ) {
    if (value.length < minLength) {
      return Left(
        ValidationFailure(
          message: '$fieldName must be at least $minLength characters',
        ),
      );
    }

    if (value.length > maxLength) {
      return Left(
        ValidationFailure(
          message: '$fieldName must not exceed $maxLength characters',
        ),
      );
    }

    return Right(value);
  }

  /// Validate positive number
  static Either<ValidationFailure, int> validatePositiveNumber(int value) {
    if (value < 0) {
      return const Left(
        ValidationFailure(message: 'Value must be positive'),
      );
    }
    return Right(value);
  }
}

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:robbie_starter/core/errors/failures.dart';

/// Base class for all use cases
/// Enforces the single responsibility principle and provides consistent error handling
abstract class UseCase<Type, Params extends UseCaseParams> {
  /// Execute the use case
  Future<Either<Failure, Type>> call(Params params);

  /// Use case identifier for logging and monitoring
  String get useCaseName => runtimeType.toString();
}

/// Base class for use cases that don't require parameters
abstract class NoParamsUseCase<Type> extends UseCase<Type, NoParams> {
  /// Execute the use case without parameters
  Future<Either<Failure, Type>> execute();

  @override
  Future<Either<Failure, Type>> call(NoParams params) => execute();
}

/// Base class for use case parameters
abstract class UseCaseParams extends Equatable {
  const UseCaseParams();
}

/// No parameters class for use cases that don't need parameters
class NoParams extends UseCaseParams {
  const NoParams();

  @override
  List<Object?> get props => [];
}

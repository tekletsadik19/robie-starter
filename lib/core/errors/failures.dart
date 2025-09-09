import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
abstract class Failure extends Equatable {
  const Failure({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

/// Server failure
class ServerFailure extends Failure {
  const ServerFailure({super.message});
}

/// Cache failure
class CacheFailure extends Failure {
  const CacheFailure({super.message});
}

/// Network failure
class NetworkFailure extends Failure {
  const NetworkFailure({super.message});
}

/// Validation failure
class ValidationFailure extends Failure {
  const ValidationFailure({super.message});
}

/// Authentication failure
class AuthenticationFailure extends Failure {
  const AuthenticationFailure({super.message});
}

/// Authorization failure
class AuthorizationFailure extends Failure {
  const AuthorizationFailure({super.message});
}

/// Not found failure
class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message});
}

/// Unexpected failure
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({super.message});
}

/// Base class for all exceptions in the application
abstract class AppException implements Exception {
  const AppException({this.message});

  final String? message;

  @override
  String toString() => '$runtimeType: ${message ?? 'Unknown error occurred'}';
}

/// Server exception
class ServerException extends AppException {
  const ServerException({super.message});
}

/// Cache exception
class CacheException extends AppException {
  const CacheException({super.message});
}

/// Network exception
class NetworkException extends AppException {
  const NetworkException({super.message});
}

/// Validation exception
class ValidationException extends AppException {
  const ValidationException({super.message});
}

/// Authentication exception
class AuthenticationException extends AppException {
  const AuthenticationException({super.message});
}

/// Authorization exception
class AuthorizationException extends AppException {
  const AuthorizationException({super.message});
}

/// Not found exception
class NotFoundException extends AppException {
  const NotFoundException({super.message});
}

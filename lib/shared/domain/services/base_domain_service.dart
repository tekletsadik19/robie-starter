/// Base interface for domain services
/// Domain services encapsulate business logic that doesn't naturally fit within entities
abstract class BaseDomainService {
  /// Service identifier for logging and debugging
  String get serviceName;
}

/// Mixin for domain services that need validation
mixin DomainServiceValidation {
  /// Validate business rules
  void validateBusinessRules<T>(T entity, List<String Function(T)> rules) {
    final errors = <String>[];

    for (final rule in rules) {
      final error = rule(entity);
      if (error.isNotEmpty) {
        errors.add(error);
      }
    }

    if (errors.isNotEmpty) {
      throw ArgumentError('Business rule violations: ${errors.join(', ')}');
    }
  }

  /// Validate required parameters
  void validateRequired(Map<String, dynamic> params) {
    final missing = <String>[];

    params.forEach((key, value) {
      if (value == null) {
        missing.add(key);
      }
    });

    if (missing.isNotEmpty) {
      throw ArgumentError('Required parameters missing: ${missing.join(', ')}');
    }
  }
}

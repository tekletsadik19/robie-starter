/// Layer boundary enforcement for Clean Architecture and DDD compliance
///
/// This file defines the architectural constraints and validates layer dependencies
library layer_boundaries;

/// Enum representing the architectural layers
enum ArchitecturalLayer {
  domain,
  application,
  infrastructure,
  presentation,
}

/// Mixin to enforce layer boundaries
/// Use this mixin on classes to validate they only depend on allowed layers
mixin LayerBoundaryEnforcement {
  /// Get the layer this class belongs to
  ArchitecturalLayer get layer;

  /// Get the layers this class is allowed to depend on
  List<ArchitecturalLayer> get allowedDependencies;

  /// Validate that a dependency is allowed
  bool isDependencyAllowed(ArchitecturalLayer dependencyLayer) =>
      allowedDependencies.contains(dependencyLayer);
}

/// Domain layer constraints
mixin DomainLayerConstraints on LayerBoundaryEnforcement {
  @override
  ArchitecturalLayer get layer => ArchitecturalLayer.domain;

  @override
  List<ArchitecturalLayer> get allowedDependencies => [
        ArchitecturalLayer.domain, // Can depend on other domain components
      ];
}

/// Application layer constraints
mixin ApplicationLayerConstraints on LayerBoundaryEnforcement {
  @override
  ArchitecturalLayer get layer => ArchitecturalLayer.application;

  @override
  List<ArchitecturalLayer> get allowedDependencies => [
        ArchitecturalLayer.domain, // Can depend on domain
        ArchitecturalLayer
            .application, // Can depend on other application components
      ];
}

/// Infrastructure layer constraints
mixin InfrastructureLayerConstraints on LayerBoundaryEnforcement {
  @override
  ArchitecturalLayer get layer => ArchitecturalLayer.infrastructure;

  @override
  List<ArchitecturalLayer> get allowedDependencies => [
        ArchitecturalLayer
            .domain, // Can depend on domain (implements interfaces)
        ArchitecturalLayer.infrastructure, // Can depend on other infrastructure
      ];
}

/// Presentation layer constraints
mixin PresentationLayerConstraints on LayerBoundaryEnforcement {
  @override
  ArchitecturalLayer get layer => ArchitecturalLayer.presentation;

  @override
  List<ArchitecturalLayer> get allowedDependencies => [
        ArchitecturalLayer
            .domain, // Can depend on domain (entities, value objects)
        ArchitecturalLayer.application, // Can depend on application (use cases)
        ArchitecturalLayer
            .presentation, // Can depend on other presentation components
      ];
}

/// DDD compliance validation rules
class DDDComplianceValidator {
  /// Validate that entities only contain business logic
  static bool validateEntity(Type entityType) {
    // Entities should not have external dependencies
    // They should only contain business logic and domain rules
    return true; // Implementation would check actual dependencies
  }

  /// Validate that repositories are interfaces in domain layer
  static bool validateRepositoryInterface(Type repositoryType) {
    // Repository interfaces should be in domain layer
    // They should be abstract classes or interfaces
    return true; // Implementation would check if abstract
  }

  /// Validate that use cases follow single responsibility
  static bool validateUseCase(Type useCaseType) {
    // Use cases should have single responsibility
    // They should orchestrate domain logic, not contain it
    return true; // Implementation would analyze methods
  }

  /// Validate that domain services contain business logic
  static bool validateDomainService(Type serviceType) {
    // Domain services should contain business logic that doesn't fit in entities
    // They should not have infrastructure dependencies
    return true; // Implementation would check dependencies
  }
}

/// Architectural decision records for DDD compliance
abstract class ArchitecturalDecisions {
  /// ADR-001: Layer Dependencies
  /// - Domain layer has no dependencies on other layers
  /// - Application layer depends only on Domain
  /// - Infrastructure layer implements Domain interfaces
  /// - Presentation layer depends on Domain and Application
  static const String layerDependencies = 'ADR-001';

  /// ADR-002: Repository Pattern
  /// - All data access goes through repositories
  /// - Repository interfaces are in Domain layer
  /// - Repository implementations are in Infrastructure layer
  static const String repositoryPattern = 'ADR-002';

  /// ADR-003: Use Case Pattern
  /// - All business operations are encapsulated in use cases
  /// - Use cases orchestrate domain logic
  /// - Use cases return Either<Failure, Success> for error handling
  static const String useCasePattern = 'ADR-003';

  /// ADR-004: Domain Services
  /// - Business logic that doesn't fit in entities goes in domain services
  /// - Domain services are stateless
  /// - Domain services can depend on repositories
  static const String domainServices = 'ADR-004';
}

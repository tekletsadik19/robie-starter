import 'package:dartz/dartz.dart';
import 'package:shemanit/core/errors/failures.dart';

/// Base repository interface with common CRUD operations
abstract class BaseRepository<T, ID> {
  /// Get entity by ID
  Future<Either<Failure, T>> getById(ID id);

  /// Get all entities with optional pagination
  Future<Either<Failure, List<T>>> getAll({
    int? limit,
    int? offset,
    Map<String, dynamic>? filters,
  });

  /// Create a new entity
  Future<Either<Failure, T>> create(T entity);

  /// Update an existing entity
  Future<Either<Failure, T>> update(T entity);

  /// Delete an entity by ID
  Future<Either<Failure, bool>> delete(ID id);

  /// Check if entity exists
  Future<Either<Failure, bool>> exists(ID id);
}

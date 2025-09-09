import 'package:robbie_starter/core/errors/exceptions.dart';

/// Base interface for all data sources
/// Enforces consistent error handling and operation patterns
abstract class BaseDataSource<T, ID> {
  /// Get entity by ID
  Future<T> getById(ID id);

  /// Get all entities with optional filters
  Future<List<T>> getAll({Map<String, dynamic>? filters});

  /// Create or update entity
  Future<void> save(T entity);

  /// Delete entity by ID
  Future<void> delete(ID id);

  /// Check if entity exists
  Future<bool> exists(ID id);

  /// Clear all data
  Future<void> clear();
}

/// Base interface for local data sources (caching, offline storage)
abstract class BaseLocalDataSource<T, ID> extends BaseDataSource<T, ID> {
  /// Get cached entity by ID
  Future<T> getCached(ID id);

  /// Cache entity
  Future<void> cache(T entity);

  /// Clear cache
  Future<void> clearCache();

  /// Check if data is cached and valid
  Future<bool> isCached(ID id);
}

/// Base interface for remote data sources (APIs, web services)
abstract class BaseRemoteDataSource<T, ID> extends BaseDataSource<T, ID> {
  /// Fetch entity from remote source
  Future<T> fetch(ID id);

  /// Push entity to remote source
  Future<T> push(T entity);

  /// Sync with remote source
  Future<List<T>> sync({DateTime? lastSync});

  /// Check connectivity
  Future<bool> isConnected();
}

/// Mixin for data sources that need validation
mixin DataSourceValidation<T> {
  /// Validate entity before operations
  void validateEntity(T entity) {
    if (entity == null) {
      throw const ValidationException(message: 'Entity cannot be null');
    }
  }

  /// Validate ID before operations
  void validateId<ID>(ID id) {
    if (id == null) {
      throw const ValidationException(message: 'ID cannot be null');
    }
  }
}

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:robbie_starter/core/errors/exceptions.dart';
import 'package:robbie_starter/core/utils/logger.dart';
import 'package:robbie_starter/features/counter/infrastructure/models/counter_model.dart';
import 'package:robbie_starter/shared/infrastructure/datasources/base_data_source.dart';
import 'package:robbie_starter/shared/infrastructure/security/encryption_service.dart';

/// Local data source for counter persistence
/// Extends BaseLocalDataSource to enforce consistent patterns
abstract class CounterLocalDataSource
    extends BaseLocalDataSource<CounterModel, String> {
  /// Get cached counter
  Future<CounterModel> getCachedCounter();

  /// Cache counter
  Future<void> cacheCounter(CounterModel counter);

  /// Get counter history
  Future<List<CounterModel>> getCachedCounterHistory();

  /// Add counter to history
  Future<void> addToHistory(CounterModel counter);
}

@Singleton(as: CounterLocalDataSource)
class CounterLocalDataSourceImpl extends CounterLocalDataSource
    with DataSourceValidation<CounterModel> {
  CounterLocalDataSourceImpl(this._encryptionManager);

  final HiveEncryptionManager _encryptionManager;

  static const String _counterBoxName = 'counter_box';
  static const String _counterKey = 'CACHED_COUNTER';
  static const String _historyKey = 'COUNTER_HISTORY';

  Box<String>? _counterBox;

  /// Get or open the counter box
  Future<Box<String>> get counterBox async {
    if (_counterBox?.isOpen == true) return _counterBox!;

    final config = _encryptionManager.createSecureBoxConfig(_counterBoxName);
    _counterBox = await Hive.openBox<String>(
      config.name,
      encryptionCipher: config.cipher,
      compactionStrategy: config.compactionStrategy ??
          (entries, deletedEntries) => deletedEntries > 50,
    );
    return _counterBox!;
  }

  @override
  Future<CounterModel> getCachedCounter() async {
    try {
      final box = await counterBox;
      final jsonString = box.get(_counterKey);

      if (jsonString == null) {
        // Return default counter if none exists
        final defaultCounter = CounterModel(
          id: 'default',
          value: 0,
          createdAt: DateTime.now(),
        );
        await cacheCounter(defaultCounter);
        return defaultCounter;
      }

      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return CounterModel.fromJson(jsonMap);
    } catch (e) {
      Logger.error('Error getting cached counter', e);
      throw const CacheException(message: 'Failed to get cached counter');
    }
  }

  @override
  Future<void> cacheCounter(CounterModel counter) async {
    try {
      final box = await counterBox;
      final jsonString = json.encode(counter.toJson());
      await box.put(_counterKey, jsonString);
      Logger.debug('Counter cached successfully');
    } catch (e) {
      Logger.error('Error caching counter', e);
      throw const CacheException(message: 'Failed to cache counter');
    }
  }

  @override
  Future<List<CounterModel>> getCachedCounterHistory() async {
    try {
      final box = await counterBox;
      final jsonString = box.get(_historyKey);

      if (jsonString == null) {
        return [];
      }

      final jsonList = json.decode(jsonString) as List<dynamic>;
      return jsonList
          .map((json) => CounterModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      Logger.error('Error getting counter history', e);
      throw const CacheException(message: 'Failed to get counter history');
    }
  }

  @override
  Future<void> addToHistory(CounterModel counter) async {
    try {
      final currentHistory = await getCachedCounterHistory();
      currentHistory.add(counter);

      // Keep only last 100 entries
      if (currentHistory.length > 100) {
        currentHistory.removeRange(0, currentHistory.length - 100);
      }

      final box = await counterBox;
      final jsonString = json.encode(
        currentHistory.map((model) => model.toJson()).toList(),
      );
      await box.put(_historyKey, jsonString);
      Logger.debug('Counter added to history');
    } catch (e) {
      Logger.error('Error adding to counter history', e);
      throw const CacheException(message: 'Failed to add to counter history');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      final box = await counterBox;
      await box.delete(_counterKey);
      await box.delete(_historyKey);
      Logger.debug('Counter cache cleared');
    } catch (e) {
      Logger.error('Error clearing counter cache', e);
      throw const CacheException(message: 'Failed to clear counter cache');
    }
  }

  // Base data source method implementations
  @override
  Future<CounterModel> getById(String id) async {
    validateId(id);
    return getCachedCounter();
  }

  @override
  Future<List<CounterModel>> getAll({Map<String, dynamic>? filters}) async =>
      getCachedCounterHistory();

  @override
  Future<void> save(CounterModel entity) async {
    validateEntity(entity);
    await cacheCounter(entity);
  }

  @override
  Future<void> delete(String id) async {
    validateId(id);
    await clearCache();
  }

  @override
  Future<bool> exists(String id) async {
    validateId(id);
    try {
      await getCachedCounter();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> clear() async {
    await clearCache();
  }

  @override
  Future<CounterModel> getCached(String id) async {
    validateId(id);
    return getCachedCounter();
  }

  @override
  Future<void> cache(CounterModel entity) async {
    validateEntity(entity);
    await cacheCounter(entity);
  }

  @override
  Future<bool> isCached(String id) async {
    validateId(id);
    return exists(id);
  }
}

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:robbie_starter/core/constants/app_constants.dart';
import 'package:robbie_starter/core/errors/exceptions.dart';
import 'package:robbie_starter/core/utils/logger.dart';
import 'package:robbie_starter/shared/infrastructure/security/encryption_service.dart';

/// Cache entry with expiration
class CacheEntry<T> {
  const CacheEntry({
    required this.data,
    required this.timestamp,
    this.ttl = AppConstants.cacheTimeout,
  });

  /// Create from JSON
  factory CacheEntry.fromJson(Map<String, dynamic> json) => CacheEntry<T>(
        data: json['data'] as T,
        timestamp: DateTime.parse(json['timestamp'] as String),
        ttl: Duration(milliseconds: json['ttl'] as int),
      );

  final T data;
  final DateTime timestamp;
  final Duration ttl;

  /// Check if cache entry is expired
  bool get isExpired => DateTime.now().difference(timestamp) > ttl;

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
        'data': data,
        'timestamp': timestamp.toIso8601String(),
        'ttl': ttl.inMilliseconds,
      };
}

/// Cache manager interface
abstract class CacheManager {
  /// Store data in cache
  Future<void> store<T>(String key, T data, {Duration? ttl});

  /// Retrieve data from cache
  Future<T?> retrieve<T>(String key);

  /// Remove data from cache
  Future<void> remove(String key);

  /// Check if key exists and is not expired
  Future<bool> contains(String key);

  /// Clear all cache
  Future<void> clear();

  /// Clear expired entries
  Future<void> clearExpired();
}

@Singleton(as: CacheManager)
class CacheManagerImpl implements CacheManager {
  CacheManagerImpl(this._encryptionManager);

  final HiveEncryptionManager _encryptionManager;
  static const String _cacheBoxName = 'cache_box';

  Box<String>? _cacheBox;

  /// Get or open the cache box
  Future<Box<String>> get cacheBox async {
    if (_cacheBox?.isOpen == true) return _cacheBox!;

    final config = _encryptionManager.createSecureBoxConfig(_cacheBoxName);
    _cacheBox = await Hive.openBox<String>(
      config.name,
      encryptionCipher: config.cipher,
      compactionStrategy: config.compactionStrategy ??
          (entries, deletedEntries) => deletedEntries > 50,
    );
    return _cacheBox!;
  }

  @override
  Future<void> store<T>(String key, T data, {Duration? ttl}) async {
    try {
      final box = await cacheBox;
      final cacheEntry = CacheEntry<T>(
        data: data,
        timestamp: DateTime.now(),
        ttl: ttl ?? AppConstants.cacheTimeout,
      );

      final jsonString = json.encode(cacheEntry.toJson());
      await box.put(key, jsonString);

      Logger.debug('Data cached for key: $key');
    } catch (e) {
      Logger.error('Error caching data', e);
      throw const CacheException(message: 'Failed to cache data');
    }
  }

  @override
  Future<T?> retrieve<T>(String key) async {
    try {
      final box = await cacheBox;
      final jsonString = box.get(key);
      if (jsonString == null) return null;

      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      final cacheEntry = CacheEntry<T>.fromJson(jsonMap);

      if (cacheEntry.isExpired) {
        await remove(key);
        Logger.debug('Cache entry expired and removed: $key');
        return null;
      }

      Logger.debug('Data retrieved from cache: $key');
      return cacheEntry.data;
    } catch (e) {
      Logger.error('Error retrieving cached data', e);
      throw const CacheException(message: 'Failed to retrieve cached data');
    }
  }

  @override
  Future<void> remove(String key) async {
    try {
      final box = await cacheBox;
      await box.delete(key);
      Logger.debug('Cache entry removed: $key');
    } catch (e) {
      Logger.error('Error removing cached data', e);
      throw const CacheException(message: 'Failed to remove cached data');
    }
  }

  @override
  Future<bool> contains(String key) async {
    try {
      final box = await cacheBox;
      final jsonString = box.get(key);
      if (jsonString == null) return false;

      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      final cacheEntry = CacheEntry<dynamic>.fromJson(jsonMap);

      if (cacheEntry.isExpired) {
        await remove(key);
        return false;
      }

      return true;
    } catch (e) {
      Logger.error('Error checking cache existence', e);
      return false;
    }
  }

  @override
  Future<void> clear() async {
    try {
      final box = await cacheBox;
      await box.clear();
      Logger.debug('All cache cleared');
    } catch (e) {
      Logger.error('Error clearing cache', e);
      throw const CacheException(message: 'Failed to clear cache');
    }
  }

  @override
  Future<void> clearExpired() async {
    try {
      final box = await cacheBox;
      final keys = box.keys.toList();
      var removedCount = 0;

      for (final key in keys) {
        final jsonString = box.get(key);
        if (jsonString == null) continue;

        try {
          final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
          final cacheEntry = CacheEntry<dynamic>.fromJson(jsonMap);

          if (cacheEntry.isExpired) {
            await box.delete(key);
            removedCount++;
          }
        } catch (e) {
          // Remove corrupted entries
          await box.delete(key);
          removedCount++;
        }
      }

      Logger.debug('Cleared $removedCount expired cache entries');
    } catch (e) {
      Logger.error('Error clearing expired cache', e);
      throw const CacheException(message: 'Failed to clear expired cache');
    }
  }
}

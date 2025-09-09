// ignore_for_file: avoid_annotating_with_dynamic

import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

/// Cache service interface
abstract class CacheService {
  Future<void> initialize();
  Future<void> dispose();

  // Basic operations
  Future<void> put<T>(String key, T value);
  Future<T?> get<T>(String key);
  Future<void> delete(String key);
  Future<void> clear();
  Future<bool> exists(String key);

  // Bulk operations
  Future<void> putAll<T>(Map<String, T> entries);
  Future<Map<String, T?>> getAll<T>(List<String> keys);
  Future<void> deleteAll(List<String> keys);

  // Cache with expiration
  Future<void> putWithExpiration<T>(String key, T value, Duration expiration);
  Future<T?> getWithExpirationCheck<T>(String key);

  // Cache info
  Future<List<String>> getAllKeys();
  Future<int> getSize();
  Future<void> compact();
}

/// Hive-based cache service implementation
@Singleton(as: CacheService)
class HiveCacheService implements CacheService {
  late Box<dynamic> _cacheBox;
  late Box<DateTime> _expirationBox;

  static const String _cacheBoxName = 'app_cache';
  static const String _expirationBoxName = 'cache_expiration';

  @override
  Future<void> initialize() async {
    await Hive.initFlutter();

    // Open cache boxes
    _cacheBox = await Hive.openBox<dynamic>(_cacheBoxName);
    _expirationBox = await Hive.openBox<DateTime>(_expirationBoxName);

    // Clean expired entries on initialization
    await _cleanExpiredEntries();
  }

  @override
  Future<void> dispose() async {
    await _cacheBox.close();
    await _expirationBox.close();
  }

  @override
  Future<void> put<T>(String key, T value) async {
    await _cacheBox.put(key, _serializeValue(value));

    // Remove from expiration box if it exists
    if (_expirationBox.containsKey(key)) {
      await _expirationBox.delete(key);
    }
  }

  @override
  Future<T?> get<T>(String key) async {
    if (!_cacheBox.containsKey(key)) return null;

    final value = _cacheBox.get(key);
    return _deserializeValue<T>(value);
  }

  @override
  Future<void> delete(String key) async {
    await _cacheBox.delete(key);
    await _expirationBox.delete(key);
  }

  @override
  Future<void> clear() async {
    await _cacheBox.clear();
    await _expirationBox.clear();
  }

  @override
  Future<bool> exists(String key) async {
    return _cacheBox.containsKey(key);
  }

  @override
  Future<void> putAll<T>(Map<String, T> entries) async {
    final serializedEntries = <String, dynamic>{};
    for (final entry in entries.entries) {
      serializedEntries[entry.key] = _serializeValue(entry.value);
    }

    await _cacheBox.putAll(serializedEntries);

    // Remove from expiration box for all keys
    for (final key in entries.keys) {
      if (_expirationBox.containsKey(key)) {
        await _expirationBox.delete(key);
      }
    }
  }

  @override
  Future<Map<String, T?>> getAll<T>(List<String> keys) async {
    final result = <String, T?>{};

    for (final key in keys) {
      result[key] = await get<T>(key);
    }

    return result;
  }

  @override
  Future<void> deleteAll(List<String> keys) async {
    await _cacheBox.deleteAll(keys);
    await _expirationBox.deleteAll(keys);
  }

  @override
  Future<void> putWithExpiration<T>(
    String key,
    T value,
    Duration expiration,
  ) async {
    final expirationTime = DateTime.now().add(expiration);

    await _cacheBox.put(key, _serializeValue(value));
    await _expirationBox.put(key, expirationTime);
  }

  @override
  Future<T?> getWithExpirationCheck<T>(String key) async {
    if (!_cacheBox.containsKey(key)) return null;

    // Check if key has expiration
    if (_expirationBox.containsKey(key)) {
      final expirationTime = _expirationBox.get(key)!;

      if (DateTime.now().isAfter(expirationTime)) {
        // Entry has expired, remove it
        await delete(key);
        return null;
      }
    }

    final value = _cacheBox.get(key);
    return _deserializeValue<T>(value);
  }

  @override
  Future<List<String>> getAllKeys() async {
    return _cacheBox.keys.cast<String>().toList();
  }

  @override
  Future<int> getSize() async {
    return _cacheBox.length;
  }

  @override
  Future<void> compact() async {
    await _cacheBox.compact();
    await _expirationBox.compact();
  }

  // Helper methods
  dynamic _serializeValue<T>(T value) {
    if (value == null) return null;

    // Handle primitive types directly
    if (value is String || value is num || value is bool) {
      return value;
    }

    // Handle lists and maps
    if (value is List || value is Map) {
      return jsonEncode(value);
    }

    // For complex objects, try to serialize as JSON
    try {
      return jsonEncode(value);
    } catch (e) {
      // If serialization fails, store as string representation
      return value.toString();
    }
  }

  T? _deserializeValue<T>(dynamic value) {
    if (value == null) return null;

    // If T is dynamic, return value as-is
    if (T == dynamic) return value as T;

    // Handle primitive types
    if (T == String) return value.toString() as T;
    if (T == int) {
      if (value is int) return value as T;
      if (value is String) return int.tryParse(value) as T?;
      return (value as num).toInt() as T;
    }
    if (T == double) {
      if (value is double) return value as T;
      if (value is String) return double.tryParse(value) as T?;
      return (value as num).toDouble() as T;
    }
    if (T == bool) {
      if (value is bool) return value as T;
      if (value is String) {
        return (value.toLowerCase() == 'true') as T;
      }
      return false as T;
    }

    // Handle collections
    if (T == List) {
      if (value is List) return value as T;
      if (value is String) {
        try {
          return jsonDecode(value) as T;
        } catch (e) {
          return <dynamic>[] as T;
        }
      }
    }

    if (T == Map) {
      if (value is Map) return value as T;
      if (value is String) {
        try {
          return jsonDecode(value) as T;
        } catch (e) {
          return <String, dynamic>{} as T;
        }
      }
    }

    // For other types, try JSON decoding if it's a string
    if (value is String) {
      try {
        final decoded = jsonDecode(value);
        return decoded as T;
      } catch (e) {
        // If JSON decoding fails, return the string value
        return value as T;
      }
    }

    // Return as-is if type matches
    if (value is T) return value;

    return null;
  }

  Future<void> _cleanExpiredEntries() async {
    final now = DateTime.now();
    final expiredKeys = <String>[];

    for (final key in _expirationBox.keys) {
      final expirationTime = _expirationBox.get(key);
      if (expirationTime != null && now.isAfter(expirationTime)) {
        expiredKeys.add(key.toString());
      }
    }

    if (expiredKeys.isNotEmpty) {
      await deleteAll(expiredKeys);
    }
  }
}

/// Cache configuration
class CacheConfig {
  const CacheConfig({
    this.defaultExpiration = const Duration(hours: 24),
    this.maxSize = 1000,
    this.cleanupInterval = const Duration(hours: 1),
  });

  final Duration defaultExpiration;
  final int maxSize;
  final Duration cleanupInterval;
}

/// Cache entry with metadata
class CacheEntry<T> {
  const CacheEntry({
    required this.value,
    required this.createdAt,
    this.expiresAt,
    this.lastAccessed,
  });

  final T value;
  final DateTime createdAt;
  final DateTime? expiresAt;
  final DateTime? lastAccessed;

  bool get isExpired => expiresAt != null && DateTime.now().isAfter(expiresAt!);

  CacheEntry<T> copyWith({
    T? value,
    DateTime? createdAt,
    DateTime? expiresAt,
    DateTime? lastAccessed,
  }) {
    return CacheEntry<T>(
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      lastAccessed: lastAccessed ?? this.lastAccessed,
    );
  }
}

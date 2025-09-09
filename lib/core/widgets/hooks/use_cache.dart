import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:robbie_starter/core/cache/cache_service.dart';
import 'package:robbie_starter/core/di/injection_container.dart';

/// Hook for interacting with cache service
({
  T? data,
  bool isLoading,
  String? error,
  Future<void> Function(T) setData,
  Future<void> Function() removeData,
  Future<void> Function() refreshData,
}) useCache<T>(
  String key, {
  Future<T> Function()? fetcher,
  Duration? expiration,
  T Function()? fromJson,
  dynamic Function(T)? toJson,
}) {
  final cacheService = getIt<CacheService>();

  final data = useState<T?>(null);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  // Define refresh callback first
  late final Future<void> Function() refreshData;

  refreshData = useCallback(
    () async {
      if (fetcher == null) return;

      try {
        isLoading.value = true;
        error.value = null;

        final freshData = await fetcher();
        data.value = freshData;

        if (expiration != null) {
          await cacheService.putWithExpiration(key, freshData, expiration);
        } else {
          await cacheService.put(key, freshData);
        }
      } catch (e) {
        error.value = e.toString();
      } finally {
        isLoading.value = false;
      }
    },
    [key, fetcher, expiration],
  );

  // Load data from cache on mount
  useEffect(
    () {
      Future<void> loadFromCache() async {
        try {
          isLoading.value = true;
          error.value = null;

          T? cachedData;
          if (expiration != null) {
            cachedData = await cacheService.getWithExpirationCheck<T>(key);
          } else {
            cachedData = await cacheService.get<T>(key);
          }

          if (cachedData != null) {
            data.value = cachedData;
          } else if (fetcher != null) {
            // Cache miss, fetch fresh data
            await refreshData();
          }
        } catch (e) {
          error.value = e.toString();
        } finally {
          isLoading.value = false;
        }
      }

      loadFromCache();
      return null;
    },
    [key],
  );

  final setData = useCallback(
    (T newData) async {
      try {
        data.value = newData;
        if (expiration != null) {
          await cacheService.putWithExpiration(key, newData, expiration);
        } else {
          await cacheService.put(key, newData);
        }
      } catch (e) {
        error.value = e.toString();
      }
    },
    [key, expiration],
  );

  final removeData = useCallback(
    () async {
      try {
        data.value = null;
        await cacheService.delete(key);
      } catch (e) {
        error.value = e.toString();
      }
    },
    [key],
  );

  return (
    data: data.value,
    isLoading: isLoading.value,
    error: error.value,
    setData: setData,
    removeData: removeData,
    refreshData: refreshData,
  );
}

/// Hook for managing multiple cache entries
Map<String, T?> useCacheMultiple<T>(
  List<String> keys, {
  Map<String, Future<T> Function()>? fetchers,
}) {
  final cacheService = getIt<CacheService>();
  final dataMap = useState<Map<String, T?>>({});

  useEffect(
    () {
      Future<void> loadMultiple() async {
        try {
          final results = await cacheService.getAll<T>(keys);
          dataMap.value = results;

          // Fetch missing data if fetchers are provided
          if (fetchers != null) {
            for (final key in keys) {
              if (results[key] == null && fetchers.containsKey(key)) {
                try {
                  final freshData = await fetchers[key]!();
                  await cacheService.put(key, freshData);
                  dataMap.value = {...dataMap.value, key: freshData};
                } catch (e) {
                  // Handle individual fetch errors
                }
              }
            }
          }
        } catch (e) {
          // Handle error
        }
      }

      loadMultiple();
      return null;
    },
    [keys],
  );

  return dataMap.value;
}

/// Hook for cache invalidation patterns
({
  Future<void> Function(String) invalidateByPattern,
  Future<void> Function() invalidateAll,
  Future<void> Function(List<String>) invalidateKeys,
}) useCacheInvalidation() {
  final cacheService = getIt<CacheService>();

  final invalidateByPattern = useCallback(
    (String pattern) async {
      final allKeys = await cacheService.getAllKeys();
      final keysToDelete =
          allKeys.where((key) => key.contains(pattern)).toList();
      if (keysToDelete.isNotEmpty) {
        await cacheService.deleteAll(keysToDelete);
      }
    },
    [],
  );

  final invalidateAll = useCallback(
    () async {
      await cacheService.clear();
    },
    [],
  );

  final invalidateKeys = useCallback(
    (List<String> keys) async {
      await cacheService.deleteAll(keys);
    },
    [],
  );

  return (
    invalidateByPattern: invalidateByPattern,
    invalidateAll: invalidateAll,
    invalidateKeys: invalidateKeys,
  );
}

/// Hook for cache statistics
({
  Future<int> Function() getCacheSize,
  Future<List<String>> Function() getAllKeys,
  Future<void> Function() compactCache,
}) useCacheStats() {
  final cacheService = getIt<CacheService>();

  final getCacheSize = useCallback(cacheService.getSize, []);
  final getAllKeys = useCallback(cacheService.getAllKeys, []);
  final compactCache = useCallback(cacheService.compact, []);

  return (
    getCacheSize: getCacheSize,
    getAllKeys: getAllKeys,
    compactCache: compactCache,
  );
}

/// Hook for optimistic updates with cache
({
  T? data,
  bool isLoading,
  String? error,
  Future<void> Function(T, Future<T> Function()) optimisticUpdate,
}) useOptimisticCache<T>(
  String key, {
  Future<T> Function()? fetcher,
}) {
  final cacheHook = useCache<T>(key, fetcher: fetcher);

  final optimisticUpdate = useCallback(
    (T optimisticData, Future<T> Function() actualUpdate) async {
      // Store current data as backup
      final originalData = cacheHook.data;

      try {
        // Apply optimistic update immediately
        await cacheHook.setData(optimisticData);

        // Perform actual update
        final actualData = await actualUpdate();

        // Update with actual result
        await cacheHook.setData(actualData);
      } catch (e) {
        // Rollback on error
        if (originalData != null) {
          await cacheHook.setData(originalData);
        } else {
          await cacheHook.removeData();
        }
        rethrow;
      }
    },
    [cacheHook.setData, cacheHook.removeData],
  );

  return (
    data: cacheHook.data,
    isLoading: cacheHook.isLoading,
    error: cacheHook.error,
    optimisticUpdate: optimisticUpdate,
  );
}

/// Hook for cache synchronization across tabs/windows
void useCacheSync(String key, void Function() onUpdate) {
  useEffect(
    () {
      // In a real implementation, you'd listen for storage events
      // or use other cross-tab communication mechanisms
      return null;
    },
    [key],
  );
}

/// Hook for cache preloading
void useCachePreload<T>(
  List<String> keys,
  Map<String, Future<T> Function()> fetchers,
) {
  final cacheService = getIt<CacheService>();

  useEffect(
    () {
      Future<void> preload() async {
        for (final key in keys) {
          final exists = await cacheService.exists(key);
          if (!exists && fetchers.containsKey(key)) {
            try {
              final data = await fetchers[key]!();
              await cacheService.put(key, data);
            } catch (e) {
              // Ignore preload errors
            }
          }
        }
      }

      preload();
      return null;
    },
    [keys],
  );
}

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheImageManager {
  CacheImageManager._internal();

  /// Singleton factory
  static final CacheImageManager _instance = CacheImageManager._internal();

  factory CacheImageManager() {
    return _instance;
  }

  static CacheManager instance = CacheManager(
    Config(
      'cacheKey',
      stalePeriod: const Duration(minutes: 60),
      maxNrOfCacheObjects: 20,
    ),
  );
}

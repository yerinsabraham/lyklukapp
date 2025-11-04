import 'package:lykluk/core/services/network/api_response.dart';

/// Contract for all Videoentication endpoints.
abstract class SearchRepository {
  // ─────────────── VIDEOS ───────────────

  Future<ApiResponse> search({required Map<String, dynamic> queryParameter});

  Future<ApiResponse> trendingVideos({
    required Map<String, dynamic> queryParameter,
  });

  Future<ApiResponse> trendingHashTags({
    required Map<String, dynamic> queryParameter,
  });

  Future<ApiResponse> searchUsername({
    required Map<String, dynamic> queryParameter,
  });

  Future<ApiResponse> videosByHashTagId({
    required Map<String, dynamic> queryParameter,
  });
}

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/network/api_response.dart';
import 'package:lykluk/core/services/network/api_service.dart';
import 'package:lykluk/modules/search/data/repository/repo/search_repo.dart';
import 'package:lykluk/core/services/network/endpoints.dart';
final searchRepoProvider = Provider<SearchRepositoryImpl>((ref) {
  return SearchRepositoryImpl(apiService: ref.read(apiServiceProvider));
});

class SearchRepositoryImpl implements SearchRepository {
  final ApiService apiService;
  const SearchRepositoryImpl({required this.apiService});

  // GET /search/search
  @override
  Future<ApiResponse> search({required Map<String, dynamic> queryParameter}) {
    return apiService.getData(
      Endpoints.search,
      hasHeader: true,
      queryParameters: queryParameter,
    );
  }

  // GET /search/trendingVideos
  @override
  Future<ApiResponse> trendingVideos({
    required Map<String, dynamic> queryParameter,
  }) {
    return apiService.getData(
      Endpoints.trendingVideos,
      hasHeader: true,
      queryParameters: queryParameter,
    );
  }

  // GET /search/trendingHashTags
  @override
  Future<ApiResponse> trendingHashTags({
    required Map<String, dynamic> queryParameter,
  }) {
    return apiService.getData(
      Endpoints.trendingHashTags,
      hasHeader: true,
      queryParameters: queryParameter,
    );
  }

  // GET /search/searchUsername
  @override
  Future<ApiResponse> searchUsername({
    required Map<String, dynamic> queryParameter,
  }) {
    return apiService.getData(
      Endpoints.searchUsername,
      hasHeader: true,
      queryParameters: queryParameter,
    );
  }

  // GET /search/videosByHashTagId
  @override
  Future<ApiResponse> videosByHashTagId({
    required Map<String, dynamic> queryParameter,
  }) {
    return apiService.getData(
      Endpoints.videosByHashTagId,
      hasHeader: true,
      queryParameters: queryParameter,
    );
  }
}

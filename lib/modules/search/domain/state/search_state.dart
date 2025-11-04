import 'package:lykluk/core/services/network/api_response.dart';

class SearchViewState {
  // Loaders
  final bool isSearching;
  final bool isGettingTrendingVideos;
  final bool isGettingTrendingHashTags;
  final bool isSearchingUsername;
  final bool isGettingVideosByHashTag;

  // Errors
  final String? errorMessage;

  // Data
  final ApiResponse? searchResponse;
  final ApiResponse? trendingVideosResponse;
  final ApiResponse? trendingHashTagsResponse;
  final ApiResponse? searchUsernameResponse;
  final ApiResponse? videosByHashTagIdResponse;

  const SearchViewState({
    this.isSearching = false,
    this.isGettingTrendingVideos = false,
    this.isGettingTrendingHashTags = false,
    this.isSearchingUsername = false,
    this.isGettingVideosByHashTag = false,
    this.errorMessage,
    this.searchResponse,
    this.trendingVideosResponse,
    this.trendingHashTagsResponse,
    this.searchUsernameResponse,
    this.videosByHashTagIdResponse,
  });

  SearchViewState copyWith({
    bool? isSearching,
    bool? isGettingTrendingVideos,
    bool? isGettingTrendingHashTags,
    bool? isSearchingUsername,
    bool? isGettingVideosByHashTag,
    String? errorMessage,
    ApiResponse? searchResponse,
    ApiResponse? trendingVideosResponse,
    ApiResponse? trendingHashTagsResponse,
    ApiResponse? searchUsernameResponse,
    ApiResponse? videosByHashTagIdResponse,
  }) {
    return SearchViewState(
      isSearching: isSearching ?? this.isSearching,
      isGettingTrendingVideos:
          isGettingTrendingVideos ?? this.isGettingTrendingVideos,
      isGettingTrendingHashTags:
          isGettingTrendingHashTags ?? this.isGettingTrendingHashTags,
      isSearchingUsername: isSearchingUsername ?? this.isSearchingUsername,
      isGettingVideosByHashTag:
          isGettingVideosByHashTag ?? this.isGettingVideosByHashTag,
      errorMessage: errorMessage ?? this.errorMessage,
      searchResponse: searchResponse ?? this.searchResponse,
      trendingVideosResponse:
          trendingVideosResponse ?? this.trendingVideosResponse,
      trendingHashTagsResponse:
          trendingHashTagsResponse ?? this.trendingHashTagsResponse,
      searchUsernameResponse:
          searchUsernameResponse ?? this.searchUsernameResponse,
      videosByHashTagIdResponse:
          videosByHashTagIdResponse ?? this.videosByHashTagIdResponse,
    );
  }
}

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/logger_service.dart';
import 'package:lykluk/core/services/app_analytics.dart';
import 'package:lykluk/modules/search/data/repository/impl/search_repo_impl.dart';
import 'package:lykluk/modules/search/domain/state/search_state.dart';
import 'package:lykluk/utils/helpers/toast_notification.dart';

/// Primary VM for Search
final searchViewModelProvider =
    NotifierProvider<SearchViewModel, SearchViewState>(SearchViewModel.new);

class SearchViewModel extends Notifier<SearchViewState> {
  @override
  SearchViewState build() => const SearchViewState();

  SearchRepositoryImpl get _repo => ref.read(searchRepoProvider);

  void _set(SearchViewState s) => state = s;

  void _toast(String message, {bool isSuccess = true}) {
    ToastNotification.showCustomNotification(
      title: isSuccess ? 'Success' : 'Alert',
      subtitle: message,
      isSuccess: isSuccess,
    );
  }

  void _log(String name) =>
      AppAnalytics.logEvent(name: name, parameters: {'status': 'success'});

  // ─────────────── ACTIONS ───────────────

  Future<void> search({required Map<String, dynamic> query}) async {
    _set(state.copyWith(isSearching: true));
    try {
      final res = await _repo.search(queryParameter: query);
      if (res.isSuccessful) {
        _log('search');
        _set(state.copyWith(searchResponse: res));
      } else {
        _toast(res.message ?? 'Search failed', isSuccess: false);
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: 'search',
        errorCode: 'SEARCH',
      );
      _toast('Search operation failed, try again.', isSuccess: false);
    } finally {
      _set(state.copyWith(isSearching: false));
    }
  }

  Future<void> trendingVideos({required Map<String, dynamic> query}) async {
    _set(state.copyWith(isGettingTrendingVideos: true));
    try {
      final res = await _repo.trendingVideos(queryParameter: query);
      if (res.isSuccessful) {
        _log('trendingVideos');
        _set(state.copyWith(trendingVideosResponse: res));
      } else {
        _toast(
          res.message ?? 'Failed to load trending videos',
          isSuccess: false,
        );
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: 'trendingVideos',
        errorCode: 'TRENDING_VIDEOS',
      );
      _toast('Operation failed, try again.', isSuccess: false);
    } finally {
      _set(state.copyWith(isGettingTrendingVideos: false));
    }
  }

  Future<void> trendingHashTags({required Map<String, dynamic> query}) async {
    _set(state.copyWith(isGettingTrendingHashTags: true));
    try {
      final res = await _repo.trendingHashTags(queryParameter: query);
      if (res.isSuccessful) {
        _log('trendingHashTags');
        _set(state.copyWith(trendingHashTagsResponse: res));
      } else {
        _toast(
          res.message ?? 'Failed to load trending hashtags',
          isSuccess: false,
        );
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: 'trendingHashTags',
        errorCode: 'TRENDING_HASHTAGS',
      );
      _toast('Operation failed, try again.', isSuccess: false);
    } finally {
      _set(state.copyWith(isGettingTrendingHashTags: false));
    }
  }

  Future<void> searchUsername({required Map<String, dynamic> query}) async {
    _set(state.copyWith(isSearchingUsername: true));
    try {
      final res = await _repo.searchUsername(queryParameter: query);
      if (res.isSuccessful) {
        _log('searchUsername');
        _set(state.copyWith(searchUsernameResponse: res));
      } else {
        _toast(res.message ?? 'Failed to search username', isSuccess: false);
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: 'searchUsername',
        errorCode: 'SEARCH_USERNAME',
      );
      _toast('Operation failed, try again.', isSuccess: false);
    } finally {
      _set(state.copyWith(isSearchingUsername: false));
    }
  }

  Future<void> videosByHashTagId({required Map<String, dynamic> query}) async {
    _set(state.copyWith(isGettingVideosByHashTag: true));
    try {
      final res = await _repo.videosByHashTagId(queryParameter: query);
      if (res.isSuccessful) {
        _log('videosByHashTagId');
        _set(state.copyWith(videosByHashTagIdResponse: res));
      } else {
        _toast(res.message ?? 'Failed to load videos', isSuccess: false);
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: 'videosByHashTagId',
        errorCode: 'VIDEOS_BY_HASHTAG',
      );
      _toast('Operation failed, try again.', isSuccess: false);
    } finally {
      _set(state.copyWith(isGettingVideosByHashTag: false));
    }
  }
}

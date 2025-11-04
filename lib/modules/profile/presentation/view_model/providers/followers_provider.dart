import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/logger_service.dart';
import 'package:lykluk/modules/profile/domain/repo/profile_repo.dart';
import 'package:lykluk/utils/storage/local_storage.dart';

import '../../../../../utils/pagination/cursor_pagination.dart';
import '../../../data/models/other_user.dart';
import '../../../data/repository/impl/profile_repo_impl.dart';

final followersProvider = AsyncNotifierProviderFamily<
  FollowersNotifier,
  CursorPaginatedResponse<OtherUser>,
  ({String userId, String? search, String? sortBy})
>(FollowersNotifier.new);

class FollowersNotifier
    extends
        FamilyAsyncNotifier<
          CursorPaginatedResponse<OtherUser>,
          ({String userId, String? search, String? sortBy})
        >
    with CursorPaginationController {
  late ProfileRepository _repository;
  bool _isFetching = false;
  @override
  FutureOr<CursorPaginatedResponse<OtherUser>> build(
    ({String userId, String? search, String? sortBy}) arg,
  ) {
    _repository = ref.read(profileRepoProvider);
    onAuthStateChanged(canRefreshSelf: true);
    onNetworkStateChanged();

    return loadData(CursorPaginatedRequest());
  }

  @override
  FutureOr<CursorPaginatedResponse<OtherUser>> loadData(
    CursorPaginatedRequest request,
  ) async {
    if (_isFetching) {
      return state.value ?? CursorPaginatedResponse.emptyPaginatedResponse();
    }
    _isFetching = true;

    try {
      final userId = arg.userId;
      final searchQuery = arg.search;
      final sortBy = arg.sortBy;

      // Add search query if present
      final queryParams = {
        ...request.toJson(),
        if (searchQuery != null && searchQuery.isNotEmpty)
          'search': searchQuery,
        if (sortBy != null && sortBy.isNotEmpty && sortBy != 'Default')
          'sortBy': sortBy,
      };

      final response = await _repository.getFollowerList(
        userId: userId,
        queryParameters: queryParams,
      );
      if (response.isSuccessful) {
        final raw = (response.data as Map<String, dynamic>)['data'];
        return CursorPaginatedResponse<OtherUser>.fromJson(
          json: raw,
          dataFromJson: (e) => OtherUser.fromJson(e as Map<String, dynamic>),
          paginationfieldName: 'cursor',
          dataFieldName: 'profiles',
          filter: (e) => e.following?.username != HiveStorage.username,
        );
      } else {
        return Future.error(response.message ?? "Unable to fetch profile");
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Unable to fetch profile -- FollowingNotifier",
      );
      return Future.error("something went wrong, please try again later");
    } finally {
      _isFetching = false;
    }
  }

  Future<void> followUnfollow({required String userName}) async {
    try {
      final res = await _repository.followUnfollowByUserName(
        userName: userName,
      );

      if (res.isSuccessful) {
        // Update only the changed item in the current list instead of refetching all data
        findAndUpdate(
          where: (item) => item.following?.username == userName,
          update: (item) {
            final other = item;
            final f = other.following;
            if (f == null) return other;
            final toggled = f.copyWith(
              isFollowedByCurrentUser: !(f.isFollowedByCurrentUser ?? false),
            );
            return other.copyWith(following: toggled);
          },
        );
      } else {
        LoggerService.logError(
          error: res.message ?? "Failed to follow/unfollow user",
        );
      }
    } catch (e, s) {
      LoggerService.logError(error: e, stackTrace: s);
    }
  }
}

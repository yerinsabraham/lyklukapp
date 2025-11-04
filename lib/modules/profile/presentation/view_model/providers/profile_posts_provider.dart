import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/logger_service.dart';
import 'package:lykluk/modules/profile/domain/repo/profile_repo.dart';
import 'package:lykluk/utils/pagination/cursor_pagination.dart';
import '../../../../posts/data/model/post_model.dart';
import '../../../data/repository/impl/profile_repo_impl.dart';

final profilePostsProvider = AsyncNotifierProviderFamily<
  ProfileVideosNotifier,
  CursorPaginatedResponse<PostModel>,
  String
>(ProfileVideosNotifier.new);

class ProfileVideosNotifier
    extends FamilyAsyncNotifier<CursorPaginatedResponse<PostModel>, String>
    with CursorPaginationController {
  late ProfileRepository _repository;
  @override
  FutureOr<CursorPaginatedResponse<PostModel>> build(arg) {
    _repository = ref.read(profileRepoProvider);
    onAuthStateChanged(canRefreshSelf: true);
    onNetworkStateChanged();
    return loadData(CursorPaginatedRequest());
  }

  @override
  FutureOr<CursorPaginatedResponse<PostModel>> loadData(
    CursorPaginatedRequest request,
  ) async {
    try {
      final response = await _repository.getProfileVideos(
        userId: arg,
        queryParameters: request.toJson(),
      );
      if (response.isSuccessful) {
        final raw = (response.data as Map<String, dynamic>)['data'];
        return CursorPaginatedResponse<PostModel>.fromJson(
          json: raw,
          dataFromJson: (e) => PostModel.fromJson(e as Map<String, dynamic>),
          paginationfieldName: 'cursor',
          dataFieldName: 'videos',
        );
      } else {
        return Future.error(response.message ?? "Unable to fetch profile");
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Unable to fetch profile -- ProfileVideosNotifier",
      );
      return Future.error("something went wrong, please try again later");
    }
  }
}

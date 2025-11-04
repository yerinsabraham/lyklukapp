import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/services.dart';
import 'package:lykluk/modules/profile/domain/repo/profile_repo.dart';
import 'package:lykluk/core/services/network/endpoints.dart';

final profileRepoProvider = Provider<ProfileRepositoryImpl>((ref) {
  return ProfileRepositoryImpl(apiService: ref.read(apiServiceProvider));
});

class ProfileRepositoryImpl implements ProfileRepository {
  final ApiService apiService;
  const ProfileRepositoryImpl({required this.apiService});

  // ─────────────── PROFILE MANAGEMENT ───────────────

  /// GET /profile - Get user profile (current user if no userId provided)
  @override
  Future<ApiResponse> getProfile({ required String userId}) {
    final url = Endpoints.getProfile.replaceFirst("userId", userId);
       

    return apiService.getData(url, hasHeader: true);
  }
  /// GET /profile - Get user profile (current user if no userId provided)
  @override
  Future<ApiResponse> getProfileByUserName({ required String userName}) {
    final url = Endpoints.getProfileByUsername.replaceFirst("username", userName);
       

    return apiService.getData(url,  hasHeader: true);
  }

  @override
  Future<ApiResponse> getMyProfile({required String userId}) {
    final url = Endpoints.getProfile.replaceFirst("userId", userId);

    return apiService.getData(url,  hasHeader: true);
  }

  /// PUT /profile - Edit/Update user profile
  @override
  Future<ApiResponse> editProfile({required Map<String, dynamic> body}) {
    return apiService.putData(
      Endpoints.editProfile,
      hasAuthorization: true,
      hasXAuthToken: true,
      body: body,
    );
  }

  /// POST /profile/pic - Update profile picture
  @override
  Future<ApiResponse> editProfilePic({required Map<String, dynamic> body}) {
    return apiService.postData(
      Endpoints.editProfilePic,
      hasHeader: true,
      body: body,
    );
  }

  // ─────────────── CONNECTION MANAGEMENT ───────────────

  /// POST /profile/follow/{userId} - Follow/Unfollow a user
  @override
  Future<ApiResponse> followUnfollow({required String userId}) {
    return apiService.postData(
      // '${Endpoints.followUnfollow}$userId',
      Endpoints.followUnfollow.replaceFirst("userId", userId),
      hasHeader: true,
    );
  }
  /// POST /profile/follow/{userId} - Follow/Unfollow a user
  @override
  Future<ApiResponse> followUnfollowByUserName({required String userName}) {
    return apiService.postData(
      // '${Endpoints.followUnfollow}$userId',
      Endpoints.followUnfollowByUsername.replaceFirst("username", userName),
      hasHeader: true,
    );
  }

  /// GET /profile/following/{userId} - Get following list
  @override
  Future<ApiResponse> getFollowingList({
    required String userId,
    Map<String, dynamic>? queryParameters,
  }) {
    return apiService.getData(
      // '${Endpoints.followingList}$userId',
      Endpoints.followingList.replaceFirst("userId", userId),
      hasHeader: true,
      queryParameters: queryParameters,
    );
  }

  /// GET /profile/follower/{userId} - Get followers list
  @override
  Future<ApiResponse> getFollowerList({
    required String userId,
    Map<String, dynamic>? queryParameters,
  }) {
    return apiService.getData(
      // '${Endpoints.followerList}$userId',
        Endpoints.followerList.replaceFirst("userId", userId),
      hasHeader: true,
      queryParameters: queryParameters,
    );
  }

/// GET /profile/requests/pending - Get requests list
  @override
  Future<ApiResponse> getRequestsList({
    Map<String, dynamic>? queryParameters,
  }) {
    return apiService.getData(
      Endpoints.getConnectionRequests,
       hasHeader: true,
      queryParameters: queryParameters,
    );
  }

  /// POST /profile/block/{userId} - Block/Unblock a user
  @override
  Future<ApiResponse> blockUnblockProfile({required String userId}) {
    return apiService.postData(
      // '${Endpoints.blockUnblockProfile}$userId',
      Endpoints.blockUnblockProfile.replaceFirst("userId", userId),
      hasHeader: true,
    );
  }

  /// GET /profile/blocked/accounts - Get blocked accounts list
  @override
  Future<ApiResponse> getBlockedAccountsList({
    Map<String, dynamic>? queryParameters,
  }) {
    return apiService.getData(
      Endpoints.blockedAccountList,
      hasHeader: true,
      queryParameters: queryParameters,
    );
  }

  // ─────────────── CONTENT MANAGEMENT ───────────────

  /// GET /profile/videos/{userId} - Get user's videos/posts
  @override
  Future<ApiResponse> getProfileVideos({
    required String userId,
    Map<String, dynamic>? queryParameters,
  }) {
    return apiService.getData(
      // '${Endpoints.profileVideos}$userId',
      Endpoints.profileVideos.replaceFirst("userId", userId),
       hasHeader: true,
      queryParameters: queryParameters,
    );
  }

  // ─────────────── SETTINGS MANAGEMENT ───────────────

  /// PUT /profile/settings - Update profile settings
  @override
  Future<ApiResponse> updateProfileSettings({
    required Map<String, dynamic> body,
  }) {
    return apiService.putData(
      Endpoints.updateProfileSettings,
      hasAuthorization: true,
      hasXAuthToken: true,
      body: body,
    );
  }

  /// GET /profile/settings/get - Get profile settings
  @override
  Future<ApiResponse> getProfileSettings() {
    return apiService.getData(
      Endpoints.getProfileSettings,
      hasHeader: true,
    );
  }

  /// DELETE /profile - Deactivate/Delete user account
  @override
  Future<ApiResponse> deactivateAccount() {
    return apiService.deleteData(
      Endpoints.deleteProfile,
        hasHeader: true,
    );
  }
}

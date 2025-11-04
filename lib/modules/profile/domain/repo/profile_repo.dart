

import '../../../../core/services/services.dart';

/// Contract for all Profile endpoints.
abstract class ProfileRepository {
  // ─────────────── PROFILE MANAGEMENT ───────────────
  /// GET /profile - Get user profile (current user if no userId provided)
  Future<ApiResponse> getProfile({ required String userId});
  Future<ApiResponse> getProfileByUserName({ required String userName});
  Future<ApiResponse> getMyProfile({ required String userId});

  /// PUT /profile - Edit/Update user profile
  Future<ApiResponse> editProfile({required Map<String, dynamic> body});

  /// PUT /profile/pic - Update profile picture
  Future<ApiResponse> editProfilePic({required Map<String, dynamic> body});

  // ─────────────── CONNECTION MANAGEMENT ───────────────
  /// POST /profile/follow/{userId} - Follow/Unfollow a user
  Future<ApiResponse> followUnfollow({required String userId});
  Future<ApiResponse> followUnfollowByUserName({required String userName});

  /// GET /profile/following/{userId} - Get following list
  Future<ApiResponse> getFollowingList({
    required String userId,
    Map<String, dynamic>? queryParameters,
  });

  /// GET /profile/follower/{userId} - Get followers list
  Future<ApiResponse> getFollowerList({
    required String userId,
    Map<String, dynamic>? queryParameters,
  });

  /// POST /profile/block/{userId} - Block/Unblock a user
  Future<ApiResponse> blockUnblockProfile({required String userId});

  /// GET /profile/blocked/accounts - Get blocked accounts list
  Future<ApiResponse> getBlockedAccountsList({
    Map<String, dynamic>? queryParameters,
  });

  // ─────────────── CONTENT MANAGEMENT ───────────────
  /// GET /profile/videos/{userId} - Get user's videos/posts
  Future<ApiResponse> getProfileVideos({
    required String userId,
    Map<String, dynamic>? queryParameters,
  });

  // ─────────────── SETTINGS MANAGEMENT ───────────────
  /// PUT /profile/settings - Update profile settings
  Future<ApiResponse> updateProfileSettings({
    required Map<String, dynamic> body,
  });

  /// GET /profile/settings/get - Get profile settings
  Future<ApiResponse> getProfileSettings();

  /// DELETE /profile - Deactivate/Delete user account
  Future<ApiResponse> deactivateAccount();

/// GET /profile/requests/pending - Get requests list
  Future<ApiResponse> getRequestsList({Map<String, dynamic>? queryParameters});
}

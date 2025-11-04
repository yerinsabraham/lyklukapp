// API DOCUMENTATION
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/logger_service.dart';
import 'package:lykluk/core/services/remote_config.dart';

class Endpoints {
  Endpoints._();
  static const int localTimeoutSession = 10;
  static const String debugStagingUrl = 'https://api.lykluk.com';
  static const String debugToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjQsInVzZXJuYW1lIjoiZGltZTFAeW9wbWFpbC5jb20iLCJhcHBfdG9rZW4iOiJ5SmhiR2NpT2lKSVV6STFOaUlzSW5SNWNDSTZJa3BYVkNKOS5leUp6ZFdJaU9qUXNJblZ6WlhKdVlXMWxJam9pWkdsdFpURkFlVzl3YldGcGJDNWpiMjBpQ0poY0hCZmRHOXJaVzRpT2lKalEwOTJWMEpHTFZwcldYWndZWFJHTTBOU2JHVm5Pa0ZRUVRreFlrZFJhbGhNVFU1eFNVOWlTV05VUlhjM1UxZERiR1ZpYjNGT05tRllaMEUxTkcxcloyZHZRbmwxZVZSQ2RFWXdZa3BVT0VsUlJIaExlRGxtWmpFNVRXaFhPVWhmWjFSTGNETndZbWRwV0dwVlpFa3lURGhQTmxSUVZXcENVTjRXV2hTYlUwek5IRTJWMnhNYUVaeWNWQjBkREpwYVhKbE5FNVdUMnRrYlVkMmJsWnVTell6TkNJc0ltbGhkQ0k2TVRjMU56YzRNRFE0TjMwLkhDcUpjRUdvclVHQW9IUWdSQmdaZWdfbHlYYzZ2YVd1N0ZhbDMwWFBqU2cxNzU3ODEyNTA3NTgxIiwiaWF0IjoxNzU3ODEyNjE3fQ._m90SnGS01tgLa20qW2tp6tlV3_wGu7VZpn3MJ7GuD0";
  static const appToken =
      "yJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjQsInVzZXJuYW1lIjoiZGltZTFAeW9wbWFpbC5jb20iCJhcHBfdG9rZW4iOiJjQ092V0JGLVprWXZwYXRGM0NSbGVnOkFQQTkxYkdRalhMTU5xSU9iSWNURXc3U1dDbGVib3FONmFYZ0E1NG1rZ2dvQnl1eVRCdEYwYkpUOElRRHhLeDlmZjE5TWhXOUhfZ1RLcDNwYmdpWGpVZEkyTDhPNlRQVWpCUN4WWhSbU0zNHE2V2xMaEZycVB0dDJpaXJlNE5WT2tkbUd2blZuSzYzNCIsImlhdCI6MTc1Nzc4MDQ4N30.HCqJcEGorUGAoHQgRBgZeg_lyXc6vaWu7Fal30XPjSg1757812507581";
  // File Upload Paths
  static const String mediaUploadPath = '/lykluk-files';
  static const mediaUploadBaseUrl = "https://api.lykluk.com";
  // This is url used in previous to load video and image but not it is deprecated.
  // static const mediaServer = "https://cdn.lykluk.com/";
  static const defaultProfilePicUrl =
      "https://cdn.lykluk.com/default/profile/default3.jpeg";
  static const ecommerceServiceUrl =
      "https://ecommerce-service-728695047638.us-east1.run.app";

  // RemoteConfigService instance
  static final RemoteConfigService _remoteConfigService = ProviderContainer()
      .read(remoteConfigServiceProvider);

  static String get sentryDnsKey =>
      _getConfig(() => _remoteConfigService.getConfig().sentryDns);
  static int get prodTimeoutSession =>
      _getConfig(() => _remoteConfigService.getConfig().sessionTimeout);
  static int get otpCountdown =>
      _getConfig(() => _remoteConfigService.getConfig().otpCountdown);
  static String get productionUrl =>
      _getConfig(() => _remoteConfigService.getConfig().productionUrl);
  static String get privacyPolicy =>
      _getConfig(() => _remoteConfigService.getConfig().privacyPolicy);
  static String get termsAndConditions =>
      _getConfig(() => _remoteConfigService.getConfig().termsAndConditions);
  static String get supportEmail =>
      _getConfig(() => _remoteConfigService.getConfig().supportEmail);
  static String get whatsAppPrefix =>
      _getConfig(() => _remoteConfigService.getConfig().whatsappPrefix);
  static String get supportWhatsApp =>
      _getConfig(() => _remoteConfigService.getConfig().supportWhatsApp);
  static List<String> get supportContacts =>
      _getConfig(() => _remoteConfigService.getConfig().supportNumbers);

  static int get timeOutSession =>
      kDebugMode ? localTimeoutSession : prodTimeoutSession;

  static String get baseUrl {
    // return productionUrl;
    return debugStagingUrl;
  }

  static T _getConfig<T>(T Function() getter) {
    try {
      return getter();
    } catch (e) {
      log.d('⚠️ Error fetching remote config: $e');
      if (T == int) return 0 as T;
      return '' as T;
    }
  }

  // Common API root
  static final String apiV1 = baseUrl;

  // ================================
  // AUTHENTICATION (from images)
  // ================================
  static String authSignUp = '/auth/signup';
  static String authSocial = '/auth/social-verified';
  static String authSignIn = '/auth/signin';
  static String authRefreshToken = '/auth/refresh';
  static String authResetPassword = '/auth/reset-password';
  static String authUpdatePassword = '/auth/update-password';
  static String authLogout = '/auth/logout';
  static String authVerify = '/verifycheck';
  static String authSendVerification = '/verify';
  static String interests = '/profile/interests/all';

  // ================================
  // SEARCHS (labelled as such in UI)
  // ================================
  static String search = '/search';
  static String trendingVideos = '/discover/trending';
  static String searchHashTags = '/search/hashtags';
  static String searchUsername = '/search/username';
  static String trendingHashTags = '/discover/trending/hashtags';
  static String videosByHashTagId = '/discover/trending/get_video_by_hashtag';

  // ================================
  // PROFILE
  // ================================
  static String blockedAccountList = '/profile/blocked/accounts';
  static String editProfile = '/profile/';
  static String getProfile = '/profile/user/userId';
  static String getProfileByUsername = '/profile/username';
  static String blockUnblockProfile = '/profile/block/user/userId';
  static String followUnfollow = '/profile/follow/user/userId';
  static String followUnfollowByUsername = '/profile/follow/username';
  static String followingList = '/profile/following/user/userId';
  static String followerList = '/profile/follower/user/userId';
  static String profileVideos = '/profile/videos/user/userId';
  static String editProfilePic = '/profile/pic';
  static String updateProfileSettings = '/profile/settings';
  static String getProfileSettings = '/profile/settings/get';
  static String deleteProfile = '/profile/';
  static String getConnectionRequests = '/profile/requests/pending';
  static String acceptConnectionRequest = '/profile/requests/accept/userId';
  static String rejectConnectionRequests = '/profile/requests/reject/userId';

  // ================================
  // VERIFICATION
  // ================================
  static String verificationStart = '/auth/verify';
  static String verificationCheck = '/auth/verifycheck';

  // ================================
  // VIDEO
  // ================================
  static String videoUpload = '/video/';
  static String videoUpdate = '/video/';
  static String videoLikeToggle = '/video/like/';
  static String videoDislikeToggle = '/video/dislike/';
  static String videoGet = '/video';
  static String videoForYou = '/video/fyp';
  static String videoFollowing = '/video/following';
  static String videoNotifications = '/video/notifications';
  static String videoDelete = '/video'; // Soft/Hard delete
  static String videoView = '/video/view/';
  static String videoRestore = '/video/view/';
  static String videoFirebaseTest = '/video/firebase-test';
  static String videoForYouCursor = '/video/fyp2';
  static String videoByUuid = '/video/getByUid';
  static String saveVideo = '/video/save/videoId';
  static String unsaveVideo = '/video/unsave/videoId';
  static String videoSignedUrl = '/video/signed-url';

  // ================================
  // COMMENT
  // ================================
  static String commentDelete = '/video/comment/';
  static String commentReplies = '/video/comment/{videoId}/reply/{commentId}';
  static String commentReply = '/video/comment/videoId/reply/commentId';
  static String videoComments = '/video/comment/';
  static String commentLike = '/video/comment/like';
  static String commentToVideo = '/video/comment/';

  // ================================
  // MESSAGING
  // ================================
  static String messageCreate = '/message/create';
  static String messageGetUser = '/message/get-users';
  static String messageUpdateSettings = '/message/settings';
  static String messageGetSettings = '/message/settings';
  static String messageGetActivities = '/message/activities';

  // ================================
  // APPENDIX
  // ================================
  static String appendixSendEmail = '/auth/email';

  // ================================
  // NOTIFICATIONS
  // ================================
  static String notifications = '/notifications';
  static String notificationSettings = '/notifications/settings';
  static String notificationStats = '/notifications/stats';
  static String notificationUnreadCount = '/notifications/unread-count';

  // ================================
  // ABUSE REPORT
  // ================================
  static String reportAbuse = '/abuse';

  // ================================
  // SHARING
  // ================================
  static String sharingDownload = '/download';
  static String sharingCheckDownload = '/get_download';

  //////////////////////////e-commerce---//////////////////////////
  

  /// put
}

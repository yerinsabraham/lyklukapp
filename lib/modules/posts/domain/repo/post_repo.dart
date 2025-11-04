// import 'package:lykluk/core/services/network/api_response.dart';

// /// Contract for all Videoentication endpoints.
// abstract class VideoRepository {
//   // ─────────────── VIDEOS ───────────────
//   Future<ApiResponse> videoUpload({required Map<String, dynamic> body});

//   Future<ApiResponse> videoUpdate({required Map<String, dynamic> body});

//   Future<ApiResponse> videoLikeToggle({required Map<String, dynamic> body});

//   Future<ApiResponse> getVideo({required Map<String, dynamic> queryParameter});

//   Future<ApiResponse> videoByUuid({
//     required Map<String, dynamic> queryParameter,
//   });

//   Future<ApiResponse> videoForYou({
//     required Map<String, dynamic> queryParameter,
//   });

//   Future<ApiResponse> videoForYouCursor({
//     required Map<String, dynamic> queryParameter,
//   });

//   Future<ApiResponse> videoFollowing({
//     required Map<String, dynamic> queryParameter,
//   });

//   Future<ApiResponse> videoNotifications({
//     required Map<String, dynamic> queryParameter,
//   });

//   Future<ApiResponse> videoView({required Map<String, dynamic> body});

//   Future<ApiResponse> videoRestore({required Map<String, dynamic> body});

//   Future<ApiResponse> videoFirebaseTest({required Map<String, dynamic> body});

//   Future<ApiResponse> videoDelete({required Map<String, dynamic> body});
// }

import 'package:lykluk/core/shared/resources/typedefs.dart';
import 'package:lykluk/utils/pagination/cursor_pagination.dart';

import '../../data/model/post_model.dart';

abstract class PostRepository {
  /// get video fyp
  FutureResponse<CursorPaginatedResponse<PostModel>> getPosts({
    required Map<String, dynamic> query,
  });

  /// get video following
  FutureResponse<CursorPaginatedResponse<PostModel>> getFollowingPosts({
    required Map<String, dynamic> query,
  });


  FutureResponse<StringMap> createPost({
    required Map<String, dynamic> data,
    Function(double)? onProgress,
  });

  FutureResponse<StringMap> videoSignedUrl({
    required Map<String, dynamic> data,
    Function(double)? onProgress,
  });

  /// like video
  FutureResponse<bool> likePost({required String postID, required bool like});
  /// dislike video
  FutureResponse<bool> dislikePost({required String postID, required bool like,
  });

  /// save post
  FutureResponse<bool> savePost({required String postID, required bool saved});

  /// get post
  FutureResponse<PostModel> getPost({required String postID});

  Stream<PostModel> onPostUpdate();
}

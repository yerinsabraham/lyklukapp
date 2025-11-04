import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:lykluk/modules/posts/presentation/view_model/notifiers/video_upload_notifier.dart';
import 'package:lykluk/utils/helpers/image_video_extension.dart';
import 'package:lykluk/utils/storage/local_storage.dart';
import '../../../../../core/services/services.dart';
import '../../../data/impl/post_repo_impl.dart';
import '../../../data/model/post_model.dart';
import '../../../domain/repo/post_repo.dart';
import '../../views/create_post/controllers/post_controller.dart';
import '../../views/create_post/controllers/video_sign_url_controller.dart';

import '../state/post_state.dart';

final postNotifierProvider = NotifierProvider<PostNotifier, PostState>(
  PostNotifier.new,
);

class PostNotifier extends Notifier<PostState> {
  late PostRepository _repository;

  @override
  PostState build() {
    _repository = ref.read(postRepoProvider);
    return PostInitial();
  }

  void createPost() async {
    try {
      state = PostUploading();
      final data = await ref.read(postParamsController).toMap();
      final result = await _repository.createPost(
        data: data,
        onProgress: (v) {
          state = PostUploading(progress: v);
        },
      );
      // final f= await MultipartFile
      result.fold(
        (l) {
          state = PostUploadError(message: l.toString());
        },
        (r) {
          state = PostUploaded(post: r.data);
        },
      );
    } catch (e) {
      state = PostUploadError(message: e.toString());
    }
  }

  Future<void> getVideoSignedUrl(String filePath, String imagePath) async {
    try {
      final data = ref.read(postVideoSignUrlParamsController).toMap();
      final result = await _repository.videoSignedUrl(
        data: data,
       // onProgress: (v) => state = PostUploading(progress: v),
      );

      result.fold(
        (l) {
          state = PostUploadError(message: l.toString());
        },
        (r) async {
          //state = PostUploading(progress: 0.0);
          final videoUrl = r.data['video_upload_url'] as String?;
          final imageUrl = r.data['thumbnail_upload_url'] as String?;

          if (videoUrl == null || imageUrl == null) {
            state = PostUploadError(message: "Invalid response from server");
            return;
          }

          File videoFile = File(filePath);
          File imageFile = File(imagePath);

          if (!await videoFile.exists()) {
            debugPrint("Video file not found at $filePath");
            return;
          }
          if (!await imageFile.exists()) {
            debugPrint("Image file not found at $imagePath");
            return;
          }

          final videoBytes = await videoFile.readAsBytes();
          final imageBytes = await imageFile.readAsBytes();

          final videoContentType = getVideoContentType(videoFile.path);
          final imageContentType = getImageContentType(imageFile.path);

          try {
            state = PostUploading(progress: 0.0);
            final responses = await Future.wait([
              uploadToGcs(videoUrl, videoBytes, videoContentType),
              uploadToGcs(imageUrl, imageBytes, imageContentType),
            ]);

            final videoResponse = responses[0];
            final imageResponse = responses[1];

            if (videoResponse.statusCode == 200 &&
                imageResponse.statusCode == 200) {
              debugPrint("Video and Image uploaded successfully!");
             
              ref.read(videoRefreshProvider.notifier).update((state) => true);
             
              await Future.delayed(Duration(seconds: 2)); 
              for (double i = 0.0; i <= 100.0; i += 10.0) {
                await Future.delayed(Duration(seconds: 1));  
                state = PostUploading(progress: i);
              }
              state = PostUploaded(post: r.data);
           
            } else {
              debugPrint(
                "Upload failed. Video: ${videoResponse.statusCode}, Image: ${imageResponse.statusCode}",
              );
              state = PostUploadError(message: "Upload failed");
            }
          } catch (e) {
            debugPrint("Error during parallel upload: $e");
            state = PostUploadError(message: e.toString());
          }
        },
      );
    } catch (e) {
      debugPrint("Exception in getVideoSignedUrl: $e");
      state = PostUploadError(message: e.toString());
    }
  }

  // Upload Video and Image files in GCS
  Future<http.Response> uploadToGcs(
    String url,
    List<int> bytes,
    String contentType,
  ) async {
    return http.put(
      Uri.parse(url),
      headers: {
        "Content-Type": contentType,
        'Authorization':
            HiveStorage.accessToken.isEmpty
                ? ""
                : 'Bearer ${HiveStorage.accessToken}',
      },
      body: bytes,
    );
  }

  /// like video
  void likePost({required PostModel post}) async {
    try {
      final newPost = post.copyWith(
        isLiked: !post.isLiked,
        count: post.count.copyWith(
          videoLikes:
              post.isLiked
                  ? post.count.videoLikes - 1
                  : post.count.videoLikes + 1,
        ),
      );
      state= newPost.isLiked? PostLiked(post: newPost) : PostUnliked(post: newPost);
      final result = await _repository.likePost(
        postID: newPost.id.toString(),
        like: newPost.isLiked,
      );
      result.fold(
        (l) {
          state = PostLikeFailed(message: l.message, post: post);
        },
        (r) {
          // state = SentComment(message: r.message, comment: r.data);
        },
      );
    } catch (e) {
      log.e(e.toString());
      state = PostLikeFailed(message: e.toString(), post: post);
    }
  }

  /// dislike post

  /// save post
  void savePost({required PostModel post}) async {
    try {
      final newPost = post.copyWith(
        isSaved: !post.isSaved,
      );
      state= newPost.isSaved? PostSaved(post: newPost) : PostUnsaved(post: newPost);
      final result = await _repository.savePost(
        postID: newPost.id.toString(),
        saved: newPost.isLiked,
      );
      result.fold(
        (l) {
          state = PostSaveFailed(message: l.message, post: post);
        },
        (r) {
          // state = SentComment(message: r.message, comment: r.data);
        },
      );
    } catch (e) {
      log.e(e.toString());
      state = PostSaveFailed(message: e.toString(), post: post);
    }
  }


}

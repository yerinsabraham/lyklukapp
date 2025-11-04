import 'dart:convert';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lykluk/core/services/services.dart';
import 'package:lykluk/core/services/network/endpoints.dart';
import 'package:lykluk/utils/pagination/cursor_pagination.dart';
import 'package:lykluk/core/services/network/socket_io_manager.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../core/services/queue_system/queue_service.dart';
import '../../../../core/shared/resources/failure.dart';
import '../../../../core/shared/resources/response_data.dart';
import '../../../../core/shared/resources/typedefs.dart';
import '../../domain/repo/post_repo.dart';
import '../model/post_model.dart';

final postRepoProvider = Provider((ref) {
  return PostRepoImpl(
    apiService: ref.read(apiServiceProvider),
    queueService: ref.read(queueServiceProvider),
  );
});

class PostRepoImpl implements PostRepository {
  final ApiService _apiService;
  final QueueService _queueService;
  const PostRepoImpl({
    required ApiService apiService,
    required QueueService queueService,
  }) : _apiService = apiService,
       _queueService = queueService;
  static final String baseUrl = "https://b8t6mp5v-8001.uks1.devtunnels.ms/";
  static final Dio vidoClient = Dio(BaseOptions(baseUrl: baseUrl));

  @override
  FutureResponse<StringMap> createPost({
    required Map<String, dynamic> data,
    Function(double)? onProgress,
  }) async {
    try {
      final res = await _apiService.postData(
        Endpoints.videoUpload,
        hasHeader: true,
        body: FormData.fromMap(data),
        contentType: 'multipart/form-data',
        onReceiveProgress: onProgress,
      );
      if (res.isSuccessful) {
        final raw = (res.data as Map<String, dynamic>);
        final vidRes = Map<String, dynamic>.from(raw['data']);
        return Right(
          ResponseData(data: vidRes, message: "Video created successfully"),
        );
      } else {
        return Left(
          Failure(res.message ?? "Failed to upload video, try again"),
        );
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Failed to create video ",
      );
      return Left(
        Failure("Something went wrong, Failed to create video, try again"),
      );
    }
  }

  @override
  FutureResponse<StringMap> videoSignedUrl({
    required Map<String, dynamic> data,
    Function(double)? onProgress,
  }) async {
    try {
      final res = await _apiService.postData(
        Endpoints.videoSignedUrl,
        hasHeader: true,
        body: jsonEncode(data),
        contentType: 'application/json',
        onReceiveProgress: onProgress,
      );
      if (res.isSuccessful) {
        final raw = (res.data as Map<String, dynamic>);
        final vidRes = Map<String, dynamic>.from(raw['data']);
        return Right(
          ResponseData(data: vidRes, message: "signed url fetched successfully"),
        );
      } else {
        return Left(
          Failure(res.message ?? "signed url fetch failed, try again"),
        );
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "signed url fetch failed",
      );
      return Left(
        Failure("Something went wrong, signed url fetch failed, try again"),
      );
    } 
  }

  @override
  FutureResponse<bool> dislikePost({
    required String postID,
    required bool like,
  }) {
    // TODO: implement dislikeVideo
    throw UnimplementedError();
  }

  @override
  FutureResponse<PostModel> getPost({required String postID}) {
    // TODO: implement getVideo
    throw UnimplementedError();
  }

  @override
  FutureResponse<bool> likePost({
    required String postID,
    required bool like,
  }) async {
    try {
      final res = await _apiService.postData(
        Endpoints.videoLikeToggle + postID,
        hasHeader: true,
      );
      if (res.isSuccessful) {
        final raw = Map<String, dynamic>.from(res.data as Map)['data'];
        final result = Map<String, dynamic>.from(raw);
        return Right(ResponseData(data: result['like'] as bool, message: ""));
      } else {
        // add to queue

        _queueService.addToQueue(
          endpoint: Endpoints.videoLikeToggle + postID,
          method: 'POST',
          hasHeaders: true,
        );
        return Right(ResponseData(data: like, message: res.message ?? ""));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e.toString(),
        stackTrace: s,
        reason: 'Unable to like comment',
      );

      _queueService.addToQueue(
        endpoint: Endpoints.videoLikeToggle + postID,
        method: 'POST',
        hasHeaders: true,
      );
      return Right(
        ResponseData(
          data: like,
          message: 'Unable to like video, please try again later',
        ),
      );
    }
  }

  @override
  FutureResponse<CursorPaginatedResponse<PostModel>> getPosts({
    required Map<String, dynamic> query,
  }) async {
    try {
      final res = await _apiService.getData(
        Endpoints.videoForYou,
        hasHeader: true,
        queryParameters: query,
      );

      if (res.isSuccessful) {
        final raw = (res.data as Map<String, dynamic>)['data'];
        final values = await Isolate.run(() {
          final result = CursorPaginatedResponse.fromJson(
            json: raw,
            dataFromJson: (c) => PostModel.fromJson(c as Map<String, dynamic>),
            paginationfieldName: "cursor",
            dataFieldName: 'videos',
          );

          return result;
        });

        return Right(ResponseData(data: values, message: res.message ?? ""));
      } else {
        return Left(Failure(res.message ?? "Unable to load videos, try again"));
      }
    } catch (e, s) {
      log.d(e, stackTrace: s);
      return Left(Failure("Error occured while loading videos, try again"));
    }
  }

  @override
  FutureResponse<CursorPaginatedResponse<PostModel>> getFollowingPosts({
    required Map<String, dynamic> query,
  }) async {
    try {
      final res = await _apiService.getData(
        Endpoints.videoFollowing,
        hasHeader: true,
        queryParameters: query,
      );

      if (res.isSuccessful) {
        final raw = (res.data as Map<String, dynamic>)['data'];
        if (raw.isEmpty) {
          return Right(
            ResponseData(
              data: CursorPaginatedResponse.emptyPaginatedResponse(),
              message: "No videos found",
            ),
          );
        }
        final values = await Isolate.run(() {
          final result = CursorPaginatedResponse.fromJson(
            json: raw,
            dataFromJson: (c) => PostModel.fromJson(c as Map<String, dynamic>),
            paginationfieldName: "cursor",
            dataFieldName: 'videos',
          );

          return result;
        });

        return Right(ResponseData(data: values, message: res.message ?? ""));
      } else {
        return Left(Failure(res.message ?? "Unable to load videos, try again"));
      }
    } catch (e, s) {
      log.d(e, stackTrace: s);
      return Left(Failure("Error occured while loading videos, try again"));
    }
  }

  @override
  Stream<PostModel> onPostUpdate() {
    return Stream<PostModel>.multi((controller) {
      SocketIOManager.instance.listenToEvent(
        event: 'video_update',
        callback: (data) {
          try {
            final video = PostModel.fromJson(jsonDecode(data));
            controller.add(video);
          } catch (e, s) {
            LoggerService.logError(
              error: e.toString(),
              stackTrace: s,
              reason: 'Unable to listen to video_update',
            );
            controller.addError('Something went wrong');
          }
        },
      );
    });
  }

  @override
  FutureResponse<bool> savePost({
    required String postID,
    required bool saved,
  }) async {
    try {
      final res = await _apiService.postData(
        saved
            ? Endpoints.saveVideo.replaceFirst('videoId', postID) + postID
            : Endpoints.unsaveVideo.replaceFirst('videoId', postID),
        hasHeader: true,
      );
      if (res.isSuccessful) {
        final raw = Map<String, dynamic>.from(res.data as Map)['data'];
        final result = Map<String, dynamic>.from(raw);
        return Right(ResponseData(data: result['like'] as bool, message: ""));
      } else {
        // add to queue
        _queueService.addToQueue(
          endpoint:
              saved
                  ? Endpoints.saveVideo.replaceFirst('videoId', postID) + postID
                  : Endpoints.unsaveVideo.replaceFirst('videoId', postID),
          method: 'POST',
          hasHeaders: true,
        );
        return Right(ResponseData(data: saved, message: res.message ?? ""));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e.toString(),
        stackTrace: s,
        reason: 'Unable to save video',
      );

      _queueService.addToQueue(
        endpoint:
            saved
                ? Endpoints.saveVideo.replaceFirst('videoId', postID) + postID
                : Endpoints.unsaveVideo.replaceFirst('videoId', postID),
        method: 'POST',
        hasHeaders: true,
      );
      return Right(
        ResponseData(
          data: saved,
          message: 'Unable to like save post, please try again later',
        ),
      );
    }
  }
}

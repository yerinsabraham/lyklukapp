import 'dart:convert';
import 'dart:isolate';

import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/queue_system/queue_service.dart';
import 'package:lykluk/core/shared/resources/typedefs.dart';
import 'package:lykluk/modules/comments/data/model/comment_model.dart';
import 'package:lykluk/modules/comments/domain/repo/comment_repository.dart';
import 'package:lykluk/utils/pagination/pagination.dart';
import 'package:lykluk/core/services/network/socket_io_manager.dart';

import '../../../../core/services/services.dart';
import '../../../../core/shared/resources/failure.dart';
import '../../../../core/shared/resources/response_data.dart';
import 'package:lykluk/core/services/network/endpoints.dart';

final commentRepoProvider = Provider<CommentRepository>(
  (ref) => CommentRepoImpl(ref.read(apiServiceProvider), ref.read(queueServiceProvider)),
);

class CommentRepoImpl implements CommentRepository {
  // static final _logger = LoggerService;
  final ApiService _apiService;
  final QueueService _queueService;
  const CommentRepoImpl(this._apiService, this._queueService);
  @override
  FutureResponse<String> deleteComment({required String commentId}) {
    // TODO: implement deleteComment
    throw UnimplementedError();
  }

  @override
  FutureResponse<PaginatedResponse<CommentModel>> getComments({
    required String videoId,
    required Map<String, dynamic> query,
  }) async {
    try {
      final res = await _apiService.getData(
        Endpoints.commentToVideo + videoId,
        hasHeader: true,
        queryParameters: query,
      );
      if (res.isSuccessful) {
        final raw = Map<String, dynamic>.from(res.data as Map);
        if ((raw['data'] as List).isEmpty) {
          return Right(
            ResponseData(
              data: PaginatedResponse.empty(),
              message: "No comments found",
            ),
          );
        }
        final result = await Isolate.run(() {
          final result = PaginatedResponse.fromJson(
            fieldName: "data",
            json: raw,
            dataFromJson:
                (d) => CommentModel.fromJson(d as Map<String, dynamic>),
          );
          return result;
        });

        return Right(ResponseData(data: result, message: ""));
      } else {
        return Left(Failure("Unable to get comments"));
      }
    } catch (e, s) {
      log.d(e, stackTrace: s);
      return Left(
        Failure("Error occured while getting comments, please try again later"),
      );
    }
  }

  @override
  FutureResponse<PaginatedResponse<CommentModel>> getReplies({
    required String commentId,
    required String videoId,
    required Map<String, dynamic> query,
  }) async {
    try {
      final res = await _apiService.getData(
        "${Endpoints.videoComments}$videoId/reply/$commentId",
        hasHeader: true,
        queryParameters: query,
      );
      if (res.isSuccessful) {
        final raw = Map<String, dynamic>.from(res.data as Map);
        if ((raw['data'].runtimeType == List) && (raw['data'] as List).isEmpty) {
          return Right(
            ResponseData(
              data: PaginatedResponse.empty(),
              message: "No comments found",
            ),
          );
        }
        final result = await Isolate.run(() {
          final result = PaginatedResponse.fromJson(
            fieldName: "replyFrom",
            json: raw['data'],
            dataFromJson:
                (d) => CommentModel.fromJson(d as Map<String, dynamic>),
          );
          return result;
        });

        return Right(ResponseData(data: result, message: ""));
      } else {
        return Left(Failure("Unable to get comments"));
      }
    } catch (e, s) {
      log.d(e, stackTrace: s);
      return Left(
        Failure("Error occured while getting comments, please try again later"),
      );
    }
  }

  @override
  FutureResponse<StringMap> likeComment({required String commentId}) async {
    try {
      final res = await _apiService.postData(
        "${Endpoints.commentLike}/$commentId",
        hasHeader: true,
      );
      if (res.isSuccessful) {
        final raw = Map<String, dynamic>.from(res.data as Map);
        final result = Map<String, dynamic>.from(raw['data']);
        return Right(ResponseData(data: result, message: ""));
      } else {
        // return Left(Failure("Unable to like comment"));
        // add to queue
        _queueService.addToQueue(
        endpoint:   "${Endpoints.commentLike}/$commentId",
        method: 'POST',
        hasHeaders: true,
        );
        return Right(ResponseData(data: {}, message: ""));
      }
    } catch (e, s) {
      // log.d(e, stackTrace: s);
      LoggerService.logError(
        error: e.toString(),
        stackTrace: s,
        reason: 'Unable to like comment',
      );
      // return Left(
      //   Failure("Error occured while liking a comment, please try again later"),
      // );
          _queueService.addToQueue(
        endpoint: "${Endpoints.commentLike}/$commentId",
        method: 'POST',
        hasHeaders: true,
      );
      return Right(ResponseData(data: {}, message: ""));
    }
  }

  @override
  FutureResponse<CommentModel> replyToComment({
    required String commentId,
    required String videoId, 
    required Map<String, dynamic> data,
  }) async{
   try {
      final res = await _apiService.postData(
        Endpoints.commentReply.replaceFirst("videoId", videoId).replaceFirst("commentId", commentId),
        hasHeader: true,
        body: data,
      );
      if (res.isSuccessful) {
        final raw = Map<String, dynamic>.from(res.data as Map);
        final result = CommentModel.fromJson(raw['data']);
        return Right(ResponseData(data: result, message: ""));
      } else {
        return Left(Failure("Unable to send comment"));
      }
    } catch (e, s) {
      // log.d(e, stackTrace: s);
      LoggerService.logError(
        error: e.toString(),
        stackTrace: s,
        reason: 'Unable to send comment',
      );
      return Left(
        Failure("Error occured while sending comment, please try again later"),
      );
    }
  }

  @override
  FutureResponse<CommentModel> sendComment({
    required Map<String, dynamic> data,
    required String videoId,
  }) async {
    try {
      final res = await _apiService.postData(
        Endpoints.commentToVideo + videoId,
        hasHeader: true,
        body: data,
      );
      if (res.isSuccessful) {
        final raw = Map<String, dynamic>.from(res.data as Map);
        final result = CommentModel.fromJson(raw['data']);
        return Right(ResponseData(data: result, message: ""));
      } else {
        return Left(Failure("Unable to send comment"));
      }
    } catch (e, s) {
      // log.d(e, stackTrace: s);
      LoggerService.logError(
        error: e.toString(),
        stackTrace: s,
        reason: 'Unable to send comment',
      );
      return Left(
        Failure("Error occured while sending comment, please try again later"),
      );
    }
  }

  @override
  Stream<CommentModel> onCommentUpdate() {
    return Stream<CommentModel>.multi((controller) {
      SocketIOManager.instance.listenToEvent(
        event: 'video_update',
        callback: (data) {
          try {
            final video = CommentModel.fromJson(jsonDecode(data));
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
}

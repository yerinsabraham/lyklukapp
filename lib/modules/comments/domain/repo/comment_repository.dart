import 'package:lykluk/core/shared/resources/typedefs.dart';
import 'package:lykluk/modules/comments/data/model/comment_model.dart';
import 'package:lykluk/utils/pagination/pagination.dart';

abstract class CommentRepository {

  /// send comment on a video
  FutureResponse<CommentModel> sendComment({required Map<String ,dynamic> data,  required String videoId});

  /// get video comments
  FutureResponse<PaginatedResponse<CommentModel>> getComments({required String videoId, required Map<String, dynamic> query});
  /// get comment replies
  FutureResponse<PaginatedResponse<CommentModel>> getReplies({required String commentId, required String videoId,
    required Map<String, dynamic> query});

  /// reply to a comment
  FutureResponse<CommentModel> replyToComment({required String commentId, required String videoId, required Map<String, dynamic> data});

  /// delete comment
  FutureResponse<String> deleteComment({required String commentId});

  /// like a comment
  FutureResponse<StringMap> likeComment({required String commentId});

  /// on comment update
Stream<CommentModel> onCommentUpdate();





}

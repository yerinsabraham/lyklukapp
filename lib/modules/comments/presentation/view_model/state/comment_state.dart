import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/model/comment_model.dart';
part 'comment_state.freezed.dart';

@freezed
abstract class CommentState with _$CommentState {
   const factory CommentState.initial() = CommentStateInitial;
   const factory CommentState.sending() = SendingComment;
   const factory CommentState.sent({required String message, required CommentModel comment}) = SentComment;
  const  factory CommentState.sendingFailed({required String message}) = SendingCommentFailed;

   /// like comment
  const  factory CommentState.likeSucess({  required String message,required CommentModel comment}) = LikeSucess;
const  factory CommentState.likeFailed({required String message, required CommentModel comment}) = LikeFailed;
  /// reply comment
  const factory CommentState.replying() = ReplyingComment;
  const factory CommentState.replied({required String message,required CommentModel comment, required String replyToId}) = RepliedComment;
  const factory CommentState.replyingCommentFailed({required String message}) =ReplyingCommentFailed;
}
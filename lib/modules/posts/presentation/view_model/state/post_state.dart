import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/shared/resources/typedefs.dart';
import '../../../data/model/post_model.dart';

part 'post_state.freezed.dart';

@freezed
class PostState with _$PostState {
  const factory PostState.initial() = PostInitial;

  const factory PostState.uploading({@Default(0.0) double progress}) = PostUploading;

  const factory PostState.uploaded({required StringMap post}) = PostUploaded;

  const factory PostState.uploadError({required String message}) = PostUploadError;

  /// like/unlike states
  const factory PostState.liked({required PostModel post}) = PostLiked;

  const factory PostState.unliked({required PostModel post}) = PostUnliked;

  const factory PostState.likeFailed({required PostModel post, required String message}) = PostLikeFailed;


  /// save/unsave states
  const factory PostState.saved({required PostModel post}) = PostSaved;
  
  const factory PostState.unsaved({required PostModel post}) = PostUnsaved;

  const factory PostState.saveFailed({required PostModel post, required String message}) = PostSaveFailed;
}

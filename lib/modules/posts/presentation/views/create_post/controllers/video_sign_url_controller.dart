// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostVideoSignUrlRequestParams extends Equatable {
  final String videoFilename;
  final String videoMime;
  final String thumbnailFilename;
  final String thumbnailMime;
  final String? description;
  final int commentPrivacy;
  final bool allowShare;
  final bool allowComment;
  final int privacy;

  const PostVideoSignUrlRequestParams({
    required this.videoFilename,
    required this.videoMime,
    required this.thumbnailFilename,
    required this.thumbnailMime,
    this.description,
    this.commentPrivacy = 1,
    this.allowShare = true,
    this.allowComment = true,
    this.privacy = 1,
  });

  PostVideoSignUrlRequestParams copyWith({
    String? videoFilename,
    String? videoMime,
    String? thumbnailFilename,
    String? thumbnailMime,
    String? description,
    int? commentPrivacy,
    bool? allowShare,
    bool? allowComment,
    int? privacy,
  }) {
    return PostVideoSignUrlRequestParams(
      videoFilename: videoFilename ?? this.videoFilename,
      videoMime: videoMime ?? this.videoMime,
      thumbnailFilename: thumbnailFilename ?? this.thumbnailFilename,
      thumbnailMime: thumbnailMime ?? this.thumbnailMime,
      description: description ?? this.description,
      commentPrivacy: commentPrivacy ?? this.commentPrivacy,
      allowShare: allowShare ?? this.allowShare,
      allowComment: allowComment ?? this.allowComment,
      privacy: privacy ?? this.privacy,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'video_filename': videoFilename,
      'video_mime': videoMime,
      'thumbnail_filename': thumbnailFilename,
      'thumbnail_mime': thumbnailMime,
      'description': description,
      'comment_privacy': commentPrivacy,
      'allow_share': allowShare,
      'allow_comment': allowComment,
      'privacy': privacy,
    };
  }

  @override
  List<Object?> get props => [
        videoFilename,
        videoMime,
        thumbnailFilename,
        thumbnailMime,
        description,
        commentPrivacy,
        allowShare,
        allowComment,
        privacy,
      ];
}

final postVideoSignUrlParamsController = StateProvider((_) => const PostVideoSignUrlRequestParams(
      videoFilename: '',
      videoMime: '',
      thumbnailFilename: '',
      thumbnailMime: '',
    ));

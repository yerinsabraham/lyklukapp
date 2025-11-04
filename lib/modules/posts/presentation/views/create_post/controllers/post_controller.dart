// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostRequesParams  extends Equatable {
final String? description;
final File? video;
final File? thumbnail;
 final bool allowComment;
 final bool allowShare;
 final bool allowLike;
 final int commentPrivacy;
 final int privacy;
 final String? visibilty;

const PostRequesParams({
    this.description,
    this.video,
    this.thumbnail,
    this.allowComment = true,
    this.allowShare = true,
    this.allowLike = true,
    this.commentPrivacy = 1,
    this.privacy = 1,
    this.visibilty,
  });

  PostRequesParams copyWith({
    String? description,
    File? video,
    File? thumbnail,
    bool? allowComment,
    bool? allowShare,
    int? commentPrivacy,
    int? privacy,
    String? visibilty,
    bool? allowLike,
  }) {
    return PostRequesParams(
      description: description ?? this.description,
      video: video ?? this.video,
      thumbnail: thumbnail ?? this.thumbnail,
      allowComment: allowComment ?? this.allowComment,
      allowShare: allowShare ?? this.allowShare,
      commentPrivacy: commentPrivacy ?? this.commentPrivacy,
      privacy: privacy ?? this.privacy,
      visibilty: visibilty ?? this.visibilty,
      allowLike: allowLike ?? this.allowLike,
    );
  }

  Future<Map<String, dynamic>> toMap() async {
    return <String, dynamic>{
      'description': description,
      'video': await MultipartFile.fromFile(video!.path), 
      'thumbnail': await MultipartFile.fromFile(thumbnail!.path),
      'allow_comment': allowComment,
      'allow_share': allowShare,
      'allow_like': allowLike,
      'comment_privacy': commentPrivacy,
      'privacy': privacy,
      'visibilty': visibilty,
    };
  }
  
  @override

  List<Object?> get props => [
    description,
    video,
    thumbnail,
    allowComment,
    allowShare,
    allowLike,
    commentPrivacy,
    privacy,
    visibilty,

  ];
}

final postParamsController = StateProvider((_) => PostRequesParams());

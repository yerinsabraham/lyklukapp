import 'package:lykluk/modules/profile/data/models/user_profile.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/router/app_router.dart';
import 'package:lykluk/utils/storage/local_storage.dart';

class CommentModel {
  CommentModel({
    required this.id,
    this.comment,
    this.userId,
    this.replyToId,
    required this.videoId,
    this.createdAt,
    this.updatedAt,
    this.user,
    required this.count,
    this.commentLikes = const [],
  });

  final int id;
  final String? comment;
  final int? userId;
  final int? replyToId;
  final int videoId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final UserProfile? user;
  final CommentCount count;
  final List<CommentLike> commentLikes;

  CommentModel copyWith({
    int? id,
    String? comment,
    int? userId,
    int? replyToId,
    int? videoId,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserProfile? user,
    CommentCount? count,
    List<CommentLike>? commentLikes,
  }) {
    return CommentModel(
      id: id ?? this.id,
      comment: comment ?? this.comment,
      userId: userId ?? this.userId,
      replyToId: replyToId ?? this.replyToId,
      videoId: videoId ?? this.videoId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
      count: count ?? this.count,
      commentLikes: commentLikes ?? this.commentLikes,
    );
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json["id"],
      comment: json["comment"],
      userId: json["userId"],
      replyToId: json["replyToId"],
      videoId: json["videoId"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      user: json["User"] == null ? null : UserProfile.fromJson(json["User"]),
      count:
          json["_count"] == null
              ? CommentCount()
              : CommentCount.fromJson(json["_count"]),
      commentLikes:
          json["comment_likes"] == null
              ? []
              : List<CommentLike>.from(
                json["comment_likes"]!.map((x) => CommentLike.fromJson(x)),
              ),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "comment": comment,
    "userId": userId,
    "replyToId": replyToId,
    "videoId": videoId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "user": user?.toJson(),
    "_count": count.toJson(),
  };

  @override
  String toString() {
    return "$id, $comment, $userId, $replyToId, $videoId, $createdAt, $updatedAt, ${user?.toJson()} ";
  }
}

class CommentCount {
  CommentCount({this.replyFrom = 0, this.commentLikes = 0});

  final int replyFrom;
  final int commentLikes;

  CommentCount copyWith({int? replyFrom, int? commentLikes}) {
    return CommentCount(
      replyFrom: replyFrom ?? this.replyFrom,
      commentLikes: commentLikes ?? this.commentLikes,
    );
  }

  factory CommentCount.fromJson(Map<String, dynamic> json) {
    return CommentCount(
      replyFrom: json["replyFrom"] ?? 0,
      commentLikes: json["comment_likes"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "replyFrom": replyFrom,
    "comment_likes": commentLikes,
  };

  @override
  String toString() {
    return "$replyFrom, $commentLikes, ";
  }
}

class CommentLike {
  CommentLike({required this.user});

  final UserProfile? user;

  CommentLike copyWith({UserProfile? user}) {
    return CommentLike(user: user ?? this.user);
  }

  factory CommentLike.fromJson(Map<String, dynamic> json) {
    return CommentLike(
      user: json["User"] == null ? null : UserProfile.fromJson(json["User"]),
    );
  }

  Map<String, dynamic> toJson() => {"User": user?.toJson()};

  @override
  String toString() {
    return "$user, ";
  }
}

extension CommentModelX on CommentModel {
  String get header {
    // 'Block Global Roots 🌍🌳 · 9m · Author '
    return "${user?.phone?.name.capitalize ?? user?.plainUsername.capitalize ?? ""} · ${createdAt?.toAgo ?? ""} · Author ";
  }
  String get header2 {
    // 'Block Global Roots 🌍🌳 · 9m · Author '
    return "${user?.phone?.name.capitalize ?? user?.plainUsername.capitalize ?? ""} · ${createdAt?.toTime ?? ""}";
  }


  

  String get avatarUrl {
    return user?.profile?.avatar ?? "";
  }

  bool get  isLiked {
    return commentLikes.any((element) => element.user?.username == HiveStorage.getUser.username);
  }
}

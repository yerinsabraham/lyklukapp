import 'package:equatable/equatable.dart';
import 'package:lykluk/utils/extensions/datetime_extension.dart';
import '../../../../core/shared/model/profile_model.dart';
import '../../../profile/data/models/user_profile.dart';

class PostModel extends Equatable {
  const PostModel({
    required this.id,
     this.uuid,
     this.key,
     this.outputKey,
     this.description,
     this.thumbNail,
     this.settings,
     this.user,
     required this.count,
     this.createAt,
    this.hls,
    this.videoLikes = const [],
    this.isLiked = false,
    this.isSaved = false,
    this.commented = false,
  });

  final int id;
  final String? uuid;
  final String? key;
  final String? outputKey;
  final String? description;
  final String? thumbNail;
  final PostSettings? settings;
  final PostUser? user;
  final PostCount count;
  final DateTime? createAt;
  final String? hls;
  final List<VideoLikes> videoLikes;
  final bool isLiked;
  final bool isSaved;
  final bool commented;

  PostModel copyWith({
    int? id,
    String? uuid,
    String? key,
    String? outputKey,
    String? description,
    String? thumbNail,
    PostSettings? settings,
    PostUser? user,
    PostCount? count,
    DateTime? createAt,
    String? hls,
    List<VideoLikes>? videoLikes,
    bool? isLiked,
    bool? isSaved,
    bool? commented,
  }) {
    return PostModel(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      key: key ?? this.key,
      outputKey: outputKey ?? this.outputKey,
      description: description ?? this.description,
      thumbNail: thumbNail ?? this.thumbNail,
      settings: settings ?? this.settings,
      user: user ?? this.user,
      count: count ?? this.count,
      createAt: createAt ?? this.createAt,
      hls: hls ?? this.hls,
      videoLikes: videoLikes ?? this.videoLikes,
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
      commented: commented ?? this.commented,
    );
  }

  factory PostModel.empty() {
    return PostModel(
      id: 0,
      uuid: "",
      key: "",
      outputKey: "",
      description: "",
      thumbNail: "",
      settings: PostSettings(
        id: 0,
        privacyLevel: 0,
        commentPrivacyLevel: 0,
        allowShare: false,
        allowComment: false,
        status: 0,
      ),
      user: PostUser(
        username: "",
        profile: ProfileModel.empty(),
        verifiedProfile: false,
      ),
      count: PostCount(comments: 0, videoLikes: 0, videoViews: 0),
      createAt: DateTime.now(),
      hls: "",
      videoLikes: [],
      isLiked: false,
      isSaved: false,
      commented: false,
    );
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json["id"],
      uuid: json["uuid"],
      key: json["key"],
      outputKey: json["output_key"],
      description: json["description"],
      thumbNail: json["thumbNail"],
      settings:
          json["settings"] == null
              ? null
              : PostSettings.fromJson(json["settings"]),
      user: json["User"] == null ? null : PostUser.fromJson(json["User"]),
      count:
          json["_count"] == null
              ? PostCount()
              : PostCount.fromJson(json["_count"]),
      createAt: DateTime.tryParse(json["createdAt"] ?? ""),
      videoLikes:
          json['videoLikes'] == null
              ? []
              : List.from(
                json['videoLikes'],
              ).map((e) => VideoLikes.fromJson(e)).toList(),
        isLiked: json['isLiked'] ?? false,
        isSaved: json['isSaved'] ?? false,
        commented: json['commented'] ?? false,
    );
  }
  factory PostModel.fromApiVideosJson(Map<String, dynamic> json) {
    return PostModel(
      id: json["videoId"],
      uuid: json["uuid"],
      key: json["key"],
      outputKey: json["output_key"],
      description: json["title"],
      thumbNail: json["thumbNail"],
      settings:
          json["settings"] == null
              ? null
              : PostSettings.fromJson(json["settings"]),
      user: json["User"] == null ? null : PostUser.fromJson(json["User"]),
      count:
          json["_count"] == null
              ? PostCount()
              : PostCount.fromJson(json["_count"]),
      createAt: DateTime.tryParse(json["createdAt"] ?? ""),
      hls: json['assets']?["hls"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "key": key,
    "output_key": outputKey,
    "description": description,
    "thumbNail": thumbNail,
    "settings": settings?.toJson(),
    "User": user?.toJson(),
    "_count": count.toJson(),
    "createdAt": createAt?.toUtc().toIso8601String(),
    "videoLikes": videoLikes.map((e) => e.toJson()).toList(),
  };

  @override
  String toString() {
    return "$id, $uuid, $key, $outputKey, $description, $thumbNail, $settings, $user, $count, $createAt, $hls, $videoLikes, $isLiked, $isSaved, $commented, ";
  }

  @override
  List<Object?> get props => [
    id,
    uuid,
    key,
    outputKey,
    description,
    thumbNail,
    settings,
    user,
    count,
    createAt,
    hls,
    videoLikes,
    isLiked,
    isSaved,
    commented,
  ];
}

class PostCount extends Equatable {
  const PostCount({
    this.comments = 0,
    this.videoLikes = 0,
    this.videoViews = 0,
  });

  final int comments;
  final int videoLikes;
  final int videoViews;

  PostCount copyWith({int? comments, int? videoLikes, int? videoViews}) {
    return PostCount(
      comments: comments ?? this.comments,
      videoLikes: videoLikes ?? this.videoLikes,
      videoViews: videoViews ?? this.videoViews,
    );
  }

  factory PostCount.fromJson(Map<String, dynamic> json) {
    return PostCount(
      comments: json["comments"] ?? 0,
      videoLikes: json["video_likes"] ?? 0,
      videoViews: json["video_views"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "comments": comments,
    "video_likes": videoLikes,
    "video_views": videoViews,
  };

  @override
  String toString() {
    return "$comments, $videoLikes, $videoViews, ";
  }

  @override
  List<Object?> get props => [comments, videoLikes, videoViews];
}

class VideoLikes {
  VideoLikes({required this.user});

  final UserProfile? user;

  VideoLikes copyWith({UserProfile? user}) {
    return VideoLikes(user: user ?? this.user);
  }

  factory VideoLikes.fromJson(Map<String, dynamic> json) {
    return VideoLikes(
      user: json["User"] == null ? null : UserProfile.fromJson(json["User"]),
    );
  }

  Map<String, dynamic> toJson() => {"User": user?.toJson()};

  @override
  String toString() {
    return "$user, ";
  }
}

class PostSettings extends Equatable {
  const PostSettings({
    required this.id,
    required this.privacyLevel,
    required this.commentPrivacyLevel,
    required this.allowShare,
    required this.allowComment,
    required this.status,
  });

  final int? id;
  final int? privacyLevel;
  final int? commentPrivacyLevel;
  final bool? allowShare;
  final bool? allowComment;
  final int? status;

  PostSettings copyWith({
    int? id,
    int? privacyLevel,
    int? commentPrivacyLevel,
    bool? allowShare,
    bool? allowComment,
    int? status,
  }) {
    return PostSettings(
      id: id ?? this.id,
      privacyLevel: privacyLevel ?? this.privacyLevel,
      commentPrivacyLevel: commentPrivacyLevel ?? this.commentPrivacyLevel,
      allowShare: allowShare ?? this.allowShare,
      allowComment: allowComment ?? this.allowComment,
      status: status ?? this.status,
    );
  }

  factory PostSettings.fromJson(Map<String, dynamic> json) {
    return PostSettings(
      id: json["id"],
      privacyLevel: json["privacyLevel"],
      commentPrivacyLevel: json["commentPrivacyLevel"],
      allowShare: json["allowShare"],
      allowComment: json["allowComment"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "privacyLevel": privacyLevel,
    "commentPrivacyLevel": commentPrivacyLevel,
    "allowShare": allowShare,
    "allowComment": allowComment,
    "status": status,
  };

  @override
  String toString() {
    return "$id, $privacyLevel, $commentPrivacyLevel, $allowShare, $allowComment, $status, ";
  }

  @override
  List<Object?> get props => [
    id,
    privacyLevel,
    commentPrivacyLevel,
    allowShare,
    allowComment,
    status,
  ];
}

class PostUser extends Equatable {
  const PostUser({
    required this.username,
    required this.profile,
    required this.verifiedProfile,
  });

  final String? username;
  final ProfileModel? profile;
  final bool? verifiedProfile;

  PostUser copyWith({
    String? username,
    ProfileModel? profile,
    bool? verifiedProfile,
  }) {
    return PostUser(
      username: username ?? this.username,
      profile: profile ?? this.profile,
      verifiedProfile: verifiedProfile ?? this.verifiedProfile,
    );
  }

  factory PostUser.fromJson(Map<String, dynamic> json) {
    return PostUser(
      username: json["username"],
      profile:
          json["profile"] == null
              ? null
              : ProfileModel.fromJson(json["profile"]),
      verifiedProfile: json["verified_profile"],
    );
  }

  Map<String, dynamic> toJson() => {
    "username": username,
    "profile": profile?.toJson(),
    "verified_profile": verifiedProfile,
  };

  @override
  String toString() {
    return "$username, $profile, $verifiedProfile, ";
  }

  @override
  List<Object?> get props => [username, profile, verifiedProfile];
}

extension PostModelExtension on PostModel {
  String get url {
    return outputKey ?? key ?? "";
  }

  String get thumbNailUrl {
    return thumbNail ?? "";
  }

  String get availableName {
    return user?.profile?.name ??
        user?.username?.split("@")[1] ??
        "Unknown User";
  }

  String get userProfileImage {
    return user?.profile?.avatar ?? "";
  }

  String get timeAt {
    return createAt?.toAgo ?? "";
  }

  // bool get isLiked {
  //   return videoLikes.any(
  //     (element) => element.user?.username == HiveStorage.getUser.username,
  //   );
  // }
}

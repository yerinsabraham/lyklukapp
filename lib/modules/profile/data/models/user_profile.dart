import 'package:lykluk/core/shared/model/profile_model.dart';

class UserProfile {
  UserProfile({
     required this.id,
    this.email,
    this.phone,
    this.username = "",
    this.profile,
    this.verifiedProfile,
    this.followedBy = const [],
    this.count,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    this.deletedAt,
  });
  final int id;
  final String? email;
  final String? phone;
  final String username;
  final ProfileModel? profile;
  final bool? verifiedProfile;
  final List<dynamic> followedBy;
  final Count? count;
  final DateTime? emailVerifiedAt;
  final DateTime? phoneVerifiedAt;
  final DateTime? deletedAt;

  UserProfile copyWith({
    int? id,
    String? email,
    String? phone,
    String? username,
    ProfileModel? profile,
    bool? verifiedProfile,
    List<dynamic>? followedBy,
    Count? count,
    DateTime? emailVerifiedAt,
    DateTime? phoneVerifiedAt,
    DateTime? deletedAt,
  }) {
    return UserProfile(
      id:  id?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      username: username ?? this.username,
      profile: profile ?? this.profile,
      verifiedProfile: verifiedProfile ?? this.verifiedProfile,
      followedBy: followedBy ?? this.followedBy,
      count: count ?? this.count,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      phoneVerifiedAt: phoneVerifiedAt ?? this.phoneVerifiedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  factory UserProfile.empty() {
    return UserProfile(
      id: 0,
      email: null,
      phone: null,
      username: "",
      profile: null,
      verifiedProfile: null,
      followedBy: [],
      count: Count(followedBy: 0, following: 0, likes: 0),
      emailVerifiedAt: null,
      phoneVerifiedAt: null,
      deletedAt: null,
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json["id"]?? 0,
      email: json["email"],
      phone: json["phone"],
      username: json["username"] ?? "",
      profile:
          json["profile"] == null
              ? null
              : ProfileModel.fromJson(json["profile"]),
      verifiedProfile: json["verified_profile"] ?? false,
      followedBy:
          json["followedBy"] == null
              ? []
              : List<dynamic>.from(json["followedBy"]!.map((x) => x)),
      count:
          json["_count"] == null
              ? Count(followedBy: 0, following: 0, likes: 0)
              : Count.fromJson(json["_count"]),
      emailVerifiedAt: DateTime.tryParse(json["email_verified_at"] ?? ""),
      phoneVerifiedAt: DateTime.tryParse(json["phone_verified_at"] ?? ""),
      deletedAt: DateTime.tryParse(json["deletedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "email": email,
    "phone": phone,
    "username": username,
    "profile": profile?.toJson(),
    "verified_profile": verifiedProfile,
    "followedBy": followedBy.map((x) => x).toList(),
    "_count": count?.toJson(),
  };

  @override
  String toString() {
    return "$email, $phone, $username, $profile, $verifiedProfile, $followedBy, $count, ";
  }
}

class Count {
  Count({
    required this.followedBy,
    required this.following,
    required this.likes,
  });

  final int followedBy;
  final int following;
  final int likes;

  Count copyWith({int? followedBy, int? following, int? likes}) {
    return Count(
      followedBy: followedBy ?? this.followedBy,
      following: following ?? this.following,
      likes: likes ?? this.likes,
    );
  }

  factory Count.fromJson(Map<String, dynamic> json) {
    return Count(
      followedBy: json["followedBy"],
      following: json["following"],
      likes: json["likes"],
    );
  }

  Map<String, dynamic> toJson() => {
    "followedBy": followedBy,
    "following": following,
    "likes": likes,
  };

  @override
  String toString() {
    return "$followedBy, $following, $likes, ";
  }
}

extension UserProfileX on UserProfile {
  String get plainUsername {
    if (username.contains('@')) {
      final parts = username.split('@');
      return parts.length > 1 ? parts[1] : username;
    }
    return username;
  }

  bool get isSetup => profile?.name != null && profile?.bio != null;

  String? get imageUrl {
    if (profile?.avatar != null) {
      return "${profile?.avatar}";
    }
    return null;
  }

  String get displayName {
    /// remove @ in front of userName
    return "@${username.substring(1)}";
  }
}

import 'package:equatable/equatable.dart';



import '../../../../core/shared/model/profile_model.dart';

class OtherUser extends Equatable {
  const OtherUser({required this.id, required this.following});

  final int id;
  final Following? following;

  OtherUser copyWith({int? id, Following? following}) {
    return OtherUser(
      id: id ?? this.id,
      following: following ?? this.following,
    );
  }

  factory OtherUser.fromJson(Map<String, dynamic> json) {
    final dynamic followerOrFollowing = json["follower"] ?? json["following"];
    return OtherUser(
      id: json["id"],
      following: followerOrFollowing == null
          ? null
          : Following.fromJson(followerOrFollowing as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "follower": following?.toJson(),
        "following": following?.toJson(),
      };

  @override
  String toString() {
    return "$id, $following, ";
  }

  @override
  List<Object?> get props => [id, following];
}

class Following extends Equatable {
  const Following({
    required this.username,
    required this.profile,
    required this.verifiedProfile,
    required this.isFollowedByCurrentUser,
  });

  final String? username;
  final ProfileModel? profile;
  final bool? verifiedProfile;
  final bool? isFollowedByCurrentUser;

  Following copyWith({
    String? username,
    ProfileModel? profile,
    bool? verifiedProfile,
    bool? isFollowedByCurrentUser,    
  }) {
    return Following(
      username: username ?? this.username,
      profile: profile ?? this.profile,
      verifiedProfile: verifiedProfile ?? this.verifiedProfile,
      isFollowedByCurrentUser: isFollowedByCurrentUser ?? this.isFollowedByCurrentUser,
    );
  }

  factory Following.fromJson(Map<String, dynamic> json) {
    return Following(
      username: json["username"],
      profile:
          json["profile"] == null
              ? null
              : ProfileModel.fromJson(json["profile"]),
      verifiedProfile: json["verified_profile"],
      isFollowedByCurrentUser: json["isFollowedByCurrentUser"],
    );
  }

  Map<String, dynamic> toJson() => {
    "username": username,
    "profile": profile?.toJson(),
    "verified_profile": verifiedProfile,
    "isFollowedByCurrentUser": isFollowedByCurrentUser
  };

  @override
  String toString() {
    return "$username, $profile, $verifiedProfile, $isFollowedByCurrentUser, ";
  }

  @override
  List<Object?> get props => [username, profile, verifiedProfile, isFollowedByCurrentUser];
}

// class FollowedBy extends Equatable {
//   const FollowedBy({
//     required this.id,
//     required this.followerId,
//     required this.followingId,
//     required this.createdAt,
//   });

//   final int? id;
//   final int? followerId;
//   final int? followingId;
//   final DateTime? createdAt;

//   FollowedBy copyWith({
//     int? id,
//     int? followerId,
//     int? followingId,
//     DateTime? createdAt,
//   }) {
//     return FollowedBy(
//       id: id ?? this.id,
//       followerId: followerId ?? this.followerId,
//       followingId: followingId ?? this.followingId,
//       createdAt: createdAt ?? this.createdAt,
//     );
//   }

//   factory FollowedBy.fromJson(Map<String, dynamic> json) {
//     return FollowedBy(
//       id: json["id"],
//       followerId: json["followerId"],
//       followingId: json["followingId"],
//       createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "followerId": followerId,
//     "followingId": followingId,
//     "createdAt": createdAt?.toIso8601String(),
//   };

//   @override
//   String toString() {
//     return "$id, $followerId, $followingId, $createdAt, ";
//   }

//   @override
//   List<Object?> get props => [id, followerId, followingId, createdAt];
// }



extension ProfileExt on OtherUser {
  String get profileUrl {
    return "${following?.profile?.avatar}";
  }

  String get abbrev {
    final sp = following?.profile?.name?.split(" ") ?? [];
    if (sp.isEmpty) return 'AN';
    return sp.map((e) => e.substring(0, 1)).toList().join().toUpperCase();
  }
}



// eyJraWQiOiJZUXJxZE1ENGJxIiwiYWxnIjoiUlMyNTYifQ.eyJpc3MiOiJodHRwczovL2FwcGxlaWQuYXBwbGUuY29tIiwiYXVkIjoiY29tLmx5a2x1ay5seWtsdWtEZXYiLCJleHAiOjE3NjAwMDY3OTIsImlhdCI6MTc1OTkyMDM5Miwic3ViIjoiMDAwNzQ0LjZlZmEwNzVkMjBmMzQ1ZDM5NzU5MGMyODAwNDgwNDM5LjAxMzEiLCJjX2hhc2giOiJuNDM3S3U2UFdfbFhoNVVuTmdUWU5nIiwiZW1haWwiOiJkaW1lamlhd295ZWZhNUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiYXV0aF90aW1lIjoxNzU5OTIwMzkyLCJub25jZV9zdXBwb3J0ZWQiOnRydWV9.RDDuavouKjrcrdZbgFBWEKchY6t4dWZ1qr_MYSG3m3ICTaTNFjZ0w3KX7rpy5jcRA_Nvrgk_6HPJqoF5OpxXpKnl4pGVlyFm3UDHXi1eCXtCXerUCGfWhfNflp_so7XElo1A9Rz3qtTpcrm1VPMDmfRRpT8v51Vfl2IalqybTUXZ5shDxKt3GA48AtycUdMBsbZFzLEH_ZwA3jKSS_l6_h8mpAmLihfDMSkpFlIzXrorccPOoYs4kmv2n8OL3mlt5i9ZfNADl4PCTZHBcfAvQxM3edm1XtzFzvrCDHYf0OTso4ncPzFmq09vhI2c3T-CltV-Qm-X5hVeV5yOGo8e4g
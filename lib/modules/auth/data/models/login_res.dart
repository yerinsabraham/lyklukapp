import 'dart:convert';

import '../../../../core/shared/model/profile_model.dart';

class LoginRes {
  final bool? success;
  final LoginData? data;
  final String? message;

  LoginRes({this.success, this.data, this.message});

  LoginRes copyWith({bool? success, LoginData? data, String? message}) =>
      LoginRes(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory LoginRes.fromRawJson(String str) =>
      LoginRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginRes.fromJson(Map<String, dynamic> json) => LoginRes(
    success: json["success"],
    data: json["data"] == null ? null : LoginData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class LoginData {
  final String? accessToken;
  final SiginUser? siginUser;
  final String? privateKey;

  LoginData({this.accessToken, this.siginUser, this.privateKey});

  LoginData copyWith({
    String? accessToken,
    SiginUser? siginUser,
    String? privateKey,
  }) => LoginData(
    accessToken: accessToken ?? this.accessToken,
    siginUser: siginUser ?? this.siginUser,
    privateKey: privateKey ?? this.privateKey,
  );

  factory LoginData.fromRawJson(String str) =>
      LoginData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    accessToken: json["access_token"],
    siginUser:
        json["sigin_user"] == null
            ? null
            : SiginUser.fromJson(json["sigin_user"]),
    privateKey: json["privateKey"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "sigin_user": siginUser?.toJson(),
    "privateKey": privateKey,
  };
}

class SiginUser {
  final String? email;
  final dynamic phone;
  final dynamic emailVerifiedAt;
  final dynamic phoneVerifiedAt;
  final dynamic deletedAt;
  final String? username;
  final int? private;
  final String? publicKey;
  final bool? verifiedProfile;
  final ProfileModel? profile;

  SiginUser({
    this.email,
    this.phone,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    this.deletedAt,
    this.username,
    this.private,
    this.publicKey,
    this.verifiedProfile,
    this.profile,
  });

  SiginUser copyWith({
    String? email,
    dynamic phone,
    dynamic emailVerifiedAt,
    dynamic phoneVerifiedAt,
    dynamic deletedAt,
    String? username,
    int? private,
    String? publicKey,
    bool? verifiedProfile,
    ProfileModel? profile,
  }) => SiginUser(
    email: email ?? this.email,
    phone: phone ?? this.phone,
    emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
    phoneVerifiedAt: phoneVerifiedAt ?? this.phoneVerifiedAt,
    deletedAt: deletedAt ?? this.deletedAt,
    username: username ?? this.username,
    private: private ?? this.private,
    publicKey: publicKey ?? this.publicKey,
    verifiedProfile: verifiedProfile ?? this.verifiedProfile,
    profile: profile ?? this.profile,
  );

  factory SiginUser.fromRawJson(String str) =>
      SiginUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SiginUser.fromJson(Map<String, dynamic> json) => SiginUser(
    email: json["email"],
    phone: json["phone"],
    emailVerifiedAt: json["email_verified_at"],
    phoneVerifiedAt: json["phone_verified_at"],
    deletedAt: json["deletedAt"],
    username: json["username"],
    private: json["private"],
    publicKey: json["publicKey"],
    verifiedProfile: json["verified_profile"],
    profile: json["profile"] == null ? null : ProfileModel.fromJson(json["profile"]),
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "phone": phone,
    "email_verified_at": emailVerifiedAt,
    "phone_verified_at": phoneVerifiedAt,
    "deletedAt": deletedAt,
    "username": username,
    "private": private,
    "publicKey": publicKey,
    "verified_profile": verifiedProfile,
    "profile": profile?.toJson(),
  };
}

// class Profile {
//   final String? avatar;
//   final String? name;
//   final DateTime? dob;

//   Profile({this.avatar, this.name, this.dob});

//   Profile copyWith({String? avatar, String? name, DateTime? dob}) => Profile(
//     avatar: avatar ?? this.avatar,
//     name: name ?? this.name,
//     dob: dob ?? this.dob,
//   );

//   factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Profile.fromJson(Map<String, dynamic> json) => Profile(
//     avatar: json["avatar"],
//     name: json["name"],
//     dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "avatar": avatar,
//     "name": name,
//     "dob": dob?.toIso8601String(),
//   };
// }

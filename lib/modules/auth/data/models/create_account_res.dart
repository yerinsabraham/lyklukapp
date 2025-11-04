import 'dart:convert';

class SignUpRes {
  final bool? success;
  final SignUpData? data;
  final String? message;

  SignUpRes({this.success, this.data, this.message});

  SignUpRes copyWith({bool? success, SignUpData? data, String? message}) =>
      SignUpRes(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory SignUpRes.fromRawJson(String str) =>
      SignUpRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SignUpRes.fromJson(Map<String, dynamic> json) => SignUpRes(
    success: json["success"],
    data: json["data"] == null ? null : SignUpData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class SignUpData {
  final String? accessToken;
  final SiginUser? siginUser;
  final String? privateKey;

  SignUpData({this.accessToken, this.siginUser, this.privateKey});

  SignUpData copyWith({
    String? accessToken,
    SiginUser? siginUser,
    String? privateKey,
  }) => SignUpData(
    accessToken: accessToken ?? this.accessToken,
    siginUser: siginUser ?? this.siginUser,
    privateKey: privateKey ?? this.privateKey,
  );

  factory SignUpData.fromRawJson(String str) =>
      SignUpData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SignUpData.fromJson(Map<String, dynamic> json) => SignUpData(
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
  final Profile? profile;

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
    Profile? profile,
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
    profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
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

class Profile {
  final String? avatar;
  final String? name;
  final DateTime? dob;

  Profile({this.avatar, this.name, this.dob});

  Profile copyWith({String? avatar, String? name, DateTime? dob}) => Profile(
    avatar: avatar ?? this.avatar,
    name: name ?? this.name,
    dob: dob ?? this.dob,
  );

  factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    avatar: json["avatar"],
    name: json["name"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
  );

  Map<String, dynamic> toJson() => {
    "avatar": avatar,
    "name": name,
    "dob":
        "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
  };
}

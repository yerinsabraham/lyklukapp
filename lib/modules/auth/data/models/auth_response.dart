class AuthResponse {
  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.siginUser,
  });

  final String accessToken;
  final String? refreshToken;
  final SiginUser? siginUser;

  AuthResponse copyWith({
    String? accessToken,
    String? refreshToken,
    SiginUser? siginUser,
  }) {
    return AuthResponse(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      siginUser: siginUser ?? this.siginUser,
    );
  }

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json["access_token"],
      refreshToken: json["refresh_token"],
      siginUser:
          json["sigin_user"] == null
              ? null
              : SiginUser.fromJson(json["sigin_user"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "refresh_token": refreshToken,
    "sigin_user": siginUser?.toJson(),
  };

  @override
  String toString() {
    return "$accessToken, $refreshToken, $siginUser, ";
  }
}

class SiginUser {
  SiginUser({
    required this.id,
    required this.email,
    required this.phone,
    required this.emailVerifiedAt,
    required this.phoneVerifiedAt,
    required this.username,
  });

  final String? email;
  final dynamic phone;
  final DateTime? emailVerifiedAt;
  final dynamic phoneVerifiedAt;
  final String? username;
  final int id;

  SiginUser copyWith({
    String? email,
    String? phone,
    DateTime? emailVerifiedAt,
    DateTime? phoneVerifiedAt,
    String? username,
    int? id,
  }) {
    return SiginUser(
      id:  id?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      phoneVerifiedAt: phoneVerifiedAt ?? this.phoneVerifiedAt,
      username: username ?? this.username,
    );
  }

  factory SiginUser.fromJson(Map<String, dynamic> json) {
    return SiginUser(
      id: json["id"],
      email: json["email"],
      phone: json["phone"]?.toString(),
      emailVerifiedAt: DateTime.tryParse(json["email_verified_at"] ?? ""),
      phoneVerifiedAt: json["phone_verified_at"],
      username: json["username"],
    );
  }

  Map<String, dynamic> toJson() => {
    "email": email,
    "phone": phone,
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "phone_verified_at": phoneVerifiedAt,
    "username": username,
    "id": id,
  };

  @override
  String toString() {
    return "$email, $phone, $emailVerifiedAt, $phoneVerifiedAt, $username, $id, ";
  }
}

class ProfileModel {
  ProfileModel({
    this.bio,
    this.website,
    this.avatar,
    this.name,
    this.facebook,
    this.instagram,
    this.twitter,
    this.dob,
  });

  final String? bio;
  final String? website;
  final String? avatar;
  final String? name;
  final String? facebook;
  final String? instagram;
  final String? twitter;
  final DateTime? dob;

  ProfileModel copyWith({
    String? bio,
    String? website,
    String? avatar,
    String? name,
    String? facebook,
    String? instagram,
    String? twitter,
    DateTime? dob,
  }) {
    return ProfileModel(
      bio: bio ?? this.bio,
      website: website ?? this.website,
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      facebook: facebook ?? this.facebook,
      instagram: instagram ?? this.instagram,
      twitter: twitter ?? this.twitter,
      dob: dob ?? this.dob,
    );
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      bio: json["bio"],
      website: json["website"],
      avatar: json["avatar"],
      name: json["name"],
      facebook: json["facebook"],
      instagram: json["instagram"],
      twitter: json["twitter"],
      dob: DateTime.tryParse(json["dob"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "bio": bio,
    "website": website,
    "avatar": avatar,
    "name": name,
    "facebook": facebook,
    "instagram": instagram,
    "twitter": twitter,
    "dob": dob?.toIso8601String(),
  };

  @override
  String toString() {
    return "$bio, $website, $avatar, $name, $facebook, $instagram, $twitter, $dob, ";
  }

  factory ProfileModel.empty() {
    return ProfileModel();
  }
}

extension ProfileModelX on ProfileModel {
  String get proflleImageUrl{
    return "$avatar"; 
  }
}

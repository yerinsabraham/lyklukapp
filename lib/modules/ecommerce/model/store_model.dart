enum SubscriptionPlan { free, basic, classic, premium }

class StoreModel {
  StoreModel({
    required this.id,
    required this.userId,
     required this.name,
     this.description,
    this.country,
    this.region,
    this.address,
    this.location,
    this.contactPhone,
    this.contactEmail,
    this.image,
    this.subscriptionPlan,
    this.verified,
    this.verificationDate,
    this.rejectionReason,
    this.createdAt,
    this.updatedAt,
    this.subscription,
    this.count = const StoreCount(),
  });

  final int id;
  final int userId;
  final String name;
  final String? description;
  final String? country;
  final String? region;
  final String? address;
  final String? location;
  final String? contactPhone;
  final dynamic contactEmail;
  final dynamic image;
  final String? subscriptionPlan;
  final bool? verified;
  final dynamic verificationDate;
  final dynamic rejectionReason;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic subscription;
  final StoreCount count;

  StoreModel copyWith({
    int? id,
    int? userId,
    String? name,
    String? description,
    String? country,
    String? region,
    String? address,
    String? location,
    String? contactPhone,
    String? contactEmail,
    String? image,
    String? subscriptionPlan,
    bool? verified,
    DateTime? verificationDate,
    String? rejectionReason,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic subscription,
    StoreCount? count,
  }) {
    return StoreModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      country: country ?? this.country,
      region: region ?? this.region,
      address: address ?? this.address,
      location: location ?? this.location,
      contactPhone: contactPhone ?? this.contactPhone,
      contactEmail: contactEmail ?? this.contactEmail,
      image: image ?? this.image,
      subscriptionPlan: subscriptionPlan ?? this.subscriptionPlan,
      verified: verified ?? this.verified,
      verificationDate: verificationDate ?? this.verificationDate,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      subscription: subscription ?? this.subscription,
      count: count ?? this.count,
    );
  }

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json["id"],
      userId: json["userId"],
      name: json["name"],
      description: json["description"],
      country: json["country"],
      region: json["region"],
      address: json["address"],
      location: json["location"],
      contactPhone: json["contactPhone"],
      contactEmail: json["contactEmail"],
      image: json["image"],
      subscriptionPlan: json["subscriptionPlan"],
      verified: json["verified"],
      verificationDate: json["verificationDate"],
      rejectionReason: json["rejectionReason"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      subscription: json["subscription"],
      count:
          json["_count"] == null
              ? StoreCount()
              : StoreCount.fromJson(json["_count"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "name": name,
    "description": description,
    "country": country,
    "region": region,
    "address": address,
    "location": location,
    "contactPhone": contactPhone,
    "contactEmail": contactEmail,
    "image": image,
    "subscriptionPlan": subscriptionPlan,
    "verified": verified,
    "verificationDate": verificationDate,
    "rejectionReason": rejectionReason,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "subscription": subscription,
    "_count": count.toJson(),
  };

  @override
  String toString() {
    return "$id, $userId, $name, $description, $country, $region, $address, $location, $contactPhone, $contactEmail, $image, $subscriptionPlan, $verified, $verificationDate, $rejectionReason, $createdAt, $updatedAt, $subscription, $count, ";
  }

  factory StoreModel.empty() => StoreModel(id: 0, userId: 0, name: "", count: StoreCount());
}

class StoreCount {
  const StoreCount({this.products = 0, this.orders = 0, this.followers = 0});

  final int products;
  final int orders;
  final int followers;

  StoreCount copyWith({int? products, int? orders, int? followers}) {
    return StoreCount(
      products: products ?? this.products,
      orders: orders ?? this.orders,
      followers: followers ?? this.followers,
    );
  }

  factory StoreCount.fromJson(Map<String, dynamic> json) {
    return StoreCount(
      products: json["products"],
      orders: json["orders"],
      followers: json["followers"],
    );
  }

  Map<String, dynamic> toJson() => {
    "products": products,
    "orders": orders,
    "followers": followers,
  };

  @override
  String toString() {
    return "$products, $orders, $followers, ";
  }
}

// class StoreModel {
//   StoreModel({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.location,
//     required this.contactPhone,
//     required this.contactEmail,
//     this.verified = false,
//     required this.userId,
//     required this.createdAt,
//   });

//   final int id;
//   final String? name;
//   final String? description;
//   final String? location;
//   final String? contactPhone;
//   final String? contactEmail;
//   final bool verified;
//   final int userId;
//   final DateTime? createdAt;

//   StoreModel copyWith({
//     int? id,
//     String? name,
//     String? description,
//     String? location,
//     String? contactPhone,
//     String? contactEmail,
//     bool? verified,
//     int? userId,
//     DateTime? createdAt,
//   }) {
//     return StoreModel(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       description: description ?? this.description,
//       location: location ?? this.location,
//       contactPhone: contactPhone ?? this.contactPhone,
//       contactEmail: contactEmail ?? this.contactEmail,
//       verified: verified ?? this.verified,
//       userId: userId ?? this.userId,
//       createdAt: createdAt ?? this.createdAt,
//     );
//   }

//   factory StoreModel.fromJson(Map<String, dynamic> json) {
//     return StoreModel(
//       id: json["id"],
//       name: json["name"],
//       description: json["description"],
//       location: json["location"],
//       contactPhone: json["contactPhone"],
//       contactEmail: json["contactEmail"],
//       verified: json["verified"] ?? false,
//       userId: json["userId"],
//       createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "description": description,
//     "location": location,
//     "contactPhone": contactPhone,
//     "contactEmail": contactEmail,
//     "verified": verified,
//     "userId": userId,
//     "createdAt": createdAt?.toIso8601String(),
//   };

//   factory StoreModel.empty() => StoreModel(
//     id: 0,
//     name: "",
//     description: "",
//     location: "",
//     contactPhone: "",
//     contactEmail: "",
//     verified: false,
//     userId: 0,
//     createdAt: null,
//   );

//   @override
//   String toString() {
//     return "$id, $name, $description, $location, $contactPhone, $contactEmail, $verified, $userId, $createdAt, ";
//   }
// }

final demoStoreModel = StoreModel(
  id: 0,
  name: "Beauty hut",
  description:
      'About the store About About the store About the store About the store the stpyuu... ',
  location: "",
  contactPhone: "",
  contactEmail: "",
  userId: 0,
  createdAt: DateTime.now(),
);

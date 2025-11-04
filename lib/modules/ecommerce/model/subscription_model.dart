import 'dart:ui';

class SubscriptionModel {
  SubscriptionModel({
    required this.plan,
    required this.limits,
    required this.price,
    required this.features,
  });

  final String plan;
  final SubLimits? limits;
  final SubPrice? price;
  final List<String> features;

  SubscriptionModel copyWith({
    String? plan,
    SubLimits? limits,
    SubPrice? price,
    List<String>? features,
  }) {
    return SubscriptionModel(
      plan: plan ?? this.plan,
      limits: limits ?? this.limits,
      price: price ?? this.price,
      features: features ?? this.features,
    );
  }

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      plan: json["plan"],
      limits:
          json["limits"] == null ? null : SubLimits.fromJson(json["limits"]),
      price: json["price"] == null ? null : SubPrice.fromJson(json["price"]),
      features:
          json["features"] == null
              ? []
              : List<String>.from(json["features"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "plan": plan,
    "limits": limits?.toJson(),
    "price": price?.toJson(),
    "features": features.map((x) => x).toList(),
  };
  factory SubscriptionModel.empty() {
    return SubscriptionModel(
      plan: "",
      limits: SubLimits(
        productUploads: 0,
        storeCount: 0,
        freeAds: 0,
        shippingCompanies: 0,
        classroomFeePercentage: 0,
        liveStreaming: false,
        prioritySupport: false,
        analytics: false,
        bulkOperations: false,
      ),
      price: SubPrice(monthly: 0, annual: 0),
      features: [],
    );
  }

  @override
  String toString() {
    return "$plan, $limits, $price, $features, ";
  }
}

class SubLimits {
  SubLimits({
    required this.productUploads,
    required this.storeCount,
    required this.freeAds,
    required this.shippingCompanies,
    required this.classroomFeePercentage,
    required this.liveStreaming,
    required this.prioritySupport,
    required this.analytics,
    required this.bulkOperations,
  });

  final int? productUploads;
  final int? storeCount;
  final int? freeAds;
  final int? shippingCompanies;
  final int? classroomFeePercentage;
  final bool? liveStreaming;
  final bool? prioritySupport;
  final bool? analytics;
  final bool? bulkOperations;

  SubLimits copyWith({
    int? productUploads,
    int? storeCount,
    int? freeAds,
    int? shippingCompanies,
    int? classroomFeePercentage,
    bool? liveStreaming,
    bool? prioritySupport,
    bool? analytics,
    bool? bulkOperations,
  }) {
    return SubLimits(
      productUploads: productUploads ?? this.productUploads,
      storeCount: storeCount ?? this.storeCount,
      freeAds: freeAds ?? this.freeAds,
      shippingCompanies: shippingCompanies ?? this.shippingCompanies,
      classroomFeePercentage:
          classroomFeePercentage ?? this.classroomFeePercentage,
      liveStreaming: liveStreaming ?? this.liveStreaming,
      prioritySupport: prioritySupport ?? this.prioritySupport,
      analytics: analytics ?? this.analytics,
      bulkOperations: bulkOperations ?? this.bulkOperations,
    );
  }

  factory SubLimits.fromJson(Map<String, dynamic> json) {
    return SubLimits(
      productUploads: json["productUploads"],
      storeCount: json["storeCount"],
      freeAds: json["freeAds"],
      shippingCompanies: json["shippingCompanies"],
      classroomFeePercentage: json["classroomFeePercentage"],
      liveStreaming: json["liveStreaming"],
      prioritySupport: json["prioritySupport"],
      analytics: json["analytics"],
      bulkOperations: json["bulkOperations"],
    );
  }

  Map<String, dynamic> toJson() => {
    "productUploads": productUploads,
    "storeCount": storeCount,
    "freeAds": freeAds,
    "shippingCompanies": shippingCompanies,
    "classroomFeePercentage": classroomFeePercentage,
    "liveStreaming": liveStreaming,
    "prioritySupport": prioritySupport,
    "analytics": analytics,
    "bulkOperations": bulkOperations,
  };

  @override
  String toString() {
    return "$productUploads, $storeCount, $freeAds, $shippingCompanies, $classroomFeePercentage, $liveStreaming, $prioritySupport, $analytics, $bulkOperations, ";
  }
}

class SubPrice {
  SubPrice({this.monthly = 0.0, this.annual = 0.0});

  final num monthly;
  final num annual;

  SubPrice copyWith({num? monthly, num? annual}) {
    return SubPrice(
      monthly: monthly ?? this.monthly,
      annual: annual ?? this.annual,
    );
  }

  factory SubPrice.fromJson(Map<String, dynamic> json) {
    return SubPrice(
      monthly: json["monthly"] ?? 0.0,
      annual: json["annual"] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {"monthly": monthly, "annual": annual};

  @override
  String toString() {
    return "$monthly, $annual, ";
  }
}

// class SubscriptionModel {
//   SubscriptionModel({
//     required this.name,
//     required this.price,
//     required this.features,
//   });

//   final String? name;
//   final SubscriptionPrice? price;
//   final List<String> features;

//   SubscriptionModel copyWith({
//     String? name,
//     SubscriptionPrice? price,
//     List<String>? features,
//   }) {
//     return SubscriptionModel(
//       name: name ?? this.name,
//       price: price ?? this.price,
//       features: features ?? this.features,
//     );
//   }

//   factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
//     return SubscriptionModel(
//       name: json["name"],
//       price: json["price"] == null ? null : SubscriptionPrice.fromJson(json["price"]),
//       features:
//           json["features"] == null
//               ? []
//               : List<String>.from(json["features"]!.map((x) => x)),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     "name": name,
//     "price": price?.toJson(),
//     "features": features.map((x) => x).toList(),
//   };

//   @override
//   String toString() {
//     return "$name, $price, $features, ";
//   }

//   factory SubscriptionModel.empty() {
//     return SubscriptionModel(
//       name: "",
//       price: SubscriptionPrice(monthly: 0, yearly: 0),
//       features: [],
//     );
// }
// }

// class SubscriptionPrice {
//   SubscriptionPrice({required this.monthly, required this.yearly});

//   final int? monthly;
//   final int? yearly;

//   SubscriptionPrice copyWith({int? monthly, int? yearly}) {
//     return SubscriptionPrice(
//       monthly: monthly ?? this.monthly,
//       yearly: yearly ?? this.yearly,
//     );
//   }

//   factory SubscriptionPrice.fromJson(Map<String, dynamic> json) {
//     return SubscriptionPrice(monthly: json["monthly"], yearly: json["yearly"]);
//   }

//   Map<String, dynamic> toJson() => {"monthly": monthly, "yearly": yearly};

//   @override
//   String toString() {
//     return "$monthly, $yearly, ";
//   }
// }

extension SubscriptionModelX on SubscriptionModel {
  Color get getColor {
    return switch (plan) {
      "FREE" => Color(0xffF7F6F7),
      "BASIC" => Color(0xffFFFCF6),
      "CLASSIC" => Color(0xffFFF2EB),
      "PRO" => Color(0xffF7F6F7),
      "PREMIUM" => Color(0xffF7EBFF),
      "ENTERPRISE" => Color(0xffF73EC7).withValues(alpha: 0.1),
      _ => Color(0xffF7F6F7),
    };
  }
}

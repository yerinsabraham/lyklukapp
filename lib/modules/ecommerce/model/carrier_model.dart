class CarrierModel {
  CarrierModel({
    required this.serviceCode,
    required this.name,
    required this.pinImage,
    required this.originCountry,
    required this.supportsDomestic,
    required this.supportsInternational,
    required this.onDemand,
    required this.packageCategories,
    required this.status,
  });

  final String? serviceCode;
  final String? name;
  final String? pinImage;
  final String? originCountry;
  final bool? supportsDomestic;
  final bool? supportsInternational;
  final bool? onDemand;
  final List<String> packageCategories;
  final String? status;

  CarrierModel copyWith({
    String? serviceCode,
    String? name,
    String? pinImage,
    String? originCountry,
    bool? supportsDomestic,
    bool? supportsInternational,
    bool? onDemand,
    List<String>? packageCategories,
    String? status,
  }) {
    return CarrierModel(
      serviceCode: serviceCode ?? this.serviceCode,
      name: name ?? this.name,
      pinImage: pinImage ?? this.pinImage,
      originCountry: originCountry ?? this.originCountry,
      supportsDomestic: supportsDomestic ?? this.supportsDomestic,
      supportsInternational:
          supportsInternational ?? this.supportsInternational,
      onDemand: onDemand ?? this.onDemand,
      packageCategories: packageCategories ?? this.packageCategories,
      status: status ?? this.status,
    );
  }

  factory CarrierModel.fromJson(Map<String, dynamic> json) {
    return CarrierModel(
      serviceCode: json["service_code"],
      name: json["name"],
      pinImage: json["pin_image"],
      originCountry: json["origin_country"],
      supportsDomestic: json["supports_domestic"],
      supportsInternational: json["supports_international"],
      onDemand: json["on_demand"],
      packageCategories:
          json["package_categories"] == null
              ? []
              : List<String>.from(json["package_categories"]!.map((x) => x)),
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
    "service_code": serviceCode,
    "name": name,
    "pin_image": pinImage,
    "origin_country": originCountry,
    "supports_domestic": supportsDomestic,
    "supports_international": supportsInternational,
    "on_demand": onDemand,
    "package_categories": packageCategories.map((x) => x).toList(),
    "status": status,
  };

  @override
  String toString() {
    return "$serviceCode, $name, $pinImage, $originCountry, $supportsDomestic, $supportsInternational, $onDemand, $packageCategories, $status, ";
  }
}

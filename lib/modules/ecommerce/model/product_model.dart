import 'package:intl/intl.dart';
import 'package:lykluk/modules/ecommerce/domain/enums/product_enums.dart';
import 'package:lykluk/utils/storage/local_storage.dart';

import '../data/market_contants.dart/market_endpoints.dart';
import 'saved_product_model.dart';

class ProductModel {
  ProductModel({
    required this.id,
    this.name,
    this.description,
    this.price,
    this.type = ProductType.physicalProduct,
    this.inventory = 0,
    required this.status,
    this.featured = false,
    this.createdAt,
    this.updatedAt,
    this.images = const [],
    this.category,
    this.store,
    this.categoryId,
    this.storeId,
  });

  final int id;
  final String? name;
  final String? description;
  final String? price;
  final ProductType type;
  final int inventory;
  final String status;
  final bool featured;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<String> images;
  final int? categoryId;
  final int? storeId;
  final ProductCategory? category;
  final ProductStore? store;

  ProductModel copyWith({
    int? id,
    String? name,
    String? description,
    String? price,
    ProductType? type,
    int? inventory,
    String? status,
    bool? featured,
    List<String>? images,
    DateTime? createdAt,
    ProductCategory? category,
    ProductStore? store,
    int? categoryId,
    int? storeId,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      type: type ?? this.type,
      inventory: inventory ?? this.inventory,
      status: status ?? this.status,
      featured: featured ?? this.featured,
      images: images ?? this.images,
      createdAt: createdAt ?? this.createdAt,
      category: category ?? this.category,
      store: store ?? this.store,
      categoryId: categoryId ?? this.categoryId,
      storeId: storeId ?? this.storeId,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      price: json["price"],
      type: ProductType.fromString(json["type"]),
      inventory: json["inventory"],
      status: json["status"],
      featured: json["featured"],
      images:
          json["images"] == null
              ? []
              : List<String>.from(json["images"]!.map((x) => x)),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      category:
          json["category"] == null
              ? null
              : ProductCategory.fromJson(json["category"]),
      store:
          json["store"] == null ? null : ProductStore.fromJson(json["store"]),
      categoryId: json["categoryId"],
      storeId: json["storeId"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "type": type.toString(),
    "inventory": inventory,
    "status": status,
    "featured": featured,
    "images": images.map((x) => x).toList(),
    "createdAt": createdAt?.toIso8601String(),
    "category": category?.toJson(),
    "store": store?.toJson(),
    "categoryId": categoryId,
    "storeId": storeId,
  };

  factory ProductModel.empty() {
    return ProductModel(
      id: 0,
      name: "",
      description: "",
      price: "",
      type: ProductType.physicalProduct,
      inventory: 0,
      status: "",
      featured: false,
      images: [],
      createdAt: null,
      category: null,
      store: null,
      categoryId: null,
      storeId: null,
    );
  }

  @override
  String toString() {
    return "$id, $name, $description, $price, $type, $inventory, $status, $featured, $images, $createdAt, $category, $store, $categoryId, $storeId, ";
  }

  SavedProductModel toSaved() {
    return SavedProductModel(
      id: DateTime.now().millisecondsSinceEpoch,
      userId:int.parse( HiveStorage.userId),
      productId: id,
      createdAt: DateTime.now(),
      product: this,
    );
  }
}

class ProductCategory {
  ProductCategory({required this.id, required this.name});

  final int id;
  final String? name;

  ProductCategory copyWith({int? id, String? name}) {
    return ProductCategory(id: id ?? this.id, name: name ?? this.name);
  }

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(id: json["id"], name: json["name"]);
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name};

  @override
  String toString() {
    return "$id, $name, ";
  }
}

class ProductStore {
  ProductStore({
    required this.id,
    required this.name,
    required this.verified,
    this.rating = 0.0,
    this.followerCount = 0,
  });

  final int id;
  final String? name;
  final bool? verified;
  final double rating;
  final int followerCount;

  ProductStore copyWith({
    int? id,
    String? name,
    bool? verified,
    double? rating,
    int? followers,
    int? followerCount,
  }) {
    return ProductStore(
      id: id ?? this.id,
      name: name ?? this.name,
      verified: verified ?? this.verified,
      rating: rating ?? this.rating,
      followerCount: followerCount ?? this.followerCount,
    );
  }

  factory ProductStore.fromJson(Map<String, dynamic> json) {
    return ProductStore(
      id: json["id"],
      name: json["name"],
      verified: json["verified"],
      rating: json["rating"] ?? 0.0,
      followerCount: json["followerCount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "verified": verified,
    "rating": rating,
    "followerCount": followerCount,
  };

  @override
  String toString() {
    return "$id, $name, $verified, $rating, $followerCount, ";
  }
}

extension ProductModelExtension on ProductModel {
  String formatToKM(double value) {
    final NumberFormat numberFormat = NumberFormat.currency(
      decimalDigits: 1,
      symbol: '', // remove $ or any currency symbol
    );

    return numberFormat.format(value).split('.')[0];
  }

  ///
  String get priceString {
    final convert = double.tryParse(price ?? "0.0");
    if (convert == null) {
      return "0.0";
    }
    return formatToKM(convert);
  }

  List<String> get imageUrls {
    return images.map((e) => "${MarketEndpoints.mediaServer}$e").toList();
  }
}

// final singleDemoproduct = ProductModel(
//   id: 23,
//   name: 'Classic Denim Jacket',
//   description: 'Stylish blue denim jacket made from premium cotton.',
//   price: "49.99",
//   status: 'ACTIVE',
//   inventory: 30,
//   images: [
//     'https://example.com/images/denim1.jpg',
//     'https://example.com/images/denim2.jpg',
//   ],
//   category: ProductCategory(id: 1, name: 'Clothing'),
//   categoryId: 1,
//   store: ProductStore(id: 1, name: 'Lyklik Store', verified: true),
//   storeId: 1,
//   featured: false,
//   createdAt: DateTime.now(),
//   updatedAt: DateTime.now(),
// );

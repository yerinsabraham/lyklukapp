import 'package:lykluk/modules/ecommerce/model/market_models.dart';

class SavedProductModel {
  final int id;
  final int userId;
  final int productId;
  final DateTime? createdAt;
  final ProductModel product;

  SavedProductModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.createdAt,
    required this.product,
  });

  SavedProductModel copyWith({
    int? id,
    int? userId,
    int? productId,
    DateTime? createdAt,
    ProductModel? product,
  }) {
    return SavedProductModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      createdAt: createdAt ?? this.createdAt,
      product: product ?? this.product,
    );
  }

  factory SavedProductModel.fromJson(Map<String, dynamic> json) {
    return SavedProductModel(
      id: json['id'],
      userId: json['userId'],
      productId: json['productId'],
      createdAt: DateTime.tryParse(json['createdAt']),
      product: ProductModel.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,  
      'productId': productId,
      'createdAt': createdAt?.toIso8601String(),
      'product': product.toJson(),
    };
  }

}

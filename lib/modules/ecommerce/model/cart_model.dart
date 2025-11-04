import 'product_model.dart';

class CartModel {
  CartModel({
    required this.id,
    required this.userId,
    this.items = const [],
    this.totalItems,
    this.totalAmount,
    this.createdAt,
    this.updatedAt,
    this.totals = const CartTotals(itemCount: 0, subtotal: "0.0"),
  });

  final int id;
  final int userId;
  final List<CartItem> items;
  final int? totalItems;
  final String? totalAmount;

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final CartTotals totals;

  CartModel copyWith({
    int? id,
    int? userId,
    List<CartItem>? items,
    int? totalItems,
    String? totalAmount,
  }) {
    return CartModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      totalItems: totalItems ?? this.totalItems,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json["id"],
      userId: json["userId"],
      items:
          json["items"] == null
              ? []
              : List<CartItem>.from(
                json["items"]?.map((x) => CartItem.fromJson(x)),
              ),
      totalItems: json["totalItems"],
      totalAmount: json["totalAmount"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      totals:
          json["totals"] == null
              ? CartTotals()
              : CartTotals.fromJson(json["totals"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "items": items.map((x) => x.toJson()).toList(),
    "totalItems": totalItems,
    "totalAmount": totalAmount,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "totals": totals.toJson(),
  };

  factory CartModel.empty() {
    return CartModel(
      id: 0,
      userId: 0,
      items: [],
      totalItems: 0,
      totalAmount: "0",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      totals: CartTotals(),
    );
  }

  @override
  String toString() {
    return "$id, $userId, $items, $totalItems, $totalAmount, ";
  }
}

//// cart item model
class CartItem {
  CartItem({
    required this.id,
    required this.cartId,
    required this.productId,
    this.quantity = 0,
    required this.addedAt,
    required this.product,
  });

  final int id;
  final int? cartId;
  final int? productId;
  final int quantity;
  final DateTime? addedAt;
  final ProductModel? product;

  CartItem copyWith({
    int? id,
    int? cartId,
    int? productId,
    int? quantity,
    DateTime? addedAt,
    ProductModel? product,
  }) {
    return CartItem(
      id: id ?? this.id,
      cartId: cartId ?? this.cartId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      addedAt: addedAt ?? this.addedAt,
      product: product ?? this.product,
    );
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json["id"],
      cartId: json["cartId"],
      productId: json["productId"],
      quantity: json["quantity"] ?? 0,
      addedAt: DateTime.tryParse(json["addedAt"] ?? ""),
      product:
          json["product"] == null
              ? null
              : ProductModel.fromJson(json["product"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "cartId": cartId,
    "productId": productId,
    "quantity": quantity,
    "addedAt": addedAt?.toIso8601String(),
    "product": product?.toJson(),
  };

  @override
  String toString() {
    return "$id, $cartId, $productId, $quantity, $addedAt, $product, ";
  }

  /// empty cart item
  /// used when adding a product to cart
  factory CartItem.empty() {
    return CartItem(
      id: 0,
      cartId: 0,
      productId: 0,
      quantity: 0,
      addedAt: DateTime.now(),
      product: ProductModel.empty(),
    );
  }
}

class CartTotals {
  const CartTotals({this.itemCount = 0, this.subtotal = "0.0"});

  final int itemCount;
  final String subtotal;

  CartTotals copyWith({int? itemCount, String? subtotal}) {
    return CartTotals(
      itemCount: itemCount ?? this.itemCount,
      subtotal: subtotal ?? this.subtotal,
    );
  }

  factory CartTotals.fromJson(Map<String, dynamic> json) {
    return CartTotals(itemCount: json["itemCount"], subtotal: json["subtotal"]);
  }

  Map<String, dynamic> toJson() => {
    "itemCount": itemCount,
    "subtotal": subtotal,
  };

  @override
  String toString() {
    return "$itemCount, $subtotal, ";
  }
}

class OrderModel {
 final  String id;
  final String? userId;
final  String? productId;
 final String? productName;
 final String? productImage;
 final double productPrice;
 final int quantity;
 final double totalPrice;
 final String? status;
 final String? createdAt;
 final String? updatedAt;

  OrderModel(
      {
     required this.id,
      this.userId,
      this.productId,
      this.productName,
      this.productImage,
      this.productPrice=0.0,
      this.quantity=0,
      this.totalPrice =0.0,
      this.status,
      this.createdAt,
      this.updatedAt});

 factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(  
    id : json['id'],
    userId : json['user_id'],
    productId : json['product_id'],
    productName : json['product_name'],
    productImage : json['product_image'],
    productPrice : json['product_price'],
    quantity : json['quantity'],
    totalPrice : json['total_price'],
    status : json['status'],
    createdAt : json['created_at'],
    updatedAt : json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['product_image'] = productImage;
    data['product_price'] = productPrice;
    data['quantity'] = quantity;
    data['total_price'] = totalPrice;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

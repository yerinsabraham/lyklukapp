import 'package:lykluk/core/shared/resources/typedefs.dart';
import 'package:lykluk/utils/pagination/pagination.dart';

import '../../data/ecommerce_services/upload_event.dart';
import '../../model/market_models.dart';

abstract class ProductRepository {
  /// create product
  FutureResponse<ProductModel> createProduct({
    required Map<String, dynamic> data,
  });

  /// get all products
  FutureResponse<PaginatedResponse<ProductModel>> getProducts({
    required Map<String, dynamic> query,
  });

  /// get my products
  FutureResponse<PaginatedResponse<ProductModel>> getMyProducts({
    required Map<String, dynamic> query,
  });

  /// get product by id
  FutureResponse<ProductModel> getProduct({required int productId});

  ///  update product
  FutureResponse<ProductModel> updatetProduct({
    required Map<String, dynamic> data,
  });

  /// update inventory
  FutureResponse<ProductModel> updatetInventory({
    required Map<String, dynamic> data,
  });

  /// delete product
  FutureResponse<Map> deleteProduct({required String productId});

  /// get featured products
  FutureResponse<PaginatedResponse<ProductModel>> getFeaturedProduct({
    required Map<String, dynamic> query,
  });

  /// save product
  FutureResponse<StringMap<bool>> saveProduct({required String productId});

  /// unsave product
  FutureResponse<StringMap<bool>> unSaveProduct({required String productId});

  /// get saved products
  FutureResponse<PaginatedResponse<ProductModel>> getSavedProduct({
    required Map<String, dynamic> query,
  });

  /// upload product image
  FutureResponse<bool> uploadProductImage({
    required List<String> images,
    required int productId,
     required int storeId,
  });

  Stream<UploadEvent> onUploadProgress();
}

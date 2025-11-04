import 'package:lykluk/core/shared/resources/typedefs.dart';
import 'package:lykluk/utils/pagination/pagination.dart';

import '../../model/product_model.dart';

abstract class ProductRecommendationRepository {
  FutureResponse<PaginatedResponse<ProductModel>> getFypRecommendations({required Map<String, dynamic> query});

  FutureResponse<PaginatedResponse<ProductModel>> getTrendingRecommendations({
    required Map<String, dynamic> query,
  });
  FutureResponse<PaginatedResponse<ProductModel>> getPopularRecommendations({
    required Map<String, dynamic> query,
  });
  FutureResponse<PaginatedResponse<ProductModel>> getFollowingStoreRecommendations({required Map<String, dynamic> query});

  
}

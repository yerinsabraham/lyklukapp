class MarketEndpoints {
  static const mediaServer = "https://cdn.lykluk.com/";
  ///products
  static String getProducts = '/ecommerce/products';
  static String getProduct = '/ecommerce/products/id';
  static String createProduct = '/ecommerce/products';
  static String getMyProducts = '/ecommerce/products/my-products';
  static String deleteProduct = '/ecommerce/products/id';
  static String updateProduct = '/ecommerce/products/id';
  static String getSavedProducts = '/ecommerce/social/saved/products';

  /// put
  static String updateInventory = '/ecommerce/products/id/inventory';

  /// patch
  static String getFeaturedProducts = '/ecommerce/products/featured';
  static String getProductsByCategory =
      '/ecommerce/ecommerce/categories/id/products';

  /// store
  static String getStore = '/ecommerce/store/id';
  static String getStores = '/ecommerce/store';
  static String getMyStores = '/ecommerce/store/my-stores';
  static String createStore = '/ecommerce/store/register';
  static String updateStore = '/ecommerce/store/update';
  static String verifyStoreIndentity = '/ecommerce/store/identity-document';
  static String uploadeStoreDocument = '/ecommerce/store/upload-document';
  static String getStoreProducts = '/ecommerce/products/store/id';
  static String getStoreOrders = '/ecommerce/orders/store/id';

  /// put
  static String updateStoreSettings = '/ecommerce/store/settings';

  /// put
  static String verifyStore = '/ecommerce/store/verify/id';
  static String rejectStore = '/ecommerce/store/verify/id';

  /// subscription
  static String getSubscriptions = '/ecommerce/subscription/plans';
  static String getMySubscriptions = '/ecommerce/subscription';
  static String updateSubscription = '/ecommerce/subscription/update';

  /// post
  static String getFeaturedAccessSubscriptions =
      '/ecommerce/subscription/features/product_uploads/check';
  static String getAnalytics = '/ecommerce/subscription/analytics';

  /// cart
  static String addToCart = '/ecommerce/cart/add';
  static String getCart = '/ecommerce/cart';
  static String updateCart = '/ecommerce/cart/items/id';
  static String clearCart = '/ecommerce/cart/clear';
  static String removeFromCart = '/ecommerce/cart/items/{id}';
  static String validateCart = '/ecommerce/cart/validate';

  /// delete
  /// social participation
  static String followStore = '/ecommerce/social/stores/{id}/follow';
  static String unfollowStore = '/ecommerce/social/stores/{id}/follow';

  ///delete
  static String saveProduct = '/ecommerce/social/products/{id}/save';
  static String unSaveProduct = '/ecommerce/social/products/{id}/save';

  ///delete
  static String getFollowedStores = '/ecommerce/social/following/stores';
  static String isFollowingStore = '/ecommerce/social/stores/id/is-following';
  static String isProductSaved = '/ecommerce/social/products/id/is-saved';
  static String getMutualFollowers = '/ecommerce/social/mutuals';

  /// reccommedations
  static String getFYRecommendations = '/ecommerce/recommendations/for-you';
  static String getFollowingStoreRecommendations =
      '/ecommerce/recommendations/following';
  static String getTrendingProducts = '/ecommerce/recommendations/trending';
  static String getPopularProducts = '/ecommerce/recommendations/popular';
  static String recordProductClick =
      '/ecommerce/recommendations/products/id/click';

  /// categories
  static String getAllCategories = '/ecommerce/categories';
  static String getRootCategories = '/ecommerce/categories/root';
  static String getCategory = '/ecommerce/categories/id';

  /// logistics
  static String getAvailableCarriers = '/ecommerce/logistics/carriers';
  static String getCarrierDetails = '/ecommerce/logistics/carriers/sendbox';
  static String getRecommendedCarriers = '/ecommerce/carriers/recommend';
  static String getStoreCarriers = '/ecommerce/logistics/stores/id/carriers';
  static String addLogisticsCarrier = '/ecommerce/store/logistics/preferences';
  static String addLogisticsPerference =
      '/ecommerce/store/logistics/preferences';
  static String getLogisticsPerference =
      '/ecommerce/store/logistics/preferences';
  static String updateLogisticsPerference =
      '/ecommerce/store/logistics/preferences/id';

  /// put
  static String removeLogisticsPerference =
      '/ecommerce/store/logistics/preferences';

  /// delete

  static String setPerferredCarriers = '/ecommerce/store/logistics/preferred';

  /// order
  static String createOrder = '/ecommerce/orders';
  static String getOrders = '/ecommerce/orders';
  static String getOrderStats = '/ecommerce/orders/stats';
  static String getOrderById = '/ecommerce/orders/{id}';
  static String udpateOrderStatus = '/ecommerce/orders/{id}/status';
  static String createTrackingEntry = '/ecommerce/orders/{id}/tracking';
  static String updateTrackingStatus = '/ecommerce/orders/tracking/{id}';
  static String getInternationalOrdersStats =
      '/ecommerce/orders/international-stats';
  static String getOrdersByCurrency = '/ecommerce/orders/currency/{code}';
  static String validateCarrierChoice = '/ecommerce/orders/carriers/validate';
}

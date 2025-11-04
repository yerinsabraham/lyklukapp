import 'package:lykluk/core/shared/resources/typedefs.dart';
import 'package:lykluk/modules/ecommerce/model/order_model.dart';
import 'package:lykluk/utils/pagination/pagination.dart';

abstract class OrderRepository {
  /// create order
  FutureResponse<OrderModel> createOrder({ required Map<String, dynamic> data});
  /// get my orders
  FutureResponse<PaginatedResponse<OrderModel>>  getMyOrders({required Map<String, dynamic> query});
  /// get order byID
  FutureResponse getOrderById({required String id});
  /// get order stats
  FutureResponse getOrderStats({required Map<String, dynamic> query});
  /// update order status
  FutureResponse updateOrderStatus({required String orderId, required Map<String, dynamic> data});
  /// create tracking entry
  FutureResponse createTrackingEntry({required String orderId, required Map<String, dynamic> data});
  /// update tracking staus
  FutureResponse updateTrackingStatus({required String orderId, required Map<String, dynamic> data});
  /// get international order
  FutureResponse getInternationalOrderStats();
  /// get orders by current
  FutureResponse getOrdersByCurrency({required Map<String, dynamic> query});
  

  ///  validate carrier choice
  FutureResponse<StringMap> validateCarrierChoice({required Map<String, dynamic> data});
}

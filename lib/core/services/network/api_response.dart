import 'package:dio/dio.dart';
import 'package:lykluk/utils/extensions/datetime_extension.dart';

enum ApiStatus { success, failure }

class ApiResponse {
  
  ApiResponse({
    required this.isSuccessful,
    this.message,
    this.statusCode,
    this.data,
    this.header,
    this.responseObject,
  });

  final bool isSuccessful;
  String? message;
  int? statusCode;
  Response? responseObject;
  dynamic data;
  dynamic header;

  static ApiResponse response(Response response, Headers? headers) {
    final int statusCode = response.statusCode ?? 0;
    final bool isSuccessful = statusCode >= 200 && statusCode <= 299;

    final dynamic responseData = response.data;
    String status = 'SUCCESS';
    String message = 'Success';

    if (responseData is Map<String, dynamic>) {
      status = (responseData['status']?.toString().toUpperCase()) ?? 'SUCCESS';

      final dynamic messages = responseData['messages'];
      message =
          (messages is List && messages.isNotEmpty)
              ? messages.first.toString()
              : (responseData['message'] ?? 'Success').toString();
    } else if (responseData is bool) {
      status = responseData ? 'SUCCESS' : 'FAILED';
      message = responseData ? 'Operation successful' : 'Operation failed';
    } else if (responseData is String) {
      message = responseData;
    }

    return ApiResponse(
      isSuccessful: isSuccessful && status == 'SUCCESS',
      message: parseResponseMessage(message),
      data: responseData,
      header: headers,
      statusCode: statusCode,
      responseObject: response,
    );
  }

}

extension ApiError on DioException {
  ApiResponse toApiError() {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.sendTimeout:
        return ApiResponse(
          isSuccessful: false,
          message: 'Please check your internet connection or try again later',
        );

      case DioExceptionType.receiveTimeout:
        return ApiResponse(
          isSuccessful: false,
          message: 'Server took too long to respond, please try again later',
        );

      case DioExceptionType.cancel:
        return ApiResponse(isSuccessful: false, message: 'Request cancelled');

      case DioExceptionType.badResponse:
        final statusCode = response!.statusCode ?? 0;
        // final isSuccessful = statusCode >= 400 && statusCode <= 499;

        final responseData = response!.data;
        // final status =
        //     responseData['status']?.toString().toUpperCase() ?? 'SUCCESS';
        final messages = responseData['messages'];
        final message =
            messages is List && messages.isNotEmpty
                ? messages.first.toString()
                : (responseData['message'] ?? 'Success').toString();

        if (response!.data is Map) {
          return ApiResponse(
            isSuccessful: false ,
            message: parseResponseMessage(message),
            data: responseData,
            statusCode: statusCode,
            responseObject: response,
          );
        } else {
          return ApiResponse(
            isSuccessful: false,
            message: message,
            data: responseData,
            statusCode: response?.statusCode,
            responseObject: response,
          );
        }
      case DioExceptionType.unknown:
      default:
       
        return ApiResponse(
          isSuccessful: false,
          message: 'An unknown error occurred, please try again later',
        );
    }
  }
}

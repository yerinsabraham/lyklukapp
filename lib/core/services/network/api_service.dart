import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/network/endpoints.dart';
import 'package:lykluk/core/services/services.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/storage/local_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../queue_system/queue_config.dart';
import 'dio_interceptor.dart';

final apiServiceProvider = Provider((ref) => ApiService());

class ApiService {
  final Dio _client;

  ApiService({Dio? client})
    : _client =
          client ??
          Dio(
            BaseOptions(
              baseUrl: Endpoints.apiV1,
              connectTimeout: const Duration(seconds: 60),
              headers: {'Content-Type': 'application/json'},
            ),
          ) {
    _client.interceptors.addAll([prettyLogger, DioInterceptor(dio: _client)]);
  }
 

  /// pretty logger
  static final prettyLogger = PrettyDioLogger(
    request: false,
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    compact: true,
    enabled: kDebugMode,
  );

  Future<ApiResponse> postData(
    String url, {
    bool hasHeader = true,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool cancelFormerRequests = false,
    String? contentType,
    Dio? customClient,
    Function(double)? onReceiveProgress,
  }) async {
    try {
      final staticHeaders =
          {
            "app_token":
                "Date: eyyryyegdujc${DateTime.now().toUtc().microsecondsSinceEpoch}",
            // 'app_token':
            //     HiveStorage.fcmToken.isEmpty
            //         ? "Date: eyyryyegdujc${DateTime.now().toUtc().microsecondsSinceEpoch}"
            //         : HiveStorage.fcmToken,
            'Authorization':
                HiveStorage.accessToken.isEmpty
                    ? null
                    : 'Bearer ${HiveStorage.accessToken}',
          }.removeNullValues;
      final head = headers ?? staticHeaders;

      customClient?.interceptors.addAll([
        prettyLogger,
        DioInterceptor(dio: _client),
      ]);

      final request = await (customClient ?? _client).post(
        url,
        data: body,
        queryParameters: queryParameters,
        onSendProgress: (count, total) {
          double progress = ((count / total) * 100).floor().toDouble();

          onReceiveProgress?.call(progress);
        },
        options: Options(
          method: 'POST',
          headers: hasHeader ? head : null,
          contentType: contentType ?? 'application/json',
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );

      return ApiResponse.response(request, request.headers);
    } catch (e, s) {
      return _handleError(e, s);
    }
  }

  Future<ApiResponse> deleteData(
    String url, {
    bool hasHeader = true,
    dynamic body,
    bool cancelFormerRequests = false,
    Dio? customClient,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,

  }) async {
    try {
      customClient?.interceptors.addAll([
        prettyLogger,
        DioInterceptor(dio: _client),
      ]);

      final staticHeaders =
          {
            "app_token":
                "Date: eyyryyegdujc${DateTime.now().toUtc().microsecondsSinceEpoch}",
            // 'app_token':
            //     HiveStorage.fcmToken.isEmpty
            //         ? "Date: eyyryyegdujc${DateTime.now().toUtc().microsecondsSinceEpoch}"
            //         : HiveStorage.fcmToken,
            'Authorization':
                HiveStorage.accessToken.isEmpty
                    ? null
                    : 'Bearer ${HiveStorage.accessToken}',
          }.removeNullValues;
      final head = headers ?? staticHeaders;
      final request = await (customClient ?? _client).delete(
        url,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          method: 'DELETE',
          headers: hasHeader ? head : null,
          contentType: 'application/json',
        ),
      );

      return ApiResponse.response(request, request.headers);
    } catch (e, s) {
      return _handleError(e, s);
    }
  }

  Future<ApiResponse> putData(
    String url, {
    bool hasHeader = true,
    dynamic body,
    bool cancelFormerRequests = false,
    Dio? customClient,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool hasAuthorization = true,
    bool hasXAuthToken = false,
  }) async {
    try {
      customClient?.interceptors.addAll([
        prettyLogger,
        DioInterceptor(dio: _client),
      ]);
      final staticHeaders =
          {
            "app_token":
                "Date: eyyryyegdujc${DateTime.now().toUtc().microsecondsSinceEpoch}",
            // 'app_token':
            //     HiveStorage.fcmToken.isEmpty
            //         ? "Date: eyyryyegdujc${DateTime.now().toUtc().microsecondsSinceEpoch}"
            //         : HiveStorage.fcmToken,
            'Authorization':
                HiveStorage.accessToken.isEmpty
                    ? null
                    : 'Bearer ${HiveStorage.accessToken}',
          }.removeNullValues;
      final head = headers ?? staticHeaders;

      final request = await (customClient ?? _client).put(
        url,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          method: 'PUT',
          headers: hasHeader ? head : null,
          contentType: 'application/json',
        ),
      );

      return ApiResponse.response(request, request.headers);
    } catch (e, s) {
      return _handleError(e, s);
    }
  }

  Future<ApiResponse> patchData(
    String url, {
    bool hasHeader = true,
    dynamic body,
    bool cancelFormerRequests = false,
    Dio? customClient,
    Map<String, dynamic>? headers,
    bool hasAuthorization = true,
    bool hasXAuthToken = false,
  }) async {
    try {
      customClient?.interceptors.addAll([
        prettyLogger,
        DioInterceptor(dio: _client),
      ]);
      final staticHeaders =
          {
            "app_token":
                "Date: eyyryyegdujc${DateTime.now().toUtc().microsecondsSinceEpoch}",
            // 'app_token':
            //     HiveStorage.fcmToken.isEmpty
            //         ? "Date: eyyryyegdujc${DateTime.now().toUtc().microsecondsSinceEpoch}"
            //         : HiveStorage.fcmToken,
            'Authorization':
                HiveStorage.accessToken.isEmpty
                    ? null
                    : 'Bearer ${HiveStorage.accessToken}',
          }.removeNullValues;
      final head = headers ?? staticHeaders;

      final request = await (customClient ?? _client).patch(
        url,
        data: body,
        options: Options(
          method: 'PATCH',
          headers: hasHeader ? head : null,
          contentType: 'application/json',
        ),
      );

      return ApiResponse.response(request, request.headers);
    } catch (e, s) {
      return _handleError(e, s);
    }
  }

  Future<ApiResponse> getData(
    String url, {
    bool hasHeader = true,
    bool cancelFormerRequests = false,
    Dio? customClient,
    Map<String, dynamic>? queryParameters,
    String? contentType,
    Map<String, dynamic>? headers,
    // bool hasAuthorization = true,
    // bool hasXAuthToken = false,
  }) async {
    try {
      customClient?.interceptors.addAll([
        prettyLogger,
        DioInterceptor(dio: _client),
      ]);
      final staticHeaders =
          {
            // "app_token":
            //     "Date: eyyryyegdujc${DateTime.now().toUtc().microsecondsSinceEpoch}",
            'app_token':
                LocalAppStorage.fcm.isEmpty
                    ? "Date: eyyryyegdujc${DateTime.now().toUtc().microsecondsSinceEpoch}"
                    : LocalAppStorage.fcm.isEmpty,
            'Authorization':
                HiveStorage.accessToken.isEmpty
                    ? null
                    : 'Bearer ${HiveStorage.accessToken}',
          }.removeNullValues;
      final head = headers ?? staticHeaders;

      final request = await (customClient ?? _client).get(
        url,
        queryParameters: queryParameters,
        options: Options(
          method: 'GET',
          headers: hasHeader ? head : null,
          contentType: contentType ?? 'application/json',
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );

      return ApiResponse.response(request, request.headers);
    } catch (e, s) {
      return _handleError(e, s);
    }
  }

  ApiResponse _handleError(Object e, StackTrace s) {
    if (e is DioException) {
      return e.toApiError();
    } else if (e is SocketException) {
      return ApiResponse(
        isSuccessful: false,
        message: 'Please check your internet connection or try again later',
      );
    } else {
      log.d(e.toString(), stackTrace: s);
      return ApiResponse(isSuccessful: false, message: e.toString());
    }
  }

  ///excute
  Future<ApiResponse> execute(ApiAction action) async {
    try {
      final staticHeaders =
          {
            "app_token":
                "Date: eyyryyegdujc${DateTime.now().toUtc().microsecondsSinceEpoch}",
            // 'app_token':
            //     HiveStorage.fcmToken.isEmpty
            //         ? "Date: eyyryyegdujc${DateTime.now().toUtc().microsecondsSinceEpoch}"
            //         : HiveStorage.fcmToken,
            'Authorization':
                HiveStorage.accessToken.isEmpty
                    ? null
                    : 'Bearer ${HiveStorage.accessToken}',
          }.removeNullValues;
      final response = await _client.request(
        action.endpoint,
        data: action.body,
        queryParameters: action.queryParameters,
        options: Options(
          method: action.method,
          headers: action.headers ?? staticHeaders,
        ),
      );

      return ApiResponse.response(response, response.headers);
    } catch (e, s) {
      return _handleError(e, s);
    }
  }
}

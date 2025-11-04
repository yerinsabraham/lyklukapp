import 'package:dio/dio.dart';
import 'package:lykluk/utils/storage/local_storage.dart';




class DioInterceptor implements Interceptor {
  final Dio dio;

   DioInterceptor({ required this.dio });

  int retryCount = 0;
  final int maxRetry = 3;
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
     if (err.response?.statusCode == 419) {
      cancelAllRequest(clearCachedData: true);
      // AppRouter.router.goNamed(Routes.welcomeRoute);
    }
    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
   // Extract new tokens from response headers if present
    final rawAccessToken = response.headers['authorization']?.first;
    final rawRefreshToken = response.headers['token']?.first;

    final newAccessToken = rawAccessToken?.replaceFirst('Bearer ', '');
    final newRefreshToken = rawRefreshToken?.replaceFirst('Bearer ', '');

    if (newAccessToken != null) {
      HiveStorage.accessToken = newAccessToken;
      // log.d("Access token updated from header: $newAccessToken");
    }
    if (newRefreshToken != null) {
      HiveStorage.refreshToken = newRefreshToken;
      // log.d("Refresh token updated from header: $newRefreshToken");
    }

    if (response.statusCode == 419) {
      cancelAllRequest(clearCachedData: true);
    }

    return handler.next(response);
  }


void cancelAllRequest({bool clearCachedData = false}) {
    // token.cancel();
    if (clearCachedData) {
      HiveStorage.clearBoxes();
    }
  }
}

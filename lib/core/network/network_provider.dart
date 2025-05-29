import 'dart:developer';

import 'package:ai_resume_builder/core/constants/api_constant.dart';
import 'package:dio/dio.dart';

class NetworkProvider {
  static Dio instance() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstant.geminiUrl,
        validateStatus: (status) {
          return status != null && status >= 200 && status < 300;
        },
      ),
    );

    dio.interceptors.addAll([
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
      DioInterceptors(),
    ]);

    return dio;
  }
}

class DioInterceptors extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    log("Dio Exception: ${err.message}");

    super.onError(err, handler);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll({
      'Content-Type': 'application/json; charset=UTF-8',
    });

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }
}

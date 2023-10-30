import 'package:dio/dio.dart';
import 'package:news_app_flutter/core/data/http/api_exception.dart';
import 'package:news_app_flutter/core/data/http/custom_dio_interceptor.dart';

class ApiClient {
  final Dio client;

  ApiClient._({
    required this.client,
  });

  factory ApiClient.instance() {
    final baseOptions = BaseOptions(
      baseUrl: '',
      connectTimeout: 40000,
      receiveTimeout: 40000,
      contentType: 'application/json',
      responseType: ResponseType.json,
    );

    final dio = Dio(baseOptions)
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            return handler.next(options);
          },
          onResponse: (response, handler) {
            return handler.next(response);
          },
          onError: (error, handler) {
            ApiException.fromJson(error.response?.data);
            return handler.next(error);
          },
        ),
      );

    dio.interceptors.add(CustomDioInterceptor(
      responseBody: true,
      requestBody: true,
      requestHeader: true,
    ));

    return ApiClient._(client: dio);
  }

  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await client.get(
        url,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      return response.data;
    }catch(e) {
      rethrow;
    }
  }
}

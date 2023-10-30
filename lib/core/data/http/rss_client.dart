import 'package:dio/dio.dart';
import 'package:news_app_flutter/core/data/http/api_exception.dart';
import 'package:news_app_flutter/core/data/http/custom_dio_interceptor.dart';

class RssClient {
  final Dio client;

  RssClient._({
    required this.client,
  });

  factory RssClient.instance() {
    final baseOptions = BaseOptions(
      baseUrl: 'https://rss-to-json-serverless-api.vercel.app/',
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

    return RssClient._(client: dio);
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

  Future<dynamic> post(
      String url, {
        dynamic data = const {},
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    final response = await client.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );

    return response.data;
  }
}
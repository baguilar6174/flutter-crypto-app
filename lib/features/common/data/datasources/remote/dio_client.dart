import 'package:dio/dio.dart';

import 'package:crypto_app/utils/utils.dart';
import 'package:crypto_app/features/common/data/data.dart';

class DioClient {
  late Dio _dio;

  DioClient() {
    _dio = _createDio();
    _dio.interceptors.add(DioInterceptor());
  }

  Dio get dio {
    final dio = _createDio();
    dio.interceptors.add(DioInterceptor());
    return dio;
  }

  Dio _createDio() => Dio(
        BaseOptions(
          baseUrl: Constants.get.baseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          receiveTimeout: 60000,
          connectTimeout: 60000,
          validateStatus: (int? status) {
            return status! > 0;
          },
        ),
      );

  Future<Response> getRequest(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.get(url, queryParameters: queryParameters);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> postRequest(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    try {
      return await dio.post(url, data: data);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flutter_test_myeg/core/constants/app_constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetworkHelper {
  final Dio _dio;

  NetworkHelper() : _dio = Dio(BaseOptions(baseUrl: baseUrl, connectTimeout: connectTimeout, receiveTimeout: receiveTimeout)) {
    _dio.interceptors.add(PrettyDioLogger());
  }

  Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParameters, options: options);
      return response;
    } catch (e) {
      _handleError(e);
    }
  }

  void _handleError(dynamic error) {
    if (error is DioException) {
      throw Exception('Error: ${error.message}');
    } else {
      throw Exception('Unexpected error: $error');
    }
  }
}

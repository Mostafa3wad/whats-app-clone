import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:whats_app_clone/core/constants/keys/local_db_keys.dart';
import 'package:whats_app_clone/core/constants/paths/api_endpoints.dart';

import '../logging/app_logger.dart';

class DioClient {
  final Dio _dio;
  final AppLogger _appLogger = AppLogger();

  DioClient(this._dio) {
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = const Duration(seconds: 10)
      ..options.receiveTimeout = const Duration(seconds: 10)
      ..options.headers = <String, dynamic>{'Content-Type': 'application/json'};

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          // You can add authorization tokens here if needed
          _appLogger.info(
            'REQUEST[${options.method}] => PATH: ${options.path}',
          );
          return handler.next(options);
        },
        onResponse:
            (Response<dynamic> response, ResponseInterceptorHandler handler) {
              _appLogger.info(
                'RESPONSE[${response.statusCode}] => DATA: ${response.data}',
              );
              return handler.next(response);
            },
        onError: (DioException e, ErrorInterceptorHandler handler) async {
          if (e.response?.statusCode == 401) {
            final FlutterSecureStorage storage = const FlutterSecureStorage();
            final String? refreshToken = await storage.read(
              key: LocalDbKeys.refreshToken,
            );

            post(
              ApiEndpoints.refreshToken,
              data: <String, dynamic>{'refresh': refreshToken},
            );
          }
          _appLogger.info(
            'ERROR[${e.response?.statusCode}] => MESSAGE: ${e.message}',
          );
          return handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response<dynamic> response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>> post(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final Response<dynamic> response = await _dio.post(path, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>> put(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final Response<dynamic> response = await _dio.put(path, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>> delete(String path) async {
    try {
      final Response<dynamic> response = await _dio.delete(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>> patch(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final Response<dynamic> response = await _dio.patch(path, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

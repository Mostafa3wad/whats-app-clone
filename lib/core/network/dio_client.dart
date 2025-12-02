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
            try {
              // Try to refresh token
              final bool refreshed = await _refreshToken();

              if (refreshed) {
                // Retry the original request with new token
                final RequestOptions requestOptions = e.requestOptions;

                // Get new token
                const FlutterSecureStorage storage = FlutterSecureStorage();
                final String? newToken = await storage.read(
                  key: LocalDbKeys.accessToken,
                );

                // Add new token to headers
                requestOptions.headers['Authorization'] = 'Bearer $newToken';

                // Retry the request
                final Response<dynamic> response = await _dio.fetch(
                  requestOptions,
                );
                return handler.resolve(response);
              }
            } catch (refreshError) {
              _appLogger.error('Token refresh failed', refreshError, null);
              // Token refresh failed, user needs to login again
            }
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

  /// Refresh access token using refresh token
  /// Returns true if refresh was successful, false otherwise
  Future<bool> _refreshToken() async {
    try {
      // Get refresh token from secure storage
      const FlutterSecureStorage storage = FlutterSecureStorage();
      final String? refreshToken = await storage.read(
        key: LocalDbKeys.refreshToken,
      );

      // Check if refresh token exists
      if (refreshToken == null || refreshToken.isEmpty) {
        _appLogger.error('No refresh token found', null, null);
        return false;
      }

      // Call refresh token API
      final Response<dynamic> response = await _dio.post(
        ApiEndpoints.refreshToken,
        data: <String, dynamic>{'refresh': refreshToken},
      );

      // Check if refresh was successful
      if (response.statusCode == 200 && response.data != null) {
        final String? newAccessToken = response.data['access'] as String?;

        if (newAccessToken != null && newAccessToken.isNotEmpty) {
          // Save new access token
          await storage.write(
            key: LocalDbKeys.accessToken,
            value: newAccessToken,
          );

          _appLogger.info('Token refreshed successfully');
          return true;
        }
      }

      return false;
    } on Exception catch (e) {
      _appLogger.error('Token refresh error', e);
      return false;
    }
  }
}

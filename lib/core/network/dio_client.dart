import 'package:dio/dio.dart';

import '../logging/app_logger.dart';

class DioClient {
  final Dio _dio;
  final AppLogger _appLogger = AppLogger();

  DioClient(this._dio) {
    _dio
      ..options.baseUrl = 'https://api.example.com/'
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
        onError: (DioException e, ErrorInterceptorHandler handler) {
          _appLogger.info(
            'ERROR[${e.response?.statusCode}] => MESSAGE: ${e.message}',
          );
          return handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;
}

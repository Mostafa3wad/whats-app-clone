import 'package:dio/dio.dart';
import '/core/logging/app_logger.dart';
import '/core/network/dio_client.dart';

class ApiService {
  final DioClient dioClient;
  final AppLogger _appLogger = AppLogger();

  ApiService({
    required this.dioClient,
  });

  Future<dynamic> get({
    required String endpoint,
  }) async {
    try {
      final Response<dynamic> response = await dioClient.dio.get(
        endpoint,
      );
      return response.data;
    } catch (e) {
      _appLogger.error('ERROR => $e');
      rethrow;
    }
  }

  Future<dynamic> post({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      final Response<dynamic> response = await dioClient.dio.post(
        endpoint,
        data: data,
      );
      return response.data;
    } catch (e) {
      _appLogger.error('ERROR => $e');
      rethrow;
    }
  }

  Future<dynamic> put({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      final Response<dynamic> response = await dioClient.dio.put(
        endpoint,
        data: data,
      );
      return response.data;
    } catch (e) {
      _appLogger.error('ERROR => $e');
      rethrow;
    }
  }

  Future<dynamic> delete({
    required String endpoint,
  }) async {
    try {
      final Response<dynamic> response = await dioClient.dio.delete(
        endpoint,
      );
      return response.data;
    } catch (e) {
      _appLogger.error('ERROR => $e');
      rethrow;
    }
  }
}

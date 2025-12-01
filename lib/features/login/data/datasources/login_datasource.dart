import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:whats_app_clone/core/constants/keys/local_db_keys.dart';
import 'package:whats_app_clone/core/network/dio_client.dart';
import 'package:whats_app_clone/features/login/data/models/respone_send_otp_model.dart';
import 'package:whats_app_clone/core/constants/paths/api_endpoints.dart';

class LoginDataSource {
  final DioClient dioClient;
  LoginDataSource(this.dioClient);

  Future<ResponseSendOtpModel> sendOtp(String phoneNumber) async {
    log(phoneNumber);
    final Response<dynamic> response = await dioClient.post(
      ApiEndpoints.sendOtp,
      data: <String, dynamic>{'phone_number': phoneNumber},
    );
    if (response.statusCode == 200) {
      return ResponseSendOtpModel.fromJson(response.data);
    } else {
      throw Exception(response.data['detail']);
    }
  }

  Future<Unit> verifyOtp(String sessionId, String otp) async {
    final Response<dynamic> response = await dioClient.post(
      ApiEndpoints.verifyOtp,
      data: <String, dynamic>{'session_id': sessionId, 'otp': otp},
    );
    if (response.statusCode == 200) {
      final FlutterSecureStorage storage = const FlutterSecureStorage();
      final String token = response.data['access'];
      final String refreshToken = response.data['refresh'];
      await storage.write(key: LocalDbKeys.accessToken, value: token);
      await storage.write(key: LocalDbKeys.refreshToken, value: refreshToken);

      return unit;
    } else {
      throw Exception(response.data['detail']);
    }
  }
}

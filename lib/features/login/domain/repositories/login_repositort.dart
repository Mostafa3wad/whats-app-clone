import 'package:dartz/dartz.dart';
import 'package:whats_app_clone/core/errors/failures.dart';
import 'package:whats_app_clone/features/login/domain/entities/respone_send_otp_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, ResponseSendOtpEntity>> sendOtp(String phoneNumber);
  Future<Either<Failure, Unit>> verifyOtp(String sessionId, String otp);
}

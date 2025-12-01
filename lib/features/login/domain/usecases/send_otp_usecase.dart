import 'package:dartz/dartz.dart';
import 'package:whats_app_clone/core/errors/failures.dart';
import 'package:whats_app_clone/features/login/domain/entities/respone_send_otp_entity.dart';
import 'package:whats_app_clone/features/login/domain/repositories/login_repositort.dart';

class SendOtpUseCase {
  final LoginRepository loginRepository;

  SendOtpUseCase(this.loginRepository);

  Future<Either<Failure, ResponseSendOtpEntity>> call(String phoneNumber) {
    return loginRepository.sendOtp(phoneNumber);
  }
}

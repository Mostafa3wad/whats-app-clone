import 'package:dartz/dartz.dart';
import 'package:whats_app_clone/core/errors/failures.dart';
import 'package:whats_app_clone/features/login/domain/repositories/login_repositort.dart';

class VerifyOtpUseCase {
  final LoginRepository loginRepository;

  VerifyOtpUseCase(this.loginRepository);

  Future<Either<Failure, Unit>> call(String sessionId, String otp) {
    return loginRepository.verifyOtp(sessionId, otp);
  }
}

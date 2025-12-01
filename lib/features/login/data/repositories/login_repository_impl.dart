import 'package:dartz/dartz.dart';
import 'package:whats_app_clone/core/errors/failures.dart';
import 'package:whats_app_clone/core/network/network_info.dart';
import 'package:whats_app_clone/features/login/data/datasources/login_datasource.dart';
import 'package:whats_app_clone/features/login/data/models/respone_send_otp_model.dart';
import 'package:whats_app_clone/features/login/domain/entities/respone_send_otp_entity.dart';
import 'package:whats_app_clone/features/login/domain/repositories/login_repositort.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource loginDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl(this.loginDataSource, this.networkInfo);

  @override
  Future<Either<Failure, ResponseSendOtpEntity>> sendOtp(
    String phoneNumber,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final ResponseSendOtpModel response = await loginDataSource.sendOtp(
          phoneNumber,
        );
        return Right(response);
      } on Exception catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    }
    return const Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, Unit>> verifyOtp(String sessionId, String otp) async {
    if (await networkInfo.isConnected) {
      try {
        final Unit response = await loginDataSource.verifyOtp(sessionId, otp);
        return Right(response);
      } on Exception catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    }
    return const Left(NetworkFailure());
  }
}

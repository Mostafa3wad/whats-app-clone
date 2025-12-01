import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whats_app_clone/core/errors/failures.dart';
import 'package:whats_app_clone/features/login/domain/entities/respone_send_otp_entity.dart';
import 'package:whats_app_clone/features/login/domain/usecases/send_otp_usecase.dart';
import 'package:whats_app_clone/features/login/domain/usecases/verify_otp_usecse.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.sendOtpUseCase, this.verifyOtpUseCase)
    : super(LoginInitial());

  final SendOtpUseCase sendOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;

  Future<void> sendOtp(String phoneNumber) async {
    emit(LoginLoading());

    final Either<Failure, ResponseSendOtpEntity> result = await sendOtpUseCase(
      phoneNumber,
    );
    result.fold(
      (Failure failure) => emit(LoginError(failure.message!)),
      (ResponseSendOtpEntity success) => emit(LoginSuccess(success)),
    );
  }

  Future<void> verifyOtp({
    required String sessionId,
    required String otp,
  }) async {
    emit(LoginLoading());
    final Either<Failure, Unit> result = await verifyOtpUseCase(sessionId, otp);
    result.fold(
      (Failure failure) => emit(LoginError(failure.message!)),
      (Unit success) => emit(VerifyOtpSuccess()),
    );
  }
}

part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => <Object>[];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final ResponseSendOtpEntity data;

  const LoginSuccess(this.data);
}

final class VerifyOtpSuccess extends LoginState {}

final class LoginError extends LoginState {
  final String message;

  const LoginError(this.message);
}

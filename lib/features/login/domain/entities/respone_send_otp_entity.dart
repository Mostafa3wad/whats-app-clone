import 'package:equatable/equatable.dart';

class ResponseSendOtpEntity extends Equatable {
  final String detail;
  final String sessionId;
  final int expiresIn;

  const ResponseSendOtpEntity({
    required this.detail,
    required this.sessionId,
    required this.expiresIn,
  });

  @override
  List<Object?> get props => <Object?>[detail, sessionId, expiresIn];
}

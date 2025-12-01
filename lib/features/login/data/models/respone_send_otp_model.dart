import 'package:whats_app_clone/features/login/domain/entities/respone_send_otp_entity.dart';

class ResponseSendOtpModel extends ResponseSendOtpEntity {
  const ResponseSendOtpModel({
    required super.detail,
    required super.sessionId,
    required super.expiresIn,
  });

  factory ResponseSendOtpModel.fromJson(Map<String, dynamic> json) {
    return ResponseSendOtpModel(
      detail: json['detail'],
      sessionId: json['session_id'],
      expiresIn: json['expires_in'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'detail': detail,
      'session_id': sessionId,
      'expires_in': expiresIn,
    };
  }
}

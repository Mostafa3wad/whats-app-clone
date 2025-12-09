class ApiEndpoints {
  static const String wsUrl =
      'wss://whatsapp-clone-production-c456.up.railway.app/ws/chat';
  static const String baseUrl =
      'https://whatsapp-clone-production-c456.up.railway.app';
  static const String sendOtp = '$baseUrl/users/send-otp/';
  static const String verifyOtp = '$baseUrl/users/verify-otp/';
  static const String refreshToken = '$baseUrl/users/api/token/refresh/';
}
 
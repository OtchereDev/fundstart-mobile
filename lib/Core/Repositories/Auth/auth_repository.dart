abstract class AuthRepository {
  Future<Map<String, dynamic>> setHeaders();
  Future<dynamic> signin(context, dynamic data);
  Future<dynamic> signup(context, dynamic data);
  Future<dynamic> sendOtp(context, dynamic data);
  Future<dynamic> verifyOtp(context, dynamic data);
  Future<dynamic> subscribePushNotification(context, dynamic data);
  // Future<dynamic> testPushNotification(context, dynamic data);
}

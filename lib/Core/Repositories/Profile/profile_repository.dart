

abstract class ProfileRepository {
  Future<dynamic> getPortfolio(context);
  Future<dynamic> changePassword(context, dynamic data);
  Future<dynamic> changeProfile(context, dynamic data);
  // Future<Map<String, dynamic>> verifyForgotOtp(context, dynamic data);
  // Future<dynamic> changePassword(context, dynamic data);
  // Future<dynamic> forgotPassword(context, dynamic data);
}

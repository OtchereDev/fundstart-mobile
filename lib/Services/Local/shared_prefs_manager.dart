// import 'dart:convert';
// import 'package:collector_app/Model/user_model.dart';

import 'dart:convert';

import 'package:crowdfunding/Model/Response/user_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsManager {
  final String authToken = "auth_token";
  final String baseCurrency = "base_currency";
  final String getStarted = 'get_started';
  final firstTime = "firstTimeUser";
  // final String user_id = "user_id";

//set data into shared preferences like this
  Future<void> setAuthToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(authToken, token);
  }

  Future<String> getCurrency() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(baseCurrency) ?? "";
  }

  Future<UserResponse?> getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user = preferences.getString('user');
    if (user == null) {
      return null;
    }
    return UserResponse.fromJson(jsonDecode(user));
  }

  Future<String> getAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? newToken;
    newToken = pref.getString(authToken) ?? "";
    return newToken;
  }

  getFlowIdToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('flow_id');
    return token;
  }

  setFlowIdToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('flow_id', token);
  }

  Future<bool> isAuthenticated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? phone = prefs.getString(authToken);
    if (phone != null) {
      return true;
    }
    return false;
  }




 

  setGetStarted(bool set) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var phone = prefs.setBool(getStarted, set);
    return phone;
  }

  Future<bool> getGetstarted() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final result = preferences.getBool(getStarted);
    return result ?? false;
  }

 
  setUser(UserResponse user) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('user', jsonEncode(user.toJson()));
  }

  Future<void> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    await preferences.remove('verification_response');
  }
}

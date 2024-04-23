import 'dart:convert';

import 'package:crowdfunding/Core/Api/routes.dart';
import 'package:crowdfunding/Core/Mixins/auth_base_repository.dart';
import 'package:crowdfunding/Core/Repositories/Auth/auth_repository.dart';
import 'package:crowdfunding/Services/Local/shared_prefs_manager.dart';
import 'package:http/http.dart' as http;
class AuthRemoteService with AuthBaseRepository implements AuthRepository {
  @override
  String token = "N/A";
  // SharedPrefsManager _manager = new SharedPrefsManager();

  @override
  Future<Map<String, String>> setHeaders() async {
    token = await SharedPrefsManager().getAuthToken();
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // registers device for firebase notifications
  @override
  Future<bool> registerDevice(String token) async {
    try {
      Map<String, String> headers = await setHeaders();
      var data = {'device_token': token};

      var response = await http.post(Uri.parse(kBaseUrl),
          body: jsonEncode(data), headers: headers);
      return response.statusCode == 200;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> signin(context, data) async {
    dynamic responseMap = {"status": false, "message": "", "data": null};
    await post(
      context,
      url: "$kBaseUrl/auth/login",
      data: jsonEncode(data),
    ).then((response) {
       if (response != null) {
        var dataResponse = json.decode(response.body);
        if (response.statusCode == 200) {
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        } else {
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        }
      }
    });
    return responseMap;
  }

  @override
  Future<dynamic> signup(context, data) async {
    dynamic responseMap = {"status": false, "message": "", "data": null};
    await post(
      context,
      url: "$kBaseUrl/auth/signup",
      data: jsonEncode(data),
    ).then((response) {
      if (response != null) {
        var dataResponse = json.decode(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        } else {
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        }
      }
      // print(responseMap);
    });
    return responseMap;
  }

  @override
  Future<dynamic> sendOtp(context, data) async {
    dynamic responseMap = {"status": false, "message": "", "data": null};
    await post(context, url: "$kBaseUrl/referring-doctors/request-password-reset", data:jsonEncode(data))
        .then((response) {
      if (response != null) {
        var dataResponse = json.decode(response.body);
        print(dataResponse);
        if (response.statusCode == 200) {
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = json.decode(response.body);
        }else{
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        }
      }
    });
    return responseMap;
  }

  @override
  Future verifyOtp(context, data) async {
      dynamic responseMap = {"status": false, "message": "", "data": null};
    await post(context, url: "$kBaseUrl/account/verify", data: data)
        .then((response) {
      if (response != null){
         var dataResponse = json.decode(response.body);
        if (response.statusCode == 200) {
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = json.decode(response.body);
        }else{
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        }
      }
    });
    return responseMap;
  }

  Future checkAuthUser(context) async {
    dynamic responseMap = {"status": false, "message": "", "data": null};
     await get(context, url: "$kBaseUrl/auth/check-user").then((response) {
      if (response != null){
        if (response.statusCode == 200) {
          var dataResponse = json.decode(response.body);
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = json.decode(response.body);
        }else{
          responseMap['message'] = "No user available";
          responseMap['data'] = null;
        }
      }
    });
    return responseMap;
  }

  @override
  Future subscribePushNotification(context, data) async {
    dynamic responseMap;
    await post(context, url: "", data: data).then((response) {
      // print(response.body);
      if (response != null) responseMap = json.decode(response.body);
    });
    return responseMap;
  }

  // @override
  Future testPushNotification(context, data) async {
    dynamic responseMap;
    await get(context, url: "").then((response) {
      if (response != null){
          var dataResponse = json.decode(response.body);
        if (response.statusCode == 200) {
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = json.decode(response.body);
        }else{
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        }
      }
    });
    return responseMap;
  }

  // @override
  Future resetPassword(context, data) async {
       dynamic responseMap = {"status": false, "message": "", "data": null};
    await post(context, url: "$kBaseUrl/referring-doctors/reset-password", data: jsonEncode(data)).then((response) {
      if (response != null) {
          var dataResponse = json.decode(response.body);
      print(dataResponse);
        if (dataResponse['statusCode'] == 200) {
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        }else{
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        }
      }
    });
    return responseMap;
  }

  //  @override
  Future verifyPin(context, data) async {
    dynamic responseMap = {"status": false, "message": "", "data": null};
    await post(context, url: "$kBaseUrl/auth/login-complete", data:jsonEncode(data)).then((response) {
      // print(response);
      if (response != null) {
        if (response.statusCode == 200) {
          var dataResponse = json.decode(response.body);
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        }else{
          responseMap['message'] = "Verification failed";
          responseMap['data'] = null;
        }
      }
    });
    return responseMap;
  }
  

  

}

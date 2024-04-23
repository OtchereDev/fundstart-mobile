import 'dart:convert';

import 'package:crowdfunding/Core/Api/routes.dart';
import 'package:crowdfunding/Core/Mixins/auth_base_repository.dart';
import 'package:crowdfunding/Core/Repositories/Profile/profile_repository.dart';

class ProfileService with AuthBaseRepository implements ProfileRepository {
  Future uploadProfilePic(context, data) async {
    dynamic responseMap = {"status": false, "message": "", "data": null};

    await put(
      context,
      url: "$kBaseUrl/user",
      data: (data)
    ).then((response) {
      print(response.body);

      if (response != null) {
        var dataResponse = json.decode(response.body);
        if (response.statusCode == 200) {
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = json.decode(response.body);
        } else {
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        }
      }
    });
    return responseMap;
  }
  
  @override
  Future changePassword(context, data) async {
  dynamic responseMap = {"status": false, "message": "", "data": null};

    await put(
      context,
      url: "$kBaseUrl/auth/change-password",
      data: jsonEncode(data)
    ).then((response) {
      print(response.body);

      if (response != null) {
        var dataResponse = json.decode(response.body);
        if (response.statusCode == 200) {
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = json.decode(response.body);
        } else {
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        }
      }
    });
    return responseMap;
  }
  
  @override
  Future changeProfile(context, data) async {
  dynamic responseMap = {"status": false, "message": "", "data": null};
    await post(
      context,
      url: "$kBaseUrl/auth/change-profile",
      data: jsonEncode(data)
    ).then((response) {
      if (response != null) {
        var dataResponse = json.decode(response.body);
        if (response.statusCode == 200) {
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = json.decode(response.body);
        } else {
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        }
      }
    });
    return responseMap;
  }
  
  Future getPortfolio(context) async {
   dynamic responseMap = {"status": false, "message": "", "data": null};
    await get(
      context,
      url: "$kBaseUrl/portfolio",
    ).then((response) {
      if (response != null) {
        var dataResponse = json.decode(response.body);
        if (response.statusCode == 200) {
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = json.decode(response.body);
        } else {
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        }
      }
    });
    return responseMap;
  }

  Future replyChat(context, data) async {
  dynamic responseMap = {"status": false, "message": "", "data": null};

    await post(
      context,
      url: "$kBaseUrl/chat/add",
      data: jsonEncode(data)
    ).then((response) {
      print(response?.body);

      if (response != null) {
        if (response.statusCode == 200) {
        var dataResponse = json.decode(response.body);
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = json.decode(response.body);
        } else {
          responseMap['message'] = "Something went wrong";
          responseMap['data'] = null;
        }
      }
    });
    return responseMap;
  }

  Future initChat(context) async {
  dynamic responseMap = {"status": false, "message": "", "data": null};

    await post(
      context,
      url: "$kBaseUrl/chat/init",
      // data: jsonEncode(data)
    ).then((response) {

      if (response != null) {
        var dataResponse = json.decode(response.body);
        if (response.statusCode == 200) {
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = json.decode(response.body);
        } else {
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        }
      }
    });
    return responseMap;
  }
}

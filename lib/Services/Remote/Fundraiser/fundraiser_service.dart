import 'dart:convert';

import 'package:crowdfunding/Core/Api/routes.dart';
import 'package:crowdfunding/Core/Helpers/navigation_helper.dart';
import 'package:crowdfunding/Core/Mixins/auth_base_repository.dart';
import 'package:crowdfunding/Core/Repositories/Fundraiser/fundraiser_repository.dart';
import 'package:crowdfunding/Services/Local/shared_prefs_manager.dart';
import 'package:crowdfunding/Views/GetStarted/get_started.dart';

class FundraiserService
    with AuthBaseRepository
    implements FundraisersRepository {
  @override
  Future createFundraiser(context, data) async {
    dynamic responseMap = {"status": false, "message": "", "data": null};
    await post(
      context,
      url: "$kBaseUrl/fundraisers",
      data: jsonEncode(data),
    ).then((response) {
      print(response?.body);
      if (response != null && response != "") {
        var dataResponse = json.decode(response.body);
        if (response.statusCode == 200) {
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          // responseMap['data'] = dataResponse;
        } else if (dataResponse['message'] == "Unauthenticated") {
          SharedPrefsManager().logout();
          AppNavigationHelper.setRootOldWidget(context, GetStarted());
        } else {
          responseMap['message'] = "Campaign creation failed";
          responseMap['data'] = null;
        }
      }
    });
    return responseMap;
  }

  @override
  Future getAllFundraiser(context) async {
    dynamic responseMap = {"status": false, "message": "", "data": null};
    await get(
      context,
      url: "$kBaseUrl/fundraisers",
    ).then((response) {
      if (response != null) {
        if (response.statusCode == 200) {
          var dataResponse = json.decode(response.body);
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        } else {
          responseMap['message'] = "failed";
          responseMap['data'] = null;
        }
      }
    });
    return responseMap;
  }

  @override
  Future getAnalytics(context, {String? filter}) async {
    dynamic responseMap = {"status": false, "message": "", "data": null};
    await get(
      context,
      url: "$kBaseUrl/create-account",
    ).then((response) {
      if (response != null) {
        var dataResponse = json.decode(response.body);
        if (response.statusCode == 200) {
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        } else if (dataResponse['message'] == "Unauthenticated") {
          SharedPrefsManager().logout();
          AppNavigationHelper.setRootOldWidget(context, GetStarted());
        } else {
          responseMap['message'] = "failed";
          responseMap['data'] = null;
        }
      }
    });
    return responseMap;
  }

  @override
  Future getCategory(context) async {
    dynamic responseMap = {"status": false, "message": "", "data": null};
    await get(
      context,
      url: "$kBaseUrl/category",
    ).then((response) {
      if (response != null && response != "") {
        var dataResponse = json.decode(response.body);
        if (response.statusCode == 200) {
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        } else if (dataResponse['message'] == "Unauthenticated") {
          SharedPrefsManager().logout();
          AppNavigationHelper.setRootOldWidget(context, GetStarted());
        } else {
          responseMap['message'] = "get category failed";
          responseMap['data'] = null;
        }
      }
    });
    return responseMap;
  }

  @override
  Future getSingleFundraiser(context, String id) async {
    dynamic responseMap = {"status": false, "message": "", "data": null};
    await get(
      context,
      url: "$kBaseUrl/fundraisers/$id",
    ).then((response) {
      if (response != null) {
        if (response.statusCode == 200) {
          var dataResponse = json.decode(response.body);
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        } else {
          responseMap['message'] = "Failed";
          responseMap['data'] = null;
        }
      }
      // print(responseMap);
    });
    return responseMap;
  }

  Future getAllInvestors(context) async {
    dynamic responseMap = {"status": false, "message": "", "data": null};
    await get(
      context,
      url: "$kBaseUrl/investors",
    ).then((response) {
      if (response != null) {
        if (response.statusCode == 200) {
          var dataResponse = json.decode(response.body);
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        } else {
          responseMap['message'] = "Failed";
          responseMap['data'] = null;
        }
      }
      // print(responseMap);
    });
    return responseMap;
  }
}

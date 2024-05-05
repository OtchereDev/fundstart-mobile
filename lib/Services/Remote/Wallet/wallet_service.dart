import 'dart:convert';

import 'package:crowdfunding/Core/Api/routes.dart';
import 'package:crowdfunding/Core/Helpers/navigation_helper.dart';
import 'package:crowdfunding/Core/Mixins/auth_base_repository.dart';
import 'package:crowdfunding/Core/Repositories/Wallet/wallet_repository.dart';
import 'package:crowdfunding/Services/Local/shared_prefs_manager.dart';
import 'package:crowdfunding/Views/GetStarted/get_started.dart';

class WalletService with AuthBaseRepository implements WalletRepository {
  @override
  Future createWallet(context, data) async {
    dynamic responseMap = {"status": false, "message": "", "data": null};
    await post(
      context,
      url: "$kBaseUrl/wallet/create",
      data: jsonEncode(data),
    ).then((response) {
      if (response != null) {
        var dataResponse = json.decode(response.body);

        // print("---------------$dataResponse");
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
  Future getAllWallet(context) async {
    dynamic responseMap = {"status": false, "message": "", "data": null};
    await get(
      context,
      url: "$kBaseUrl/wallet",
    ).then((response) {
      if (response != null) {
          var dataResponse = json.decode(response.body);
        if (response.statusCode == 200) {
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        }
         else if (dataResponse['message'] == "Unauthenticated") {
          SharedPrefsManager().logout();
          AppNavigationHelper.setRootOldWidget(context, GetStarted());
        }  else {
          responseMap['message'] = "";
          responseMap['data'] = null;
        }
      }
    });
    return responseMap;
  }

  @override
  Future getSingleWallet(context, String id) async {
    dynamic responseMap = {"status": false, "message": "", "data": null};
    await get(
      context,
      url: "$kBaseUrl/wallet/$id",
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
          responseMap['message'] = "";
          responseMap['data'] = null;
        }
      }
    });
    return responseMap;
  }

  Future getDashboard(context) async {
    dynamic responseMap = {"status": false, "message": "", "data": null};
    await get(
      context,
      url: "$kBaseUrl/dashboard",
    ).then((response) {
      if (response != null) {
        print(response.body);
        var dataResponse = json.decode(response.body);
        if (response.statusCode == 200) {
          print(dataResponse);
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        } else if (dataResponse['message'] == "Unauthenticated") {
          SharedPrefsManager().logout();
          AppNavigationHelper.setRootOldWidget(context, GetStarted());
        } else {
          responseMap['message'] = "";
          responseMap['data'] = null;
        }
      }
    });
    return responseMap;
  }
}

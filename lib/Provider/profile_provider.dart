import 'package:crowdfunding/Components/custom_toast.dart';
import 'package:crowdfunding/Components/loading_item.dart';
import 'package:crowdfunding/Model/Response/portfolio_response.dart';
import 'package:crowdfunding/Model/Response/user_response.dart';
import 'package:crowdfunding/Services/Local/shared_prefs_manager.dart';
import 'package:crowdfunding/Services/Remote/Profile/profile_service.dart';
import 'package:crowdfunding/Utils/Dialogs/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class ProfileProvider extends ChangeNotifier {
  final SharedPrefsManager _sharedPrefsManager = SharedPrefsManager();
  final _profileFactory = ProfileService();
  UserResponse? _currentUserProfile;
  UserResponse? get currentUserProfile => _currentUserProfile;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  PortfolioResponse _portfolioResponse = PortfolioResponse();
  PortfolioResponse get portfolioResponse => _portfolioResponse;


  void setCurrentUserProfile(UserResponse user) {
    _currentUserProfile = user;
    // print("setting current user to shared Prefs ${user.toJson()}");
    _sharedPrefsManager.setUser(user);
    notifyListeners();
  }

  resetUser(context) async {
    await getUser(context);
  }

  String getUserFullname() {
    String fullName = "";
    if (_currentUserProfile != null) {
      fullName = "${_currentUserProfile!.data.result.profile.firstName!}";
    }
    return fullName;
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  getUser(context, {bool fromRemote = false}) async {
    UserResponse? user = await _sharedPrefsManager.getUser();
    // _loadingState = LoadingState.idle;

    if (user != null) {
      setCurrentUserProfile(user);
    }
    return user;
  }

  ProfileProvider(context) {
    loadCurrentProfile(context);
  }

  Future<UserResponse?> loadCurrentProfile(context) async {
    getUser(context);
    return null;
  }

  Future logout(context) async {
    await _sharedPrefsManager.logout();
    _currentUserProfile = null;
    notifyListeners();
  }

  Future<bool?> changePassword(context, String password, String newPassword,
      String confirmPassword, bool firstimer) async {
    show(context);
    bool? isFirstimer = false;
    if (newPassword != confirmPassword) {
      DialogUtils.showNativeAlertDialog(context,
          message: 'Password mis-match', title: 'Sorry');
    } else {
      Loader.hide();
      Map<String, dynamic> body = {
        "oldPassword": confirmPassword,
        "newPassword": newPassword,
      };
      await _profileFactory.changePassword(context, body).then((response) {
        Loader.hide();
        if (response['status'] == true) {
          customDailog(
              message: response['message'],
              title: "Update Complete",
              isSuccess: true);
        } else {
          customDailog(
              message: response['message'],
              title: "Update Failed",
              isSuccess: false);
        }
      });
    }
    return isFirstimer;
  }

  Future<bool?> changeProfile(
      context, data) async {
    bool? isSuccess = false;

    show(context);
   
    await _profileFactory.changeProfile(context, data).then((response) {
      print(response);
      Loader.hide();
      if (response['status'] == true) {
        isSuccess = true;
        customDailog(
            message: response['message'],
            title: "Update Complete",
            isSuccess: true);
      } else {
        customDailog(
            message: response['message'],
            title: "Update Failed",
            isSuccess: false);
      }
    });

    return isSuccess;
  }

  getPortfolio(context) async {
    setLoading(true);
    await _profileFactory.getPortfolio(context).then((value) {
      print(value);
      setLoading(false);
      if (value['status'] == true) {
        _portfolioResponse = PortfolioResponse.fromJson(value['data']);
        notifyListeners();
      }
    });
  }
}

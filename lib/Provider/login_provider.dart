import 'package:crowdfunding/Components/custom_toast.dart';
import 'package:crowdfunding/Components/loading_item.dart';
import 'package:crowdfunding/Core/Helpers/navigation_helper.dart';
import 'package:crowdfunding/Model/Response/user_response.dart';
import 'package:crowdfunding/Services/Local/shared_prefs_manager.dart';
import 'package:crowdfunding/Services/Remote/Authentication/auth_remote_service.dart';
import 'package:crowdfunding/Views/Auth/login.dart';
import 'package:crowdfunding/Views/Home/home_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class AuthProvider extends ChangeNotifier {
  AuthRemoteService authService = AuthRemoteService();
  final SharedPrefsManager _sharedPrefsManager = SharedPrefsManager();
  bool _loadPage = false;
  bool get loadPage => _loadPage;

  setLoadingPage(bool value) {
    _loadPage = value;
    notifyListeners();
  }

  verifyPin(context, String pin) async {
    String? token = await SharedPrefsManager().getFlowIdToken();

    Map<String, dynamic> data = {
      "token": token,
      "code": pin
    };
    await authService.verifyPin(context, data).then((value) async {
      // setLoadingPage(false);
      if (value['status'] == true) {
        await _sharedPrefsManager
            .setAuthToken(value['data']['response']['result']['active_token']['token']);
        print(value);
       await checkUser(context).then((res){
          if(res == true){
            AppNavigationHelper.setRootOldWidget(context, HomeIndex());
          }
        });
      } else {
        customDailog(
            isSuccess: false,
            message: 'Verification failed',
            title: 'Failed',
            icon: const Icon(Icons.warning_amber));
      }
    });
  }

  Future<bool?> performLogin(context,
      {required String email, required String password}) async {
      show(context);

    bool? actionSuccessful = false;
    Map<String, dynamic> data = {
      "email": email,
      "password": password,
    };
    await authService.signin(context, data).then((response) async {
      print("==============$response==============");
      Loader.hide();
      if (response['status'] == true) {
        await _sharedPrefsManager
            .setFlowIdToken(response['data']['data']['flow_id']);
        actionSuccessful = true;
      } else {
        customDailog(
            isSuccess: false,
            message: response['message'],
            title: 'Failed',
            icon: const Icon(Icons.warning_amber));
      }
    });
    return actionSuccessful;
  }

  Future<bool?> checkUser(context) async {
    bool actionSuccessful = false;
    setLoadingPage(true);
    await authService.checkAuthUser(context).then((response) async {
      print("---------------------$response----------------------------");
      setLoadingPage(false);
      if (response != null) {
        if (response['status'] == true) {
           await _sharedPrefsManager.setUser(UserResponse.fromJson(response['data']));
          actionSuccessful = true;
        } else {
           customDailog(
            isSuccess: false,
            message: 'No User Available',
            title: 'Failed',
            icon: const Icon(Icons.warning_amber));
        }
      }
    });
    return actionSuccessful;
  }

  // Future<bool?> verifyOtp(context,
  //     {required String phone, required String code}) async {
  //   bool? actionSuccessful;
  //   Map<String, dynamic> data = {
  //     "phone_number": phone,
  //     "phone_verification_code": code
  //   };
  //   // LoaderUtils.showOverlay(context);

  //   await authService.verifyOtp(context, data).then((response) async {
  //     print(response);
  //     if (response != null) {
  //       // session expired
  //       if (response['status'] == false) {
  //         return false;
  //       }
  //       if (response['status'] == true) {
  //         // AppNavigationHelper.setRootOldWidget(context, LoginScreen());
  //         // subscribePushNotification(context);
  //         actionSuccessful = true;
  //       } else {
  //         // DialogUtils.showNativeAlertDialog(context,
  //         //     title: "An error Occurred",
  //         //     message: response['data']['message'].toString());
  //       }
  //     }
  //     setLoadingState(LoadingState.idle);
  //     return actionSuccessful;
  //   });
  //   return null;
  // }

  registerUser(context, dynamic data) async {
    show(context);
    await authService.signup(context, data).then((response) {
      Loader.hide();
      if (response['status'] == true) {
         customDailog(
            isSuccess: true, title: 'Success', message: "User created successfully, Login into you account");
        AppNavigationHelper.navigateToWidget(
            context, LoginPage());
      } else {
         customDailog(
            isSuccess: false, title: 'Failed', message: response['message']);
      }
    });
  }

  Future<bool> verifyForgotOtp(context, String code, String password,
      String confirmPassword, String email) async {
    bool isSuccess = false;
    Map<String, dynamic> body = {
      "email": email,
      "otp": code,
      "new_password": password,
      "confirm_password": confirmPassword
    };
    print(body);
    setLoadingPage(true);
    await authService.resetPassword(context, body).then((value) async {
      setLoadingPage(false);
      if (value['status'] == true) {
        isSuccess = true;
        customDailog(
            isSuccess: true, title: 'Success', message: value['message']);
      } else {
        customDailog(
            isSuccess: false, title: 'Failed', message: value['message']);
      }
    });

    return isSuccess;
  }

  testNotification(context) async {
    authService.testPushNotification(context, "data");
  }
}

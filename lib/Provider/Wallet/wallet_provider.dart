import 'package:crowdfunding/Components/custom_toast.dart';
import 'package:crowdfunding/Components/loading_item.dart';
import 'package:crowdfunding/Model/Response/dashboard_response.dart';
import 'package:crowdfunding/Model/Response/wallet_response.dart';
import 'package:crowdfunding/Services/Remote/Wallet/wallet_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class WalletProvider extends ChangeNotifier {
  final walletProvider = WalletService();
  bool _loadPage = false;
  bool get isLoading => _loadPage;

  WalletResponse? _walletResponse;
  WalletResponse? get walletResponse => _walletResponse;

  DashboardResponse? _dashboardResponse = DashboardResponse();
  DashboardResponse? get dashboardResponse => _dashboardResponse;

  Wallet? _wallet;
  Wallet? get wallet => _wallet;

  setLoadingPage(bool value) {
    _loadPage = value;
    notifyListeners();
  }

  getWallet(context) async {
    setLoadingPage(true);
    await walletProvider.getAllWallet(context).then((value) {
      setLoadingPage(false);
      if (value['status'] == true) {
        _walletResponse = WalletResponse.fromJson(value['data']);
        notifyListeners();
      }
    });
  }

  getDashboard(context) async {
    setLoadingPage(true);
    await walletProvider.getDashboard(context).then((value) {
      print("---------------$value");
      setLoadingPage(false);
      if (value['status'] == true) {
        _dashboardResponse = DashboardResponse.fromJson(value['data']);
        notifyListeners();
      }
    });
  }

  Future<bool> createWallet(context, data) async {
    bool isSuccess = false;
    print("---------------$data");
    show(context);
    await walletProvider.createWallet(context, data).then((value) {
      print("---------------$value");
      Loader.hide();
      if (value['status'] == true) {
        isSuccess = true;
        notifyListeners();
        customDailog(
            isSuccess: true,
            message: 'Wallet created successfully',
            title: 'Successfull',
            icon: const Icon(Icons.warning_amber));
      } else {
        customDailog(
            isSuccess: false,
            message: 'Provide a valid card number or a valid expiry date',
            title: 'Wallet creation failed',
            icon: const Icon(Icons.warning_amber));
      }
    });
    return isSuccess;
  }

  Future<bool> withdraw(context) async {
    bool isSuccess = false;
    show(context);
    await Future.delayed(Duration(seconds: 3), () {
      Loader.hide();
      isSuccess = true;
    });
    return isSuccess;
  }
}

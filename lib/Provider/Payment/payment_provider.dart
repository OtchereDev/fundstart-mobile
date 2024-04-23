import 'package:crowdfunding/Components/loading_item.dart';
import 'package:crowdfunding/Components/success_page.dart';
import 'package:crowdfunding/Core/Helpers/navigation_helper.dart';
import 'package:crowdfunding/Model/Response/transaction_response.dart';
import 'package:crowdfunding/Services/Remote/Payments/payment_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripePaymentProviver extends ChangeNotifier {
  final paymentService = PaymentService();
  bool _loadPage = false;
  bool get isLoading => _loadPage;

  TransactionResponse _transactionResponse = TransactionResponse();
  TransactionResponse get transactionResponse => _transactionResponse;

  setLoadingPage(bool value) {
    _loadPage = value;
    notifyListeners();
  }

  Future<void> stripeMakePayment(context, String clientSecret) async {
    try {
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      clientSecret, //Gotten from payment intent
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Fundstart'))
          .then((value) {
        print("-----------$value===============");
      });

      //STEP 3: Display Payment sheet
      _displayPaymentSheet(context);
    } catch (e) {
      print("=====${e.toString()}");
      // Fluttertoast.showToast(msg: e.toString());
    }
  }

  _displayPaymentSheet(context) async {
    try {
      // 3. display the payment sheet.
      await Stripe.instance.presentPaymentSheet();

      AppNavigationHelper.navigateAndReplaceWidget(context, SuccessPage());

      print("===============================Sucesssss====================");

      // Fluttertoast.showToast(msg: 'Payment succesfully completed');
    } on Exception catch (e) {
      if (e is StripeException) {
        print("====Error from Stripe:====${e.error.localizedMessage}=====");
      } else {
        // Fluttertoast.showToast(msg: 'Unforeseen error: ${e}');
        print("======================Unforeseen error${e}====================");
      }
    }
  }

  Future<String?> createPayment(context, data) async {
    show(context);
    String? id;
    await paymentService.createPaymentInit(context, data).then((value) {
      Loader.hide();

      if (value['status'] == true) {
        id = value['data']['clientSecret'];
      }
    });
    return id;
  }

   geyAllTransactions(context) async {
    setLoadingPage(true);
    await paymentService.getAllTransactions(context).then((value) {
      setLoadingPage(false);
      if (value['status'] == true) {
        _transactionResponse = TransactionResponse.fromJson(value['data']);
        notifyListeners();
      }
    });
  }
}

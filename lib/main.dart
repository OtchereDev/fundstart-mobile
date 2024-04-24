import 'package:bot_toast/bot_toast.dart';
import 'package:crowdfunding/Core/app_constants.dart';
import 'package:crowdfunding/Provider/Chat/chat_provider.dart';
import 'package:crowdfunding/Provider/Fundraiser/fundraiser_provider.dart';
import 'package:crowdfunding/Provider/Payment/payment_provider.dart';
import 'package:crowdfunding/Provider/Wallet/wallet_provider.dart';
import 'package:crowdfunding/Provider/login_provider.dart';
import 'package:crowdfunding/Provider/profile_provider.dart';
import 'package:crowdfunding/Provider/util_provider.dart';
import 'package:crowdfunding/Views/Intro/init_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripKey;
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if(currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
      },
      child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => StripePaymentProviver()),
            ChangeNotifierProvider(create: (_) => FundRaiserProvider()),
            ChangeNotifierProvider(create: (_) => WalletProvider()),
            ChangeNotifierProvider(create: (_) => ChatProvider()),
            ChangeNotifierProvider(create: (_) => UtilPovider()),
            ChangeNotifierProvider(create: (_) => ProfileProvider(context)),
      
          ],
          builder: (context, child) {
            return MaterialApp(
              title: 'Flutter Demo',
              builder: BotToastInit(),
              debugShowCheckedModeBanner: false,
              navigatorObservers: [BotToastNavigatorObserver()],
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
                fontFamily: 'Satoshi'
              ),
              home: const InitScreen(),
            );
          }),
    );
  }
}

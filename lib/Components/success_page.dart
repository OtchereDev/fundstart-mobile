import 'package:crowdfunding/Core/Helpers/navigation_helper.dart';
import 'package:crowdfunding/Views/Home/home_index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(seconds: 3), (){
        AppNavigationHelper.setRootOldWidget(context, HomeIndex());
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: LottieBuilder.asset('assets/icons/success.json', height: 100,width: 100,)),
    );
  }
}
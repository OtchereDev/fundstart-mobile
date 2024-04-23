
import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Core/app_constants.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(logo, width: 200, ),
                // AppSpaces.height8,
                const Text("...Get set Funded!", style: TextStyle(color: AppColors.BLACK, fontSize: 16, fontWeight: FontWeight.w600),)
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}

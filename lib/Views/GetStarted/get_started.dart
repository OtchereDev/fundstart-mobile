import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Components/custom_button.dart';
import 'package:crowdfunding/Core/Helpers/navigation_helper.dart';
import 'package:crowdfunding/Core/app_constants.dart';
import 'package:crowdfunding/Utils/utils.dart';
import 'package:crowdfunding/Views/Auth/login.dart';
import 'package:crowdfunding/Views/Auth/register.dart';
import 'package:crowdfunding/Views/GetStarted/video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PRIMARYCOLOR,
      body: Stack(
        children: [
          const VideoApp(),
          Container(
            height: Utils.screenHeight(context),
            width: Utils.screenWidth(context),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      AppColors.SECONDARYCOLOR.withOpacity(0.5),
                      AppColors.SECONDARYCOLOR
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.6])),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
               const Spacer(),
                Center(
                    child: Image.asset(
                  white,
                  scale: 3.5,
                )),
                const Spacer(),
                const Spacer(),
                const Spacer(),
                const Spacer(),
                AppSpaces.height8,
                const Text(
                  "Invest in untapped potentials",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.WHITE),
                ),
                AppSpaces.height4,
                const Text(
                  "With our plaform, you can directly invest and raise capital to grow your startup",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.WHITE),
                ),
                AppSpaces.height20,
                AppSpaces.height16,
                SizedBox(
                  width: double.infinity,
                  child: GetStartedButton(title: 'Sign up',color: AppColors.WHITE,onTap: (){
                     AppNavigationHelper.navigateToWidget(context, RegisterPage());
                  },),),
                  AppSpaces.height20,
                  TextButton(onPressed: (){
                    AppNavigationHelper.navigateToWidget(context, LoginPage());
                  }, child: const Text("Sign In", style: TextStyle(color: AppColors.WHITE, fontSize: 17, fontWeight: FontWeight.w600),)),
                 AppSpaces.height40
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Components/custom_button.dart';
import 'package:crowdfunding/Components/passwordField.dart';
import 'package:crowdfunding/Components/textformfield.dart';
import 'package:crowdfunding/Core/Helpers/navigation_helper.dart';
import 'package:crowdfunding/Core/app_constants.dart';
import 'package:crowdfunding/Provider/login_provider.dart';
import 'package:crowdfunding/Views/Auth/verification_page.dart';
import 'package:crowdfunding/Views/Home/home_index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final skf = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, auth, _) {
      return Scaffold(
        backgroundColor: AppColors.WHITE,
        appBar: AppBar(
          backgroundColor: AppColors.WHITE,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.PRIMARYCOLOR,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            "Sign In",
            style: TextStyle(color: AppColors.PRIMARYCOLOR, fontSize: 16),
          ),
        ),
        body: auth.loadPage
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: skf,
                  child: Column(
                    children: [
                      Spacer(),
                      Center(
                          child: Image.asset(
                        logo,
                        width: 200,
                      )),
                      AppSpaces.height40,
                      AppSpaces.height40,
                      TextFormWidget(
                        emailController,
                        'Email',
                        false,
                        hint: 'Email',
                        validate: true,
                        validateEmail: true,
                        validateMsg: 'Email is required',
                      ),
                      AppSpaces.height20,
                      PasswordField(
                        controller: passwordController,
                        hintText: "Password",
                        inputType: TextInputType.text,
                        validateMsg: 'Password required',
                        labelText: "Password",
                        validate: true,
                        
                      ),
                      Spacer(),
                      Spacer(),
                      SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            title: 'Sign In',
                            onTap: () {
                              if (skf.currentState?.validate() == true) {
                                auth
                                    .performLogin(context,
                                        email: emailController.text.trim(),
                                        password: passwordController.text)
                                    .then((value) {
                                  if (value == true) {
                                    AppNavigationHelper
                                        .navigateAndReplaceWidget(
                                            context,
                                            PinCodeVerificationScreen(
                                                emailController.text));
                                  }
                                });
                              }

                              // AppNavigationHelper.setRootOldWidget(context, HomeIndex());
                            },
                            color: AppColors.SECONDARYCOLOR,
                          )),
                      AppSpaces.height40,
                    ],
                  ),
                ),
              ),
      );
    });
  }
}

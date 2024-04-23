import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Components/custom_button.dart';
import 'package:crowdfunding/Components/passwordField.dart';
import 'package:crowdfunding/Components/phoneNumberText.dart';
import 'package:crowdfunding/Components/textformfield.dart';
import 'package:crowdfunding/Core/app_constants.dart';
import 'package:crowdfunding/Provider/login_provider.dart';
import 'package:crowdfunding/Provider/util_provider.dart';
import 'package:crowdfunding/Utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final fmk = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
          "Sign Up",
          style: TextStyle(color: AppColors.PRIMARYCOLOR, fontSize: 16),
        ),
      ),
      body: Consumer<AuthProvider>(builder: (context, auth, _) {
        var util = context.read<UtilPovider>();
        return LayoutBuilder(

          builder: (context, constraint) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: fmk,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                     constraints: BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          // Spacer(),
                          Center(
                              child: Image.asset(
                            logo,
                            width: 200,
                          )),
                          AppSpaces.height40,
                          AppSpaces.height40,
                          TextFormWidget(
                            firstNameController,
                            'Firstname',
                            false,
                            hint: 'First Name',
                            isDark: false,
                          ),
                          AppSpaces.height20,
                          TextFormWidget(
                            lastNameController,
                            'Lastname',
                            false,
                            hint: 'Last name',
                            isDark: false,
                          ),
                          AppSpaces.height20,
                          TextFormWidget(
                            emailController,
                            'Email',
                            false,
                            hint: 'Email',
                            isDark: false,
                          ),
                          AppSpaces.height20,

                          PhoneNumberTextField(
                            controller: phoneController,
                            hintText: "Phone",
                            labelText: "Phone Number",
                            validate: true,
                          ),
                           AppSpaces.height20,
                          PasswordField(
                            controller: passwordController,
                            hintText: "Password",
                            inputType: TextInputType.text,
                            validateMsg: 'Password required',
                            labelText: "Password",
                          ),
                         
                      
                      
                          Spacer(),
                          SizedBox(
                              width: double.infinity,
                              child: CustomButton(
                                title: 'Sign Up',
                                onTap: () {
                                  if (fmk.currentState?.validate() == true) {
                                    Map<String, dynamic> body = {
                                      "email": emailController.text.trim(),
                                      "password": passwordController.text,
                                      "firstName": firstNameController.text,
                                      "lastName": lastNameController.text,
                                      "phone": "+${Formatters.formatToInternationNumber(util.numberCode, phoneController.text)}"
                                    };
                                    auth.registerUser(context, body);
                                  }
                                },
                                color: AppColors.SECONDARYCOLOR,
                              )),
                          AppSpaces.height40,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        );
      }),
    );
  }
}

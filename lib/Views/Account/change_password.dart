import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Components/textformfield.dart';
import 'package:crowdfunding/Provider/profile_provider.dart';
import 'package:crowdfunding/Widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatelessWidget {
   ChangePasswordPage({super.key});
final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          backgroundColor: AppColors.WHITE,
       appBar: AppBar(
          backgroundColor: AppColors.WHITE,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.PRIMARYCOLOR,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: const Text(
            "Profile",
            style: TextStyle(
                color: AppColors.PRIMARYCOLOR,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: Consumer<ProfileProvider>(
          builder: (context, profile, _) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal:20.0),
              child: Column(
                children: [
                    AppSpaces.height20,
                      const CircleAvatar(radius: 35,),
                      AppSpaces.height8,
                      Text("${profile.currentUserProfile?.data.result.profile.firstName} ${profile.currentUserProfile?.data.result.profile.lastName}",style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                      Text("${profile.currentUserProfile?.data.result.email}", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300),),
                      AppSpaces.height20,
                      const CustomDivider(),AppSpaces.height20,
                      
                  TextFormWidget(textController, "Firstname", false, isDark: false,hint: "Name",),
                  AppSpaces.height16,
                  TextFormWidget(textController, "Lastname", false, isDark: false,hint: "Name",),
                  AppSpaces.height16,

                  TextFormWidget(textController, "Phone", false, isDark: false,hint: "Name",),

                ],
              ),
            );
          }
        ),
    );
  }
}
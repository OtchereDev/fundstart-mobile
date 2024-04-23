import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Components/custom_button.dart';
import 'package:crowdfunding/Components/textformfield.dart';
import 'package:crowdfunding/Core/app_constants.dart';
import 'package:crowdfunding/Provider/profile_provider.dart';
import 'package:crowdfunding/Widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phoneController = TextEditingController();
  final fmKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Consumer<ProfileProvider>(builder: (context, profile, _) {
        var user = profile.currentUserProfile?.data.result.profile;
        firstnameController.text = user?.firstName ?? "";
        lastnameController.text = user?.lastName ?? "";
        phoneController.text = user?.phone ?? "";
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: fmKey,
            child: Column(
              children: [
                AppSpaces.height20,
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(messi),
                ),
                AppSpaces.height8,
                Text(
                  "${profile.currentUserProfile?.data.result.profile.firstName} ${profile.currentUserProfile?.data.result.profile.lastName}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(
                  "${profile.currentUserProfile?.data.result.email}",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                ),
                AppSpaces.height20,
                CustomDivider(),
                AppSpaces.height20,
                TextFormWidget(
                  firstnameController,
                  "Firstname",
                  false,
                  isDark: false,
                  hint: "Name",
                ),
                AppSpaces.height16,
                TextFormWidget(
                  lastnameController,
                  "Lastname",
                  false,
                  isDark: false,
                  hint: "Name",
                ),
                AppSpaces.height16,
                TextFormWidget(
                  phoneController,
                  "Phone",
                  false,
                  isDark: false,
                  hint: "Name",
                ),
                Spacer(),
                SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          title: 'Update',
                          color: AppColors.SECONDARYCOLOR,
                          onTap: () {
                            if (fmKey.currentState?.validate() == true) {
                              Map<String, dynamic> data = {
                                "firstName": firstnameController.text,
                                "lastName": lastnameController.text,
                                "phone":phoneController.text
                              };
                             profile.changeProfile(context, data).then((value){
                              if(value== true){
                                print("=======================");
                                profile.getUser(context);
                                Navigator.pop(context);
                              }
                             });
                            }
                          },
                        ),
                      ),
                      AppSpaces.height40,
                      AppSpaces.height40,
              ],
            ),
          ),
        );
      }),
    );
  }
}

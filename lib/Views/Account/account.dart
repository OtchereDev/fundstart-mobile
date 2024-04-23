import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Core/Helpers/navigation_helper.dart';
import 'package:crowdfunding/Core/app_constants.dart';
import 'package:crowdfunding/Provider/profile_provider.dart';
import 'package:crowdfunding/Views/Account/profile.dart';
import 'package:crowdfunding/Views/GetStarted/get_started.dart';
import 'package:crowdfunding/Widgets/custom_divider.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.WHITE,

      appBar: AppBar(
        backgroundColor: AppColors.WHITE,
       
        centerTitle: true,
        title: const Text(
          "Account",
          style: TextStyle(color: AppColors.PRIMARYCOLOR, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profile, _) {
          return  Padding(
            padding: const EdgeInsets.symmetric(horizontal:20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppSpaces.height20,
                  const CircleAvatar(radius: 35,backgroundImage: NetworkImage(messi),),
                  AppSpaces.height8,
                  Text("${profile.currentUserProfile?.data.result.profile.firstName} ${profile.currentUserProfile?.data.result.profile.lastName}",style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Text("${profile.currentUserProfile?.data.result.email}", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300),),
                  AppSpaces.height20,
                  const CustomDivider(),
                  
                   ProfileTile(subText: "Change password, Delete Account, Edit profile",title: 'Profile', icon: FeatherIcons.user,onTap: (){
                    AppNavigationHelper.navigateToWidget(context, ProfilePage());
                  },),
                  // AppSpaces.height8,
                  const CustomDivider(),
                        
                  const ProfileTile(subText: "Notification, Language, Change Currency",title: 'Setting',icon: FeatherIcons.settings,),
                  // AppSpaces.height8,
                  const CustomDivider(),
                        
                  const ProfileTile(subText: "View team",title: 'Team',icon: FeatherIcons.users,),
                  // AppSpaces.height8,
                  const CustomDivider(),
                        
                  const ProfileTile(subText: "Edit profile",title: 'Invite User',icon: FeatherIcons.userPlus,),
                  // AppSpaces.height8,
                  const CustomDivider(),
                        
                   ProfileTile(subText: "Signout",title: 'Logout',icon: FeatherIcons.logOut,onTap: (){
                      profile.logout(context);
                      AppNavigationHelper.setRootOldWidget(context, GetStarted());
                  },),
                  const CustomDivider(),
                        
                        
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final String title, subText;
  final VoidCallback? onTap;
  final IconData? icon;
  const ProfileTile({
    super.key, required this.title, required this.subText, this.onTap, this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading:  Icon(icon),
        onTap: onTap,
        title: Text(title),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
      ),
    );
  }
}

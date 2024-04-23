import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(
      backgroundColor: AppColors.WHITE,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: AppColors.PRIMARYCOLOR,),onPressed: (){
          Navigator.pop(context);
        },),
        centerTitle: true,
        title: Text("Account", style: TextStyle(color: AppColors.PRIMARYCOLOR, fontSize: 16),),
      ),
      body: Column(
        children: [
          CircleAvatar(),
          AppSpaces.height16,
          RichText(text: TextSpan(
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: AppColors.PRIMARYCOLOR),
            text: 'Name: ', children: [
            TextSpan(
              text: 'Bismark'
            )
          ]))

        ],
      ),
    );
  }
}
import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';




  Widget CustomAppBar() {
    return  AppBar(
        backgroundColor: AppColors.WHITE,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(FeatherIcons.share))
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.PRIMARYCOLOR,
          ),
          onPressed: () {
            // Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          "Details",
          style: TextStyle(color: AppColors.PRIMARYCOLOR, fontSize: 16),
        ),
      );
    
  }

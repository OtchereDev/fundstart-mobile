import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Core/Enums/enums.dart';
import 'package:crowdfunding/Utils/utils.dart';
import 'package:flutter/cupertino.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Color? color;
  const CustomButton({
    super.key,
    required this.title,
    this.onTap,
    this.color = AppColors.PRIMARYCOLOR,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        color: color,
        borderRadius: BorderRadius.circular(8),
        padding: EdgeInsets.zero,
        onPressed: onTap,
        child: Text(
          title,
          style: TextStyle(
              color: color == AppColors.PRIMARYCOLOR
                  ? AppColors.BLACK
                  : AppColors.WHITE,
              fontSize: Utils.screenSize(context) == ScreenSize.large ? 18 : 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Trueno'),
        ));
  }
}



class GetStartedButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Color? color;
  const GetStartedButton({
    super.key,
    required this.title,
    this.onTap,
    this.color = AppColors.WHITE,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        color: color,
        borderRadius: BorderRadius.circular(8),
        padding: EdgeInsets.zero,
        onPressed: onTap,
        child: Text(
          title,
          style: TextStyle(
              color: color == AppColors.WHITE
                  ? AppColors.SECONDARYCOLOR
                  : AppColors.WHITE,
              fontSize: Utils.screenSize(context) == ScreenSize.large ? 18 : 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Trueno'),
        ));
  }
}



import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Core/Enums/enums.dart';
import 'package:crowdfunding/Utils/utils.dart';
import 'package:flutter/material.dart';

class MyOutlineButtonBlue extends StatelessWidget {
  final String btntext;
  final Color color, textColor;
  final VoidCallback onTap;
  final double width;

  const MyOutlineButtonBlue(
      {Key? key, required this.btntext, required this.onTap, this.color= AppColors.WHITE, this.width = 2.0, this.textColor = AppColors.WHITE})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          // padding: EdgeInsets.zero,
          
          // backgroundColor: Colors.transparent,
          side:  BorderSide(width: width, color:color),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: onTap,
        child: Text(
          btntext,
          style:  TextStyle(
              color: textColor,
               fontSize: Utils.screenSize(context) == ScreenSize.large ? 18 : 16,
              fontWeight: FontWeight.w500),
        )
        );
  }
}

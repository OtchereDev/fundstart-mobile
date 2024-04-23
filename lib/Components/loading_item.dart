import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

show(context) {
  Loader.show(context,
      overlayColor: Colors.black26,
      progressIndicator: Container(
          height: 30,
          width: 30,
          decoration:
              BoxDecoration(color: AppColors.WHITE, shape: BoxShape.circle),
          child: Center(child: CupertinoActivityIndicator(color: AppColors.BLACK,))),
      themeData: Theme.of(context).copyWith(
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.green)));
}

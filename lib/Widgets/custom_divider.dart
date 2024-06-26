
import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 0.5,
      color: AppColors.BLACK.withOpacity(0.2),
    );
  }
}
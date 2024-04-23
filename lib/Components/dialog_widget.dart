import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:flutter/material.dart';

class DailogWidget extends StatelessWidget {
  final bool hasError;
  final String title, message;
  const DailogWidget({super.key, required this.message,  this.hasError = false, required this.title,  });

  @override
  Widget build(BuildContext context) {
    return   Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: AppColors.WHITE
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppSpaces.height16,
                 Text(
                "$title  ${hasError? "🚫" : ""}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20.0),
                  child: Divider(),
                ),
                AppSpaces.height8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:30.0),
                  child: Text("$message", textAlign: TextAlign.center,),
                ),
                AppSpaces.height8,
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: TextButton(
                        child: const Text(
                          "Try again",
                          style: TextStyle(color: AppColors.PRIMARYCOLOR),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                )
              ],
            ),
        
        );
     
  }
}
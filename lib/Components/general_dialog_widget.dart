import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:flutter/material.dart';

class GeneralDialogWidget extends StatelessWidget {
  final String? title;
  final Widget children;
  // final Function(String)onGenderSelect;
  const GeneralDialogWidget({super.key,  this.title, required this.children,  });

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
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppSpaces.height16,
                 Text(
                title??"",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:0.0),
                  child: Divider(),
                ),
                AppSpaces.height8,
                children,
              
               
                AppSpaces.height8,
               
                
              ],
            ),
        
        );
     
  }
}
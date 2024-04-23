

import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Core/app_constants.dart';
import 'package:crowdfunding/Widgets/rating_widget.dart';
import 'package:flutter/material.dart';

class ContributorsTab extends StatelessWidget {
  const ContributorsTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(3),
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.WHITE,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 2),
                      color: AppColors.BLACK
                          .withOpacity(0.2),
                      blurRadius: 1),
                  BoxShadow(
                      offset: Offset(1, 0),
                      color: AppColors.BLACK
                          .withOpacity(0.2),
                      blurRadius: 1)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(messi),
                ),
                AppSpaces.height4,
                Text("Robert Oliver"),
                Text(
                  "Angel Investor & Founder of  Crowwwn",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      color: AppColors.ASHDEEP),
                ),
                RatingWidget()
              ],
            ),
          ),
        );
  }
}

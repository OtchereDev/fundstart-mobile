
import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Core/app_constants.dart';
import 'package:crowdfunding/Model/Response/portfolio_response.dart';
import 'package:crowdfunding/Provider/profile_provider.dart';
import 'package:crowdfunding/Views/Investors/top_investors.dart';
import 'package:crowdfunding/Widgets/custom_divider.dart';
import 'package:crowdfunding/Widgets/rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContributorTile extends StatelessWidget {
  final Portfolio portfolio;
  const ContributorTile({
    super.key, required this.portfolio,
  });

  @override
  Widget build(BuildContext context) {
    var user = context.read<ProfileProvider>().currentUserProfile?.data;
    return Padding(
      padding: const EdgeInsets.only(bottom:10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(width: 0.5, color: AppColors.BLACK.withOpacity(0.2)),
            color: AppColors.WHITE,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 0.5),
                  blurRadius: 1,
                  color: AppColors.BLACK.withOpacity(0.1))
            ]),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(backgroundImage: NetworkImage(messi),),
                      AppSpaces.width8,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            "${user?.result.profile.firstName} ${user?.result.profile.lastName}",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                           Text(
                            "${portfolio.fundraiser?.title}",
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w300),
                          ),
                          RatingWidget(),
                        ],
                      ),
                    ],
                  ),
                   Column(
                    children: [
                      Text(
                        "£${portfolio.amount}",
                        style:
                            TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      AppSpaces.height4,
                      CategoryContainer(
                        title: "Invested Amt",
                      ),
                    ],
                  )
                ],
              ),
            ),
            const CustomDivider(),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    child: Image.asset(
                      'assets/icons/chat.png',
                      height: 15,
                    ),
                    radius: 14,
                  ),
                  AppSpaces.width4,
                  const Text(
                    "Send a Message",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

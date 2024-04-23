import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Components/card_loading_shimmer.dart';
import 'package:crowdfunding/Components/custom_button.dart';
import 'package:crowdfunding/Core/Helpers/navigation_helper.dart';
import 'package:crowdfunding/Provider/Fundraiser/fundraiser_provider.dart';
import 'package:crowdfunding/Provider/profile_provider.dart';
import 'package:crowdfunding/Views/Campaigns/all_my_campaigns.dart';
import 'package:crowdfunding/Views/Campaigns/all_my_investments.dart';
import 'package:crowdfunding/Widgets/campaign_tile.dart';
import 'package:crowdfunding/Widgets/constributor_tile.dart';
import 'package:crowdfunding/Widgets/contibutor_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCapmaign extends StatefulWidget {
  const MyCapmaign({super.key});

  @override
  State<MyCapmaign> createState() => _MyCapmaignState();
}

class _MyCapmaignState extends State<MyCapmaign> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.value([
        context.read<ProfileProvider>().getPortfolio(context)
        // context.read<FundRaiserProvider>().get(context)
      ]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE,
      appBar: AppBar(
        backgroundColor: AppColors.WHITE,
        centerTitle: true,
        title: const Text(
          "My Campaigns",
          style: TextStyle(
              color: AppColors.PRIMARYCOLOR,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Consumer<FundRaiserProvider>(builder: (context, fund, _) {
          return Consumer<ProfileProvider>(builder: (context, profile, _) {
            return profile.isLoading
                ? CardLoadingShimmer(
                    numberOfCards: 6,
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "My Campaigns",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w600),
                              ),
                              TextButton(
                                onPressed: () {
                                  AppNavigationHelper.navigateToWidget(
                                      context, AllMyCampaigns());
                                },
                                child: const Text(
                                  "View all",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                            ],
                          ),
                          profile.portfolioResponse.portfolio != null &&
                                  profile.portfolioResponse.portfolio!.isEmpty
                              ? ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text("No Campaign available"),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...List.generate(
                                        profile.portfolioResponse.portfolio
                                                ?.take(1)
                                                .length ??
                                            0,
                                        (index) => CampaignTile(
                                              fundraiser: profile
                                                  .portfolioResponse
                                                  .portfolio![index]
                                                  .fundraiser!,
                                              showMOre: false,
                                            )),
                                  ],
                                ),
                          AppSpaces.height16,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "My Investments (${profile.portfolioResponse.portfolio?.length ?? 0})",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w600),
                              ),
                              TextButton(
                                onPressed: () {
                                  AppNavigationHelper.navigateToWidget(
                                      context, AllMyInvestments());
                                },
                                child: const Text(
                                  "View all",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                          profile.portfolioResponse.portfolio != null &&
                                  profile.portfolioResponse.portfolio!.isEmpty
                              ? ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text("No Investment available"),
                                )
                              : Column(
                                  children: [
                                    ...List.generate(
                                        profile.portfolioResponse.portfolio
                                                ?.take(3)
                                                .length ??
                                            0,
                                        (index) => ContributorTile(
                                              portfolio: profile
                                                  .portfolioResponse
                                                  .portfolio![index],
                                            )),
                                  ],
                                ),
                          AppSpaces.height16,
                          AppSpaces.height16,
                          const Text(
                            "Your Campaign Followers",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                  5, (index) => ContributorsTab()),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
          });
        }),
      ),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(left: 20.0, top: 10, bottom: 20, right: 20),
        child: Row(
          children: [
            const Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Total Balance:",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                Text(
                  "£500000",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.SECONDARYCOLOR),
                ),
              ],
            )),
            Expanded(
                child: CustomButton(
              title: 'Withdraw Now',
              color: AppColors.SECONDARYCOLOR,
              onTap: () {},
            )),
          ],
        ),
      ),
    );
  }
}

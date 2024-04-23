import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Provider/Fundraiser/fundraiser_provider.dart';
import 'package:crowdfunding/Provider/profile_provider.dart';
import 'package:crowdfunding/Widgets/campaign_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllMyCampaigns extends StatelessWidget {
  const AllMyCampaigns({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          backgroundColor: AppColors.WHITE,
       appBar: AppBar(
          backgroundColor: AppColors.WHITE,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.PRIMARYCOLOR,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: const Text(
            "My Campaigns",
            style: TextStyle(
                color: AppColors.PRIMARYCOLOR,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
        ),
        body:  SafeArea(
        child: Consumer<FundRaiserProvider>(
          builder: (context, fund, _) {
            return Consumer<ProfileProvider>(builder: (context, profile, _) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                                        ...List.generate(
                          profile.portfolioResponse.portfolio?.length??0,
                          (index) => CampaignTile(
                                fundraiser: profile.portfolioResponse.portfolio![index].fundraiser!,
                                showMOre: false,
                              )),
                      AppSpaces.height16,
                      
                    ],
                  ),
                ),
              );
            });
          }
        ),
      ),
    
    );
  }
}
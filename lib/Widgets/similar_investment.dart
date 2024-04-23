import 'package:crowdfunding/Provider/Fundraiser/fundraiser_provider.dart';
import 'package:crowdfunding/Widgets/campaign_tile.dart';
import 'package:flutter/material.dart';

class SimilarInvestment extends StatelessWidget {
  final FundRaiserProvider profile;
  const SimilarInvestment({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        profile.fundRaiserModel!.fundraisers!.isEmpty
            ? const ListTile(
                title: Text("No Campaign available"),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(
                      profile.fundRaiserModel!.fundraisers?.take(2).length ?? 0,
                      (index) => CampaignTile(
                            fundraiser:
                                profile.fundRaiserModel!.fundraisers![index],
                            showMOre: false,
                          )),
                ],
              ),
      ],
    );
  }
}

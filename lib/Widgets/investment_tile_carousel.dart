import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:crowdfunding/Components/card_loading_shimmer.dart';
import 'package:crowdfunding/Core/Enums/enums.dart';
import 'package:crowdfunding/Core/Helpers/navigation_helper.dart';
import 'package:crowdfunding/Provider/Fundraiser/fundraiser_provider.dart';
import 'package:crowdfunding/Utils/utils.dart';
import 'package:crowdfunding/Views/Campaigns/campaign_details.dart';
import 'package:crowdfunding/Views/Home/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InvestmentTileCarousel extends StatelessWidget {
  InvestmentTileCarousel({super.key});
  List<Color> colors = [
    Color(0xffFFE2E2),
    Color(0xffE5F4FA),
    Color.fromARGB(255, 161, 197, 231),
    Color.fromARGB(255, 245, 251, 194),
    Color(0xffE2FBE5),
  ];
  Color randomColor() {
    Random random = Random();
    return colors[random.nextInt(colors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FundRaiserProvider>(builder: (context, fund, _) {
      var fundR = fund.fundRaiserModel?.fundraisers;
      return fund.isLoading? Expanded(child: CardLoadingShimmer(numberOfCards: 1,)): CarouselSlider(
        options: CarouselOptions(
          height:Utils.screenSize(context) == ScreenSize.medium ?  115: null,
          aspectRatio: 3.0,
          pageSnapping: true,
          scrollDirection: Axis.horizontal,
          viewportFraction: 01,
          autoPlay: true,

          onScrolled: (value) {
          },
        ),
        items: fundR!.map((index) {
          return Builder(
            builder: (BuildContext context) {
              return InterestedCampaignTile(
                onTap: () {
                  AppNavigationHelper.navigateToWidget(
                      context, CampaignDetails(fundraiser: index));
                },
                color: randomColor(),
                fundraiser: index,
              );
            },
          );
        }).toList(),
      );
    });
  }
}

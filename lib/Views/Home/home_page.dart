import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Components/carousel.dart';
import 'package:crowdfunding/Core/Helpers/navigation_helper.dart';
import 'package:crowdfunding/Provider/Fundraiser/fundraiser_provider.dart';
import 'package:crowdfunding/Provider/Wallet/wallet_provider.dart';
import 'package:crowdfunding/Provider/profile_provider.dart';
import 'package:crowdfunding/Utils/formatters.dart';
import 'package:crowdfunding/Utils/utils.dart';
import 'package:crowdfunding/Views/Campaigns/all_investments.dart';
import 'package:crowdfunding/Views/Campaigns/all_top_investors.dart';
import 'package:crowdfunding/Views/Campaigns/create/create_campaign.dart';
import 'package:crowdfunding/Views/Chat/chat_gpt.dart';
import 'package:crowdfunding/Views/Investors/top_investors.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

   late AnimationController _controller;

  @override
  void initState() {
     _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.value([
        context.read<FundRaiserProvider>().getFundraisers(context),
        context.read<WalletProvider>().getWallet(context),
        context.read<FundRaiserProvider>().getAllInvestors(context)
      ]);
    });
    super.initState();
  }

      static const List<IconData> icons =  [ FeatherIcons.messageCircle, FeatherIcons.plusCircle ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE,
      body: SafeArea(
        child: Consumer<ProfileProvider>(builder: (context, profile, _) {
          return Consumer<FundRaiserProvider>(
              builder: (context, fundraiser, _) {
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${Formatters.greeting()} ${profile.getUserFullname()}",
                            style: TextStyle(
                                color: AppColors.PRIMARYCOLOR,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Let's manage your investments",
                            style: TextStyle(
                                color: AppColors.PRIMARYCOLOR,
                                fontSize: 10,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.5, color: AppColors.SECONDARYCOLOR),
                              shape: BoxShape.circle),
                          child: const Icon(
                            Icons.notifications_none_sharp,
                            color: AppColors.PRIMARYCOLOR,
                          ))
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CarouselComponent(
                              height: Utils.screenHeight(context) / 5,
                              images: [
                                "https://img.freepik.com/premium-vector/creative-business-startup-banner-landing-page_1302-18784.jpg?size=626&ext=jpg",
                                "https://img.freepik.com/free-vector/startup-success-banner-concept-successful-launch-management-business-project-growth-company_107791-3376.jpg",
                                "https://cdn5.vectorstock.com/i/1000x1000/20/74/web-banner-design-startup-concept-vector-25522074.jpg"
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Popular campaigns",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              TextButton(
                                  onPressed: () {
                                    AppNavigationHelper.navigateToWidget(
                                        context, AllCampaignsPage());
                                  },
                                  child: const Text(
                                    "View all",
                                    style: TextStyle(
                                        color: AppColors.PRIMARYCOLOR,
                                        fontSize: 12),
                                  ))
                            ],
                          ),
                          // AppSpaces.height8,
                          ...List.generate(
                              fundraiser.fundRaiserModel?.fundraisers
                                      ?.take(3)
                                      .length ??
                                  0, (index) {
                            var data = fundraiser
                                .fundRaiserModel?.fundraisers!.reversed
                                .toList()[index];
                            return FundraiserTile(
                              fundraiser: data!,
                              // onTap: () {
                              //   fundraiser.setFundRaiser(data);
                              //   AppNavigationHelper.navigateToWidget(
                              //       context, CampaignDetails(fundraiser: data));
                              // },
                            );
                          }),
                         
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Top Investors",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              TextButton(
                                  onPressed: () {
                                    AppNavigationHelper.navigateToWidget(
                                        context, AllInvestorsPage());
                                  },
                                  child: const Text(
                                    "View all",
                                    style: TextStyle(
                                        color: AppColors.PRIMARYCOLOR,
                                        fontSize: 14),
                                  ))
                            ],
                          ),
                          ...List.generate(
                              fundraiser.investorsResponse?.investors
                                      ?.take(2)
                                      .length ??
                                  0, (index) {
                            var data = fundraiser
                                .investorsResponse?.investors!.reversed
                                .toList()[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom:12.0),
                              child: InvestorLsitTile(investor: data!),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          });
        }),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(icons.length, (int index) {
          Widget child = Container(
            height: 50.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: _controller,
                curve: Interval(
                  0.0,
                  1.0 - index / icons.length / 2.0,
                  curve: Curves.easeOut
                ),
              ),
              child: FloatingActionButton(
                heroTag: null,
                backgroundColor: AppColors.SECONDARYCOLOR,
                mini: true,
                child: Center(child: Icon(icons[index], color: Colors.white)),
                onPressed: () {
                  if(index == 0){
                    AppNavigationHelper.navigateToWidget(context, ChatPage());
                  }else{

                    AppNavigationHelper.navigateToWidget(context, CreateCampaign());
                  }
                },
              ),
            ),
          );
          return child;
        }).toList()..add(
          FloatingActionButton(
            heroTag: null,
            shape: const CircleBorder(),
            backgroundColor: AppColors.SECONDARYCOLOR,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context,  _) {
                return Transform(
                  transform: Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
                  alignment: FractionalOffset.center,
                  child: Icon(_controller.isDismissed ? Icons.add : Icons.close, color: AppColors.WHITE,),
                );
              },
            ),
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
          ),
        ),
      ),
      
      // floatingActionButton: FloatingActionButton.extended(
      //     extendedPadding: const EdgeInsets.symmetric(horizontal: 10),
      //     backgroundColor: AppColors.SECONDARYCOLOR,
      //     onPressed: () {
           
      //       // AppNavigationHelper.navigateToWidget(context, ChatPage());
      //       context.read<FundRaiserProvider>().getFile(context);

      //       // AppNavigationHelper.navigateToWidget(context, CreateCampaign());
      //     },
      //     label: const Row(
      //       children: [
      //         Icon(
      //           Icons.add_circle_outline,
      //           color: AppColors.WHITE,
      //         ),
      //         Text(
      //           "Start Campaign",
      //           style: TextStyle(color: AppColors.WHITE),
      //         )
      //       ],
      //     )),
    
    
    );
  }
}

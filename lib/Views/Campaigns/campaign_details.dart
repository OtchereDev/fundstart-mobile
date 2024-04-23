import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Components/card_loading_shimmer.dart';
import 'package:crowdfunding/Components/custom_button.dart';
import 'package:crowdfunding/Components/image_viewer.dart';
import 'package:crowdfunding/Core/Helpers/navigation_helper.dart';
import 'package:crowdfunding/Model/Response/fundraiser_model.dart';
import 'package:crowdfunding/Provider/Fundraiser/fundraiser_provider.dart';
import 'package:crowdfunding/Utils/utils.dart';
import 'package:crowdfunding/Views/Campaigns/invest_campaign.dart';
import 'package:crowdfunding/Widgets/contibutor_tab.dart';
import 'package:crowdfunding/Widgets/custom_divider.dart';
import 'package:crowdfunding/Widgets/faq_widget.dart';
import 'package:crowdfunding/Widgets/financial_tab_view.dart';
import 'package:crowdfunding/Widgets/similar_investment.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CampaignDetails extends StatefulWidget {
  final Fundraiser fundraiser;
  const CampaignDetails({super.key, required this.fundraiser});

  @override
  State<CampaignDetails> createState() => _CampaignDetailsState();
}

class _CampaignDetailsState extends State<CampaignDetails>
    with SingleTickerProviderStateMixin {
  @override
  // TabController? tabController;
  void initState() {
    // tabController = TabController(length: 4, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.value([
        context
            .read<FundRaiserProvider>()
            .getSingleFundraisers(context, widget.fundraiser.id)
      ]);
    });
    super.initState();
  }

  final tabCtrl = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE,
      // appBar: AppBar(
      //   backgroundColor: AppColors.WHITE,
      //   actions: [
      //     IconButton(onPressed: () {}, icon: const Icon(FeatherIcons.share))
      //   ],
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.arrow_back,
      //       color: AppColors.PRIMARYCOLOR,
      //     ),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   centerTitle: true,
      //   title: const Text(
      //     "Details",
      //     style: TextStyle(color: AppColors.PRIMARYCOLOR, fontSize: 16),
      //   ),
      // ),
      body: Consumer<FundRaiserProvider>(builder: (context, fundPro, _) {
        double percent = 0.0;
        var amount = fundPro.fundraiser.investments?.fold(
            0,
            (previousValue, element) =>
                previousValue + int.parse(element.amount ?? "0"));

        if (amount != null && !fundPro.isLoading) {
          percent =
              amount / double.parse(fundPro.fundraiser.amountRaising!) * 100;
        }

        return fundPro.isLoading
            ? const SafeArea(
                child: CardLoadingShimmer(
                numberOfCards: 6,
              ))
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ImageViewer(
                          images: widget.fundraiser.image ?? "",
                          height: Utils.screenHeight(context) / 3,
                          fromNetwork: true,
                        ),
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                AppColors.PRIMARYCOLOR.withOpacity(0.8),
                                Colors.transparent
                              ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)),
                        ),
                        SafeArea(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: CircleAvatar(
                                  backgroundColor: AppColors.PRIMARYCOLOR,
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back,
                                        color: AppColors.WHITE,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    AppSpaces.height16,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.fundraiser.title ?? "",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                          AppSpaces.height16,
                          RichText(
                              text: TextSpan(
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.BLACK),
                                  text: '£$amount raised ',
                                  children: [
                                TextSpan(
                                  text:
                                      'of  £${fundPro.fundraiser.amountRaising}',
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.BLACK),
                                )
                              ])),
                          AppSpaces.height16,
                          LinearProgressIndicator(
                            value: percent / 100,
                            color: AppColors.PRIMARYCOLOR,
                            minHeight: 7,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          AppSpaces.height8,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    FeatherIcons.tag,
                                    size: 16,
                                  ),
                                  AppSpaces.width4,
                                  Text("${fundPro.fundraiser.category?.name}")
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    FeatherIcons.clock,
                                    size: 16,
                                  ),
                                  AppSpaces.width4,
                                  Text(
                                    "Created: ${Utils.timeAgo(widget.fundraiser.createdAt!)}",
                                    style: const TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ],
                          ),
                          AppSpaces.height16,
                          Text(
                            widget.fundraiser.description ?? "",
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                          AppSpaces.height20,
                          const Text(
                            "Organizer",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                          AppSpaces.height8,
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.ASHDEEP.withOpacity(0.2)),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(fundPro.isLoading
                                  ? "Loading..."
                                  : "${fundPro.fundraiser.organizer?.firstName} ${fundPro.fundraiser.organizer?.lastName}"),
                              subtitle: Text(fundPro.isLoading
                                  ? "Loading..."
                                  : "${fundPro.fundraiser.organizer?.email}"),
                              leading: const CircleAvatar(
                                child: Icon(FeatherIcons.user),
                              ),
                            ),
                          ),
                          AppSpaces.height16,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ValueListenableBuilder(
                                valueListenable: tabCtrl,
                                builder: (context, tab, _) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                        tabName.length,
                                        (index) => GestureDetector(
                                              onTap: () {
                                                tabCtrl.value = index;
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                    color: tab == index
                                                        ? AppColors
                                                            .SECONDARYCOLOR
                                                        : AppColors.WHITE,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    border: Border.all(
                                                      color: tab == index
                                                          ? AppColors
                                                              .SECONDARYCOLOR
                                                          : AppColors
                                                              .PRIMARYCOLOR
                                                              .withOpacity(0.2),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    tabName[index],
                                                    style: TextStyle(
                                                        color: tab == index
                                                            ? AppColors.WHITE
                                                            : AppColors.BLACK),
                                                  ),
                                                ),
                                              ),
                                            )),
                                  );
                                }),
                          ),
                          AppSpaces.height16,
                          ValueListenableBuilder(
                              valueListenable: tabCtrl,
                              builder: (context, tab, _) {
                                if (tab == 0) {
                                  return GeneralTabView(fundPro: fundPro);
                                } else if (tab == 1) {
                                  return const FinancialsTabView();
                                } else if (tab == 2) {
                                  return const FaqWidget();
                                }
                                return SimilarInvestment(profile: fundPro);
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              );
      }),
      bottomNavigationBar: Container(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20.0, top: 10, bottom: 20, right: 20),
          child: SizedBox(
              width: double.infinity,
              child: CustomButton(
                title: 'Invest Now',
                color: AppColors.SECONDARYCOLOR,
                onTap: () {
                  AppNavigationHelper.navigateToWidget(
                      context, InvestInCampaign());
                },
              )),
        ),
      ),
    );
  }
}

class GeneralTabView extends StatelessWidget {
  final FundRaiserProvider fundPro;
  const GeneralTabView({
    super.key,
    required this.fundPro,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Investors (${fundPro.fundraiser.investments?.length ?? 0})",
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                "View all",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
        fundPro.fundraiser.investments!.isEmpty
            ? const ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text("No Investor Available"),
              )
            : Column(
                children: List.generate(
                  fundPro.fundraiser.investments?.length ?? 0,
                  (index) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                        "${fundPro.fundraiser.investments![index].user?.firstName} ${fundPro.fundraiser.investments![index].user?.lastName}"),
                    subtitle: Text(
                        "${fundPro.fundraiser.investments![index].user?.email}"),
                    trailing: Text(
                      "£${fundPro.fundraiser.investments![index].amount}",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    leading: const CircleAvatar(
                      child: Icon(FeatherIcons.user),
                    ),
                  ),
                ),
              ),
        const CustomDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Comment (${fundPro.fundraiser.comments?.length ?? 0})",
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                "View all",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
        fundPro.fundraiser.comments!.isEmpty
            ? const ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text("No Comment Available"),
              )
            : Column(
                children: List.generate(
                  fundPro.fundraiser.comments?.length ?? 0,
                  (index) => const ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("Oliver"),
                    subtitle: Text("£10 almost 12 years"),
                    leading: CircleAvatar(
                      child: Icon(FeatherIcons.user),
                    ),
                  ),
                ),
              ),
        AppSpaces.height16,
        const Text(
          "Your Campaign Followers",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(5, (index) => const ContributorsTab()),
          ),
        )
      ],
    );
  }
}

List<String> tabName = ["General", "Financials", "FAQ", "Similar Investment"];

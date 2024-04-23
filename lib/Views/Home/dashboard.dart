import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Core/Enums/enums.dart';
import 'package:crowdfunding/Core/Helpers/navigation_helper.dart';
import 'package:crowdfunding/Core/app_constants.dart';
import 'package:crowdfunding/Model/Response/fundraiser_model.dart';
import 'package:crowdfunding/Model/Response/transaction_response.dart';
import 'package:crowdfunding/Provider/Payment/payment_provider.dart';
import 'package:crowdfunding/Provider/Wallet/wallet_provider.dart';
import 'package:crowdfunding/Provider/profile_provider.dart';
import 'package:crowdfunding/Utils/utils.dart';
import 'package:crowdfunding/Views/Campaigns/all_transactions.dart';
import 'package:crowdfunding/Views/Home/add_credit_card.dart';
import 'package:crowdfunding/Widgets/investment_tile_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.value([
        context.read<StripePaymentProviver>().geyAllTransactions(context),
        context.read<WalletProvider>().getDashboard(context),
      ]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dashboard = context.watch<WalletProvider>();
    return Scaffold(
      body: Consumer<StripePaymentProviver>(builder: (context, trans, _) {
        return Consumer<ProfileProvider>(builder: (context, profile, _) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Utils.screenHeight(context) / 3,
                  child: Stack(
                    children: [
                      Container(
                        height: Utils.screenHeight(context) / 3.8,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: AppColors.SECONDARYCOLOR,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Total Investment ",
                              style: TextStyle(color: AppColors.WHITE),
                            ),
                            Text(
                            dashboard.isLoading ? "...":   "£${dashboard.dashboardResponse?.data?.amountInvested} ",
                              style: TextStyle(
                                  color: AppColors.WHITE,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 100,
                            decoration: BoxDecoration(
                                color: AppColors.WHITE,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColors.BLACK.withOpacity(0.2),
                                      offset: const Offset(1, 1))
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 NewDashboardStatCard(
                                  icon: 'revenue',
                                  title: 'Invested Pct',
                                  value:dashboard.isLoading ? "...": '${dashboard.dashboardResponse?.data?.investedPercentage}%',
                                ),
                                AppSpaces.width8,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Container(
                                    height: double.infinity,
                                    width: 1,
                                    color: AppColors.BLACK.withOpacity(0.2),
                                  ),
                                ),
                                AppSpaces.width8,
                                 NewDashboardStatCard(
                                  icon: 'spending',
                                  title: 'Profit Precent',
                                  value:dashboard.isLoading ? "...": '${dashboard.dashboardResponse?.data?.profitPercentage!.toStringAsFixed(2)}%',
                                ),
                                AppSpaces.width8,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Container(
                                    height: double.infinity,
                                    width: 1,
                                    color: AppColors.BLACK.withOpacity(0.2),
                                  ),
                                ),
                                AppSpaces.width8,
                                 NewDashboardStatCard(
                                  icon: 'profit',
                                  title: 'Total Profit',
                                  value:dashboard.isLoading ? "...": '${dashboard.dashboardResponse?.data?.proposedProfit!.toStringAsFixed(2)}',
                                ),
                                AppSpaces.width8,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: SvgPicture.asset(
                            'assets/icons/circle.svg',
                            color: AppColors.WHITE,
                            fit: BoxFit.cover,
                          )),
                    ],
                  ),
                ),
                AppSpaces.height16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Investment that might interest you",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                      AppSpaces.height8,
                      // const InterestedCampaignTile(),
                      InvestmentTileCarousel(),
                      AppSpaces.height16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Transactions",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                          TextButton(
                            onPressed: () {
                              AppNavigationHelper.navigateToWidget(
                                  context, const AllTransactionsPage());
                            },
                            child: const Text(
                              "View all",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          ...List.generate(
                              trans.transactionResponse.transactions
                                      ?.take(3)
                                      .length ??
                                  0,
                              (index) => TransactionTile(
                                  transaction: trans.transactionResponse
                                      .transactions![index]))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Wallet",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                          TextButton(
                            onPressed: () async {
                              bool? isSuccess = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddCreditCard()));
                              if (isSuccess == true) {
                                context
                                    .read<WalletProvider>()
                                    .getWallet(context);
                              }
                            },
                            child: const Text(
                              "+ Add Wallet",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      const CreditCardWidget(),
                      AppSpaces.height8,
                    ],
                  ),
                )
              ],
            ),
          );
        });
      }),
    );
  }
}

class NewDashboardStatCard extends StatelessWidget {
  final String? title, value, icon;
  const NewDashboardStatCard({
    super.key,
    this.title,
    this.value,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icons/$icon.png',
          height: 20,
          width: 20,
        ),
        AppSpaces.height4,
        Text(
          "$value",
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        AppSpaces.height4,
        Text(
          "$title",
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}

class InterestedCampaignTile extends StatelessWidget {
  final Fundraiser fundraiser;
  final Color color;
  final VoidCallback? onTap;
  const InterestedCampaignTile({
    super.key,
    required this.color,
    this.onTap,
    required this.fundraiser,
  });

  @override
  Widget build(BuildContext context) {
    var amount = fundraiser.investments?.fold(
        0,
        (previousValue, element) =>
            previousValue + int.parse(element.amount ?? "0"));
    double percent = 0.0;
    if (amount != null) {
      percent = amount / double.parse(fundraiser.amountRaising!) * 100;
    }

// print(Utils.screenSize(context));
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
          boxShadow: [
            BoxShadow(
                color: AppColors.BLACK.withOpacity(0.2),
                offset: const Offset(0, 1),
                blurRadius: 1)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage(messi),
                      ),
                      AppSpaces.width8,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:Utils.screenSize(context) == ScreenSize.medium ?  Utils.screenWidth(context)-180: double.infinity,
                            child: Text(
                              fundraiser.title ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            "Target: £${fundraiser.amountRaising}",
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w300),
                          ),
                        ],
                      )
                    ],
                  ),
                  AppSpaces.height8,
                  Text(
                    "Raised: £$amount",
                    style:  TextStyle(
                        fontSize: Utils.screenSize(context)== ScreenSize.small  ?  13 : Utils.screenSize(context)== ScreenSize.medium  ?  15: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onTap,
                child: const CircleAvatar(
                  backgroundColor: AppColors.WHITE,
                  child: Icon(Icons.check),
                ),
              )
            ],
          ),
          AppSpaces.height8,
          LinearProgressIndicator(
            color: AppColors.SECONDARYCOLOR,
            value: percent / 100,
            borderRadius: BorderRadius.circular(20),
            minHeight: 6,
          )
        ],
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final Color color;
  final bool isUp;
  final String name;
  final amount;
  final String percentage;
  const DashboardCard({
    super.key,
    required this.color,
    required this.isUp,
    required this.name,
    this.amount,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: color),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.WHITE,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  percentage,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.green[600],
                      fontWeight: FontWeight.w700),
                ),
              ),
              SvgPicture.asset(
                isUp ? 'assets/icons/downward.svg' : 'assets/icons/upward.svg',
                width: 100,
              )
            ],
          ),
          AppSpaces.height8,
          Text(
            name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          AppSpaces.height4,
          Text(
            "£$amount",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class TransactionTile extends StatelessWidget {
  final Transaction transaction;
  const TransactionTile({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, profile, _) {
      var user = profile.currentUserProfile?.data.result.profile;
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.WHITE,
              boxShadow: [
                BoxShadow(
                    color: AppColors.BLACK.withOpacity(0.2),
                    offset: const Offset(0, 1),
                    blurRadius: 1)
              ]),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text("${user?.firstName} ${user?.lastName}"),
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(messi),
            ),
            subtitle: Text(
              "${transaction.createdAt.day}.${transaction.createdAt.month}.${transaction.createdAt.year} (${transaction.transType})",
              style: const TextStyle(fontSize: 12),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "£${transaction.amount}",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.PRIMARYCOLOR),
                ),
                const Text(
                  "Created",
                  style: TextStyle(color: AppColors.GREENCOLOR),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletProvider>(builder: (context, wallet, _) {
      var myWallet = wallet.walletResponse!.wallets.reversed.toList();
      if (wallet.walletResponse!.wallets.isEmpty) {
        return Text("No Card Added");
      } else {
        return Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.SECONDARYCOLOR),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          wallet.isLoading
                              ? "Loading..."
                              : myWallet[0].cardNumber,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColors.WHITE),
                        ),
                        Text(
                          wallet.isLoading
                              ? "Loading..."
                              : "EXP ${myWallet[0].expiryDate}",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColors.WHITE),
                        ),
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        wallet.isLoading
                            ? "Loading..."
                            : "${myWallet[0].cardHolder}",
                        style: const TextStyle(
                            fontSize: 20,
                            color: AppColors.WHITE,
                            fontWeight: FontWeight.w600),
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SvgPicture.asset(
                'assets/icons/line.svg',
                color: AppColors.WHITE,
                height: 30,
                width: 30,
              ),
            ),
            Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(
                  'assets/icons/circle.svg',
                  color: AppColors.WHITE,
                  height: 150,
                )),
          ],
        );
      }
    });
  }
}

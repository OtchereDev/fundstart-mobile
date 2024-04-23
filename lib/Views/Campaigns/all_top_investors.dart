import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Components/card_loading_shimmer.dart';
import 'package:crowdfunding/Model/Response/investors_response.dart';
import 'package:crowdfunding/Provider/Fundraiser/fundraiser_provider.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllInvestorsPage extends StatefulWidget {
  const AllInvestorsPage({super.key});

  @override
  State<AllInvestorsPage> createState() => _AllInvestorsPageState();
}

class _AllInvestorsPageState extends State<AllInvestorsPage> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.value([context.read<FundRaiserProvider>().getAllInvestors(context)]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            "All Investors",
            style: TextStyle(
                color: AppColors.PRIMARYCOLOR,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: Consumer<FundRaiserProvider>(
          builder: (context, fund, _) {
            return fund.isLoading ? const CardLoadingShimmer(numberOfCards: 5,cardHeight: 100,): Padding(
              padding: const EdgeInsets.symmetric(horizontal:20.0),
              child: ListView.builder(
                  itemCount: fund.investorsResponse?.investors?.length ?? 0,
                  itemBuilder: (context, index) {
                    var investor = fund.investorsResponse?.investors?.reversed.toList()[index];
                    return  Padding(
                      padding: const EdgeInsets.only(bottom:12.0),
                      child: InvestorLsitTile(investor: investor),
                    );
                  }),
            );
          }
        ));
  }
}

class InvestorLsitTile extends StatelessWidget {
  const InvestorLsitTile({
    super.key,
    required this.investor,
  });

  final Investor? investor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.WHITE,
        boxShadow: [
          BoxShadow(
            color: AppColors.BLACK.withOpacity(0.3),
            offset: Offset(1, 1),
          )
        ]
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text("${investor?.firstName} ${investor?.lastName}"),
        subtitle: Text("${investor?.email}"),
        // trailing: const Text(
        //   "£100",
        //   style: TextStyle(fontWeight: FontWeight.w600),
        // ),
        leading: const CircleAvatar(
          child: Icon(FeatherIcons.user),
        ),
      ),
    );
  }
}

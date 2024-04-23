import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Provider/Fundraiser/fundraiser_provider.dart';
import 'package:crowdfunding/Views/Investors/top_investors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllCampaignsPage extends StatefulWidget {
  const AllCampaignsPage({super.key});

  @override
  State<AllCampaignsPage> createState() => _AllCampaignsPageState();
}

class _AllCampaignsPageState extends State<AllCampaignsPage> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.value(
          [context.read<FundRaiserProvider>().getFundraisers(context)]);
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
            "All Campaigns",
            style: TextStyle(
                color: AppColors.PRIMARYCOLOR,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: Consumer<FundRaiserProvider>(builder: (context, fund, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal:20.0),
            child:fund.fundRaiserModel?.fundraisers !=null && fund.fundRaiserModel!.fundraisers!.isEmpty ? ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("No Campaign available"),
                   ) : ListView.builder(
                itemCount: fund.fundRaiserModel?.fundraisers?.length ?? 0,
                itemBuilder: (context, index) {
                  var data =
                      fund.fundRaiserModel?.fundraisers!.reversed.toList()[index];
                  return FundraiserTile(fundraiser: data!);
                }),
          );
        }));
  }
}

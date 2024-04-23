import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Components/custom_button.dart';
import 'package:crowdfunding/Components/image_viewer.dart';
import 'package:crowdfunding/Components/textformfield.dart';
import 'package:crowdfunding/Core/Helpers/navigation_helper.dart';
import 'package:crowdfunding/Model/Response/fundraiser_model.dart';
import 'package:crowdfunding/Provider/Fundraiser/fundraiser_provider.dart';
import 'package:crowdfunding/Utils/utils.dart';
import 'package:crowdfunding/Views/Campaigns/campaign_details.dart';
import 'package:crowdfunding/Views/Campaigns/invest_campaign.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopInvestorsPage extends StatelessWidget {
  TopInvestorsPage({super.key});
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE,
      appBar: AppBar(
        backgroundColor: AppColors.WHITE,
        actions: [
          IconButton(onPressed: () {}, icon: Image.asset('assets/icons/filter.png', height: 20,))
        ],
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
          "Top Fundraisers",
          style: TextStyle(color: AppColors.PRIMARYCOLOR, fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            TextFormWidget(
              textController,
              "",
              false,
              hint: "Search...",
              icon: const Icon(FeatherIcons.search),
              onValueChange: (val){},
            ),
            AppSpaces.height8,
          //  Expanded(child: SingleChildScrollView(
          //    child: Column(
          //     children: List.generate(5, (index) =>  const FundraiserTile()),
          //    ),
          //  ))
          ],
        ),
      ),
    );
  }
}

class FundraiserTile extends StatelessWidget {
  final Fundraiser fundraiser;
  const FundraiserTile({
    super.key, required this.fundraiser,
  });

  @override
  Widget build(BuildContext context) {
         var amount = fundraiser.investments?.fold(0, (previousValue, element) => previousValue+int.parse(element.amount!));
           var percent;
      //  var percent  = amount/double.parse()
      if(amount != null){
       percent = amount/double.parse(fundraiser.amountRaising!)*100;

      }
   
    return Padding(
      padding: const EdgeInsets.only(bottom:15.0),
      child: GestureDetector(
        onTap: (){
          AppNavigationHelper.navigateToWidget(context, CampaignDetails(fundraiser: fundraiser));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.BLACK.withOpacity(0.2), width: 0.5)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: ImageViewer(
                  images:
                      fundraiser.image??"",
                  height: Utils.screenHeight(context) / 6,
                  fromNetwork: true,
                ),
              ),
              AppSpaces.height4,
              Padding(
                padding: const EdgeInsets.only(bottom:10.0, left: 10, right: 10, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                  fundraiser.title??"",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                AppSpaces.height8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text:  TextSpan(
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.ASHDEEP),
                            text: 'Milestone Amount ',
                            children: [
                          TextSpan(
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.PRIMARYCOLOR),
                              text: '£$amount')
                        ])),
                    CategoryContainer(title: '${fundraiser.category?.name??""}',)
                  ],
                ),
                Divider(color: AppColors.BLACK.withOpacity(0.2),thickness: 0.5,),
                AppSpaces.height8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(child:Image.asset('assets/icons/chat.png', height: 20,),),
                        AppSpaces.width4,
                        const Text("Message", style: TextStyle(fontWeight: FontWeight.w500),)
                      ],
                    ),
                     Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(child:Image.asset('assets/icons/mutual-fund.png', height: 20,),),
                          AppSpaces.width4,
                         Text("${fundraiser.investments?.length ??0}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(child:Image.asset('assets/icons/calendar.png', height: 20,),),
                          AppSpaces.width4,
                         Text("${fundraiser.createdAt?.day}.${fundraiser.createdAt?.month}.${fundraiser.createdAt?.year}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),),
                      ],
                    )
                  ],
                ),
                AppSpaces.height16,
                SizedBox(
                              width: double.infinity,
                              child: CustomButton(
                                title: 'Invest Now',
                                color: AppColors.SECONDARYCOLOR,
                                onTap: () {
                                  context.read<FundRaiserProvider>().setFundRaiser(fundraiser);
                                  AppNavigationHelper.navigateToWidget(context, InvestInCampaign());
                                },
                              )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryContainer extends StatelessWidget {
  final String title;
  const CategoryContainer({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
            width: 0.3, color: AppColors.BLACK.withOpacity(0.3)),
      ),
      child:  Text(title, style: TextStyle(fontSize: 11),),
    );
  }
}

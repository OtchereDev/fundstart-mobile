import 'dart:io';

import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Components/custom_button.dart';
import 'package:crowdfunding/Components/textformfield.dart';
import 'package:crowdfunding/Core/Helpers/navigation_helper.dart';
import 'package:crowdfunding/Model/Requests/fundraiser_request.dart';
import 'package:crowdfunding/Provider/Fundraiser/fundraiser_provider.dart';
import 'package:crowdfunding/Utils/DatePicker/date_picker_util.dart';
import 'package:crowdfunding/Utils/utils.dart';
import 'package:crowdfunding/Views/Home/home_index.dart';
import 'package:crowdfunding/Widgets/custom_divider.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateCampaignFrom2 extends StatefulWidget {
  CreateCampaignFrom2({super.key});

  @override
  State<CreateCampaignFrom2> createState() => _CreateCampaignFrom2State();
}

class _CreateCampaignFrom2State extends State<CreateCampaignFrom2> {
  final textController = TextEditingController();
  final dateController = TextEditingController();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final amountController = TextEditingController();

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
          "Add Comment",
          style: TextStyle(color: AppColors.PRIMARYCOLOR, fontSize: 16),
        ),
      ),
      body: Consumer<FundRaiserProvider>(builder: (context, fund, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                AppSpaces.height16,

               
                TextFormWidget(
                  descController,
                  'Comment',
                  false,
                  isDark: false,
                  hint: 'Enter your comment',
                  line: 4,
                ),
                AppSpaces.height16,
               
                // const Text(
                //   "FundStart has a 0% platform fee for organisers. FundStart will continue offering its services thanks to donors who leave an optional amount here:",
                //   style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                // ),
                AppSpaces.height16,

                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    title: 'Create Campaign',
                    color: AppColors.SECONDARYCOLOR,
                    onTap: () {
                      FundraiserRequest fundraiserRequest = FundraiserRequest();
                      fundraiserRequest.amountRaising = int.parse(amountController.text);
                      fundraiserRequest.categoryId = int.parse(fund.catID!);
                      fundraiserRequest.expiryDate = fund.dateTime;
                      fundraiserRequest.title = titleController.text;
                      fundraiserRequest.image = fund.imageString;
                      fundraiserRequest.description = descController.text;

                      // fund.CreateCampaignFrom2(context, fundraiserRequest).then((value){
                      //   if(value ){
                      //     AppNavigationHelper.setRootOldWidget(context, const HomeIndex());
                      //   }
                      // });


                    },
                  ),
                ),
                AppSpaces.height16,
                //  const CustomDivider(),
                //     const Text(
                //       "FundStart Guarantee",
                //       style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                //     ),
                //     const Text(
                //       "In the rare event that something isn't right, we will work with you to determine if misuse has occurred. Learn more.",
                //       style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                //     ),
                //     AppSpaces.height40,
              ],
            ),
          ),
        );
      }),
    );
  }
}

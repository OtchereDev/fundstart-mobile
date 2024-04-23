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

class CreateCampaign extends StatefulWidget {
  CreateCampaign({super.key});

  @override
  State<CreateCampaign> createState() => _CreateCampaignState();
}

class _CreateCampaignState extends State<CreateCampaign> {
  final textController = TextEditingController();
  final dateController = TextEditingController();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final amountController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.value([context.read<FundRaiserProvider>().getCategories(context)]);
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
          "Create Campaign",
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
                Text("Add a cover photo", style: TextStyle(
              color: AppColors.BLACK,
              fontSize: 14,
             ),),
             AppSpaces.height8,
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.5, color: AppColors.BLACK.withOpacity(0.2))),
                  height: Utils.screenHeight(context) / 4,
                  width: double.infinity,
                  child: fund.imageFile == null
                      ? IconButton(
                          icon: const Icon(FeatherIcons.cameraOff),
                          onPressed: () {
                            fund.selectProfileImages();
                          },
                        )
                      : Image.file(File(fund.imageFile!.path)),
                ),
                AppSpaces.height16,

                TextFormWidget(
                  titleController,
                  'Title',
                  false,
                  isDark: false,
                  hint: 'Enter title of the campaign',
                ),
                AppSpaces.height16,
                TextFormWidget(
                  descController,
                  'Description',
                  false,
                  isDark: false,
                  hint: 'Enter description of campaign',
                  line: 4,
                ),
                AppSpaces.height16,
                TextFormWidget(
                  amountController,
                  'Amount',
                  false,
                  isDark: false,
                  hint: '£',
                ),
                AppSpaces.height16,
                TextFormWidget(
                  textController,
                  'Category',
                  true,
                  isDark: false,
                  hint: '--Select category--',
                  icon: const Icon(Icons.keyboard_arrow_down),
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return CategoryBottomSheet(
                            fundRaiserProvider: fund,
                            controller: textController,
                          );
                        });
                  },
                ),
                AppSpaces.height16,
                TextFormWidget(
                  dateController,
                  'Expiry Date',
                  true,
                  isDark: false,
                  hint: '12/10/2024',
                  icon: const Icon(FeatherIcons.calendar),
                  onTap: () async {
                    DateTime? date = await DatePickerUtil.pickDate(context,
                        lastDate: DateTime.now(),
                        title: "Campaign Expiry Sate");
                    if(date != null){
                      dateController.text =
                        ("${date.day}/${date.month}/${date.year}");
                    fund.setDate(date);
                    }
                  },
                ),
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

                      fund.createCampaign(context, fundraiserRequest).then((value){
                        if(value ){
                          AppNavigationHelper.setRootOldWidget(context, const HomeIndex());
                        }
                      });


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

class CategoryBottomSheet extends StatelessWidget {
  final FundRaiserProvider fundRaiserProvider;
  final TextEditingController controller;
  const CategoryBottomSheet({
    super.key,
    required this.fundRaiserProvider, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
          color: AppColors.WHITE,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Select Category",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              IconButton(onPressed: () {
                Navigator.pop(context);
              }, icon: const Icon(Icons.close))
            ],
          ),
                const CustomDivider(),
          Expanded(
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(
                    fundRaiserProvider.categoryModel?.response.length ?? 0, (index) {
                  var data = fundRaiserProvider.categoryModel?.response[index];
                  return Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(data?.name ?? ""),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 15,),
                        onTap: (){
                          fundRaiserProvider.setCategoryID(data?.id.toString() ??"");
                          controller.text = data?.name??"";
                             Navigator.pop(context);
                        },
                      ),
                      const CustomDivider(),
                    ],
                  );
                })
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

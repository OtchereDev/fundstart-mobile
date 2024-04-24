import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Components/custom_button.dart';
import 'package:crowdfunding/Components/image_viewer.dart';
import 'package:crowdfunding/Components/textformfield.dart';
import 'package:crowdfunding/Provider/Fundraiser/fundraiser_provider.dart';
import 'package:crowdfunding/Provider/Payment/payment_provider.dart';
import 'package:crowdfunding/Utils/utils.dart';
import 'package:crowdfunding/Widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InvestInCampaign extends StatefulWidget {
  InvestInCampaign({super.key});

  @override
  State<InvestInCampaign> createState() => _InvestInCampaignState();
}

class _InvestInCampaignState extends State<InvestInCampaign> {
  final textController = TextEditingController();

  final nameController = TextEditingController();

  final amountController = TextEditingController();

  final tipController = TextEditingController();

  final fmKey = GlobalKey<FormState>();

  final scfKey = GlobalKey<ScaffoldState>();

  late FocusNode _amountFocus, donationFocus;

  @override
  void initState() {
    _amountFocus = FocusNode();
    donationFocus = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scfKey,
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
          "Invest",
          style: TextStyle(color: AppColors.PRIMARYCOLOR, fontSize: 16),
        ),
      ),
      body: Consumer<StripePaymentProviver>(builder: (context, payment, _) {
        return Consumer<FundRaiserProvider>(builder: (context, fundRaiser, _) {
          return  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Form(
                key: fmKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageViewer(
                      images: fundRaiser.fundraiser.image ?? "",
                      height: Utils.screenHeight(context) / 4,
                      fromNetwork: true,
                    ),
                    AppSpaces.height16,
                    Text(
                      fundRaiser.fundraiser.title ?? "",
                      style:
                          const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    AppSpaces.height8,
                    Text(
                      fundRaiser.fundraiser.description ?? "",
                      style:
                          const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    AppSpaces.height16,
                    TextFormWidget(
                      amountController,
                      'Enter your donation',
                      false,
                      isDark: false,
                      hint: '0.0',
                      icon: Image.asset('assets/icons/pounds.png'),
                      validate: true,
                      validateMsg: "Amount required",
                      focusNode: donationFocus,
                    ),
                    AppSpaces.height16,
                    TextFormWidget(
                      nameController,
                      'Donor Name',
                      false,
                      isDark: false,
                      hint: 'Please provide your full name',
                      validate: true,
                      validateMsg: "fullname required",
                    ),
                    AppSpaces.height16,
                    const Text(
                      "Tip FundStart Services",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      "FundStart has a 0% platform fee for organisers. FundStart will continue offering its services thanks to donors who leave an optional amount here:",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    AppSpaces.height16,
                    TextFormWidget(
                      tipController,
                      'Tip amount',
                      false,

                      focusNode: _amountFocus,
                      isDark: false,
                      hint: '0.0',
                      icon: Image.asset('assets/icons/pounds.png'),
                      inputType: TextInputType.number,
                    ),
                    AppSpaces.height16,
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        title: 'Invest Now',
                        color: AppColors.SECONDARYCOLOR,
                        onTap: () {
                          if (fmKey.currentState?.validate() == true) {
                            Map<String, dynamic> data = {
                              "amount": int.parse(amountController.text),
                              "tip": int.parse(tipController.text),
                              "fundraiserId": fundRaiser.fundraiser.id,
                              "name": nameController.text
                            };
                            payment.createPayment(context, data).then((value) {
                              _amountFocus.unfocus();
                              donationFocus.unfocus();
                              if (value != null) {
                                payment.stripeMakePayment(scfKey.currentContext,value);
                              }
                            });
                          }
                        },
                      ),
                    ),
                    AppSpaces.height16,
                    const CustomDivider(),
                    const Text(
                      "FundStart Guarantee",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      "In the rare event that something isn't right, we will work with you to determine if misuse has occurred. Learn more.",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    AppSpaces.height40,
                  ],
                ),
              ),
            ),
          );
        });
      }),
    );
  }
}

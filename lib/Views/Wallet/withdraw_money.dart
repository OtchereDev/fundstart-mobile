import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Components/custom_button.dart';
import 'package:crowdfunding/Components/success_page.dart';
import 'package:crowdfunding/Components/textformfield.dart';
import 'package:crowdfunding/Core/Helpers/navigation_helper.dart';
import 'package:crowdfunding/Provider/Wallet/wallet_provider.dart';
import 'package:crowdfunding/Widgets/custom_divider.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WithdrawalPage extends StatelessWidget {
  WithdrawalPage({super.key});
  final textController = TextEditingController();
  final bankController = TextEditingController();
  final amountController = TextEditingController();
  final fmKey = GlobalKey<FormState>();
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
          "Withdrawal",
          style: TextStyle(
              color: AppColors.PRIMARYCOLOR,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return Consumer<WalletProvider>(builder: (context, wallet, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: fmKey,
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.3,
                                  color: AppColors.BLACK.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            "£50000",
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          )),
                        ),
                        AppSpaces.height20,
                        TextFormWidget(
                          amountController,
                          'Amount',
                          false,
                          isDark: false,
                          hint: 'Enter Amount',
                          validateMsg: 'Amount required',
                          validate: true,
                          inputType: TextInputType.number,
                          // icon: const Icon(Icons.keyboard_arrow_down),
                          onTap: () {
                            // showModalBottomSheet(
                            //     context: context,
                            //     builder: (context) {
                            //       return CategoryBottomSheet(
                            //         fundRaiserProvider: fund,
                            //         controller: textController,
                            //       );
                            //     });
                          },
                        ),
                        AppSpaces.height20,
                        TextFormWidget(
                          bankController,
                          'Bank',
                          true,
                          isDark: false,
                          hint: '--Select bank--',
                          validateMsg: 'Bank required',
                          validate: true,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30)),
                                        color: AppColors.WHITE),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                            "Select Bank",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            ...List.generate(
                                                banks.length,
                                                (index) => Column(
                                                      children: [
                                                        ListTile(
                                                          onTap: () {
                                                            bankController
                                                                    .text =
                                                                banks[index];
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          leading: CircleAvatar(
                                                            child: Icon(Icons
                                                                .account_balance_outlined),
                                                          ),
                                                          title: Text(
                                                              banks[index]),
                                                        ),
                                                        CustomDivider()
                                                      ],
                                                    )),
                                          ],
                                        ),
                                        AppSpaces.height20,
                                        AppSpaces.height20,
                                        AppSpaces.height20,
                                      ],
                                    ),
                                  );
                                });
                          },
                        ),
                        AppSpaces.height20,
                        TextFormWidget(
                          textController,
                          'Account Number',
                          false,
                          isDark: false,
                          hint: 'Enter account number',
                          validateMsg: 'Account number required',
                          validate: true,
                          inputType: TextInputType.number,
                        ),
                        Spacer(),
                        AppSpaces.height20,
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            title: 'Withdraw',
                            color: AppColors.SECONDARYCOLOR,
                            onTap: () {
                              if (fmKey.currentState?.validate() == true) {
                                wallet.withdraw(context).then((value) {
                                  if (value == true) {
                                    AppNavigationHelper.navigateAndReplaceWidget(context, SuccessPage());
                                  }
                                });
                              }
                            },
                          ),
                        ),
                        AppSpaces.height40
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
      }),
    );
  }
}

List<String> banks = [
  "Banque Havilland S.A. (UK Branch)",
  "Diamond Bank (UK) Plc",
  "Zenith Bank (UK) Limited",
  "British Business Bank"
];

import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Components/credit_card_exp.dart';
import 'package:crowdfunding/Components/custom_button.dart';
import 'package:crowdfunding/Components/textformfield.dart';
import 'package:crowdfunding/Provider/Wallet/wallet_provider.dart';
import 'package:crowdfunding/Widgets/credit_card_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AddCreditCard extends StatelessWidget {
  AddCreditCard({super.key});

  final cardNameValueNotifier = ValueNotifier("");
  final cardNumberValueNotifier = ValueNotifier("");
  final cardExpValueNotifier = ValueNotifier("");
  final accept3 = ValueNotifier(false);
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final expController = TextEditingController();
  final cvvController = TextEditingController();
  final fmKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Add Credit Card",
          style: TextStyle(
              color: AppColors.PRIMARYCOLOR,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Consumer<WalletProvider>(builder: (context, wallet, _) {
        return LayoutBuilder(builder: (context, constraint) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: fmKey,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        ValueListenableBuilder(
                            valueListenable: cardNameValueNotifier,
                            builder: (context, cardName, _) {
                              return ValueListenableBuilder(
                                  valueListenable: cardNumberValueNotifier,
                                  builder: (context, cardNumber, _) {
                                    return ValueListenableBuilder(
                                        valueListenable: cardExpValueNotifier,
                                        builder: (context, exp, _) {
                                          return CreditCardPreviewWidget(
                                            exp: exp,
                                            name: cardName,
                                            number: cardNumber,
                                          );
                                        });
                                  });
                            }),
                        AppSpaces.height20,
                        ValueListenableBuilder(
                            valueListenable: cardNumberValueNotifier,
                            builder: (context, number, _) {
                              return TextFormWidget(
                                  numberController, 'Card Number', false,
                                  isDark: false,
                                  hint: 'Please provide your card number',
                                  validate: true,
                                  validateMsg: "card number required",
                                  onValueChange: (p0) {
                                cardNumberValueNotifier.value = p0;
                                accept3.value = p0[0] == "5" ? true : false;
                              });
                            }),
                        AppSpaces.height20,
                        ValueListenableBuilder(
                            valueListenable: cardNameValueNotifier,
                            builder: (context, number, _) {
                              return TextFormWidget(
                                  nameController, 'Card Holder Name', false,
                                  isDark: false,
                                  hint: 'Please provide name on card',
                                  validate: true,
                                  validateMsg: "name required",
                                  onValueChange: (p0) {
                                cardNameValueNotifier.value = p0;
                              });
                            }),
                        AppSpaces.height20,
                        Row(
                          children: [
                            ValueListenableBuilder(
                                valueListenable: cardExpValueNotifier,
                                builder: (context, number, _) {
                                  return Expanded(
                                    child: ExpiryDateTextField(
                                      onValueChange: (p0) {
                                        cardExpValueNotifier.value = p0;
                                      },
                                    ),
                                  );
                                }),
                            AppSpaces.width16,
                            Expanded(
                                child: ValueListenableBuilder(
                                    valueListenable: accept3,
                                    builder: (context, threePins, _) {
                                      return TextFormWidget(
                                          cvvController, 'CVV', false,
                                          isDark: false,
                                          hint: threePins ? '1234' : '234',
                                          validate: true,
                                          count: threePins ? 4 : 3,
                                          validateMsg: "name required",
                                          onValueChange: (p0) {});
                                    }))
                          ],
                        ),
                        AppSpaces.height16,
                        Spacer(),
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            title: 'Add  Wallet',
                            color: AppColors.SECONDARYCOLOR,
                            onTap: () {
                              if (fmKey.currentState?.validate() == true) {
                                Map<String, dynamic> data = {
                                  "cardHolder": nameController.text,
                                  "cvv": cvvController.text,
                                  "expiryDate": cardExpValueNotifier.value,
                                  "cardNumber": numberController.text
                                };
                                wallet
                                    .createWallet(context, data)
                                    .then((value) {
                                  if (value == true) {
                                    Navigator.pop(context, true);
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

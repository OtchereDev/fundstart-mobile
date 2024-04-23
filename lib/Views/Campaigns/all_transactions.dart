import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Provider/Payment/payment_provider.dart';
import 'package:crowdfunding/Views/Home/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllTransactionsPage extends StatefulWidget {
  const AllTransactionsPage({super.key});

  @override
  State<AllTransactionsPage> createState() => _AllTransactionsPageState();
}

class _AllTransactionsPageState extends State<AllTransactionsPage> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.value(
          [context.read<StripePaymentProviver>().geyAllTransactions(context)]);
    });
    super.initState();
  }

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
            "All Transactions",
            style: TextStyle(
                color: AppColors.PRIMARYCOLOR,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: Consumer<StripePaymentProviver>(builder: (context, fund, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal:20.0),
            child: ListView.builder(
                itemCount: fund.transactionResponse.transactions?.length ?? 0,
                itemBuilder: (context, index) {
                  var data =
                      fund.transactionResponse.transactions?.reversed.toList()[index];
                  return TransactionTile(transaction: data!,);
                }),
          );
        }));
  }
}

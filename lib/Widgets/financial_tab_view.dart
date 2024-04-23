import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Utils/utils.dart';
import 'package:crowdfunding/Widgets/custom_divider.dart';
import 'package:crowdfunding/Widgets/pie_cart_for_financials.dart';
import 'package:flutter/material.dart';

class FinancialsTabView extends StatelessWidget {
  const FinancialsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDivider(),

        Text(
          "Key Statistics",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        AppSpaces.height16,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StatisticsCard(
              subText: "5,000",
              title: "Current Revenue",
            ),
            StatisticsCard(
              subText: "30,900",
              title: "Expected Revenue",
            ),
          ],
        ),
        AppSpaces.height16,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StatisticsCard(
              subText: "60,000",
              title: "Total Expenses",
            ),
            StatisticsCard(
              subText: "100,000",
              title: "Total Investment",
            ),
          ],
        ),
        AppSpaces.height16,
        CustomDivider(),
        Text(
          "Pie",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        PieChartSample2()
      ],
    );
  }
}

class StatisticsCard extends StatelessWidget {
  final String title, subText;
  const StatisticsCard({
    super.key,
    required this.title,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: Utils.screenWidth(context) / 2.3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: const Color(0xffF9F9FB)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                const TextStyle(fontWeight: FontWeight.w300, color: AppColors.BLACK),
          ),
          AppSpaces.height8,
          Text(
            "£$subText",
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}

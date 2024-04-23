
import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Provider/Wallet/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CreditCardPreviewWidget extends StatelessWidget {
  final String name, number, exp;
   const CreditCardPreviewWidget({
    super.key, required this.name, required this.number, required this.exp,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletProvider>(
      builder: (context, wallet, _) {
        return Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.SECONDARYCOLOR),
              child:  Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                        number,
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: AppColors.WHITE),
                        ),
                        Text(
                           "EXP $exp",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: AppColors.WHITE),
                        ),
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        name,
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColors.WHITE,
                            fontWeight: FontWeight.w600),
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SvgPicture.asset(
                'assets/icons/line.svg',
                color: AppColors.WHITE,
                height: 30,
                width: 30,
              ),
            ),
            Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(
                  'assets/icons/circle.svg',
                  color: AppColors.WHITE,
                  height: 150,
                )),
          ],
        );
      }
    );
  }
}

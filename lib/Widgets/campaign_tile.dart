import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Components/image_viewer.dart';
import 'package:crowdfunding/Model/Response/fundraiser_model.dart';
import 'package:crowdfunding/Utils/utils.dart';
import 'package:crowdfunding/Widgets/custom_divider.dart';
import 'package:flutter/material.dart';

class CampaignTile extends StatelessWidget {

  final VoidCallback? onTap;
  final bool showMOre;
  final Fundraiser fundraiser;
  const CampaignTile(
      {super.key,
      this.onTap,
      this.showMOre = true,
    
 
    required this.fundraiser, });

  @override
  Widget build(BuildContext context) {
    final difference = Utils.daysBetweenDates(fundraiser.createdAt!, fundraiser.expiryDate!);
             var amount = fundraiser.investments?.fold(0, (previousValue, element) => previousValue+int.parse(element.amount!));
           double percent=0.0;
      //  var percent  = amount/double.parse()
      if(amount != null){
       percent = (amount/double.parse(fundraiser.amountRaising!)*100);

      }
   
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.WHITE,
              boxShadow: [
                BoxShadow(
                    blurRadius: 2,
                    color: AppColors.BLACK.withOpacity(0.1),
                    offset: const Offset(0, 1),
                    spreadRadius: 1)
              ],
              border: Border.all(
                  width: 0.2, color: AppColors.BLACK.withOpacity(0.4)),
            ),
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                    child: ImageViewer(
                        images: fundraiser.image??"", height: 120, fromNetwork: true)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            fundraiser.title??"",
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          showMOre
                              ? GestureDetector(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.more_vert,
                                    color: AppColors.PRIMARYCOLOR,
                                  ))
                              : const SizedBox(
                                  height: 20,
                                  width: 50,
                                )
                        ],
                      ),
                      AppSpaces.height4,
                      Text(
                        fundraiser.description??"",
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis, fontSize: 10),
                        maxLines: 3,
                      ),
                      const CustomDivider(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text:  TextSpan(
                                    text: 'Raised of ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.ACTIVECOLOR),
                                    children: [
                                      TextSpan(
                                        text: '${percent.toStringAsFixed(2)}%',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.PRIMARYCOLOR),
                                      )
                                    ]),
                              ),
                              AppSpaces.height4,
                               Text(
                                "Investor ${fundraiser.investments?.length.toString()}",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                      AppSpaces.height8,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 27,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.ACTIVECOLOR,
                                ),
                                child: const Center(
                                    child: Text(
                                  "Raised Goal",
                                  style: TextStyle(
                                      fontSize: 12, color: AppColors.WHITE),
                                )),
                              ),
                              AppSpaces.width16,
                              Text(
                                "£${fundraiser.amountRaising}",
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Text(
                            "Remaning Days: $difference",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      AppSpaces.height8,
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}

// // ignore_for_file: avoid_unnecessary_containers
//
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

//
class CardLoadingShimmer extends StatelessWidget {
  final int? numberOfCards;
  final double? cardHeight;
  const CardLoadingShimmer({Key? key, this.numberOfCards, this.cardHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Color.fromARGB(255, 188, 188, 190),
      baseColor: Color.fromARGB(255, 255, 255, 255),
      child: ListView(
          padding: EdgeInsets.zero,
          children: List.generate(numberOfCards ?? 3,
              (index) => InactiveCard(height: cardHeight)).toList()),
    );
  }
}

class InactiveCard extends StatelessWidget {
  final double? height;
  const InactiveCard({Key? key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // margin: const EdgeInsets.only(bottom: 5),
        width: double.infinity,
        height: height ?? 110,
        // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Card(
            semanticContainer: true,
            color: Colors.white,
            shadowColor: Colors.grey[50],
            elevation: 20,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            borderOnForeground: true,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: const SizedBox(height: 70)));
  }
}

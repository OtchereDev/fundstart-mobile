import 'package:carousel_slider/carousel_slider.dart';
import 'package:crowdfunding/Views/Home/dashboard.dart';
import 'package:flutter/material.dart';

class DashboardCarousel extends StatelessWidget {
  final double height;
  DashboardCarousel({super.key, required this.height});
  List<Map<String, dynamic>> data = [
    {
      "color": Color(0xffFFE2E2),
      "name": "Total Expenses",
      "percentage": "-8.8%",
      "up": false,
      "amount": "30000"
    },
    {
      "color": Color(0xffE5F4FA),
      "name": "Total Revenue",
      "percentage": "+8.8%",
      "up": true,
      "amount": "30000"
    },
    {
      "color": Color(0xffE2FBE5),
      "name": "Total Profit",
      "percentage": "+8.8%",
      "up": true,
      "amount": "30000"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: height,
        aspectRatio: 3.0,
        pageSnapping: true,
        scrollDirection: Axis.horizontal,
        viewportFraction: 01,
        autoPlay: true,
        onPageChanged: (index, reason) {},
        onScrolled: (value) {
          // print(value?.ceil());
        },
      ),
      items: data.map((index) {
        return Builder(
          builder: (BuildContext context) {
            return DashboardCard(
              color: index['color'],
              isUp: index['up'],
              name: index['name'],
              percentage: index['percentage'],
              amount: index['amount'],
            );
          },
        );
      }).toList(),
    );
  }
}

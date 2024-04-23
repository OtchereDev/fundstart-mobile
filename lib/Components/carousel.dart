import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Components/image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';

class CarouselComponent extends StatelessWidget {
  final double height;
  CarouselComponent({super.key, required this.height, required this.images});
  final List<String> images;

  final activeIndex = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: activeIndex,
        builder: (context, active, _) {
          return Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: height,
                  aspectRatio: 3.0,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1.0,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    activeIndex.value = (index);
                  },
                  onScrolled: (value) {
                    // print(value?.ceil());
                  },
                ),
                items: images.map((index) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {},
                        child: SizedBox(
                          // height: 140,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: ImageViewer(
                              fromNetwork: true,
                              images: index,
                              height: height - 20,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              // AppSpaces.height4,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    images.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:active ==index ?  AppColors.SECONDARYCOLOR : AppColors.SECONDARYCOLOR.withOpacity(0.3),
                            ),
                          ),
                    )),
              )
            ],
          );
        });
  }
}

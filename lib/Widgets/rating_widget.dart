
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingWidget extends StatelessWidget  {
  const RatingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: 2.75,
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemCount: 5,
      itemSize: 15.0,
      direction: Axis.horizontal,
    );
  }
}

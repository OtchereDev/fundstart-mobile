import 'package:crowdfunding/Components/card_loading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';

class ImageViewer extends StatelessWidget {
  final String images;
  final double height;
  final bool fromNetwork;
  const ImageViewer({super.key, required this.images, required this.height, required this.fromNetwork});

  @override
  Widget build(BuildContext context) {
    return fromNetwork ?  ImageFade(
      // whenever the image changes, it will be loaded, and then faded in:
      image:NetworkImage(images),

      // slow fade for newly loaded images:
      duration: const Duration(milliseconds: 900),
      // if the image is loaded synchronously (ex. from memory), fade in faster:
      syncDuration: const Duration(milliseconds: 500),
      // supports most properties of Image:
      alignment: Alignment.center,
      fit: BoxFit.cover,
      height: height,
      width: MediaQuery.of(context).size.width,
      // shown behind everything:
      placeholder: CardLoadingShimmer(
        cardHeight: height,
        numberOfCards: 1,
      ),
      errorBuilder: (context, error) => Container(
        color: const Color(0xFF6F6D6A),
        alignment: Alignment.center,
        child: const Icon(Icons.warning, color: Colors.black26, size: 128.0),
      ),
    ): ImageFade(
      // whenever the image changes, it will be loaded, and then faded in:
      image: AssetImage(images),

      // slow fade for newly loaded images:
      duration: const Duration(milliseconds: 900),
      // if the image is loaded synchronously (ex. from memory), fade in faster:
      syncDuration: const Duration(milliseconds: 500),
      // supports most properties of Image:
      alignment: Alignment.center,
      fit: BoxFit.cover,
      height: height,
      width: MediaQuery.of(context).size.width,
      // shown behind everything:
      placeholder: CardLoadingShimmer(
        cardHeight: height,
        numberOfCards: 1,
      ),
      errorBuilder: (context, error) => Container(
        color: const Color(0xFF6F6D6A),
        alignment: Alignment.center,
        child: const Icon(Icons.warning, color: Colors.black26, size: 128.0),
      ),
    );
  }
}

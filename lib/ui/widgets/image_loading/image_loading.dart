import 'package:flutter/material.dart';

class ImageLoading extends StatelessWidget {
  final String imageUrl;
  final double imageWidth;
  final double imageHeight;
  final BoxFit imageFitType;

  const ImageLoading({
    required this.imageUrl,
    required this.imageWidth,
    required this.imageHeight,
    this.imageFitType = BoxFit.contain,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: imageWidth,
      height: imageHeight,
      fit: imageFitType,
      loadingBuilder: (_, child, progress) {
        if (progress == null) return child;
        return imageLoader();
      },
      errorBuilder: (context, url, error) => imageLoadingErrorWidget(),
    );
  }
}

Widget imageLoader() {
  return Center(
    child: Container(
      width: 30,
      height: 14,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: const LinearProgressIndicator(),
    ),
  );
}

Widget imageLoadingErrorWidget() {
  return const Icon(
    Icons.warning,
    color: Colors.red,
    size: 40,
  );
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({Key? key, required this.imageUrl, this.width, this.height = 100}) : super(key: key);

  const ProductImage.small({required this.imageUrl, this.width = 96, this.height = 64});

  final String imageUrl;
  final double? width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        height: height,
        width: width,
        fit: BoxFit.cover,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    );
  }
}

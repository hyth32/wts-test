import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class BaseNetworkImage extends StatelessWidget {
  const BaseNetworkImage({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      imageUrl,
      width: double.infinity,
      fit: BoxFit.cover,
      handleLoadingProgress: true,
    );
  }
}

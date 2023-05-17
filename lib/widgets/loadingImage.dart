import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class loadingImageServer extends StatelessWidget {
  final String imageUrl;
  final BorderRadius? borderRadius;

  const loadingImageServer({required this.imageUrl, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: borderRadius,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
        ));
  }
}

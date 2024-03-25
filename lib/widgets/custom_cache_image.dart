import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDisplayStoryImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  
  const CustomDisplayStoryImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: CachedNetworkImage(
          key: ValueKey(imageUrl),
          useOldImageOnUrlChange: true,
          imageUrl: imageUrl,
          fit: BoxFit.fill,
          width: width,
          height: height,
          placeholder: (context, url) => const CupertinoActivityIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ));
  }
}

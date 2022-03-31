import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget cachedNetworkImage(String mediaUrl) {
  return CachedNetworkImage(
    imageUrl: mediaUrl,
    fit: BoxFit.cover,
    placeholder: (context, url) => const Padding(
      child: Center(child: CircularProgressIndicator()),
      padding: EdgeInsets.all(20),
    ),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}

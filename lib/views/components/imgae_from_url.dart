import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageFromUrl extends StatelessWidget {
  const ImageFromUrl({this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final isInvalidUrl = imageUrl.startsWith('http');
    if(imageUrl == null || imageUrl == ''|| !isInvalidUrl){
      return const Icon(Icons.broken_image);
    }else{
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context,url)=>const CircularProgressIndicator(),
        ///errorにdynamic型明示
        errorWidget: (context,url,dynamic error)=>const Icon(Icons.broken_image),
      );
    }

  }
}

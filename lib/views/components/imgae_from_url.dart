import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageFromUrl extends StatelessWidget {


  const ImageFromUrl({this.displayFilePath,this.onTap});
  final String displayFilePath;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
//    final isInvalidUrl = displayFilePath.startsWith('http');
    if(displayFilePath == null || displayFilePath == ''){
      return const Icon(Icons.broken_image);
    }else{
      return
        Container(
          decoration: BoxDecoration(
            border:  Border.all(color: Colors.blueAccent),
          ),
          child: InkWell(
            onTap: onTap,
            child: SizedBox(
              width: 100,
              height: 100,
              //todo flutter_image_compressを使用して画像を縮小する
              child:Image.file(File(displayFilePath)),
              //displayImage,
            ),
          ),
        );
//        CachedNetworkImage(
//        imageUrl: imageUrl,
//        fit: BoxFit.cover,
//        placeholder: (context,url)=>const CircularProgressIndicator(),
//        ///errorにdynamic型明示
//        errorWidget: (context,url,dynamic error)=>const Icon(Icons.broken_image),
//      );
    }

  }
}

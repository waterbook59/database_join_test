
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {

  const CachedImage({this.onTap, this.displayImage});
  final VoidCallback onTap;
  final Widget displayImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border:  Border.all(color: Colors.blueAccent),
      ),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 100,
          height: 100,
          //todo flutter_image_compressを使用して画像を縮小する
          child: displayImage,
        ),
      ),
    );
  }
}




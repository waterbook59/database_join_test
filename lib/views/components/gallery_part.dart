
import 'package:flutter/material.dart';

class GalleryPart extends StatelessWidget {

  const GalleryPart({this.onTap, this.displayImage});
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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: 100,
            height: 100,
            //todo タップでカメラ起動 or 保存先から選択
            child: displayImage,
          ),
        ),
      ),
    );
  }
}

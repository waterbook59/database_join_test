
import 'package:flutter/material.dart';

class AddIconPart extends StatelessWidget {

  const AddIconPart({this.onTap, this.displayImage, this.width, this.height});
  final VoidCallback onTap;
  final Widget displayImage;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border:  Border.all(color: Colors.blueAccent),
      ),
      child: InkWell(
        onTap: onTap,
        //padding削除
        child: SizedBox(
          width: width,
          height: height,
          child: displayImage,
        ),
      ),
    );
  }
}

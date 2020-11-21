
import 'package:flutter/material.dart';

import 'circle_icon_button.dart';

class ProductTextPart extends StatelessWidget {
  const ProductTextPart(
      {this.productTextController,
        this.onCancelButtonPressed,
        this.labelText,
        this.hintText, this.textInputType});

  final TextEditingController productTextController;
  final VoidCallback onCancelButtonPressed;
  final String labelText;
  final String hintText;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
//        alignment: const Alignment(1, 0), // right & center
        children: [
          SizedBox(
            width: 280,
            child: TextFormField(
              decoration: InputDecoration(
//              icon: const Icon(Icons.dashboard),
                labelText: labelText,
                labelStyle:const  TextStyle(color: Colors.black87),
                hintText: hintText,
                hintStyle:const TextStyle(color: Colors.black26),
              ),
              controller: productTextController,
              keyboardType:textInputType ,
              maxLines: null,
              style: const TextStyle(fontSize: 14,color: Colors.indigo),
            ),
          ),
          const SizedBox(width: 10,),
          //todo キャンセルボタンはtextFieldタップ時だけ表示する
          CircleIconButton(
            onPressed: onCancelButtonPressed,
          ),
        ],
      ),
    );
  }
}

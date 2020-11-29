
import 'package:datebasejointest/views/components/circle_icon_button.dart';
import 'package:flutter/material.dart';



class AmountInputPart extends StatelessWidget {
  const AmountInputPart(
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
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        ///TextFormFieldを固定サイズではなく画面に合わせて伸ばす
        ///単一のWidgetを伸ばすだけならSizedboxのdouble.infinityでよいが、
        ///RowやColumn内のWidgetを伸ばす場合は、Row/Columnの中でExpanded
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomRight,
          children:[
            ///TextFormFieldを固定サイズではなく画面に合わせて伸ばす
          TextFormField(
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
            Text('テスト'),

            Row(
//              crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  onPressed: (){} ,
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  onPressed: (){},),
              ],
            ),
          ]
        ),
      ),
    );
  }
}

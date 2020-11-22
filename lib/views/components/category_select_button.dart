import 'dart:ui';

import 'package:flutter/material.dart';

class CategorySelectButton extends StatefulWidget {
  const CategorySelectButton({
    this.categoryTap, this.icon, this.label, this.isSelected, this.id});

  ///  ValueChanged<String>とは書かず、Function(返したい値)
  // 各ボタンのテキストとbool値を分割元へ戻してmodel層以降で登録に使う
  final Function(bool,String,int) categoryTap;
  final int id;
  final Widget icon;
  final String label;
  final bool isSelected;

  @override
  _CategorySelectButtonState createState() => _CategorySelectButtonState();
}

class _CategorySelectButtonState extends State<CategorySelectButton> {

  ///Gridでそれぞれのボタンに分けるには、ボタンウィジェットをStatefulにして
  ///ボタン単体でbool値を設定して変化させる
  bool isPushButton =false;

  @override
  void initState() {
    isPushButton  = widget.isSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      //後ろの()がないと反応しない
      onTap: (){
        setState(() {
          isPushButton = !isPushButton;
        });
        return widget.categoryTap(isPushButton,widget.label,widget.id);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          // 選択前:背景色透明、選択時:背景色を青にする
            color: isPushButton ?Colors.blue :Colors.transparent,
//          isSelected ? Colors.blue :Colors.transparent,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8)),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  widget.icon,
                  SizedBox(height: 10,),
                  Text(widget.label,style: TextStyle(fontSize: 10),),

                ],
              )
          ),
        ),
      ),
    );
  }
}


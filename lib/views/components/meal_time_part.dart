import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'circle_icon_button.dart';

class MealTimePart extends StatelessWidget {
  const  MealTimePart({this.mealTime, this.backgroundColor, this.onAdd});
  final String mealTime;
  final Color backgroundColor;
  final VoidCallback onAdd;




  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: backgroundColor),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(mealTime),
                CircleIconButton(
                  icon: Icons.add,
                  onPressed: onAdd,),

                //todo ここにリストビュー？
              ],
            ),
          ],
        ),
      ),
    );
  }
}

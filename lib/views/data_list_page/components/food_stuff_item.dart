import 'package:datebasejointest/data_models/menu/food_stuff.dart';
import 'package:flutter/material.dart';



class FoodStuffItem extends StatelessWidget {
  final FoodStuff foodStuff;
  final ValueChanged onLongTapped;
  final ValueChanged onWordTapped;

//  final MemorizedCheckedIcon memorizedCheckedIcon;
//  final bool isMemorizedCheckIcon;

//words[position]をwordに置き換え
  const FoodStuffItem ({this.foodStuff,this.onLongTapped, this.onWordTapped});

  @override
  Widget build(BuildContext context) {
//    print("isMemorizedCheckIconは$memorizedCheckedIcon");
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: Colors.cyan,
      child: ListTile(
        title: Text("${foodStuff.name}", style: TextStyle(color: Colors.black87,fontSize: 23.0),),
        subtitle: Text("在庫：${foodStuff.amount}・期限：${foodStuff.validDate}",
          style: TextStyle(fontFamily: "Corporate", color: Colors.brown),
        ),

//        trailing: word.isMemorized ? MemorizedCheckedIcon(isCheckedIcon: word.isMemorized,):null,
        // trailing: _memorizedCheckIcon(word.isMemorized),
        onLongPress: () => onLongTapped(foodStuff),
//            _deleteWord(_wordList[position]),
        onTap: () => onWordTapped(foodStuff),
      ),
    );
  }
}
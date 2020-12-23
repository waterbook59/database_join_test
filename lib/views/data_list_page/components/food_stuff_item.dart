import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:datebasejointest/data_models/menu/food_stuff.dart';
import 'package:datebasejointest/data_models/menu/food_stuff_firebase.dart';
import 'package:flutter/material.dart';



class FoodStuffItem extends StatelessWidget {
  final FoodStuffFB foodStuff;
  final ValueChanged onLongTapped;
  final ValueChanged onWordTapped;

//  final MemorizedCheckedIcon memorizedCheckedIcon;
//  final bool isMemorizedCheckIcon;

//words[position]をwordに置き換え
  const FoodStuffItem ({this.foodStuff,this.onLongTapped, this.onWordTapped});

  @override
  Widget build(BuildContext context) {
//    print("isMemorizedCheckIconは$memorizedCheckedIcon");
    return Container(
      height: 100,
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: Colors.cyan,
        child: ListTile(
          leading:
//          Image.file(File(foodStuff.localImagePath),
///リスト画像をcachedImageに変えてみる
                  CachedNetworkImage(
        imageUrl: foodStuff.imageUrl,
        fit: BoxFit.cover,
        placeholder: (context,url)=>const CircularProgressIndicator(),
        ///errorにdynamic型明示
        errorWidget: (context,url,dynamic error)=>const Icon(Icons.broken_image),
      ),
//            Image.network(
//                foodStuff.imageUrl,
//            ///登録リストの画像の大きさを調整
//            height: 100,
//            width: 100,
//            fit: BoxFit.cover,
//          ),
          title: Text("${foodStuff.name}", style: TextStyle(color: Colors.black87,fontSize: 23.0),),
          //todo 期限を○年○月○日表記へ変更
          subtitle: Text("在庫：${foodStuff.amount}・期限：${foodStuff.validDate}",
            style: TextStyle(fontFamily: "Corporate", color: Colors.brown),
          ),

//        trailing: word.isMemorized ? MemorizedCheckedIcon(isCheckedIcon: word.isMemorized,):null,
          // trailing: _memorizedCheckIcon(word.isMemorized),
          onLongPress: () => onLongTapped(foodStuff),
//            _deleteWord(_wordList[position]),
          onTap: () => onWordTapped(foodStuff),
        ),
      ),
    );
  }
}
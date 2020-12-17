import 'package:datebasejointest/utils/constants.dart';
import 'package:flutter/material.dart';

class FoodStuff {
  int id;///moorの時は追加
  String foodStuffId; //UuidでつけるかautoIncrement
  String localImagePath; //カメラ・ギャラリーのイメージパス_File(localImagePath.path)で呼び出す
//  String imageUrl;//network経由のproductImage、localImagePathあればいらない
  String name;
  String category;
  DateTime validDate;
  String storage; //保管場所
  int amount; //総量
  int useAmount; //メニュー内で使う量
  int restAmount; //メニュー内に登録してない量
//○日目の朝には○個食べるという量が必要
//  List<AmountToEat> amountToEatList;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  FoodStuff({
    this.id,
    this.foodStuffId,
    this.localImagePath,
    this.name,
    this.category,
    this.validDate,
    this.storage,
    this.amount,
    this.useAmount,
    this.restAmount,
  });


}

class AmountToEat {
  String foodStuffId;
  String amountToEatId;
  String date; //何日目
  MealType mealType; //朝食、昼食、間食、夕食
  int piece; //食べる個数

  AmountToEat({this.foodStuffId,this.amountToEatId,this.date,this.mealType,this.piece});
}



import 'package:flutter/material.dart';

class FoodStuffFB {
  String foodStuffId; //UuidでつけるかautoIncrement
  String userId;///Firebaseへ投稿したユーザーのID
  String imageUrl;///Firebase
  String imageStoragePath;///Firebase storageのパス
  String name;
  String category;
  DateTime validDate;
  String storage; //保管場所
  int amount; //総量
  int useAmount; //メニュー内で使う量
  int restAmount;  //メニュー内に登録してない量
//○日目の朝には○個食べるという量が必要
//  List<AmountToEat> amountToEatList;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  FoodStuffFB({
    @required this.foodStuffId,
    @required this.userId,
    @required this.imageUrl,
    @required this.imageStoragePath,
    @required this.name,
    @required this.category,
    @required this.validDate,
    @required this.storage,
    @required this.amount,
    @required this.useAmount,
    @required this.restAmount,
  });

@override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is FoodStuffFB &&
              runtimeType == other.runtimeType &&
              foodStuffId == other.foodStuffId &&
              userId == other.userId &&
              imageUrl == other.imageUrl &&
              imageStoragePath == other.imageStoragePath &&
              name == other.name &&
              category == other.category &&
              validDate == other.validDate &&
              storage == other.storage &&
              amount == other.amount &&
              useAmount == other.useAmount &&
              restAmount == other.restAmount
          );


  @override
  int get hashCode =>
      foodStuffId.hashCode ^
      userId.hashCode ^
      imageUrl.hashCode ^
      imageStoragePath.hashCode ^
      name.hashCode ^
      category.hashCode ^
      validDate.hashCode ^
      storage.hashCode ^
      amount.hashCode ^
      useAmount.hashCode ^
      restAmount.hashCode;


  @override
  String toString() {
    return 'FoodStuffFB{' +
        ' foodStuffId: $foodStuffId,' +
        ' userId: $userId,' +
        ' imageUrl: $imageUrl,' +
        ' imageStoragePath: $imageStoragePath,' +
        ' name: $name,' +
        ' category: $category,' +
        ' validDate: $validDate,' +
        ' storage: $storage,' +
        ' amount: $amount,' +
        ' useAmount: $useAmount,' +
        ' restAmount: $restAmount,' +
        '}';
  }


  FoodStuffFB copyWith({
    String foodStuffId,
    String userId,
    String imageUrl,
    String imageStoragePath,
    String name,
    String category,
    DateTime validDate,
    String storage,
    int amount,
    int useAmount,
    int restAmount,
  }) {
    return new FoodStuffFB(
      foodStuffId: foodStuffId ?? this.foodStuffId,
      userId: userId ?? this.userId,
      imageUrl: imageUrl ?? this.imageUrl,
      imageStoragePath: imageStoragePath ?? this.imageStoragePath,
      name: name ?? this.name,
      category: category ?? this.category,
      validDate: validDate ?? this.validDate,
      storage: storage ?? this.storage,
      amount: amount ?? this.amount,
      useAmount: useAmount ?? this.useAmount,
      restAmount: restAmount ?? this.restAmount,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'foodStuffId': this.foodStuffId,
      'userId': this.userId,
      'imageUrl': this.imageUrl,
      'imageStoragePath': this.imageStoragePath,
      'name': this.name,
      'category': this.category,
      'validDate': this.validDate.toIso8601String(),
      'storage': this.storage,
      'amount': this.amount,
      'useAmount': this.useAmount,
      'restAmount': this.restAmount,
    };
  }

  factory FoodStuffFB.fromMap(Map<String, dynamic> map) {
    return new FoodStuffFB(
      foodStuffId: map['foodStuffId'] as String,
      userId: map['userId'] as String,
      imageUrl: map['imageUrl'] as String,
      imageStoragePath: map['imageStoragePath'] as String,
      name: map['name'] as String,
      category: map['category'] as String,
//      validDate: map['validDate'] as DateTime,
      validDate: map['validDate']==null
        ? null
        : DateTime.parse(map['validDate'] as String),
      storage: map['storage'] as String,
      amount: map['amount'] as int,
      useAmount: map['useAmount'] as int,
      restAmount: map['restAmount'] as int,
    );
  }


  //</editor-fold>




}
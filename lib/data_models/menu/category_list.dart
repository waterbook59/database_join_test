
import 'package:datebasejointest/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//todo DB登録する時はidは自動(auto increment)へ変更
List<Category> categories = [
  Category(
    id: 1,
    categoryText: '水・ジュース',
    ///CategorySelectScreenのアイコン
    categoryIcon: Icon(Icons.local_drink),
    isSelected: false,
  ),
  Category(
    id: 2,
    categoryText: 'ごはん',
    categoryIcon: Icon(Icons.airplanemode_active),
    //Icon(IconData(59789)),
    isSelected: false,
  ),
  Category(
    id: 3,
    categoryText: 'パン',
    categoryIcon: const FaIcon(FontAwesomeIcons.breadSlice),
    isSelected: false,
  ),
  Category(
    id: 4,
    categoryText: '汁物・スープ',
    categoryIcon: Icon(Icons.extension),
    //const Icon(IconData(59607)),
    isSelected: false,
  ),
  Category(
    id: 5,
    categoryText: 'おかず',
    categoryIcon: Icon(Icons.assignment_returned),
    isSelected: false,
  ),
  Category(
    id: 6,
    categoryText: '缶詰',
    categoryIcon: Icon(Icons.audiotrack),
    isSelected: false,
  ),





];

class Category {
  Category(
      {this.mealType,
        this.id,
        this.categoryText,
        this.categoryIcon,
        this.isSelected});

  final MealType mealType;
  final int id;
  final String categoryText;
  final Widget categoryIcon;
  final bool isSelected;
}

//テキスト
List<String> categoryText = [
  '水・ジュース',
  'ごはん',
  'パン',
  '汁物・スープ',
  'おかず',
  '缶詰',
//  '果物',
//  'おやつ',
//  'その他',
];
//上のテキストに対応したアイコン
///アコーディオンメニューに出てくるアイコン
List<Widget> categoryIcon = [
  Icon(Icons.local_drink),
  Icon(Icons.airplanemode_active),
  // Icon(IconData(59789)), //rice_bowl
  FaIcon(FontAwesomeIcons.breadSlice),
  Icon(Icons.extension),
  Icon(Icons.assignment_returned),
  Icon(Icons.audiotrack),

  // Icon(IconData(59607)), //outdoor_grill)
];

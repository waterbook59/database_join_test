import 'package:datebasejointest/utils/constants.dart';

class FoodStuff{
  String foodstuffId;//UuidでつけるかautoIncrement
  String localImagePath;//カメラ・ギャラリーのイメージパス_File(localImagePath.path)で呼び出す
  String imageUrl;//network経由のproductImage
  String name;
  String category;
  String validDate;
  String storage;//保管場所
  int amount;//総量
  int useAmount;//メニュー内で使う量
  int restAmount;//メニュー内に登録してない量
//○日目の朝には○個食べるという量が必要
  List<AmountToEat> amountToEat;

}

class AmountToEat {
  String foodstuffId;
  String amountToEatId;
  String date;//何日目
  MealType mealType;//朝食、昼食、間食、夕食
  int piece;//個数
}


import 'package:moor/moor.dart';

part 'food_stuff_database.g.dart';

//テーブルfood_stuff
class FoodStuff extends Table{
  TextColumn get foodstuffId => text()();
  TextColumn get localImagePath => text()();
  TextColumn get name => text()();
  TextColumn get category => text().nullable()();
  TextColumn get storage => text().nullable()();
  DateTimeColumn get validDate => dateTime().nullable()();
  IntColumn get amount =>integer()();
  IntColumn get useAmount=>integer().nullable()();//todo メニュー内で使う量、初期ゼロ
  IntColumn get restAmount=>integer().nullable()();//todo メニューで使ってない量、初期amountと同じ

  @override
  Set<Column> get primaryKey => {foodstuffId};
}

//テーブルamountToEat
class AmountToEat extends Table{
  TextColumn get foodstuffId => text()();
  TextColumn get amountToEatId => text()();
  TextColumn get date => text()();//何日目
  TextColumn get mealType => text()();//todo 朝食、昼食、間食、夕食
  IntColumn get piece =>integer().nullable()();//個数

  @override
  Set<Column> get primaryKey => { amountToEatId};
}






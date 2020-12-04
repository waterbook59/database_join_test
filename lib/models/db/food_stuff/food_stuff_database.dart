

import 'package:moor/moor.dart';

//part 'food_stuff_database.g.dart';

//テーブルfood_stuff
class FoodStuffRecord extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get foodStuffId => text()();
  TextColumn get localImagePath => text()();
  TextColumn get name => text()();
  TextColumn get category => text().nullable()();
  TextColumn get storage => text().nullable()();
  DateTimeColumn get validDate => dateTime().nullable()();
  IntColumn get amount =>integer()();
  IntColumn get useAmount=>integer().withDefault(const Constant(0))();// メニュー内で使う量、初期ゼロ
  IntColumn get restAmount=>integer().withDefault(amount)();// メニューで使ってない量、初期amountと同じ

  @override
  Set<Column> get primaryKey => {id};
}

//テーブルamountToEat
class AmountToEatRecord extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get foodStuffId => text()();
  TextColumn get amountToEatId => text()();
  TextColumn get date => text()();//何日目
  TextColumn get mealType => text()();//todo 朝食、昼食、間食、夕食
  IntColumn get piece =>integer().nullable()();//個数

  @override
  Set<Column> get primaryKey => {id};
}

//テーブル categoryList
class CategoryListRecord extends Table{

}

//テーブルdayMenuList
class DayMenuListRecord extends Table{

}





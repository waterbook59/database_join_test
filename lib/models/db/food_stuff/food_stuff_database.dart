

import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as q;

import 'food_stuff_dao.dart';
part 'food_stuff_database.g.dart';

//テーブルfood_stuff
class FoodStuffRecords extends Table{
//  IntColumn get id => integer().autoIncrement().customConstraint('PRIMARY KEY ON CONFLICT REPLACE')as IntColumn;
  IntColumn get id =>integer().autoIncrement()();
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
class AmountToEatRecords extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get foodStuffId => text()();
  TextColumn get amountToEatId => text()();
  TextColumn get date => text()();//何日目
  TextColumn get mealType => text()();//todo 朝食、昼食、間食、夕食
  IntColumn get piece =>integer().nullable()();//個数

  @override
  Set<Column> get primaryKey => {id};
}

///テーブル categoryList=>MenuDB
//class CategoryListRecord extends Table{
//}

///テーブルdayMenuList=>MenuDB
//class DayMenuListRecord extends Table{
//}


@UseMoor(tables:[FoodStuffRecords,AmountToEatRecords],daos: [FoodStuffDao])
class FoodStuffDB extends _$FoodStuffDB {

  FoodStuffDB() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    //下はpath_providerの一般的な書き方
    final file = File(q.join(dbFolder.path, 'food_stuff.db'));
    return VmDatabase(file);
  });
}



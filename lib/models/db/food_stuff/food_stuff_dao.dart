
import 'package:moor/moor.dart';
//自分で追加
import 'package:datebasejointest/models/db/food_stuff/food_stuff_database.dart';

part 'food_stuff_dao.g.dart';

@UseDao(tables:[FoodStuffRecords,AmountToEatRecords])
class FoodStuffDao extends DatabaseAccessor<FoodStuffDB> with _$FoodStuffDaoMixin {
  FoodStuffDao(FoodStuffDB foodStuffDB) : super(foodStuffDB);

  //挿入
  Future<void> addFoodStuff( FoodStuffRecord foodStuffRecord) =>into(foodStuffRecords).insert(foodStuffRecord);
  //読込
  Future<List<FoodStuffRecord>> get allFoodStuffs => select(foodStuffRecords).get();
  //削除

}
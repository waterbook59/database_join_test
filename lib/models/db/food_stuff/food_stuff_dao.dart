import 'package:moor/moor.dart';

//自分で追加
import 'package:datebasejointest/models/db/food_stuff/food_stuff_database.dart';

part 'food_stuff_dao.g.dart';

@UseDao(tables: [FoodStuffRecords, AmountToEatRecords])
class FoodStuffDao extends DatabaseAccessor<FoodStuffDB>
    with _$FoodStuffDaoMixin {
  ///コンストラクタをfoodStuffDBにしたらg.dartが
  ///foodStuffDB.foodStuffRecordsではなく、attachedDatabase.foodStuffRecords;になっている
  FoodStuffDao(FoodStuffDB attachedDatabase) : super(attachedDatabase);

//  FoodStuffDao(FoodStuffDB foodStuffDB) : super(foodStuffDB);

  //挿入
  Future<void> addFoodStuff(FoodStuffRecord foodStuffRecord) =>
      into(foodStuffRecords).insert(foodStuffRecord);

  //読込
  Future<List<FoodStuffRecord>> get allFoodStuffs =>
      select(foodStuffRecords).get();

  //削除 todo ローカル保存した時のコピーの画像まで削除できているのかpathを消してもImage.copyは残るのでは
  Future<void> deleteFoodStuff(FoodStuffRecord foodStuffRecord) =>
      (delete(foodStuffRecords)
            ..where((t) => t.foodStuffId.equals(foodStuffRecord.foodStuffId)))
          .go();
}

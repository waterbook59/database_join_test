
import 'package:moor/moor.dart';
//自分で追加
import 'package:datebasejointest/models/db/product_info/product_info_database.dart';

part 'product_info_dao.g.dart';


@UseDao(tables:[ProductRecords,ProductRecordImages,ProductWithImages])
class ProductInfoDao extends DatabaseAccessor<MyProductInfoDB> with _$ProductInfoDaoMixin {
  ProductInfoDao(MyProductInfoDB infoDB) : super(infoDB);

  ///1.extension:List<Product>=>List<ProductRecord>,List<ProductRecordImages>に分ける
  ///2.dao:分けた２つのリストをそれぞれDB格納
  // 格納する前にDBをclear

  Future<void> clearProductDB() {
    return delete(productRecords).go();
  }

  Future<void> clearImageDB() {
    return delete(productRecordImages).go();
  }

  Future<void> insertProductDB(List<ProductRecord> products) async {
    //2行以上なのでbatch
    await batch((batch) {
      batch.insertAll(productRecords, products);
    });
  }

  Future<void> insertImageDB(List<ProductRecordImage> productImages) async {
    //2行以上なのでbatch
    await batch((batch) {
      batch.insertAll(productRecordImages, productImages);
    });
  }

  ///3.dao:２つに分けたリストを内部結合して読込＆JoinedProductクラスのリストとして格納

  Future<List<JoinedProduct>> getJoinedProduct()  async{
    final query = select(productRecords).join([
      innerJoin(productRecordImages,
          productRecordImages.productId.equalsExp(productRecords.productId)),
    ]);
    //print('query:${query.toString()}'); //queryはJoinedSelectStatement
    final rows = await query.get();
    var data = rows.map((resultRow) {
              return JoinedProduct(
          productRecord: resultRow.readTable(productRecords),
          productRecordImage: resultRow.readTable(productRecordImages),
        );
    }).toList();
    return data;


//    return (query.get() as List<TypedResult>).map((typedResult) {
////    print('typedResult:${typedResult.toString()}');
////      return rows.map((row) {
//        return JoinedProduct(
//          productRecord: typedResult.readTable(productRecords),
//          productRecordImage: typedResult.readTable(productRecordImages),
//        );
//      }).toList();
//    });
  }


    ///query.get()だけしてみる
    Future<List<TypedResult>> getJoinedTable() async {
      final query = select(productRecords).join([
        innerJoin(productRecordImages,
            productRecordImages.productId.equalsExp(productRecords.productId)),
      ]);

      return query.get();
    }


    ///２つのテーブル格納と内部結合読込＆リスト格納をtransactionでまとめる
    ///(transactionならtry-catch何回も書かなくて楽ちん）
    Future<List<JoinedProduct>> insertAndJoinFromDB(
        List<ProductRecord> products, List<ProductRecordImage> productImages) =>
        transaction(() async {
          await clearProductDB();
          await clearImageDB();
          await insertProductDB(products);
          await insertImageDB(productImages);
          return getJoinedProduct();
        });


    Future<void> insertDB(List<ProductRecord> products,
        List<ProductRecordImage> productImages) =>
        transaction(() async {
          await clearProductDB();
          await clearImageDB();
          await insertProductDB(products);
          await insertImageDB(productImages);
        });


    Future<List<TypedResult>> insertAndTableDB(List<ProductRecord> products,
        List<ProductRecordImage> productImages) =>
        transaction(() async {
          await clearProductDB();
          await clearImageDB();
          await insertProductDB(products);
          await insertImageDB(productImages);
          return getJoinedTable();
        });
  }


///
///repository:読込んだ結果を格納
///extension:読込んだリストをList<Product>へ変換(toProduct<リストたち>）


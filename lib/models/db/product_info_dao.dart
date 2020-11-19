
import 'package:moor/moor.dart';
//自分で追加
import 'package:datebasejointest/models/db/product_info_database.dart';

part 'product_info_dao.g.dart';

//todo UseDaoにクエリ書いてみていろいろ内部結合してみる
@UseDao(tables:[ProductRecords,ProductRecordImages,ProductWithImages])
class ProductInfoDao extends DatabaseAccessor<MyProductInfoDB> with _$ProductInfoDaoMixin{
  ProductInfoDao(MyProductInfoDB infoDB) : super(infoDB);

///1.extension:List<Product>=>List<ProductRecord>,List<ProductRecordImages>に分ける
///2.dao:分けた２つのリストをそれぞれDB格納
  //todo 格納する前にDBをclear
Future<void> insertProductDB(List<ProductRecord> productRecords)async{
  //2行以上なのでbatch
  await batch((batch) {
    batch.insertAll(productRecords, productRecords);
  });
}

Future<void> insertImageDB(List<ProductRecordImage> productImages)async{
    //2行以上なのでbatch
    await batch((batch) {
      batch.insertAll(productRecordImages, productImages);
    });
  }

///3.dao:２つに分けたリストを内部結合して読込＆JoinedProductクラスのリストとして格納

Future<List<JoinedProduct>> getJoinedProduct() async{

  final query = select(productRecords).join([
    innerJoin(productRecordImages, productRecordImages.productId.equalsExp(productRecords.productId)),
  ]);
//  print('query:$query');
  return  (query.get() as List<TypedResult>) .map((typedResult){
//    return (typedResult ).map((row){
      return  JoinedProduct(
        productRecord: typedResult.readTable(productRecords),
        productRecordImage: typedResult.readTable(productRecordImages),
      );
//    })
//
    }).toList();
  //todo List<JoinedProduct>をList<Product>として返すのはあり？

  }

  ///２つのテーブル格納と内部結合読込＆リスト格納をtransactionでまとめる
  ///(transactionならtry-catch何回も書かなくて楽ちん）
  Future<List<JoinedProduct>> insertAndJoinFromDB(
      List<ProductRecord> productRecords,List<ProductRecordImage> productImages)=>
      transaction(()async{
        await insertProductDB();
        await insertImageDB();
        await getJoinedProduct();
      });


}




///
///repository:読込んだ結果を格納
///extension:読込んだリストをList<Product>へ変換(toProduct<リストたち>）

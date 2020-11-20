
import 'package:datebasejointest/data_models/product.dart';
import 'package:datebasejointest/main.dart';
import 'package:datebasejointest/models/db/product_info_database.dart';
import 'package:datebasejointest/utils/extensions.dart';
import 'package:moor/moor.dart';//TypedResult用にインポート

class HomeRepository{

  Future<List<Product>> getProductInfo(List<Product> products) async{

//    var products = <Product>[];
    var productRecords = <ProductRecord>[];
    var productRecordImages = <ProductRecordImage>[];
    //main.dartに設定
    final productInfoDao = myProductInfoDB.productInfoDao;
    //List<JoinedProduct>を想定
    var results = <JoinedProduct>[];
    var joinTable = <TypedResult>[];

    try{
      //2.モデルクラス(List<Product>)をDBのテーブルクラスへ変換
      productRecords = products.toProductRecord(products).cast<ProductRecord>();
      productRecordImages =
          products.toProductRecordImage(products).cast<ProductRecordImage>();
      print('products:$products');
      print('productRecords:$productRecords');
      print('productRecordImages:$productRecordImages');
      //todo 3.2つのテーブルをDBへinsert&結合クラスに変換・読込
      await productInfoDao.insertDB(productRecords, productRecordImages);
//      joinTable =await productInfoDao.insertAndTableDB(productRecords, productRecordImages);
//      print('query.getの結果：${joinTable.toString()}');
      //結合(getJoinedProduct())のところでエラー:transactionの中でtransactionを行ってはいけない？
      results = await productInfoDao.getJoinedProduct();
      print('List<JoinedProduct:${results[3].productRecord.description}>');

    }on Exception catch (error) {
      print('error:$error');
    }
    return products;


  }

}
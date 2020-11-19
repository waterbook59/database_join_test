
import 'package:datebasejointest/data_models/product.dart';
import 'package:datebasejointest/main.dart';
import 'package:datebasejointest/models/db/product_info_database.dart';
import 'package:datebasejointest/utils/extensions.dart';

class HomeRepository{

  Future<List<Product>> getProductInfo(List<Product> products) async{
//    var products = <Product>[];
    var productRecords = <ProductRecord>[];
    var productRecordImages = <ProductRecordImage>[];
    //main.dartに設定
    final productInfoDao = myProductInfoDB.productInfoDao;
    //List<JoinedProduct>を想定
    var results = <JoinedProduct>[];

    //2.モデルクラス(List<Product>)をDBのテーブルクラスへ変換
    productRecords = products.toProductRecord(products).cast<ProductRecord>();
    productRecordImages =
        products.toProductRecordImage(products).cast<ProductRecordImage>();

    //todo 3.2つのテーブルをDBへinsert(transactionで書いても良い)


    //4.DBの結合用モデルクラス(List<JoinedProduct>)に変換されたリストを読込
    results = await productInfoDao.getJoinedProduct();
    print('List<JoinedProduct:$results>');

  }

}
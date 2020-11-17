
import 'package:datebasejointest/data_models/product.dart';
import 'package:datebasejointest/models/db/product_info_database.dart';
import 'package:datebasejointest/utils/extensions.dart';

class HomeRepository{
  Future<List<Product>> getProductInfo(List<Product> products) async{
//    var products = <Product>[];
    var productRecords = <ProductRecord>[];
    var productRecordImages = <ProductRecordImage>[];

    //2.モデルクラス(List<Product>)をDBのテーブルクラスへ変換
    productRecords = products.toProductRecord(products).cast<ProductRecord>();
    productRecordImages =
        products.toProductRecordImage(products).cast<ProductRecordImage>();

    //3.DBのテーブルクラス(List<ProductRecord>)に変換したリストでDBに登録・読込

  }

}
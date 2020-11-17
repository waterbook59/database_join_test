
import 'package:datebasejointest/data_models/product.dart';

class HomeRepository{
  Future<List<Product>> getProductInfo(List<Product> products) async{
//    var products = <Product>[];
    var productRecords = <ProductRecord>[];
    var productRecordImages = <ProductRecordImage>[];

    productRecords = products.toProductRecord(products).cast<ProductRecord>();
    productRecordImages =
        products.toProductRecordImage(products).cast<ProductRecordImage>();
  }

}
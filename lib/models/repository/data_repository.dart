
import 'dart:io';

import 'package:datebasejointest/data_models/product.dart';
import 'package:datebasejointest/main.dart';
import 'package:datebasejointest/models/db/product_info_database.dart';
import 'package:datebasejointest/utils/extensions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moor/moor.dart';//TypedResult用にインポート
import 'package:datebasejointest/models/db/product_info_dao.dart';

class DataRepository{
//diあり
  DataRepository({productInfoDao}) :
      _productInfoDao = productInfoDao;
final ProductInfoDao _productInfoDao;

  //diなし main.dartに設定
//    final productInfoDao = myProductInfoDB.productInfoDao;

  Future<List<Product>> getProductInfo(List<Product> products) async{

//    var products = <Product>[];
    var productRecords = <ProductRecord>[];
    var productRecordImages = <ProductRecordImage>[];



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
      /// 3.2つのテーブルをDBへinsert
      await _productInfoDao.insertDB(productRecords, productRecordImages);
//      joinTable =await productInfoDao.insertAndTableDB(productRecords, productRecordImages);
//      print('query.getの結果：${joinTable.toString()}');
      ///4.テーブル内部結合してJoinedProductへ格納＆読込(transactionの中でやるとエラーなので上のinsertと切り離して実施）
      results = await _productInfoDao.getJoinedProduct();
//      print('List<JoinedProduct:${results[3].productRecord.description}>');
      ///5.JoinedProductクラスに格納されたデータをProductへ再格納して返す(extensions:)
      products = results.toProduct(results);

    }on Exception catch (error) {
      print('error:$error');
    }
    return products;
  }

  Future<File> getImageFromCamera() async{
    final imagePicker = ImagePicker();
    final cameraImageFile = await imagePicker.getImage(source: ImageSource.camera);
    return File(cameraImageFile.path);
  }

  Future<File> getImageFromGallery() async{
    final imagePicker = ImagePicker();
    final galleryPickedFile =
    await imagePicker.getImage(source: ImageSource.gallery);
    return File(galleryPickedFile.path);
  }


  //todo 登録
  Future<void> registerProductData() async{
    print('registerProductDataで商品情報登録');
  }




}
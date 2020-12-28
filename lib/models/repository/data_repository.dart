import 'dart:async';
import 'dart:io';

import 'package:datebasejointest/data_models/menu/food_stuff.dart';
import 'package:datebasejointest/data_models/product.dart';
import 'package:datebasejointest/models/db/food_stuff/food_stuff_dao.dart';
import 'package:datebasejointest/models/db/product_info/product_info_database.dart';
import 'package:datebasejointest/utils/extensions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart'; //TypedResult用にインポート
import 'package:datebasejointest/models/db/product_info/product_info_dao.dart';

class DataRepository {
//diあり
  DataRepository({ProductInfoDao productInfoDao, FoodStuffDao foodStuffDao})
      : _productInfoDao = productInfoDao,
        _foodStuffDao = foodStuffDao;
  final ProductInfoDao _productInfoDao;
  final FoodStuffDao _foodStuffDao;

  //diなし main.dartに設定
//    final productInfoDao = myProductInfoDB.productInfoDao;

  Future<List<Product>> getProductInfo(List<Product> products) async {
//    var products = <Product>[];
    var productRecords = <ProductRecord>[];
    var productRecordImages = <ProductRecordImage>[];

    //List<JoinedProduct>を想定
    var results = <JoinedProduct>[];
//    final joinTable = <TypedResult>[];

    try {
      //2.モデルクラス(List<Product>)をDBのテーブルクラスへ変換
      productRecords = products.toProductRecord(products).cast<ProductRecord>();
      productRecordImages =
          products.toProductRecordImage(products).cast<ProductRecordImage>();
//      print('products:$products');
//      print('productRecords:$productRecords');
//      print('productRecordImages:$productRecordImages');

      /// 3.2つのテーブルをDBへinsert
      await _productInfoDao.insertDB(productRecords, productRecordImages);
//      joinTable =await productInfoDao
//      .insertAndTableDB(productRecords, productRecordImages);
//      print('query.getの結果：${joinTable.toString()}');
      ///4.テーブル内部結合してJoinedProductへ格納＆読込
      ///(transactionの中でやるとエラーなので上のinsertと切り離して実施）
      results = await _productInfoDao.getJoinedProduct();
//      print('List<JoinedProduct:${results[3].productRecord.description}>');
      ///5.JoinedProductクラスに格納されたデータをProductへ再格納して返す(extensions:)
      products = results.toProduct(results);
    } on Exception catch (error) {
      print('error:$error');
    }
    return products;
  }

//todo FutureOr<File>で対応可能か調べる
  Future<File> getImageFromCamera() async {
    final imagePicker = ImagePicker();
    final cameraImageFile =
        await imagePicker.getImage(source: ImageSource.camera);

    ///if (pickedFile != null)を記述しておかないと、
    ///カメラ起動後「キャンセル」を押した際にエラーになってしまう!!
    if (cameraImageFile != null) {
      return File(cameraImageFile.path);
    }
  }

  Future<File> getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final galleryPickedFile =
        await imagePicker.getImage(source: ImageSource.gallery);

    ///if (pickedFile != null)を記述しておかないと、
    ///画像ライブラリの選択画面で「キャンセル」を押した際にエラーになってしまう!!
    if (galleryPickedFile != null) {
      return File(galleryPickedFile.path);
    }
  }

  //登録,viewModelでモデルクラスを作る形へ変更
  Future<void> registerProductData(FoodStuff foodStuff) async {
    try {
      final foodStuffRecord = foodStuff.toFoodStuffRecord(foodStuff);
//      print('foodStuffRecordへ変換後のid：${foodStuffRecord.id}/${foodStuffRecord.restAmount}');
      await _foodStuffDao.addFoodStuff(foodStuffRecord);
    } on SqliteException catch (e) {
      print("repositoryでのエラー：${e.toString()}");
    }
  }

  Future<List<FoodStuff>> getFoodStuffList() async {
    final resultRecords = await _foodStuffDao.allFoodStuffs;
    var results = resultRecords.toFoodStuffs(resultRecords);
    return results;
  }

  Future<void> deleteFoodStuff(FoodStuff foodStuff) async {
    final foodStuffRecord = foodStuff.toFoodStuffRecord(foodStuff);
    await _foodStuffDao.deleteFoodStuff(foodStuffRecord);
  }
}

import 'package:datebasejointest/data_models/menu/food_stuff.dart';
import 'package:datebasejointest/data_models/product.dart';
import 'package:datebasejointest/data_models/product_image.dart';
import 'package:datebasejointest/models/db/food_stuff/food_stuff_database.dart';
//自分で追加
import 'package:datebasejointest/models/db/product_info/product_info_database.dart';
import 'package:uuid/uuid.dart';

///一つのリスト(List<Product>)に対してキーを加えて２つのリストへ変換する作業
extension ConvertToProductRecord on List<Product>{

  List<ProductRecord> toProductRecord(List<Product> products) {
    final productRecords = <ProductRecord>[];
//    final productId = Uuid().v1();

    ///List<Product>を一つ一つProductRecordとProductImageRecordに分解する
    products.forEach((product) {
      productRecords.add(
        ProductRecord(
          productId: product.productId ?? '',
          name: product.name ?? '',
          description: product.description ?? '',
        ),
      );
    });
    return productRecords;
  }

  ///productIdは引継ぎつつ、imageIdを新たに追加
  List<ProductRecordImage> toProductRecordImage(List<Product> products) {
    final productRecordImages = <ProductRecordImage>[];
    products.forEach((product) {
      productRecordImages.add(
          ProductRecordImage(
            productId: product.productId ?? '',
            imageId: Uuid().v1() ?? '',
            small: product.productImage.small ?? '',
            medium: product.productImage.medium ?? '',
          )
      );
    });
    return productRecordImages;
  }

}

///JoinedProductをモデルクラスのProductへ変換する作業
extension ConvertToProduct on List<JoinedProduct>{

  List<Product> toProduct(List<JoinedProduct> joinedProducts) {
    final products = <Product>[];
    joinedProducts.forEach((joinedProduct) {
    products.add(
        Product(
          productId: joinedProduct.productRecord.productId,
          name: joinedProduct.productRecord.name,
          productImage: ProductImage(
            small: joinedProduct.productRecordImage.small,
            medium: joinedProduct.productRecordImage.medium,
          ),
          description: joinedProduct.productRecord.description,
        )
    );
    });
    return products;
        }
}

///FoodStuff=>DBテーブルクラス(foodStuffRecord)へ変換
extension ConvertToFoodStuffRecord on FoodStuff{

  FoodStuffRecord toFoodStuffRecord(FoodStuff foodStuff){

    var foodStuffRecord = FoodStuffRecord(
      foodStuffId:foodStuff.foodStuffId ?? "",
      localImagePath: foodStuff.localImagePath ?? "",
      name: foodStuff.name ?? "",
      category: foodStuff.category ?? "",
      storage: foodStuff.storage ?? "",
      validDate: foodStuff.validDate,
      amount: foodStuff.amount ??0,
      useAmount: foodStuff.useAmount ?? 0,
      restAmount: foodStuff.restAmount ?? 0,
    );
    return foodStuffRecord;
  }
}

import 'package:datebasejointest/data_models/product.dart';
//自分で追加
import 'package:datebasejointest/models/db/product_info_database.dart';
import 'package:uuid/uuid.dart';

///一つのリストに対してキーを加えて２つのリストへ変換する作業
extension ConvertToProductRecord on List<Product>{

  List<ProductRecord> toProductRecord(List<Product> products) {
    final productRecords = <ProductRecord>[];
//    final productId = Uuid().v1();

    ///List<Product>を一つ一つProductRecordとProductImageRecordに分解する
    products.map((product) {
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
    products.map((product) {
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
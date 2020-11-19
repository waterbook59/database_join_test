import 'package:datebasejointest/data_models/product.dart';
import 'package:datebasejointest/data_models/product_image.dart';
import 'package:uuid/uuid.dart';

List<Product> variableProducts = [
  Product(
      productId: Uuid().v1(),
      name: 'クリアクリーン美白ハミガキ',
      description: 'すごい美白ハミガキ',
      productImage: ProductImage(
        small: '美白ハミガキ小画像',
        medium: '美白ハミガキ中画像',
      )
  ),
  Product(
      productId: Uuid().v1(),
      name: '尾西のおかゆ',
      description: 'すごいおかゆ',
      productImage: ProductImage(
        small: 'おかゆ小画像',
        medium: 'おかゆ中画像',
      )
  ),
  Product(
      productId: Uuid().v1(),
      name: 'クレイモアバッテリー',
      description: 'すごいバッテリー',
      productImage: ProductImage(
        small: 'バッテリー小画像',
        medium: 'バッテリー中画像',
      )
  ),
  Product(
      productId: Uuid().v1(),
      name: 'スマホ',
      description: 'すごいスマホ',
      productImage: ProductImage(
        small: 'スマホ小画像',
        medium: 'スマホ中画像',
      )
  ),

];
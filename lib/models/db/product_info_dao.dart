
import 'package:moor/moor.dart';
//自分で追加
import 'package:datebasejointest/models/db/product_info_database.dart';

part 'product_info_dao.g.dart';

@UseDao(tables:[ProductRecords,ProductRecordImages,ProductWithImages])
class ProductInfoDao extends DatabaseAccessor<MyProductInfoDB> with _$ProductInfoDaoMixin{
  ProductInfoDao(MyProductInfoDB infoDB) : super(infoDB);


}
import 'dart:io';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as q;
//自分で追加
import 'package:datebasejointest/models/db/product_info/product_info_dao.dart';
part 'product_info_database.g.dart';

//テーブルProductRecords
class ProductRecords extends Table{
  TextColumn get productId => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();

  @override
  Set<Column> get primaryKey => {productId};
}

//テーブルProductRecordImages
class ProductRecordImages extends Table{
  TextColumn get productId => text()();
  TextColumn get imageId => text()();
  TextColumn get small => text()();
  TextColumn get medium => text()();

  @override
  Set<Column> get primaryKey => {imageId};
}

//結合用テーブルは使わない
class ProductWithImages extends Table{
  IntColumn get idProductWithImage => integer().autoIncrement()();
  TextColumn get product => text()();
  TextColumn get image => text()();
}

///テーブルじゃなくてクラス
class JoinedProduct{
  final ProductRecord productRecord;
  final ProductRecordImage productRecordImage;
  // ignore: sort_constructors_first
  JoinedProduct({this.productRecord,this.productRecordImage});
}


@UseMoor(tables:[ProductRecords,ProductRecordImages,ProductWithImages],daos:[
  ProductInfoDao])
class MyProductInfoDB extends _$MyProductInfoDB {
  MyProductInfoDB() : super(_openConnection());


  @override
  int get schemaVersion => 1;

}

LazyDatabase _openConnection() {

  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    //下はpath_providerの一般的な書き方
    final file = File(q.join(dbFolder.path, 'product_info.db'));
    return VmDatabase(file);
  });
}
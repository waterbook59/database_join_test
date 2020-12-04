import 'package:datebasejointest/models/db/product_info/product_info_dao.dart';
import 'package:datebasejointest/models/repository/data_repository.dart';
import 'package:datebasejointest/view_model/category_select_view_model.dart';
import 'package:datebasejointest/view_model/data_registration_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:datebasejointest/models/db/product_info/product_info_database.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];


List<SingleChildWidget> independentModels =[
  Provider<MyProductInfoDB>(
    create: (_)=>MyProductInfoDB(),
    dispose: (_,db) =>db.close(),
  ),
  //  Provider<ProductApiService>(
//    create: (_)=>ProductApiService.create(),
//    dispose: (_, productApiService)=>productApiService.dispose(),
//  ),
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<MyProductInfoDB,ProductInfoDao>(
    update: (_, db, dao)=>ProductInfoDao(db),
  ),
//  ProxyProvider<ProductInfoDao,MenuRepository>(
//    update: (_, dao, repository)=>MenuRepository(productInfoDao: dao),
//  ),

//todo Proxyprovider2にしてApiService加える,
//todo もっと進んだらApiService,ProductInfoDao,FoodStuffDaoをDataRepositoryにまとめる
  ProxyProvider<ProductInfoDao,DataRepository>(
    update: (_, dao, repository)=>DataRepository(productInfoDao: dao),
  ),

//todo menuRepository=>database
//  ProxyProvider<ProductApiService,BarcodeRepository>(
//    update: (_, productApiService, repository)=>BarcodeRepository(
//        productApiService: productApiService),
//  ),
];

//chapter98 RepositoryにChangeNotifierProxyProvider
List<SingleChildWidget> viewModels =[

  //todo カテゴリや使う商品と登録データを紐づけるので、repositoryはDataRepositoryに集約
  ChangeNotifierProvider<CategorySelectViewModel>(
    create: (context)=> CategorySelectViewModel(
      repository:Provider.of<DataRepository>(context, listen: false),
    ),
  ),
  ChangeNotifierProvider<DataRegistrationViewModel>(
    create: (context)=> DataRegistrationViewModel(
      repository:Provider.of<DataRepository>(context, listen: false),
    ),
  ),


];

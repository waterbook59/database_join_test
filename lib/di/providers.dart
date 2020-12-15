import 'package:datebasejointest/models/db/database_manager.dart';
import 'package:datebasejointest/models/db/food_stuff/food_stuff_dao.dart';
import 'package:datebasejointest/models/db/food_stuff/food_stuff_database.dart';
import 'package:datebasejointest/models/db/product_info/product_info_dao.dart';
import 'package:datebasejointest/models/repository/data_repository.dart';
import 'package:datebasejointest/models/repository/user_repository.dart';
import 'package:datebasejointest/view_model/login_viewModel.dart';
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
  Provider<FoodStuffDB>(
    create: (_)=>FoodStuffDB(),
    dispose: (_,db) =>db.close(),
  ),
  ///fireStore前におく
  Provider<DatabaseManager>(
    create: (_)=>DatabaseManager(),
  )

  //  Provider<ProductApiService>(
//    create: (_)=>ProductApiService.create(),
//    dispose: (_, productApiService)=>productApiService.dispose(),
//  ),
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<MyProductInfoDB,ProductInfoDao>(
    update: (_, db, dao)=>ProductInfoDao(db),
  ),
  ProxyProvider<FoodStuffDB,FoodStuffDao>(
    update: (_, db, dao)=>FoodStuffDao(db),
  ),
  ///Firebase_authログイン関連
  ProxyProvider<DatabaseManager,UserRepository >(
    update: (_, dbManager, userRepo)=>UserRepository(databaseManager: dbManager),
  ),
//  ProxyProvider<ProductInfoDao,MenuRepository>(
//    update: (_, dao, repository)=>MenuRepository(productInfoDao: dao),
//  ),

//todo Proxyprovider2にしてFoodStuffDao加える,
//todo Proxyprovider2にしてApiService加える,
//todo Proxyprovider3にしてApiService,ProductInfoDao,FoodStuffDaoをDataRepositoryにまとめる
  ProxyProvider2<ProductInfoDao,FoodStuffDao,DataRepository>(
    update: (_, productDao, foodDao,repository)=>
        DataRepository(productInfoDao: productDao,foodStuffDao:foodDao),
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
  ///Firebase_auth匿名ログイン関連
  ChangeNotifierProvider<LoginViewModel>(
    create: (context)=>LoginViewModel(
      userRepository: Provider.of<UserRepository>(context, listen: false),
    ),
  )

];

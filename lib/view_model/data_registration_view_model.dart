import 'dart:io';

import 'package:datebasejointest/data_models/menu/food_stuff.dart';
import 'package:datebasejointest/data_models/product.dart';
import 'package:datebasejointest/models/repository/data_repository.dart';
import 'package:datebasejointest/utils/constants.dart';
import 'package:datebasejointest/utils/file_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class DataRegistrationViewModel extends ChangeNotifier {
  //diあり
  DataRegistrationViewModel({DataRepository repository})
      : _dataRepository = repository;
  final DataRepository _dataRepository;

  //diなし
//  final DataRepository _dataRepository =DataRepository();

  ///登録データ格納 finalにすると変更通知できないのでしょ
  List<FoodStuff> _foodStuffs = <FoodStuff>[];
  List<FoodStuff> get foodStuffs => _foodStuffs;


  final List<Product> _products = variableProducts;
  List<Product> get products => _products;

  String _productUrl = '';
  String get productUrl => _productUrl;

  //商品名
  final TextEditingController _productNameController = TextEditingController();
  TextEditingController get productNameController => _productNameController;

  //カテゴリ
  final TextEditingController _productCategoryController =
      TextEditingController();
  TextEditingController get productCategoryController =>
      _productCategoryController;

  //数量
  final TextEditingController _productNumberController =
      TextEditingController();
  TextEditingController get productNumberController => _productNumberController;

  //期限
  final TextEditingController _dateEditController = TextEditingController();
  TextEditingController get dateEditController => _dateEditController;

  //保管場所
  final TextEditingController _productStorageController =
      TextEditingController();
  TextEditingController get productStorageController =>
      _productStorageController;

  DateTime _validDateTime = DateTime.now();
  DateTime get validDateTime => _validDateTime;

  String _barcodeScanRes = '';
  String get barcodeScanRes => _barcodeScanRes;

  bool _isProcessing = false;
  bool get isProcessing => _isProcessing;

//  List<Product> _products = <Product>[];
//  List<Product> get products => _products;

  //カメラ・ギャラリーから取得した画像File(imageFile)を保存ボタンを押したらキャッシュからローカル保存するメソッドへ渡す
  File imageFromCamera;
  File imageFromGallery;
  File imageFromNetwork;

  ///３つ別々より１つの方が良い?
  bool isImagePickedFromCamera = false;
  bool isImagePickedFromGallery = false;
  bool isImagePickedFromNetwork = false;

//  File get imageFromNetwork => null;

  Future<void> registerProductData(RecordStatus recordStatus) async {
//viewModel層でモデルクラスに格納してrepositoryへ
    switch(recordStatus){
      case RecordStatus.camera:
        var localImage = await FileController.saveCachedImage(imageFromCamera);
      FoodStuff foodStuff =
      FoodStuff(
        //idはautoIncrementするので、初期登録は何も入れなくて良いはず
          foodStuffId: Uuid().v1(),
          name: _productNameController.text,
          category: _productCategoryController.text,
          validDate: _validDateTime,
          storage: _productStorageController.text,
          amount: int.parse(_productNumberController.text),
          //useAmount,restAmountはDBで初期値設定
          //todo localImage.pathを保存する
          localImagePath:localImage.path,
          //amountToEatListはid以外はメニュー画面からの登録で設定するので初期値なし(エラー出ない？)
      );
      await _dataRepository.registerProductData(foodStuff);
        notifyListeners();
        break;

      case RecordStatus.gallery:
        var localImage = await FileController.saveCachedImage(imageFromGallery);
        ///finalへ変更
        final foodStuff =
        FoodStuff(
          foodStuffId: Uuid().v1(),
          name: _productNameController.text,
          category: _productCategoryController.text,
          validDate: _validDateTime,
          storage: _productStorageController.text,
          amount: int.parse(_productNumberController.text),
          //useAmount,restAmountはDBで初期値設定
          //todo localImage.pathを保存する
          localImagePath:localImage.path,
          //amountToEatListはid以外はメニュー画面からの登録で設定するので初期値なし(エラー出ない？)
        );
        print('viewModel=>repository/FoodStuff.id:${foodStuff.id}');
        print('viewModel=>repository/FoodStuff.foodStuffId:${foodStuff.foodStuffId}');
        await _dataRepository.registerProductData(foodStuff);
        notifyListeners();
        break;
      case RecordStatus.networkImage:
        //todo FileController.saveCachedImageに渡したimageFromNetworkがFileになってない
        var localImage = await FileController.saveCachedImage(imageFromNetwork);
        FoodStuff foodStuff =
        FoodStuff(
          foodStuffId: Uuid().v1(),
          name: _productNameController.text,
          category: _productCategoryController.text,
          validDate: _validDateTime,
          storage: _productStorageController.text,
          amount: int.parse(_productNumberController.text),
          //useAmount,restAmountはDBで初期値設定
          //todo localImage.pathを保存する
          localImagePath:localImage.path,
          //amountToEatListはid以外はメニュー画面からの登録で設定するので初期値なし(エラー出ない？)
        );
        await _dataRepository.registerProductData(foodStuff);
        notifyListeners();
        break;
    }

  }

  void productNameClear() {
    _productNameController.clear();
    notifyListeners();
  }

  void productCategoryClear() {
    _productCategoryController.clear();
    notifyListeners();
  }

  void productNumberClear() {
    _productNumberController.clear();
    notifyListeners();
  }

  void dateClear() {
    _dateEditController.clear();
    notifyListeners();
  }

  void productStorageClear() {
    _productStorageController.clear();
    notifyListeners();
  }

  void dateChange(DateTime newDateTime) {
    _validDateTime = newDateTime;
    //intlパッケージを使ってpickerで選択した年月日を日本語表示
    _dateEditController.text =
        DateFormat.yMMMd('ja').format(newDateTime).toString();
  }

//  @override
//  void dispose() {
//    _homeRepository.dispose();
//    super.dispose();
//  }

  Future<void> getProductInfo() async {
    await _dataRepository.getProductInfo(_products);
    _productNameController.text = _products[0].name;
    _productUrl = _products[0].productImage.medium;

//    if (_productUrl  != null){
    isImagePickedFromNetwork = true;
    isImagePickedFromCamera = false;
    isImagePickedFromGallery = false;
//    }
    notifyListeners();
  }

  Future<void> getImageFromCamera() async {
//    isImagePickedFromCamera = false;
//    notifyListeners();

    imageFromCamera = await _dataRepository.getImageFromCamera();
//    print('pickedImage:${imageFile.path}');

    if (imageFromCamera != null) {
      isImagePickedFromCamera = true;
      isImagePickedFromGallery = false;
      isImagePickedFromNetwork = false;
    }
    notifyListeners();
  }

  Future<void> getImageFromGallery() async {
    isImagePickedFromGallery = false;
    notifyListeners();
    imageFromGallery = await _dataRepository.getImageFromGallery();
    if (imageFromGallery != null) {
      isImagePickedFromGallery = true;
      isImagePickedFromCamera = false;
      isImagePickedFromNetwork = false;
    }
    notifyListeners();
  }

  Future<void> getFoodStuffList() async{
    ///finalにしない！！finalにするとnotifyListenersしてもview層でConsumer更新されない
     _foodStuffs =await _dataRepository.getFoodStuffList();

    if(_foodStuffs.isEmpty) {
      print("リストが空");
      notifyListeners();
    }else{
      print("DB=>レポジトリ=>vieModelで取得したデータの長さ：${_foodStuffs.length}");
      notifyListeners();
    }
  }
}

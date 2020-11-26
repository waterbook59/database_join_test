import 'dart:io';

import 'package:datebasejointest/data_models/product.dart';
import 'package:datebasejointest/models/repository/data_repository.dart';
import 'package:datebasejointest/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataRegistrationViewModel extends ChangeNotifier{
  //diあり
  DataRegistrationViewModel({DataRepository repository})
      : _dataRepository = repository;
  final DataRepository _dataRepository;

  //diなし
//  final DataRepository _dataRepository =DataRepository();

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


  Future<void> getProductInfo() async{
    await _dataRepository.getProductInfo(_products);
    _productNameController.text = _products[0].name;
    _productUrl = _products[0].productImage.medium;
    notifyListeners();
  }

  Future<void> registerProductData() async {
    await _dataRepository.registerProductData();
    notifyListeners();
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

  Future<void> getImageFromCamera() async {
    isImagePickedFromCamera = false;
    notifyListeners();

    imageFromCamera = await _dataRepository.getImageFromCamera();
//    print('pickedImage:${imageFile.path}');

    if (imageFromCamera != null){
      isImagePickedFromCamera = true;
      isImagePickedFromGallery = false;
    }
    notifyListeners();
  }

  Future<void> getImageFromGallery() async{
    isImagePickedFromGallery = false;
    notifyListeners();
    imageFromGallery = await _dataRepository.getImageFromGallery();
    if (imageFromGallery != null) {
      isImagePickedFromGallery = true;
      isImagePickedFromCamera = false;
    }
    notifyListeners();
  }




}
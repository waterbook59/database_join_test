import 'dart:io';

import 'package:datebasejointest/data_models/menu/food_stuff.dart';
import 'package:datebasejointest/data_models/product.dart';
import 'package:datebasejointest/models/repository/data_repository.dart';
import 'package:datebasejointest/utils/constants.dart';
import 'package:datebasejointest/utils/file_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_cropper/image_cropper.dart';
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

///FoodStuffをローカル保存
  Future<void> registerProductData(RecordStatus recordStatus) async {
//viewModel層でモデルクラスに格納してrepositoryへ
    switch(recordStatus){

  ///カメラからデータ保存
      case RecordStatus.camera:
        //todo imageFromCameraのデータ圧縮

        var localImage = await FileController.saveCachedImage(imageFromCamera);
      FoodStuff foodStuff =
      FoodStuff(
        //idはautoIncrementするので、初期登録は何も入れなくて良い
          foodStuffId: Uuid().v1(),
          name: _productNameController.text,
          category: _productCategoryController.text,
          validDate: _validDateTime,
          storage: _productStorageController.text,
          amount: int.parse(_productNumberController.text),
          //useAmount,restAmountはDBで初期値設定
          // localImage.pathを保存する
          localImagePath:localImage.path,
          //amountToEatListはid以外はメニュー画面からの登録で設定するので初期値なし(エラー出ない？)
      );
      await _dataRepository.registerProductData(foodStuff);
        // DB登録と同時にキャッシュ画像の方は削除
      imageFromCamera.delete();
        //テキスト関連を全てクリア
      allClear();
        notifyListeners();
        break;

    ///ギャラリーからデータ保存
      case RecordStatus.gallery:
        ///cacheの画像データをlocal(app_flutter内)へコピー
        var localImage = await FileController.saveCachedImage(imageFromGallery);
        print('viewModelでのlocalImage.pathの値:${localImage.path}');
        //finalへ変更
        final foodStuff =
        FoodStuff(
          foodStuffId: Uuid().v1(),
          name: _productNameController.text,
          category: _productCategoryController.text,
          validDate: _validDateTime,
          storage: _productStorageController.text,
          amount: int.parse(_productNumberController.text),
          //useAmount,restAmountはDBで初期値設定
          // localImage.pathを保存する
          localImagePath:localImage.path,
          //amountToEatListはid以外はメニュー画面からの登録で設定するので初期値なし(エラー出ない？)
        );
        await _dataRepository.registerProductData(foodStuff);
        /// DB登録と同時にキャッシュ画像の方は削除
        ///imageFromGarellyはFile: '/data/user/0/com.example.datebasejointest/cache/image_pickerxxxxx.jpg'の形
        imageFromGallery.delete();
         // テキスト関連を全てクリア
        allClear();
        notifyListeners();
        break;

    ///ネットワークからデータ保存
      case RecordStatus.networkImage:
        //todo FileController.saveCachedImageに渡したimageFromNetworkがFileになってない
        var localImage = await FileController.saveCachedImage(imageFromNetwork);
        print('imageFromNetwork:$imageFromNetwork');
        //
        FoodStuff foodStuff =
        FoodStuff(
          foodStuffId: Uuid().v1(),
          name: _productNameController.text,
          category: _productCategoryController.text,
          validDate: _validDateTime,
          storage: _productStorageController.text,
          amount: int.parse(_productNumberController.text),
//          useAmount,restAmountはDBで初期値設定
//           localImage.pathを保存する
          localImagePath:localImage.path,
//          amountToEatListはid以外はメニュー画面からの登録で設定するので初期値なし(エラー出ない？)
        );
        await _dataRepository.registerProductData(foodStuff);
        //キャッシュと入力関連全てクリア
        imageFromNetwork.delete();
        allClear();
        notifyListeners();
        break;
    }

  }

///ローカルデータ削除
  Future<void> onFoodStuffDeleted(FoodStuff foodStuff) async{
    //ローカル画像削除のためFileを渡す
    //File.pathでString形式にしてDB保存している,foodStuff.localImageはString
    File deleteFile = File(foodStuff.localImagePath);
    await _dataRepository.deleteFoodStuff(foodStuff);
    // 画像についてはDBから画像へのパスとローカルから画像も削除する
    await FileController.deleteCashedImage(deleteFile);
    notifyListeners();
  }


///Firebaseへ登録
  postFoodStuff(RecordStatus recordStatus) async{

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

    /// CacheManagerパッケージを使ってurlからFileパスを得てimageFromNetworkに格納
    if(_productUrl !=null ){
      final cache = DefaultCacheManager();
      final file = await cache.getSingleFile(_productUrl);
      imageFromNetwork = file;
      print('imageFromNetworkに格納したネットワークからのfile：$imageFromNetwork');
    }

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
    //imageFromCameraのデータに対してimage_cropper適用
    /// croppedCameraFileにimageFromCameraを代入
    // imageFromCamera =nullの場合の条件付けないとcroppedCameraFile内のimageFromCamera.path=nullでエラー
    if(imageFromCamera !=null){
    var croppedCameraFile = await ImageCropper.cropImage(
        sourcePath: imageFromCamera.path,
        aspectRatio: CropAspectRatio(
          ratioX: 1,ratioY: 1),
        compressQuality: 100,
        maxHeight: 100,
        maxWidth: 100,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: '',
            toolbarColor: Colors.black12,
//            statusBarColor: ,
//            backgroundColor: ,
//            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true,//trueにすると背景の写真が動く
            hideBottomControls: true //全部ボトムコントローラー消える
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
          doneButtonTitle: '完了',
            cancelButtonTitle: '戻る'
        )
    );
    ///croppedCameraFileをimageFromCameraに代入
      imageFromCamera = croppedCameraFile;
    }else{
      imageFromCamera =null;
    }
    if (imageFromCamera != null) {
      isImagePickedFromCamera = true;
      isImagePickedFromGallery = false;
      isImagePickedFromNetwork = false;
    }
    notifyListeners();
  }

  Future<void> getImageFromGallery() async {
//    isImagePickedFromGallery = false;
//    notifyListeners();
    imageFromGallery = await _dataRepository.getImageFromGallery();
    /// croppedCameraFileにimageFromGalleryを代入
    if(imageFromGallery !=null){
      var croppedCameraFile = await ImageCropper.cropImage(
          sourcePath: imageFromGallery.path,
          aspectRatio: CropAspectRatio(
              ratioX: 1,ratioY: 1),
          compressQuality: 100,
          maxHeight: 100,
          maxWidth: 100,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: '',
              toolbarColor: Colors.black12,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: true,//trueにすると背景の写真が動く
              hideBottomControls: true //全部ボトムコントローラー消える
          ),
          iosUiSettings: IOSUiSettings(
              minimumAspectRatio: 1.0,
              doneButtonTitle: '完了',
              cancelButtonTitle: '戻る'
          )
      );
      ///croppedCameraFileをimageFromGalleryに代入
      imageFromGallery = croppedCameraFile;
    }else{
      imageFromGallery =null;
    }
    print('ImagePickerのFile(galleryPickedFile.path)の値：$imageFromGallery');
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
//      print("DB=>レポジトリ=>vieModelで取得したデータの長さ：${_foodStuffs.length}");
      notifyListeners();
    }
  }

  Future<void> allClear() async{
    //todo それぞれキャッシュ画像はクリアの必要ありか？
    isImagePickedFromCamera = false;
    isImagePickedFromGallery = false;
    isImagePickedFromNetwork = false;
    productNameClear();
    productCategoryClear();
    dateClear();
    productNumberClear();
    productStorageClear();
    notifyListeners();//いらんかも
  }





}

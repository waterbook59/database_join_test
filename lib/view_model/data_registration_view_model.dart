import 'dart:core';
import 'dart:io';
import 'package:datebasejointest/data_models/menu/food_stuff.dart';
import 'package:datebasejointest/data_models/menu/food_stuff_firebase.dart';
import 'package:datebasejointest/data_models/product.dart';
import 'package:datebasejointest/models/repository/data_repository.dart';
import 'package:datebasejointest/models/repository/post_repository.dart';
import 'package:datebasejointest/models/repository/user_repository.dart';
import 'package:datebasejointest/utils/constants.dart';
import 'package:datebasejointest/utils/file_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class DataRegistrationViewModel extends ChangeNotifier {
  //diあり
  DataRegistrationViewModel({
    DataRepository dataRepository,
    UserRepository userRepository,
    PostRepository postRepository,
  })  : _dataRepository = dataRepository,
        _userRepository = userRepository,
        _postRepository = postRepository;

  final DataRepository _dataRepository;
  final UserRepository _userRepository;
  final PostRepository _postRepository;

  //diなし
//  final DataRepository _dataRepository =DataRepository();

  ///登録データ格納 finalにすると変更通知できないのでしょ
  List<FoodStuff> _foodStuffs = <FoodStuff>[];

  List<FoodStuff> get foodStuffs => _foodStuffs;

  //firebaseデータ格納
  List<FoodStuffFB> _foodStuffFBs = <FoodStuffFB>[];
  List<FoodStuffFB> get foodStuffFBs => _foodStuffFBs;

  final List<Product> _products = variableProducts;
  List<Product> get products => _products;

  String _productUrl = '';
  String get productUrl => _productUrl;

  //商品名
  final TextEditingController productNameController = TextEditingController();
  //カテゴリ
  final TextEditingController productCategoryController =
      TextEditingController();
  //期限
  final TextEditingController dateEditController = TextEditingController();
  //数量
  final TextEditingController productNumberController =
      TextEditingController();
  //保管場所
  final TextEditingController productStorageController =
      TextEditingController();

  DateTime validDateTime = DateTime.now();
//  DateTime get validDateTime => _validDateTime;
  String _barcodeScanRes = '';
  String get barcodeScanRes => _barcodeScanRes;
  bool _isProcessing = false;
  bool get isProcessing => _isProcessing;

  //画像とってくるときのグリグリ
  bool isImagePicked = false;
  //FoodStuffの追加(add,true)または編集(edit,false)
  bool isAddEdit = false;

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
    switch (recordStatus) {

      ///カメラからデータ保存
      case RecordStatus.camera:
        //todo imageFromCameraのデータ圧縮
        final localImage =
        await FileController.saveCachedImage(imageFromCamera);
        final foodStuff = FoodStuff(
          //idはautoIncrementするので、初期登録は何も入れなくて良い
          foodStuffId: Uuid().v1(),
          name: productNameController.text,
          category: productCategoryController.text,
          validDate: validDateTime,
          storage: productStorageController.text,
          amount: int.parse(productNumberController.text),
          //useAmount,restAmountはDBで初期値設定
          // localImage.pathを保存する
          localImagePath: localImage.path,
          //amountToEatListはid以外はメニュー画面からの登録で設定するので初期値なし(エラー出ない？)
        );
        await _dataRepository.registerProductData(foodStuff);
        // DB登録と同時にキャッシュ画像の方は削除
        await imageFromCamera.delete();
        //テキスト関連を全てクリア
        await allClear();
        notifyListeners();
        break;

      ///ギャラリーからデータ保存
      case RecordStatus.gallery:
        ///cacheの画像データをlocal(app_flutter内)へコピー
        final localImage =
        await FileController.saveCachedImage(imageFromGallery);
        print('viewModelでのlocalImage.pathの値:${localImage.path}');
        //finalへ変更
        final foodStuff = FoodStuff(
          foodStuffId: Uuid().v1(),
          name: productNameController.text,
          category: productCategoryController.text,
          validDate: validDateTime,
          storage: productStorageController.text,
          amount: int.parse(productNumberController.text),
          //useAmount,restAmountはDBで初期値設定
          // localImage.pathを保存する
          localImagePath: localImage.path,
          //amountToEatListはid以外はメニュー画面からの登録で設定するので初期値なし(エラー出ない？)
        );
        await _dataRepository.registerProductData(foodStuff);

        /// DB登録と同時にキャッシュ画像の方は削除
        ///imageFromGarellyはFile: '/data/user/0/com.example.datebasejointest/cache/image_pickerxxxxx.jpg'の形
        await imageFromGallery.delete();
        // テキスト関連を全てクリア
        await allClear();
        notifyListeners();
        break;

      ///ネットワークからデータ保存
      case RecordStatus.networkImage:
        //todo FileController.saveCachedImageに渡したimageFromNetworkがFileになってない
        final localImage =
        await FileController.saveCachedImage(imageFromNetwork);
        print('imageFromNetwork:$imageFromNetwork');
        final foodStuff = FoodStuff(
          foodStuffId: Uuid().v1(),
          name: productNameController.text,
          category: productCategoryController.text,
          validDate: validDateTime,
          storage: productStorageController.text,
          amount: int.parse(productNumberController.text),
//          useAmount,restAmountはDBで初期値設定
//           localImage.pathを保存する
          localImagePath: localImage.path,
//          amountToEatListはid以外はメニュー画面からの登録で設定するので初期値なし(エラー出ない？)
        );
        await _dataRepository.registerProductData(foodStuff);
        //キャッシュと入力関連全てクリア
        await imageFromNetwork.delete();
        await allClear();
        notifyListeners();
        break;
    }
  }

///FoodStuffをFirebaseへ登録
  Future<void> postFoodStuff(RecordStatus recordStatus) async {
    _isProcessing = true;
    notifyListeners();
    switch (recordStatus) {

      ///カメラからFBへデータ保存
      case RecordStatus.camera:
        //名前付で渡す
        await _postRepository.postFoodStuff(
          currentUser: UserRepository.currentModelUser,
          postImage: imageFromCamera,
          name: productNameController.text,
          category: productCategoryController.text,
          validDateTime: validDateTime,
          storage: productStorageController.text,
          amount: int.parse(productNumberController.text),
          useAmount: 0,
          restAmount: int.parse(productNumberController.text),
        );
        //todo 登録後再取得
        await getFoodStuffListFB();
        _isProcessing = false;
        await allClear();
        notifyListeners();
        break;

      ///ギャラリーからFBへデータ保存
      case RecordStatus.gallery:
        _isProcessing = true;
        notifyListeners();
        await _postRepository.postFoodStuff(
          currentUser: UserRepository.currentModelUser,
          postImage: imageFromGallery,
          name: productNameController.text,
          category: productCategoryController.text,
          validDateTime: validDateTime,
          storage: productStorageController.text,
          amount: int.parse(productNumberController.text),
          useAmount: 0,
          restAmount: int.parse(productNumberController.text),
        );
        //登録後再取得
        await getFoodStuffListFB();
        _isProcessing = false;
        await allClear();
        notifyListeners();
        break;
      //todo networkからの取得画像をFBへデータ保存

    }
  }

  ///FirebaseのFoodStuffを更新
  //todo 変更前のfoodStuffを渡して画像以外の変更点をcopyWithしてみる
  Future<void> updateFoodStuff(FoodStuffFB foodStuffFB) async{
    print('updateFoodStuff');
    _isProcessing = true;
    notifyListeners();

    await _postRepository.updateFoodStuff(
        foodStuffFB.copyWith(
            name: productNameController.text,
            category: productCategoryController.text,
            validDate: validDateTime,
            amount: int.parse(productNumberController.text),
            storage:productStorageController.text,
        )
    );
    //登録後再取得
    await getFoodStuffListFB();
    _isProcessing = false;
    await allClear();
    notifyListeners();

  }

  ///FoodStuffをFirebaseから削除
  Future<void> onFoodStuffDeletedDB(FoodStuffFB foodStuff) async {
    _isProcessing = true;
    notifyListeners();
    await _postRepository.deleteFoodStuff(
        foodStuff.foodStuffId, foodStuff.imageStoragePath);
    await getFoodStuffListFB();
    _isProcessing = false;
    notifyListeners();
  }

//  @override
//  void dispose() {
//    _homeRepository.dispose();
//    super.dispose();
//  }

  Future<void> getProductInfo() async {
    await _dataRepository.getProductInfo(_products);
    productNameController.text = _products[0].name;
    _productUrl = _products[0].productImage.medium;

    /// CacheManagerパッケージを使ってurlからFileパスを得てimageFromNetworkに格納
    if (_productUrl != null) {
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
    /// croppedFileの大きさ適正化
    // imageFromCamera =nullの場合の条件付けないと
    // croppedCameraFile内のimageFromCamera.path=nullでエラー
    if (imageFromCamera != null) {
      var croppedCameraFile = await ImageCropper.cropImage(
          sourcePath: imageFromCamera.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,

          ///maxHeightのサイズ指定すれば画像縮小は可能
//        maxHeight: 200,
//        maxWidth: 200,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: const AndroidUiSettings(
              toolbarTitle: '',
              toolbarColor: Colors.black12,
//            statusBarColor: ,
//            backgroundColor: ,
//            toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: true,
              //trueにすると背景の写真が動く
              hideBottomControls: true //全部ボトムコントローラー消える
              ),
          iosUiSettings: const IOSUiSettings(
              minimumAspectRatio: 1,
              doneButtonTitle: '完了',
              cancelButtonTitle: '戻る'));

      ///croppedCameraFileをimageFromCameraに代入
      imageFromCamera = croppedCameraFile;
    } else {
      imageFromCamera = null;
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
    if (imageFromGallery != null) {
      var croppedCameraFile = await ImageCropper.cropImage(
          sourcePath: imageFromGallery.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxHeight: 100,
          maxWidth: 100,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: const AndroidUiSettings(
              toolbarTitle: '',
              toolbarColor: Colors.black12,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: true,
              //trueにすると背景の写真が動く
              hideBottomControls: true //全部ボトムコントローラー消える
              ),
          iosUiSettings: const IOSUiSettings(
              minimumAspectRatio: 1.0,
              doneButtonTitle: '完了',
              cancelButtonTitle: '戻る'));

      ///croppedCameraFileをimageFromGalleryに代入
      imageFromGallery = croppedCameraFile;
    } else {
      imageFromGallery = null;
    }
    print('ImagePickerのFile(galleryPickedFile.path)の値：$imageFromGallery');
    if (imageFromGallery != null) {
      isImagePickedFromGallery = true;
      isImagePickedFromCamera = false;
      isImagePickedFromNetwork = false;
    }
    notifyListeners();
  }



  ///CloudFirestoreからデータ読み取り
  Future<void> getFoodStuffListFB() async {
    _isProcessing = true;
    notifyListeners();
    _foodStuffFBs = await _postRepository.getFoodStuffList(
        currentUser: UserRepository.currentModelUser);

    _isProcessing = false;
    notifyListeners();
  }

  ///isProcessing出さない
  Future<void> getFoodStuffsFB() async {
    _foodStuffFBs = await _postRepository.getFoodStuffList(
        currentUser: UserRepository.currentModelUser);
    notifyListeners();
  }

  ///FutureBuilder用:Firebaseデータ読み取り
  Future<List<FoodStuffFB>> getFoodStuffs() async {
    return _postRepository.getFoodStuffList(
        currentUser: UserRepository.currentModelUser);
  }
  ///FutureBuilder用:リストデータ読み取り(Firebase読み取り発生しない)
  Future<List<FoodStuffFB>> isFoodStuffsList() async {
    return _foodStuffFBs;
  }


  ///CloudFirestore Realtimeで読み取り
  Future<List<FoodStuffFB>> getFoodStuffListRealtime() async {
    //notifyListeners通知しない場合は、isProcessing系は入れない
    _isProcessing = true;
    notifyListeners();
    _foodStuffFBs = await _postRepository.getFoodStuffListRealtime(
        currentUser: UserRepository.currentModelUser);
    _isProcessing = false;
    notifyListeners();
//  return _foodStuffFBs;
  }

  ///登録後のクリア関連
  void productNameClear() {
    productNameController.clear();
    notifyListeners();
  }

  void productCategoryClear() {
    productCategoryController.clear();
    notifyListeners();
  }

  void productNumberClear() {
    productNumberController.clear();
    notifyListeners();
  }

  void dateClear() {
    dateEditController.clear();
    notifyListeners();
  }

  void productStorageClear() {
    productStorageController.clear();
    notifyListeners();
  }

  void dateChange(DateTime newDateTime) {
    validDateTime = newDateTime;
    //intlパッケージを使ってpickerで選択した年月日を日本語表示
    dateEditController.text =
        DateFormat.yMMMd('ja').format(newDateTime).toString();
  }

  Future<void> allClear() async {
    //todo それぞれキャッシュ画像はクリアの必要ありか？
    isImagePickedFromCamera = false;
    isImagePickedFromGallery = false;
    isImagePickedFromNetwork = false;
    productNameClear();
    productCategoryClear();
    dateClear();
    productNumberClear();
    productStorageClear();
    notifyListeners(); //いらんかも
  }


  ///ローカルデータ読み取り
  Future<void> getFoodStuffList() async {
    ///finalにしない！！finalにするとnotifyListenersしてもview層でConsumer更新されない
    _foodStuffs = await _dataRepository.getFoodStuffList();

    if (_foodStuffs.isEmpty) {
      print("リストが空");
      notifyListeners();
    } else {
//      print("DB=>レポジトリ=>vieModelで取得したデータの長さ：${_foodStuffs.length}");
      notifyListeners();
    }
  }

  ///ローカルデータ削除
  Future<void> onFoodStuffDeleted(FoodStuff foodStuff) async {
    //ローカル画像削除のためFileを渡す
    //File.pathでString形式にしてDB保存している,foodStuff.localImageはString
    File deleteFile = File(foodStuff.localImagePath);
    await _dataRepository.deleteFoodStuff(foodStuff);
    // 画像についてはDBから画像へのパスとローカルから画像も削除する
    await FileController.deleteCashedImage(deleteFile);
    notifyListeners();
  }


}



import 'package:datebasejointest/utils/constants.dart';
import 'package:datebasejointest/view_model/data_registration_view_model.dart';
import 'package:datebasejointest/views/components/cached_image.dart';
import 'package:datebasejointest/views/components/add_icon_part.dart';
import 'package:datebasejointest/views/components/imgae_from_url.dart';
import 'package:datebasejointest/views/components/picker_form_part.dart';
import 'package:datebasejointest/views/components/product_text_part.dart';
import 'package:datebasejointest/views/data_registration/component/amount_input_part.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


class DataRegistrationScreen extends StatelessWidget {

 RecordStatus recordStatus;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      ///image_pickerでカメラまたはギャラリーキャンセル時にエラーが出るのでWillPopScope(true?)で戻らせない
      child: Scaffold(
        appBar: AppBar(
          //戻るボタンなくなる
          leading: Container(),
          centerTitle: true,
          title: const Text('商品データを登録',),
          actions: [
            IconButton(
              icon: Icon(Icons.cancel),
              onPressed: ()=>_deleteData(context),)],
        ),
        body: SingleChildScrollView(
          child: Consumer<DataRegistrationViewModel>(
              builder: (context, model, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15,),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Wrap(
//                       alignment: WrapAlignment.center
                          spacing: 10,
                          children: [
                            ///商品画像：自分でカメラで撮影
                            model.isImagePickedFromCamera
                            ///   画像が取れたらキャッシュの画面を表示
                                ? model.imageFromCamera == null
                                ? Container()
                                : CachedImage(
                              onTap: () => getImageFromCamera(context),
                              displayImage: Image.file(model.imageFromCamera),
                            )
                            ///初期タップでカメラ起動または他で選択済みの時
                                :
                            (model.isImagePickedFromGallery || model.isImagePickedFromNetwork)
                            ///ギャラリーまたはnetworkの画像がキャッシュに入った時
                            //完全にカメラアイコンを消すのではなく小さく表示して選択肢として残す
                                ? AddIconPart(
                              onTap: () => getImageFromCamera(context),
                              displayImage: Icon(Icons.add_a_photo,size: 60,),
                              width: 60,
                              height: 60,
                            ) //小さいCameraIconPartへ変更
                                :
                            ///初期タップでカメラ起動
                            AddIconPart(
                              onTap: () => getImageFromCamera(context),
                              displayImage: Icon(Icons.add_a_photo,size: 60,),
                              width: 90,
                              height: 90,
                            ),

                            ///商品画像：networkから選択
                            model.isImagePickedFromNetwork
                                ? model.isImagePickedFromNetwork ==null
                                ? Container()
                                : SizedBox(
                                width:90,
                                height:90,
                                child: ImageFromUrl(imageUrl: model.productUrl,)
                            )
                                :(model.isImagePickedFromCamera || model.isImagePickedFromGallery)
                                ? AddIconPart(
                              onTap: () => _getProductInfo(context),
                              displayImage:  FaIcon(FontAwesomeIcons.barcode, size: 60,),
                              width: 60,
                              height: 60,
                            )
                                : AddIconPart(
                              onTap: () => _getProductInfo(context),
                              displayImage:  Center(child: FaIcon(FontAwesomeIcons.barcode, size: 60,)),
                              width: 90,
                              height: 90,
                            ),

                            ///商品画像：ギャラリーから選択
                            model.isImagePickedFromGallery
                                ? model.imageFromGallery == null
                                ? Container()
                                : CachedImage(
                              onTap: () => getImageFromGallery(context),
                              displayImage: Image.file(model.imageFromGallery),
                            )
                            ///初期タップでフォルダ選択起動
                                :
                            (model.isImagePickedFromCamera || model.isImagePickedFromNetwork)
                                ? AddIconPart(
                              onTap: () => getImageFromGallery(context),
                              displayImage:  Icon(Icons.add_photo_alternate,size: 60,),
                              width: 60,
                              height: 60,
                            )
                                : AddIconPart(
                              onTap: () => getImageFromGallery(context),
                              displayImage: Icon(Icons.add_photo_alternate,size: 60,),
                              width: 90,
                              height: 90,
                            ),


                          ],
                        )
                    ),

                    SizedBox(height: 15),
                    ///商品名
                    ProductTextPart(
                      productTextController: model.productNameController,
                      onCancelButtonPressed: () => model.productNameClear(),
                      labelText: '商品名',
                      hintText: '商品名を入力',
                      textInputType: TextInputType.text,
                    ),

                    ///カテゴリ
                    ProductTextPart(
                      productTextController: model.productCategoryController,
                      onCancelButtonPressed: () =>
                          model.productCategoryClear(),
                      labelText: 'カテゴリ',
                      hintText: 'カテゴリを入力',
                      textInputType: TextInputType.text,
                    ),

                    ///期限
                    PickerFormPart(
                      dateEditController: model.dateEditController,
                      onCancelButtonPressed: () => model.dateClear(),
                      dateTime: model.validDateTime,
                      dateChanged: (newDateTime) =>
                          model.dateChange(newDateTime),
                    ),

                    ///数量:+,-ボタンも付けて
//                    AmountInputPart(
//                      productTextController: model.productNumberController,
//                      onCancelButtonPressed: () => model.productNumberClear(),
//                      labelText: '数量',
//                      hintText: '数量を入力',
//                      textInputType: TextInputType.number,
//                    ),

                    ProductTextPart(
                      productTextController: model.productNumberController,
                      onCancelButtonPressed: () => model.productNumberClear(),
                      labelText: '数量',
                      hintText: '数量を入力',
                      ///TextInputType.numberから変更,decimalのtrueは何か？
                      textInputType: TextInputType.numberWithOptions(signed: true, decimal:true),
                    ),

                    ///保管場所
                    ProductTextPart(
                      productTextController: model.productStorageController,
                      onCancelButtonPressed: () =>
                          model.productStorageClear(),
                      labelText: '保管場所',
                      hintText: '保管場所を入力',
                      textInputType: TextInputType.text,
                    ),
                    //商品画像と商品名をバーコードから入手ボタン
                    const SizedBox(
                      height: 20,
                    ),

                    ///バーコード読み取りボタン
//                      ButtonWithIcon(
//                        label: 'バーコードで商品情報取得',
//                        icon: const FaIcon(FontAwesomeIcons.barcode),
//                        buttonColor: Colors.orangeAccent,
//                        onPressed: () => _getProductInfo(context),
//                      ),
                    const SizedBox(
                      height: 20,
                    ),

                    ///保存ボタン
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(15)),
                      color: Colors.orangeAccent,
                      child: const Text('保存'),
                      //文字=>DB,画像=>imagePathとしてドキュメントへ保存
                      onPressed: () => registerProductData(context,recordStatus),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  Future<void> _getProductInfo(BuildContext context) async {
    recordStatus = RecordStatus.networkImage;
    final viewModel =
    Provider.of<DataRegistrationViewModel>(context, listen: false);
    await viewModel.getProductInfo();
  }

  Future<void> getImageFromCamera(BuildContext context) async {
    recordStatus =RecordStatus.camera;
    final viewModel =
    Provider.of<DataRegistrationViewModel>(context, listen: false);
    await viewModel.getImageFromCamera();
  }

  Future<void> getImageFromGallery(BuildContext context) async {
    recordStatus = RecordStatus.gallery;
    final viewModel =
    Provider.of<DataRegistrationViewModel>(context, listen: false);
    await viewModel.getImageFromGallery();
  }

  Future<void> registerProductData(BuildContext context, RecordStatus recordStatus) async {
    final viewModel =
    Provider.of<DataRegistrationViewModel>(context, listen: false);
//    print('view層から登録ボタン押してviewModelへ');
    ///DB登録と同時にキャッシュ画像クリア
    await viewModel.registerProductData(recordStatus);
    //登録が終わったら閉じる
    //todo Navigator.popだと閉じた時にDataListPageが更新されない
    Navigator.pop(context);
  }


//trueで返すだけならleading残ってNavigator.popになる
  Future<bool> _willPopCallback() async {
    return true;
  }

  //ギャラリー選択時のキャンセルには効かない
  Future<bool> _exitApp(BuildContext context) async {
    return showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text('Do you want to exit this application?'),
        content: new Text('We hate to see you leave...'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }

  _deleteData(BuildContext context) {
    return showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text('入力内容を破棄してよろしいですか?'),
//        content: new Text('We hate to see you leave...'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: new Text('キャンセル'),
          ),
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: new Text('OK'),
          ),
        ],
      ),
    );
  }
}





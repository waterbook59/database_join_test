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
                if (model.isProcessing) {
                  //todo グリグリ出さないと何度でも保存ボタン押せる状態に
                  print('登録中にグリグリ〜');
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }else{
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
                              //File型のイメージ.pathはString型、File(Stringのパス)でファイル表示できる
                              displayFilePath: model.imageFromCamera.path,
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
                                //todo imageFromNetworkにパスを格納
                                child: ImageFromUrl(
                                  displayFilePath: model.imageFromNetwork.path,
                                onTap: ()=>_getProductInfo(context),
                                )
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
                              displayFilePath: model.imageFromGallery.path,
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
                    const SizedBox(
                      height: 20,
                    ),

                    ///保存ボタン
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(15)),
                      color: Colors.orangeAccent,
                      child: const Text('保存'),
                      //ローカル保存：文字=>moor,画像=>imagePathとしてドキュメントへ保存
                      //firebaseに投稿
                      //todo 保存ボタン押した時の登録までの時間はボタン押せないようにする(重複登録防止)
                      onPressed: () => registerProductData(context,recordStatus),
                    ),
                  ],
                );
                }//else閉じ
              }),
        ),
      ),
    );
  }

  //todo CircularProgressIndicator()つける
  Future<void> _getProductInfo(BuildContext context) async {
    recordStatus = RecordStatus.networkImage;
    final viewModel =
    Provider.of<DataRegistrationViewModel>(context, listen: false);
    await viewModel.getProductInfo();
  }

 //todo CircularProgressIndicator()つける
  Future<void> getImageFromCamera(BuildContext context) async {
    recordStatus =RecordStatus.camera;
    final viewModel =
    Provider.of<DataRegistrationViewModel>(context, listen: false);
    await viewModel.getImageFromCamera();
  }

 //todo CircularProgressIndicator()つける
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
    ///ローカル保存：DB登録と同時にキャッシュ画像クリア&テキストコントローラーたちもクリア
//    await viewModel.registerProductData(recordStatus);
    ///Firebase保存
    await viewModel.postFoodStuff(recordStatus);
    //todo 登録中はボタン押せないようにする
    //登録が終わったら閉じる、
    // Realtime更新でNavigator.pop or oneTimeでpushReplacementで条件分岐
    Navigator.pop(context,true);
    //Navigator.pushReplacement(caseを登録)
  }


//trueで返すだけならleading残ってNavigator.popになる
  Future<bool> _willPopCallback() async {
    return true;
  }

  //ギャラリー選択時のキャンセルには効かない
//  Future<bool> _exitApp(BuildContext context) async {
//    return showDialog(
//      context: context,
//      child:  AlertDialog(
//        title:  Text('Do you want to exit this application?'),
//        content:  Text('We hate to see you leave...'),
//        actions: <Widget>[
//           FlatButton(
//            onPressed: () => Navigator.of(context).pop(false),
//            child:  Text('No'),
//          ),
//           FlatButton(
//            onPressed: () => Navigator.of(context).pop(true),
//            child:  Text('Yes'),
//          ),
//        ],
//      ),
//    ) ??
//        false;
//  }

  //Future<void>戻り値追加
  Future<void> _deleteData(BuildContext context) {
    return showDialog(
      context: context,
      child:  AlertDialog(
        title: const Text('入力内容を破棄してよろしいですか?'),
//        content: new Text('We hate to see you leave...'),
        actions: <Widget>[
           FlatButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('キャンセル'),
          ),
           FlatButton(
            onPressed: () async{
              //入力破棄するので、入力したものは全てクリア
              await allClear(context);
//              final viewModel =
//              Provider.of<DataRegistrationViewModel>(context, listen: false);
//              await viewModel.allClear();
              Navigator.pop(context);
              Navigator.pop(context,false);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> allClear(BuildContext context) async{
    final viewModel =
    Provider.of<DataRegistrationViewModel>(context, listen: false);
    await viewModel.allClear();
  }
}





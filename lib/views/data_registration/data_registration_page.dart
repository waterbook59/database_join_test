import 'package:datebasejointest/style.dart';
import 'package:datebasejointest/view_model/data_registration_view_model.dart';
import 'package:datebasejointest/views/components/barcode_part.dart';
import 'package:datebasejointest/views/components/button_with_icon.dart';
import 'package:datebasejointest/views/components/cached_camera_image.dart';
import 'package:datebasejointest/views/components/camera_icon_part.dart';
import 'package:datebasejointest/views/components/gallery_part.dart';
import 'package:datebasejointest/views/components/imgae_from_url.dart';
import 'package:datebasejointest/views/components/picker_form_part.dart';
import 'package:datebasejointest/views/components/product_text_part.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


class DataRegistrationPage extends StatelessWidget {
//   HomeScreen({Key key, this.title}) : super(key: key);
//  final String title;
//  final int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      ///image_pickerでカメラまたはギャラリーキャンセル時にエラーが出るのでWillPopScope(true?)で戻らせない
      child: WillPopScope(
//        onWillPop: _willPopCallback,
      onWillPop: ()=>_exitApp(context),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('商品データを登録',),
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
                            ? model.imageFromCamera==null
                               ? Container()
                               : CachedCameraImage(
                              onTap: () => getImageFromCamera(context),
                              displayImage: Image.file(model.imageFromCamera),
                            )

//                            Container(
//                                  decoration: BoxDecoration(
//                                  border:  Border.all(color: Colors.blueAccent),
//                            ),
//                                child:  SizedBox(
//                                width: 90,
//                                height: 90,
//                                child: Image.file(model.imageFromCamera)
//                                )
//                            )
                            ///初期タップでカメラ起動または他で選択済みの時
                            :
                            (model.isImagePickedFromGallery||model.isImagePickedFromNetwork)
                            ///ギャラリーまたはnetworkの画像がキャッシュに入った時
                            //todo 完全にカメラアイコンを消すのではなく小さく表示して選択肢として残す
                                ? Container()//小さいCameraIconPartへ変更
                                :///初期タップでカメラ起動
                                  CameraIconPart(
                                    onTap: () => getImageFromCamera(context),
                                    displayImage: Image.asset(cameraIcon),
                                  ),



                          ///商品画像：ギャラリーから選択
                            model.isImagePickedFromGallery
                                ? model.imageFromGallery==null
                                ? Container()
                                : Container(
                                decoration: BoxDecoration(
                                  border:  Border.all(color: Colors.blueAccent),
                                ),
                                child:  SizedBox(
                                    width: 90,
                                    height: 90,
                                    child: Image.file(model.imageFromGallery)
                                )
                            )
                            ///初期タップでフォルダ選択起動
                                : Container(
                              decoration: BoxDecoration(
                                border:  Border.all(color: Colors.blueAccent),
                              ),
                              child: InkWell(
                                onTap: () => getImageFromGallery(context),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: SizedBox(
                                    width: 90,
                                    height: 90,
                                    child:Icon(Icons.folder),
                                  ),
                                ),
                              ),
                            ),

                            ///商品画像：ギャラリーから選択
//                            GalleryPart(
//                              onTap: () => getImageFromGallery(context),
//                              displayImage: model.isImagePickedFromGallery
//                                  ? model.imageFromGallery==null
//                                  ?Container()
//                                  :Image.file(model.imageFromGallery)
//                                  : Icon(Icons.folder),
//                            ),


                            ///商品画像：networkから選択
                          BarcodePart(
                            onTap: () => _getProductInfo(context),
                            displayImage: model.isImagePickedFromNetwork
                                ? model.imageFromNetwork==null
                                ?Container()
                                :Image.file(model.imageFromNetwork)
                                :FaIcon(FontAwesomeIcons.barcode),
                          ),

                  ],
                  )


                      ),
                      ///商品画像：バーコード検索結果
                      SizedBox(
                          width: 90,
                          height: 90,
                          //todo バーコード検索結果から表示、タップでカメラ起動
                          child: ImageFromUrl(
                            imageUrl: model.productUrl,
                          )),

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
                        onCancelButtonPressed: () => model.productCategoryClear(),
                        labelText: 'カテゴリ',
                        hintText: 'カテゴリを入力',
                        textInputType: TextInputType.text,
                      ),
                      ///期限
                      PickerFormPart(
                        dateEditController: model.dateEditController,
                        onCancelButtonPressed: () => model.dateClear(),
                        dateTime: model.validDateTime,
                        dateChanged: (newDateTime) => model.dateChange(newDateTime),
                      ),

                      ///数量
                      ProductTextPart(
                        productTextController: model.productNumberController,
                        onCancelButtonPressed: () => model.productNumberClear(),
                        labelText: '数量',
                        hintText: '数量を入力',
                        textInputType: TextInputType.number,
                      ),
                      ///保管場所
                      ProductTextPart(
                        productTextController: model.productStorageController,
                        onCancelButtonPressed: () => model.productStorageClear(),
                        labelText: '保管場所',
                        hintText: '保管場所を入力',
                        textInputType: TextInputType.text,
                      ),
                      //商品画像と商品名をバーコードから入手ボタン
                      const SizedBox(
                        height: 20,
                      ),

                      ///バーコード読み取りボタン
                      ButtonWithIcon(
                        label: 'バーコードで商品情報取得',
                        icon: const FaIcon(FontAwesomeIcons.barcode),
                        buttonColor: Colors.orangeAccent,
                        onPressed: () => _getProductInfo(context),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      ///保存ボタン
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(15)),
                        child: const Text('保存'),
                        //todo 文字=>DB,カメラ画像=>model.imageFileをsavedFileとしてドキュメントへ保存
                        onPressed: () => registerProductData(context),
                      ),
                    ],
                  );
                }),
          ),

          floatingActionButton: FloatingActionButton(
            onPressed:  ()=>_getProductInfo(context),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }

  Future<void> _getProductInfo(BuildContext context) async{
    final viewModel =
    Provider.of<DataRegistrationViewModel>(context, listen: false);
    await viewModel.getProductInfo();
  }

  Future<void> getImageFromCamera(BuildContext context) async{
    final viewModel =
    Provider.of<DataRegistrationViewModel>(context, listen: false);
    await viewModel.getImageFromCamera();
  }

  Future<void> getImageFromGallery(BuildContext context) async{
    final viewModel =
    Provider.of<DataRegistrationViewModel>(context, listen: false);
    await viewModel.getImageFromGallery();
  }

  Future<void> registerProductData(BuildContext context) async {
    final viewModel =
    Provider.of<DataRegistrationViewModel>(context, listen: false);
    await viewModel.registerProductData();
  }




//trueで返すだけならギャラリーのキャンセルボタンはなくなるが、スマホのボトムの戻るは残る
  Future<bool> _willPopCallback() async{
    return true;
  }

  //ギャラリー選択時のキャンセルには効かない
  Future<bool>_exitApp(BuildContext context) async{
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
}





import 'package:datebasejointest/style.dart';
import 'package:datebasejointest/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'components/button_with_icon.dart';
import 'components/camera_icon_part.dart';
import 'components/imgae_from_url.dart';
import 'components/picker_form_part.dart';
import 'components/product_text_part.dart';

class HomeScreen extends StatelessWidget {
//   HomeScreen({Key key, this.title}) : super(key: key);
//  final String title;
//  final int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('商品データを登録',),
        ),
        body: SingleChildScrollView(
          child: Consumer<HomeViewModel>(
              builder: (context, model, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    ///商品画像：自分でカメラで撮影
                    CameraIconPart(
                      onTap: () => openCamera(context),
                      displayImage: model.isImagePicked
                          ? Image.file(model.imageFile)
                          : Image.asset(cameraIcon),
                    ),
                    ///商品画像：バーコード検索結果
                    SizedBox(
                        width: 80,
                        height: 80,
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
    );
  }

  Future<void> _getProductInfo(BuildContext context) async{
        final viewModel =
    Provider.of<HomeViewModel>(context, listen: false);
    await viewModel.getProductInfo();
  }

  Future<void> openCamera(BuildContext context) async{
    final viewModel =
    Provider.of<HomeViewModel>(context, listen: false);
    await viewModel.pickImage();
  }

  Future<void> registerProductData(BuildContext context) async {
    final viewModel =
    Provider.of<HomeViewModel>(context, listen: false);
    await viewModel.registerProductData();
  }


}





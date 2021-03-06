import 'package:datebasejointest/data_models/menu/food_stuff_firebase.dart';
import 'package:datebasejointest/view_model/data_registration_view_model.dart';
import 'package:datebasejointest/views/data_registration/data_registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:datebasejointest/utils/constants.dart';

import 'components/food_stuff_item.dart';

class DataListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///①冒頭呼び出しだけなら更新時にNavigator.popでページ更新がされない
    ///=>Navigator.popでbool値を返して条件付で再描画する
    //②dataRegistrationScreenとはpushReplacementにし、条件分岐(入力中断時,登録,更新時に読み込みするか決める)
    //=>めんどい
    //③FutureBuilderだけなら冒頭呼び出しはいらないが、ページ開くたびにFirebaseから読み込んでしまう
    //④streamでRealtimeにする
    final viewModel =
    Provider.of<DataRegistrationViewModel>(context, listen: false);
    // 毎回Firebaseへリクエストしない条件追加必須
    //空の時
    if (!viewModel.isListLoading && viewModel.foodStuffFBs.isEmpty) {
      //これが実行されると変更が生じるのでConsumer以下がbuildされる
      Future<void>(viewModel.getFoodStuffListFB);
    }
    //データ登録中断:読み込みしない
    //データ登録:読み込み
    //データ更新：読み込み

//    Future<void>(viewModel.getFoodStuffListFB);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('モノリスト'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _addData(context),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Consumer<DataRegistrationViewModel>(
              builder: (context, model, child) {
                return model.isListLoading
                    ? const Center(child: CircularProgressIndicator())
//                    : model.foodStuffFBs.isEmpty
//                    ? Container(
//                      child: const Center(child: Text('リストが空なので入力してみましょう')))
                    : FutureBuilder(
//                  future: model.getFoodStuffs(),
                  ///リストがあるかないかであればFirebase読込発生しない
                    future: model.isFoodStuffsList(),
                    builder:
                        (context, AsyncSnapshot<List<FoodStuffFB>> snapshot) {
                      print('snapshot:${snapshot.data}');
                      if (snapshot.hasData && snapshot.data.isEmpty) {
                        print('EmptyView通った');
                        return Container(
                            child:
                            const Center(child: Text('リストが空なので入力してみましょう')));
                        ///snapshot.hasData=nullの場合、
                        ///Container記載入れると描画遅くなるので入れない
//                      }
//                      else if(!snapshot.hasData){
//                        print('snapshotがnull');
//                        return Container();
                      }else{
                          print('ListView通った');
                          return ListView.builder(
                            itemCount: model.foodStuffFBs.length,
                            itemBuilder: (context, int position) =>
                            ///期限をDateTime=>yyyy/MM/ddに変換
                            //todo 画像を一定の大きさに揃える(Fit?)
                            FoodStuffItem(
                              foodStuff: model.foodStuffFBs[position],
                              onLongTapped: (foodStuff) =>
                                  _onFoodStuffDeleted(foodStuff, context),
                              onDataTapped: (foodStuff) =>
                                  _upDateFoodStuff(foodStuff, context),
                            ),);
                        }
                      }
                    );
              }),
        ),
      ),
    );
  }

//TODO 'resultがtrueの時は再描画'はいらない(登録後にgetFoodStuffsFB()してるので)
  Future<void> _addData(BuildContext context) async {

    //追加なのでtrueにview側から変更
    final viewModel =
    Provider.of<DataRegistrationViewModel>(context, listen: false)
      ..isAddEdit  = true;

//    final result =
    await Navigator.push(
      //resultに再描画するならtrue
      context,
      MaterialPageRoute<bool>(
          builder: (context) =>
              DataRegistrationScreen(
              ),
          fullscreenDialog: true),
    );


//    if (result) {
//      //result:trueの時だけデータリストを取りに行く再描画(notifyListenersする)
//      print('resultがtrueの時は再描画：$result');
//      final viewModel =
//      Provider.of<DataRegistrationViewModel>(context, listen: false);
//      await viewModel.getFoodStuffsFB();
//    }
  }

  Future<void> _onFoodStuffDeleted(FoodStuffFB foodStuff,
      BuildContext context) async {
    //ここにviewModelおくと、contextが重なってエラー

    //await、showDialog<void>のvoid追加
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) =>
          AlertDialog(
            title: Text('『${foodStuff.name}』の削除'),
            content: const Text('削除してもいいですか？'),
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  ///Navigator.pop(context);は非同期より前におかないとエラー
                  Navigator.pop(context);
                  ///画像についてはDBから画像へのパスとcashとローカルから画像も削除する
//                await viewModel.onFoodStuffDeleted(foodStuff);
//                   await viewModel.getFoodStuffList();
                  ///Firebaseからの削除(ここだけviewModelのcontext重なってエラーになるのでメソッド外だし)
                  await deletePost(context, foodStuff);
                  await Fluttertoast.showToast(msg: '削除完了しました');

                },
                child: const Text('はい'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('いいえ'),
              ),
            ],
          ),
    );
  }

  Future<void> deletePost(BuildContext context, FoodStuffFB foodStuff) async {
    final viewModel =
    Provider.of<DataRegistrationViewModel>(context, listen: false);
    await viewModel.onFoodStuffDeletedDB(foodStuff);

  }

///更新
  Future<void> _upDateFoodStuff(FoodStuffFB foodStuff,
      BuildContext context)  async{

    //編集なのでisAddEditをfalseにview側から変更
    final viewModel =
     Provider.of<DataRegistrationViewModel>(context, listen: false)
     //isAdEdit編集モード
     ..isAddEdit  = false;
    //商品名・カテゴリ・期限・数量・保管場所をセット
     viewModel.productNameController.text = foodStuff.name;
     viewModel.productCategoryController.text = foodStuff.category;
     /// 期限変換 モデルクラスに格納したDateTimeをyMMdの形でStringへ変換してdateEditControllerに代入
// viewModel.validDateTime = foodStuff.validDate;
    viewModel.dateEditController.text =
    DateFormat.yMMMd('ja').format(foodStuff.validDate).toString();
    viewModel.productNumberController.text = foodStuff.amount.toString();
    viewModel.productStorageController.text = foodStuff.storage;

   await  Navigator.push(
      //resultに再描画するならtrue
      context,
      MaterialPageRoute<void>(
          builder: (context) =>
              DataRegistrationScreen(foodStuff: foodStuff,
              ),
          fullscreenDialog: true),
    );

  }
}

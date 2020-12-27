import 'package:datebasejointest/data_models/menu/food_stuff_firebase.dart';
import 'package:datebasejointest/view_model/data_registration_view_model.dart';
import 'package:datebasejointest/views/data_registration/data_registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'components/food_stuff_item.dart';

class DataListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///FutureBuilderで処理するだけで良いので、冒頭の呼び出しはいらない
    final viewModel =
        Provider.of<DataRegistrationViewModel>(context, listen: false);
    // 頭のviewModel(DB取得用)とConsumerのtaskViewModel(更新用)は違うもの
    //立ち上げと同時にConsumer１回まわる、getTaskListによりDB取得してもう１回Consumer回る、
    //そしてDBの値の数に応じてFutureBuilderで表示を変える！！！

    // 毎回Firebaseへリクエストしない条件追加必須(news_feed参照)
//    if(!viewModel.isProcessing&& viewModel.foodStuffFBs.isEmpty){
//      print('ページ開いた時getFoodStuffListFB()');
//      Future(()=>viewModel.getFoodStuffListFB());
//    }
//    Future<void>(viewModel.getFoodStuffListFB);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('モノリスト'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _addData(context),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Consumer<DataRegistrationViewModel>(
              builder: (context, model, child) {
//                print();
            if (model.isProcessing) {
              print('DataListPageでグリグリ〜');
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return FutureBuilder(
                  future: model.getFoodStuffs(),
                  builder:
                      (context, AsyncSnapshot<List<FoodStuffFB>> snapshot) {
                    //snapshotがnullの場合を考慮(nullの場合、ListViewの方に行ってしまう)
                    print('snapshot:${snapshot.data}');
                    if (snapshot.hasData) {
                      if (snapshot.data.isEmpty) {
                        print('EmptyView通った');
                        return Container();
                      } else {
                        print('ListView通った');
                        return ListView.builder(
                          itemCount: model.foodStuffFBs.length,
                          itemBuilder: (context, int position) =>
                              //todo 期限表示は○年○月○日表示
                              //todo 画像を一定の大きさに揃える(Fit?)
                              FoodStuffItem(
                            foodStuff: model.foodStuffFBs[position],
                            onLongTapped: (foodStuff) =>
                                _onFoodStuffDeleted(foodStuff, context),
                            // onWordTapped: (foodStuff)=>_upDateWord(foodStuff,context),
                          ),
                        );
                      }
                    } else {
                      print('snapshotがnull:${snapshot.data}');
                      return Center(child: CircularProgressIndicator());
                    }
                  });
            }
          }),
        ),
      ),
    );
  }

  void _addData(BuildContext context) {
    Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
            builder: (context) => DataRegistrationScreen(),
            fullscreenDialog: true));
  }

  Future<void> _onFoodStuffDeleted(
      FoodStuffFB foodStuff, BuildContext context) async {
    //ここにviewModelおくと、contextが重なってエラー

    //await、showDialog<void>のvoid追加
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text("『${foodStuff.name}』の削除"),
        content: const Text("削除してもいいですか？"),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              ///画像についてはDBから画像へのパスとcashとローカルから画像も削除する
//                await viewModel.onFoodStuffDeleted(foodStuff);
//                   await viewModel.getFoodStuffList();
              ///Firebaseからの削除(ここだけviewModelのcontext重なってエラーになるのでメソッド外だし)
              deletePost(context, foodStuff);
              Fluttertoast.showToast(msg: "削除完了しました");
              Navigator.pop(context);
            },
            child: Text("はい"),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("いいえ"),
          ),
        ],
      ),
    );
  }

  void deletePost(BuildContext context, FoodStuffFB foodStuff) async {
    final viewModel =
        Provider.of<DataRegistrationViewModel>(context, listen: false);
    await viewModel.onFoodStuffDeletedDB(foodStuff);
  }
}

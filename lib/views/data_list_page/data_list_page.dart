
import 'package:datebasejointest/view_model/data_registration_view_model.dart';
import 'package:datebasejointest/views/data_registration/data_registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'components/food_stuff_item.dart';

class DataListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final viewModel = Provider.of<DataRegistrationViewModel>(context, listen: false);
//    Future<void>(viewModel.getFoodStuffList);
      //isEmptyの時に「文字登録してください」的な表示できるか


    Future(() {
       viewModel.getFoodStuffListFB();
      //立ち上げ時はここのリストは空になるのでprintでList[]でも問題なし
//      print('取得したfoodStuffのList長さ${viewModel.foodStuffs.length}');
    });


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('モノリスト'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
            onPressed: ()=>_addData(context),)],
        ),
        body:
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Consumer<DataRegistrationViewModel>(
              builder: (context,model,child){
                if(model.isProcessing){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }else{
                  //                print('DataListPageのConsumerリスト長さ：${model.foodStuffs.length}');
                  return ListView.builder(
                      itemCount: model.foodStuffFBs.length,
                      itemBuilder: (context, int position) =>
                      //todo 期限表示は○年○月○日表示
                      //todo 画像を一定の大きさに揃える(Fit?)
                      FoodStuffItem(
                        foodStuff:model.foodStuffFBs[position],
                        onLongTapped: (foodStuff)=>_onFoodStuffDeleted(foodStuff,context),
//                          onWordTapped: (foodStuff)=>_upDateWord(foodStuff,context),
                      )
                  );
                }

              }
          ),
        ),
      ),
    );
  }

  void _addData(BuildContext context) {
    Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
            builder:(context)=>DataRegistrationScreen() ));
  }

  Future<void>_onFoodStuffDeleted(foodStuff, BuildContext context) async{
    final viewModel = Provider.of<DataRegistrationViewModel>(context, listen: false);

    showDialog(
      context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: Text("『${foodStuff.name}』の削除"),
          content:const Text("削除してもいいですか？"),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                ///画像についてはDBから画像へのパスとcashとローカルから画像も削除する
                await viewModel.onFoodStuffDeleted(foodStuff);
                  Fluttertoast.showToast(msg:"削除完了しました");
                // ここで最後の１つを削除後取得しようとするとList内が空っぽでエラーが出るがisEmptyで回避
                await viewModel.getFoodStuffList();
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


}


import 'package:datebasejointest/view_model/data_registration_view_model.dart';
import 'package:datebasejointest/views/data_registration/data_registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/food_stuff_item.dart';

class DataListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final viewModel = Provider.of<DataRegistrationViewModel>(context, listen: false);
//    Future<void>(viewModel.getFoodStuffList);
      //isEmptyの時に「文字登録してください」的な表示できるか


    Future(() {
       viewModel.getFoodStuffList();
      //立ち上げ時はここのリストは空になるのでprintでList[]でも問題なし
      print('取得したfoodStuffのList長さ${viewModel.foodStuffs.length}');
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
                print('DataListPageのConsumerリスト長さ：${model.foodStuffs.length}');
                return ListView.builder(
                    itemCount: model.foodStuffs.length,
                    itemBuilder: (context, int position) =>
                        FoodStuffItem(
                          foodStuff:model.foodStuffs[position],
//                          onLongTapped: (foodStuff)=>_onWordDeleted(foodStuff,context),
//                          onWordTapped: (foodStuff)=>_upDateWord(foodStuff,context),
                        )
                );
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
}

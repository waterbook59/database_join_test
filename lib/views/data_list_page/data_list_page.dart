
import 'package:datebasejointest/views/data_registration/data_registration_screen.dart';
import 'package:flutter/material.dart';

class DataListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('モノリスト'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
            onPressed: ()=>_addData(context),)],
        ),
        body: Center(
          child: Container(
              child: const Text('DataListPage',
              )
          ),

          //todo dropdownボタンを使ってカテゴリ別に押すと商品が出てくるなど
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

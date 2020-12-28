import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const[
          Text('開発タスク一覧'),
          Text('通知関連'),
          Text('ご要望・お問い合わせ'),
          Text('レビューを書く'),
          Text('カテゴリ設定'),
          Text('アカウント連携(google,apple,電話番号)'),
          //アカウント削除するとログイン画面
          Text('利用規約'),
          Text('プライバシーポリシー'),
          Text('バージョン番号'),
          Text('追加機能について(リストアも)'),
        ],
      )

    );
  }
}

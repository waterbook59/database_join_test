import 'package:flutter/cupertino.dart';

import 'bottom_picker.dart';

class ValidDatePicker extends StatelessWidget {
  const ValidDatePicker({
    this.dateTime, this.textEditingController,this.dateChanged});

  final DateTime dateTime;
  final TextEditingController textEditingController;
  final ValueChanged<DateTime> dateChanged;


  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      Container(
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
          border: Border(
            bottom: BorderSide(
              color: Color(0xff999999),
              width: 0,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            /// クパチーノデザインのボタン表示
            CupertinoButton(
              child: const Text('キャンセル'),
              onPressed: () => Navigator.pop(context),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5,),
            ),
            CupertinoButton(
              child: const Text('追加'),
              onPressed: () => Navigator.pop(context),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5,),
            )
          ],
        ),
      ),

      /// 最下部で表示するPicker(widget分割したものにpickerを引数として渡す)
      BottomPicker(
        //立ち上げ時の初期表示はDateTime.now()にするか追加ボタンのonPressedと連動
        CupertinoDatePicker(
          /// datePickerを日付のみの表示にする
          mode: CupertinoDatePickerMode.date,
          initialDateTime: dateTime,
          onDateTimeChanged: dateChanged,
        ),
      ),
    ]);
  }
}

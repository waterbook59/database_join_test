import 'package:datebasejointest/data_models/menu/category_list.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {

  const CategoryItem({this.selectCategory,this.onCategoryTapped});
  final Category selectCategory;
  final ValueChanged onCategoryTapped;


  @override
  Widget build(BuildContext context) {

    print('ListTileのアイコン:${selectCategory.categoryIcon}');

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: Colors.transparent,
      child: ListTile(

        //アイコンはviewModelでnullで登録しているので出ない
        leading: selectCategory.categoryIcon ,
        title: Text("${selectCategory.categoryText}", style: TextStyle(color: Colors.black87,fontSize: 14),),


//            _deleteWord(_wordList[position]),
        onTap: () => onCategoryTapped(selectCategory),
      ),
    );
  }
}

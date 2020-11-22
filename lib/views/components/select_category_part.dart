
import 'package:datebasejointest/data_models/category_list.dart';
import 'package:flutter/material.dart';

import 'category_item.dart';

class SelectCategoryPart extends StatelessWidget {
  const SelectCategoryPart({this.categoryResults});

  final List<Category> categoryResults;

  @override
  Widget build(BuildContext context) {
    //ListView.builderの高さ設定して上げないと下記エラー出るのでSizedBoxでラップ
    // The following assertion was thrown during performResize():
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
          ///ListView.builderをColumnでラップ且つshrinkWrap:trueで高さ自動指定
            shrinkWrap: true,
            itemCount: categoryResults.length,
            itemBuilder: (context, int index) {
              //todo ここでMealTypeで場合わけ？
//            if(categoryResults[index].mealType == MealType.breakfast){
              ///List<Category>の中のCategoryの中でisSelected=trueのものだけを表示
              if(categoryResults[index].isSelected){
                return CategoryItem(
                  selectCategory: categoryResults[index],
                  //todo
                  onCategoryTapped: null,
                );
                ///isSelected = falseのものはContainerにして表示しない(nullはエラー！)
              }else{
                return Container();
              }


//            }
//            else{
//              Container();
//            }



            }),
      ],
    );
  }
}

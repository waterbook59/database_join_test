
import 'package:datebasejointest/data_models/category_list.dart';
import 'package:datebasejointest/utils/constants.dart';
import 'package:datebasejointest/view_model/category_select_view_model.dart';
import 'package:datebasejointest/views/category_select/category_select_screen.dart';
import 'package:datebasejointest/views/components/meal_time_part.dart';
import 'package:datebasejointest/views/components/radius_expansion_tile.dart';
import 'package:datebasejointest/views/components/select_category_part.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';

class MenuPage extends StatefulWidget {
  MenuPage({this.categoryResult});

  List<Category> categoryResult;

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
//    print('カテゴリー選択から得たデータ：${widget.categoryResult}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //todo categoryResultの中身をどこかで空にしないとcategoryResulutの中身がどんどん増えていく
//    print('カテゴリー選択から得たデータ：${widget.categoryResult}');

    ///カテゴリ追加ボタンを押すときにMealTypeを渡す
    MealType mealType;

    return Scaffold(
      appBar: AppBar(
        title: Text('Configurable Expansion Tile Demo'),
      ),
      floatingActionButton: const FloatingActionButton(
        //todo
        onPressed: null,
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: RadiusExpansionTile(
                        animatedWidgetFollowingHeader: const Icon(
                          Icons.expand_more,
                          color: const Color(0xFF707070),
                        ),
                        headerExpanded: Flexible(
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: 50,
                                child: Center(child: Text('メニュー')))),
                        header: Flexible(
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.green),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 50,
                              child: Center(child: Text("１日目"))),
                        ),
                        children: [
                          Column(
                            children: <Widget>[
                              Consumer<CategorySelectViewModel>(
                                  builder: (context, model, child) {
                                    return Column(
                                        children: [
                                          MealTimePart(
                                            mealTime: '朝',
                                            backgroundColor: Colors.orangeAccent,
                                            ///ここでMealType.breakfastを渡す
                                            onAdd: () {
                                              mealType = MealType.breakfast;
                                              print('ソート前breakfastCategory：');
                                              model.breakfastCategory.forEach((
                                                  category) {
                                                print("${category.id}:${category
                                                    .categoryText}");
                                              });
                                              addCategory(context, mealType);
                                            },
                                          ),

                                          ///categoryResultがnullじゃないときカテゴリ選択結果表示
                                          model.breakfastCategory.isEmpty
                                              ? Container()
                                          //ここでcategoryResult.mealtype==MealType.breakfast ?SelctCategryPart:Container()
                                              : SelectCategoryPart(
                                            //todo ここでbreakfastCategoryの中のisSelectedがtrueだけのカテゴリを表示する
                                            categoryResults: model
                                                .breakfastCategory,
                                          ),
                                        ]
                                    );
                                  }
                              ),
                              const Divider(
                                height: 10,
                              ),
                              Consumer<CategorySelectViewModel>(
                                  builder: (context, model, child) {
                                    return Column(
                                      children: [
                                        MealTimePart(
                                          mealTime: '昼',
                                          backgroundColor: Colors.orangeAccent,
                                          onAdd: () {
                                            mealType = MealType.lunch;
                                            addCategory(context, mealType);
                                          },
                                        ),
                                        //todo MealType.lunchだけ表示するには？
                                        model.lunchCategory.isEmpty
                                            ? Container()
                                            : SelectCategoryPart(
                                          categoryResults: model.lunchCategory,
                                        ),
                                      ],
                                    );
                                  }
                              ),
                              const Divider(),
                              Consumer<CategorySelectViewModel>(
                                  builder: (context, model, child) {
                                    return Column(
                                      children: [
                                        MealTimePart(
                                          mealTime: '間食',
                                          backgroundColor: Colors.orangeAccent,
                                          onAdd: () {
                                            mealType = MealType.snack;
                                            addCategory(context, mealType);
                                          },
                                        ),
                                        model.snackCategory.isEmpty
                                            ? Container()
                                            : SelectCategoryPart(
                                          categoryResults: model.snackCategory,
                                        ),
                                      ],
                                    );
                                  }
                              ),

                              const Divider(),
                              Consumer<CategorySelectViewModel>(
                                  builder: (context, model, child) {
                                    return Column(
                                      children: [
                                        MealTimePart(
                                          mealTime: '夜',
                                          backgroundColor: Colors.orangeAccent,
                                          onAdd: () {
                                            mealType = MealType.dinner;
                                            addCategory(context, mealType);
                                          },
                                        ),
                                        model.dinnerCategory.isEmpty
                                            ? Container()
                                            : SelectCategoryPart(
                                          categoryResults: model.dinnerCategory,
                                        ),
                                      ],
                                    );
                                  }
                              ),
                            ],
                          ),
                        ]),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  //todo タップするとカテゴリ追加ページに
  void addCategory(BuildContext context, MealType mealType) async {
    await Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
          builder: (context) => CategorySelectScreen(mealType: mealType)),
    );
//    Navigator.pushReplacement<dynamic, dynamic>(
//        context,
//        MaterialPageRoute<dynamic>(
//            builder: (context) => CategorySelectScreen(mealType: mealType)));
  }
}

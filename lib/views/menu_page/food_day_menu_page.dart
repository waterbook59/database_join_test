///Tabバー入れたやつ
import 'package:datebasejointest/data_models/menu/category_list.dart';
import 'package:datebasejointest/utils/constants.dart';
import 'package:datebasejointest/view_model/category_select_view_model.dart';
import 'package:datebasejointest/views/category_select/category_select_screen.dart';
import 'package:datebasejointest/views/components/meal_time_part.dart';
import 'package:datebasejointest/views/components/radius_expansion_tile.dart';
import 'package:datebasejointest/views/components/select_category_part.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';

// ignore: must_be_immutable
class FoodDayMenuPage extends StatefulWidget {
  FoodDayMenuPage({this.categoryResult});

  List<Category> categoryResult;

  @override
  _FoodDayMenuPageState createState() => _FoodDayMenuPageState();
}

class _FoodDayMenuPageState extends State<FoodDayMenuPage>
    with TickerProviderStateMixin {

  TabController _tabController;

//  List<String> _titles = [
//    "1日目",
//    "2日目",
//    "3日目",
//  ];

  final _tab = <Tab>[
    const Tab(text: '1日目', icon: Icon(Icons.directions_car)),
    const Tab(text: '2日目', icon: Icon(Icons.directions_bike)),
    const Tab(text: '3日目', icon: Icon(Icons.directions_boat)),
  ];

  @override
  void initState() {
//    print('カテゴリー選択から得たデータ：${widget.categoryResult}');
    _tabController = TabController(vsync: this, length: _tab.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //todo categoryResultの中身をどこかで空にしないとcategoryResulutの中身がどんどん増えていく
//    print('カテゴリー選択から得たデータ：${widget.categoryResult}');

    ///カテゴリ追加ボタンを押すときにMealTypeを渡す
    MealType mealType;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DayMenu'),
        bottom: TabBar(
          controller: _tabController,
          tabs: _tab,
        ),
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
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: RadiusExpansionTile(
                        animatedWidgetFollowingHeader: const Icon(
                          Icons.expand_more,
                          color: Color(0xFF707070),
                        ),
                        headerExpanded: Flexible(
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: 50,
                                child: const Center(child: Text('朝のメニュー')))),
                        header: Flexible(
                          child: Container(
                              decoration: BoxDecoration(
//                                border: Border.all(color: Colors.green),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 50,
                              child: const Center(child: Text('朝'))),
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
                                            backgroundColor: Colors
                                                .orangeAccent,

                                            ///ここでMealType.breakfastを渡す
                                            onAdd: () {
                                              mealType = MealType.breakfast;
                                              print('ソート前breakfastCategory：');
                                              model.breakfastCategory.forEach((
                                                  category) {
                                                print('${category.id}:${category
                                                    .categoryText}');
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
                            ],
                          ),
                        ]),
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: RadiusExpansionTile(
                        animatedWidgetFollowingHeader: const Icon(
                          Icons.expand_more,
                          color: Color(0xFF707070),
                        ),
                        headerExpanded: Flexible(
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: 50,
                                child: const Center(child: Text('昼のメニュー')))),
                        header: Flexible(
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.green),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 50,
                              child: const Center(child: Text('昼'))),
                        ),
                        children: [
                          Column(
                            children: <Widget>[
                              Consumer<CategorySelectViewModel>(
                                  builder: (context, model, child) {
                                    return Column(
                                        children: [
                                          MealTimePart(
                                            mealTime: '昼',
                                            backgroundColor: Colors
                                                .orangeAccent,

                                            ///ここでMealType.breakfastを渡す
                                            onAdd: () {
                                              mealType = MealType.breakfast;
                                              print('ソート前breakfastCategory：');
                                              model.breakfastCategory.forEach((
                                                  category) {
                                                print('${category.id}:${category
                                                    .categoryText}');
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
                            ],
                          ),
                        ]),
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: RadiusExpansionTile(
                        animatedWidgetFollowingHeader: const Icon(
                          Icons.expand_more,
                          color: Color(0xFF707070),
                        ),
                        headerExpanded: Flexible(
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: 50,
                                child: const Center(child: Text('間食メニュー')))),
                        header: Flexible(
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.green),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 50,
                              child: const Center(child: Text('間食'))),
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
                                            backgroundColor: Colors
                                                .orangeAccent,

                                            ///ここでMealType.breakfastを渡す
                                            onAdd: () {
                                              mealType = MealType.breakfast;
                                              print('ソート前breakfastCategory：');
                                              model.breakfastCategory.forEach((
                                                  category) {
                                                print('${category.id}:${category
                                                    .categoryText}');
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
                            ],
                          ),
                        ]),
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: RadiusExpansionTile(
                        animatedWidgetFollowingHeader: const Icon(
                          Icons.expand_more,
                          color: Color(0xFF707070),
                        ),
                        headerExpanded: Flexible(
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: 50,
                                child: const Center(child: Text('夜のメニュー')))),
                        header: Flexible(
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.green),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 50,
                              child: const Center(child: Text('夜'))),
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
                                            backgroundColor: Colors
                                                .orangeAccent,

                                            ///ここでMealType.breakfastを渡す
                                            onAdd: () {
                                              mealType = MealType.breakfast;
                                              print('ソート前breakfastCategory：');
                                              model.breakfastCategory.forEach((
                                                  category) {
                                                print('${category.id}:${category
                                                    .categoryText}');
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
                            ],
                          ),
                        ]),
                  )),

            ],
          ),
        ),
      ),
    );
  }

  //todo タップするとカテゴリ追加ページに
  Future<void> addCategory(BuildContext context, MealType mealType) async {
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

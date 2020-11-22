import 'package:datebasejointest/data_models/category_list.dart';
import 'package:datebasejointest/models/repository/menu_repository.dart';
import 'package:datebasejointest/utils/constants.dart';
import 'package:flutter/material.dart';

class CategorySelectViewModel extends ChangeNotifier{
//  CategorySelectViewModel({BarcodeRepository repository})
//      : _barcodeRepository = repository;
//  final BarcodeRepository _barcodeRepository;

  final MenuRepository _menuRepository =MenuRepository();


//  bool _isSelected =false;
//  bool get isSelected => _isSelected;

  ///[選択しているカテゴリーだけを格納] カテゴリボタンタップ時に格納し,選択ボタン時に格納外し
  List<Category> breakfastCategory =   List<Category>.from(categories);
//  <Category>[];
  List<Category> lunchCategory =  List<Category>.from(categories);
  //<Category>[];
  List<Category> snackCategory =  List<Category>.from(categories);
  //<Category>[];
  List<Category> dinnerCategory = List<Category>.from(categories);

  //
  Future<void> breakfastCategoryTapped(
      {MealType mealType, bool isSelected, String label, int id}) async {

    print('タップする/しないのカテゴリをmodel層へ格納：$isSelected,$label');
    ///ベースはcategoriesとしてその一部を変更していくイメージ、リストの一部を切り出すと呼び出した時数が合わずにエラー
    ///trueだけを格納すると取り出す時変になるからtrue/falseまとめてリストへ格納

    //順番が変更されると重複登録が起こりエラー
    ///1.まずbreakfastCategoryはcategoriesを複製登録List<Category>.from(categories)

//    final  breakfastCategory =   List<Category>.from(categories);
//    breakfastCategory = categories ;
    ///2.isSelectedがtrueになったidと一致するものは削除する
    breakfastCategory.removeWhere((element) {
      return (element.id == id && element.isSelected==!isSelected);
    });
    ///3.改めてisSelected(=true)としてCategoryを新規登録で更新完了
    breakfastCategory.add(
        Category(
          mealType: mealType,
          id: id,
          categoryText: label,
          categoryIcon:  categoryIcon[id-1],
          isSelected: isSelected,
        )
    );

    print('idでソート前');
    breakfastCategory.forEach((category){
      print("${category.id}:${category.categoryText}");
    });
    ///4.ソートをかけて元の順番に
    breakfastCategory.sort((a,b) => a.id.compareTo(b.id));
    print('idでソート後');
    breakfastCategory.forEach((category){
      print("${category.id}:${category.categoryText}");
    });
    notifyListeners();
  }

  Future<void> lunchCategoryTapped(
      {MealType mealType, bool isSelected, String label, int id}) async {

    ///categoriesをそのまま使うと複製ではなく、breakfastとの連動してしまう
//    List<Category> lunchCategory =  categories;

    lunchCategory.removeWhere((element) {
      return (element.id == id && element.isSelected==!isSelected);
    });
    lunchCategory.add(
        Category(
          mealType: mealType,
          id: id,
          categoryText: label,
          categoryIcon:  categoryIcon[id-1],
          isSelected: isSelected,
        )
    );
    lunchCategory.sort((a,b) => a.id.compareTo(b.id));
    notifyListeners();
  }

  Future<void> snackCategoryTapped(
      {MealType mealType, bool isSelected, String label, int id}) async {
    snackCategory.removeWhere((element) {
      return (element.id == id && element.isSelected==!isSelected);
    });
    snackCategory.add(
        Category(
          mealType: mealType,
          id: id,
          categoryText: label,
          categoryIcon:  categoryIcon[id-1],
          isSelected: isSelected,
        )
    );
    snackCategory.sort((a,b) => a.id.compareTo(b.id));
    notifyListeners();
  }

  Future<void> dinnerCategoryTapped(
      {MealType mealType, bool isSelected, String label, int id}) async {
    dinnerCategory.removeWhere((element) {
      return (element.id == id && element.isSelected==!isSelected);
    });
    dinnerCategory.add(
        Category(
          mealType: mealType,
          id: id,
          categoryText: label,
          categoryIcon:  categoryIcon[id-1],
          isSelected: isSelected,
        )
    );
    dinnerCategory.sort((a,b) => a.id.compareTo(b.id));
    notifyListeners();
  }


  ///選択ボタンを押したらtrueのみのリストを表示するのではなく、
  ///trueもfalseも存在するカテゴリの中からisSelected:trueのものだけを表示する形へ変更

  Future<void> selectCategory() async {

    //todo breakfastCategoryの中でisSelectedがtrueのものだけを返す
    ///リスト再作成なのか、、リストそのままでtrueだけ選別できるのか


  }


}
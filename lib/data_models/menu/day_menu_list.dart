
import 'package:datebasejointest/data_models/product.dart';
import 'category_list.dart';

class DayMenuList {
  DayMenuList(
      this.id,
      this.dayMenu,
      this.breakfastCategory,
      this.breakfastProduct,
      this.lunchCategory,
      this.lunchProduct,
      this.snackCategory,
      this.snackProduct,
      this.dinnerCategory,
      this.dinnerProduct,
      this.breakfastMemo,
      this.lunchMemo,
      this.snackMemo,
      this.dinnerMemo);

  final int id;
  final String dayMenu; //○日目
  final List<Category> breakfastCategory;
  final List<Product> breakfastProduct;
  final String breakfastMemo;
  final List<Category> lunchCategory;
  final List<Product> lunchProduct;
  final String lunchMemo;
  final List<Category> snackCategory;
  final List<Product> snackProduct;
  final String snackMemo;
  final List<Category> dinnerCategory;
  final List<Product> dinnerProduct;
  final String dinnerMemo;
}

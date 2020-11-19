import 'package:datebasejointest/data_models/product.dart';
import 'package:datebasejointest/models/repository/home_repository.dart';
import 'package:datebasejointest/utils/constants.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier{
  final HomeRepository _homeRepository =HomeRepository();

  final List<Product> _products = variableProducts;
  List<Product> get products => _products;

  Future<void> getProductInfo() async{

    await _homeRepository.getProductInfo(_products);
    notifyListeners();
  }




}
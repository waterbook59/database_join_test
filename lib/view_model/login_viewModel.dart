

import 'package:datebasejointest/models/repository/user_repository.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier{
  final UserRepository userRepository;
  LoginViewModel({this.userRepository});

  bool isLoading =false;
  bool isSuccessful = false;

  ///初期画面でFutureBuilderでサインインしてるか否か
  Future<bool> isAnonymouslySignIn() async{
    return await userRepository.isAnonymouslySignIn();
  }

  ///ログインページでゲストでサインインする場合
  Future<void> anonymouslySignIn() async{
    isLoading = true;
    notifyListeners();

    isSuccessful = await userRepository.anonymouslySignIn();

    isLoading = false;
    notifyListeners();

  }

}
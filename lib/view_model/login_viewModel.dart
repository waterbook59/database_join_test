

import 'package:datebasejointest/models/repository/user_repository.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier{
  final UserRepository userRepository;
  LoginViewModel({this.userRepository});

  Future<bool> isAnonymouslySignIn() async{
    return await userRepository.isAnonymouslySignIn();
  }

}
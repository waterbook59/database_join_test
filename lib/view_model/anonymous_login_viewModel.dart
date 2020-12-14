

import 'package:datebasejointest/models/repository/user_repository.dart';
import 'package:flutter/material.dart';

class AnonymousLoginViewModel extends ChangeNotifier{
  final UserRepository userRepository;
  AnonymousLoginViewModel({this.userRepository});
}
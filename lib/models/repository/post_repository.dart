import 'dart:io';

import 'package:datebasejointest/data_models/user/anonymous_user.dart';
import 'package:datebasejointest/models/db/database_manager.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class PostRepository {
  final DatabaseManager databaseManager;

  PostRepository({this.databaseManager});

  Future<void> postFSFromCamera(AnonymousUser currentModelUser, File imageFromCamera, String text,
      DateTime validDateTime, String text2, int parse) async{

    final storageId = Uuid().v1();
    final imageUrl = await databaseManager.uploadImageToStorage(imageFromCamera, storageId);
    print('storageにアップロードした画像のUrl: $imageUrl');


  }
}
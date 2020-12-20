import 'dart:io';

import 'package:datebasejointest/data_models/menu/food_stuff_firebase.dart';
import 'package:datebasejointest/data_models/user/anonymous_user.dart';
import 'package:datebasejointest/models/db/database_manager.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class PostRepository {
  final DatabaseManager databaseManager;

  PostRepository({this.databaseManager});

  Future<void> postFSFromCamera({
    AnonymousUser currentUser,
    File imageFromCamera,
    String name,
    String category,
    DateTime validDateTime,
    String storage,
    int amount,
    int useAmount,
    int restAmount,
  }) async {
    final storageId = Uuid().v1();
    //画像とidを渡してアップロードした画像のstorage内のurl
    final imageUrl =
        await databaseManager.uploadImageToStorage(imageFromCamera, storageId);
    print('storageにアップロードした画像のUrl: $imageUrl');
    final postFoodStuff = FoodStuffFB(
      foodStuffId: Uuid().v1(),
      userId: currentUser.userId,
      imageUrl: imageUrl,
      //storageにアップロードした画像のurl
      imageStoragePath: storageId,
      //storageIdをもとにimageUrlが得られる
      name: name,
      category: category,
      validDate: validDateTime,
      storage: storage,
      amount: amount,
      useAmount: useAmount,
      restAmount: restAmount,
    );
    await databaseManager.insertFoodStuff(postFoodStuff);

  }
}

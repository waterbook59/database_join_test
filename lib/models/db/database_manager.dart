import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datebasejointest/data_models/menu/food_stuff_firebase.dart';
import 'package:datebasejointest/data_models/user/anonymous_user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';

///dbがFireStoreじゃなくなっても大丈夫なようにしておくのが良い

class DatabaseManager {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //登録ユーザーがいるかいないかをdbManagerでuserIDを下に検索
  Future<bool> searchUserInDb(auth.User firebaseUser) async{
    //collection('collectionPath')のcollectionPathには登録するコレクションの名前
    //読込(Read)/検索条件を指定して複数ドキュメントを取得
    final query = await _db.collection('users')
        .where('userId',isEqualTo: firebaseUser.uid).get();
    if(query.docs.length >0){
      return true;
    }
    return false;
  }

  //ユーザーデータ挿入(Insert,Create):docにuser.idを入れてsetすると後からユーザー情報紐付けやすい
  Future<void> insertUser(AnonymousUser user) async{
    await _db.collection('users').doc(user.userId).set(user.toMap());
  }

  Future<AnonymousUser> getUserInfoFromDbById(String userId) async{
    final query = await _db.collection('users')
        .where('userId',isEqualTo: userId).get();
    return AnonymousUser.fromMap(query.docs[0].data());
  }

  ///storageにFileをアップロードしてダウンロードUrl(パス)を返す
  //保存場所
  Future<String> uploadImageToStorage(File imageFile, String storageId) async{
    //childにstoragePath(storageId)を持ってくる
    final storageRef = FirebaseStorage.instance.ref().child(storageId);
    //Fileを保存場所にアップロード
    final uploadTask = storageRef.putFile(imageFile);
    //アップロードが終わったらファイルのダウンロードurl取得
    //FirebaseStorage5.0以降はonCompleteメソッドなくなった
    return uploadTask.then((TaskSnapshot taskSnapshot) => taskSnapshot.ref.getDownloadURL());
  }

  //todo cloudFirestoreに登録:foodStuffIdじゃなくてuserIdでセットすべき？？
  Future<void> insertFoodStuff(FoodStuffFB postFoodStuff) async{
    await _db.collection('foodstuffs').doc(postFoodStuff.foodStuffId).set(postFoodStuff.toMap());
  }

  ///cloudFirestoreから読込
  Future<List<FoodStuffFB>> getFoodStuffList(String userId) async{
    //cloudFirestoreにデータあるかどうか判別（しないとアプリ落ちる）
    final query = await _db.collection('foodstuffs').get();
    if(query.docs.length ==0) return <FoodStuffFB>[];
    //todo 自分以外にデータを共有するユーザー(partnerの名前でcollection作る予定)を加える
    var userIds = await  getFollowingUserIds(userId);
   // 自分がフォローしてるユーザーに自分を加える
    userIds.add(userId);
    var results = <FoodStuffFB>[];
    //userIdに一致しているデータを投稿順に降順で並べる
    await _db.collection('foodstuffs').where('userId',whereIn:userIds).orderBy('postDateTime',descending: true).get().then((value) {
      value.docs.forEach((element) {
        results.add(FoodStuffFB.fromMap(element.data()));
      });
    });
    print('FoodStuffを投稿順にとってくる：$results');
   return results;
  }

  Future<List<String>> getFollowingUserIds(String userId) async{
    final query = await _db.collection('users').doc(userId).collection(
        'partner').get();
    if (query.docs.length == 0) return List();
    var userIds  = <String>[];
    query.docs.forEach((id) {
      userIds.add(id.data()['userId']); //userIdがキー
    });
    return userIds;
  }

}
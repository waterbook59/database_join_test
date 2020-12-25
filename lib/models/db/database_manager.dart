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
  Future<String> uploadImageToStorage(File postImage, String storageId) async{
    //childにstoragePath(storageId)を持ってくる
    final storageRef = FirebaseStorage.instance.ref().child(storageId);
    //Fileを保存場所にアップロード
    final uploadTask = storageRef.putFile(postImage);
    //アップロードが終わったらファイルのダウンロードurl取得
    //FirebaseStorage5.0以降はonCompleteメソッドなくなった
    return uploadTask.then((TaskSnapshot taskSnapshot) => taskSnapshot.ref.getDownloadURL());
  }

  //todo cloudFirestoreに登録:foodStuffIdじゃなくてuserIdでセットすべき？？
  Future<void> insertFoodStuff(FoodStuffFB postFoodStuff) async{
    await _db.collection('foodStuffs').doc(postFoodStuff.foodStuffId).set(postFoodStuff.toMap());
  }

  ///cloudFirestoreから読込
  Future<List<FoodStuffFB>> getFoodStuffList(String userId) async{
    //cloudFirestoreにデータあるかどうか判別（しないとアプリ落ちる）
    final query = await _db.collection('foodStuffs').get();
    if(query.docs.length ==0) return <FoodStuffFB>[];
    //todo 自分以外にデータを共有するユーザー(partnerの名前でcollection作る予定)を加える
    var userIds = await  getFollowingUserIds(userId);
   // 自分がフォローしてるユーザーに自分を加える
    userIds.add(userId);
    var results = <FoodStuffFB>[];

//print('query.docs.length:${query.docs.length}');
//print('cloudFirestoreから読込userId:$userId');
//print('cloudFirestoreから読込userIds:${userIds[0]}');

    //userIdに一致しているデータを投稿順に昇順(古いものから順番に)で並べる
    await _db.collection('foodStuffs').where('userId',whereIn:userIds).orderBy('postDatetime', descending: true).get()
        .then((value) {
          value.docs.forEach((element) {
          results.add(FoodStuffFB.fromMap(element.data()));
      });
    });
    ///whereを使えばフィールド内で一致しているドキュメント群をとってこれる
//    QuerySnapshot qSnapshot =await _db.collection('foodStuffs').where('userId',whereIn:userIds).get();
    //print('コレクションからドキュメント群/querySnapshot:${qSnapshot.docs[0].data()}');

//    QuerySnapshot query
    ///doc()に入れるのはドキュメントを追加に書いてあるモノ(今回はfoodStuffIdなのでuserIdで検索してもnull)
//   DocumentSnapshot docSnapshot = await _db.collection('foodStuffs').doc(userId).get();
//    print('コレクションからuserIdに紐づくドキュメント/docSnapshot.data:${docSnapshot.data()}');

//print('FoodStuffを投稿順にとってくる：$results');
   return results;
  }

///realtime更新に変更
   Future<List<FoodStuffFB>> getFoodStuffListRealtime(String userId) async{
    //cloudFirestoreにデータあるかどうか判別（しないとアプリ落ちる）
     final query = await _db.collection('foodStuffs').get();
     if(query.docs.length ==0) return <FoodStuffFB>[];
     //todo 自分以外にデータを共有するユーザー(partnerの名前でcollection作る予定)を加える
     var userIds = await  getFollowingUserIds(userId);
     // 自分がフォローしてるユーザーに自分を加える
     userIds.add(userId);
     var results = <FoodStuffFB>[];


    final snapshots =  _db.collection('foodStuffs').where('userId',whereIn:userIds).orderBy('postDatetime', descending: true).snapshots();
    snapshots.listen((snapshot) {
      final docs = snapshot.docs;
      docs.forEach((element) {
        results.add(FoodStuffFB.fromMap(element.data()));
      });
    });
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

  ///FoodStuff削除
  Future<void> deleteFoodStuff(String foodStuffId, String imageStoragePath) async{
  //foodStuffsから削除
    final foodStuffRef = _db.collection('foodStuffs').doc(foodStuffId);
    await foodStuffRef.delete();
  //todo menuに紐付ける場合はそのコレクションからも削除
  //Storageから画像削除
    final storageRef = FirebaseStorage.instance.ref().child(imageStoragePath);
    storageRef.delete();
  }



}
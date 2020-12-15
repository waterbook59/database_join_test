import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datebasejointest/data_models/user/anonymous_user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

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

}
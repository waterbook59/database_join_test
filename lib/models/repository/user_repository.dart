import 'package:datebasejointest/models/db/database_manager.dart';
///モデルクラスをUserとする場合、重複回避
import 'package:firebase_auth/firebase_auth.dart' as auth;

class UserRepository{
  final DatabaseManager databaseManager;
  UserRepository({this.databaseManager});


  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  Future<bool> isAnonymouslySignIn() async{
    ///firebase_auth 0.18に伴う破壊的変更、currentUserがプロパティになって()とawait不要
    final firebaseUser = _auth.currentUser;
    if(firebaseUser !=null){
      return true;
    }
    return false;
  }
}
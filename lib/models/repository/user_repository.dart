import 'package:datebasejointest/data_models/user/anonymous_user.dart';
import 'package:datebasejointest/models/db/database_manager.dart';
///モデルクラスをUserとする場合、重複回避
import 'package:firebase_auth/firebase_auth.dart' as auth;


class UserRepository{
  final DatabaseManager databaseManager;
  UserRepository({this.databaseManager});

  static AnonymousUser currentModelUser;
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  Future<bool> isAnonymouslySignIn() async{
    ///firebase_auth 0.18に伴う破壊的変更、currentUserがプロパティになって()とawait不要
    final firebaseUser = _auth.currentUser;
    if(firebaseUser !=null){
      ///サインアウトして次回アプリが起動した時にログインした記録が残っていれば自動的にログインされるが、
      ///currentModelUserの値がnullのままになってしまうので、DBがひっぱってきたデータを入れておきたい
      currentModelUser = await databaseManager.getUserInfoFromDbById(firebaseUser.uid);
      return true;
    }
    return false;
  }

  ///匿名認証
  Future<bool> anonymouslySignIn() async{
    try{
      final auth.UserCredential userCredential = await _auth.signInAnonymously();
      //この時点で匿名ユーザーが作られるはず
      print('userCredential.user.uid:${userCredential.user.uid}');
      final firebaseUser = userCredential.user;
      if(firebaseUser ==null){
        return false;
      }
      // DBにUser情報を登録
      //登録ユーザーがいるかいないかをdbManagerでuserIDを下に検索
      final isUserExistedInDb =await databaseManager.searchUserInDb(firebaseUser);
      ///登録ユーザーいない場合、登録
      if(!isUserExistedInDb){
        //firebaseUserをモデルクラスへ変換したものを登録
        await databaseManager.insertUser(_convertToUser(firebaseUser));
      }
      ///登録ユーザーいる場合
      //毎度DBにアクセスしてユーザー情報取ってくるのではなく、取ってきたものをstaticに格納
      currentModelUser = await databaseManager.getUserInfoFromDbById(firebaseUser.uid);
      return true;
    }on auth.FirebaseAuthException catch (e){
      print('Failed with error code: ${e.code}');
      print(e.message);
      return false;
    }
  }

  _convertToUser(auth.User firebaseUser) {
    return AnonymousUser(
      userId: firebaseUser.uid,
      displayName: firebaseUser.displayName,
      inAppUserName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL,
    );
  }


  //todo Google認証,Apple認証,番号認証(dynamicLinkは番号認証がいいのか？？)


}
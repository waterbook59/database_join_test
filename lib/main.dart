import 'package:datebasejointest/di/providers.dart';
import 'package:datebasejointest/view_model/login_viewModel.dart';
import 'package:datebasejointest/views/home_screen.dart';
import 'package:datebasejointest/views/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localize/japanese_cupertion_localizations.dart' as jcl;
import 'package:provider/provider.dart';

//MyProductInfoDB myProductInfoDB;

void main() async{
  ///main関数での非同期処理
  WidgetsFlutterBinding.ensureInitialized();
  ///firebase_core 0.5.0以上の時初期化必要
  await Firebase.initializeApp();
//  myProductInfoDB = MyProductInfoDB();
  runApp(
// MultiProviderへ変更
//      ChangeNotifierProvider<DataRegistrationViewModel>(
////        create: (context)=>DataRegistrationViewModel(),
////        child: MyApp(),
////      )
  MultiProvider(
    providers: globalProviders,
    child: MyApp(),
  )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final loginVieModel = Provider.of<LoginViewModel>(context,listen: false);

    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        jcl.JapaneseCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('ja', 'JP'),
      ],
      locale: Locale('ja', 'JP'),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: loginVieModel.isAnonymouslySignIn(),
        builder: (context, AsyncSnapshot<bool> snapshot){
          if(snapshot.hasData && snapshot.data){
            return HomeScreen();
          }else{
            return LoginScreen();
          }
        },

      )
    );
  }
}


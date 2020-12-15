import 'package:datebasejointest/view_model/login_viewModel.dart';
import 'package:datebasejointest/views/components/button_with_icon.dart';
import 'package:datebasejointest/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<LoginViewModel>(
          builder: (context, model, child) {
            return model.isLoading
                ? CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('備蓄＋献立でもしものときを想定！Bichicon'),
                      SizedBox(
                        height: 8.0,
                      ),
                      ButtonWithIcon(
                        icon: FaIcon(FontAwesomeIcons.signInAlt),
                        label: 'ゲストで始める',
                        onPressed: () => login(context),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }

  login(BuildContext context) async {
    final loginVieModel = Provider.of<LoginViewModel>(context, listen: false);
    await loginVieModel.anonymouslySignIn();
    if (!loginVieModel.isSuccessful) {
      Fluttertoast.showToast(msg: 'signInFailed');
      return;
    }
    _openHomeScreen(context);
  }

  void _openHomeScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
  }
}

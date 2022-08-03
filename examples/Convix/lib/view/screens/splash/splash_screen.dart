import 'package:covermeapp/config/colors.dart';
import 'package:covermeapp/config/data.dart';
import 'package:covermeapp/config/default_data.dart';
import 'package:covermeapp/view/screens/intro/intro_screen.dart';
import 'package:covermeapp/view/screens/passoword/password_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    User.email = _pref.getString(PrefString.email) ?? "";
    String token = _pref.getString(PrefString.token) ?? "";
    String password = _pref.getString(PrefString.password) ?? "";
    if (token.toString().length == 0 && password.toString().length == 0) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => IntroScreen()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PasswordScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cMain,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/logo.png",height: MediaQuery.of(context).size.height/4),
            Text(
              'Hidder',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                fontFamily: "poppins",
                color: cWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

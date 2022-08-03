import 'package:covermeapp/config/colors.dart';
import 'package:covermeapp/config/data.dart';
import 'package:covermeapp/config/default_data.dart';
import 'package:covermeapp/config/text-style.dart';
import 'package:covermeapp/view/screens/login_signup/login_screen.dart';
import 'package:covermeapp/view/screens/login_signup/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    User.email = _pref.getString(PrefString.email) ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cMain,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            Image.asset("assets/logo.png", height: MediaQuery.of(context).size.height / 4),
            Spacer(),
            functionRow(title: 'Private Texting', icon: Icons.message),
            functionRow(title: 'Private Sharing', icon: Icons.share),
            functionRow(title: 'Private Storage', icon: Icons.folder),
            SizedBox(height: 30),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: cWhite,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text('Get Start', style: blueTextStyle.copyWith(fontSize: 20)),
              ),
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(
                      isBackArrowShow: true,
                    ),
                  ),
                );
              },
              child: Text(
                'Already have an account?',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: cWhite,
                  fontSize: 18,
                ),
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GestureDetector(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'By tapping "Get Start" or "Already have an account?",\n',
                        style: TextStyle(
                          color: cWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      TextSpan(
                        text: 'you agree to the\t',
                        style: TextStyle(
                          color: cWhite,
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: 'Terms of Service\t',
                        style: TextStyle(
                          color: cWhite,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w200,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: '\tand\t',
                        style: TextStyle(
                          color: cWhite,
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: '\tPrivacy Policy',
                        style: TextStyle(
                          color: cWhite,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget functionRow({String? title, IconData? icon}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(icon),
          iconSize: 35,
          color: cWhite,
        ),
        SizedBox(width: 5),
        Text(
          '$title',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontFamily: "poppins",
            fontSize: 18,
            color: cWhite,
          ),
        ),
      ],
    ),
  );
}

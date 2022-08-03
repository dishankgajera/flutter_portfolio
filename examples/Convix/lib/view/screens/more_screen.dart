import 'package:covermeapp/config/colors.dart';
import 'package:covermeapp/config/data.dart';
import 'package:covermeapp/config/text-style.dart';
import 'package:covermeapp/view/screens/intro/intro_screen.dart';
import 'package:covermeapp/view/widgets/common_widget/dialogbox/common_dialogbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cOffWhite,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: cMain,
        title: Text(
          'More',
          style: titleTextStyle,
        ),
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: () {
            },
            child: Container(
              color: cWhite,
              child: ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: cMain.withOpacity(0.4),
                  ),
                  child: Icon(
                    Icons.person,
                    color: cMain,
                    size: 35,
                  ),
                ),
                title: Text(
                  User.email,
                  maxLines: 1,
                  style: normalTextStyle.copyWith(fontWeight: FontWeight.w400),
                ),
                subtitle: Text(
                  'profile ID: ${User.profileId}',
                  style: normalTextStyle.copyWith(fontSize: 12, color: cGray),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              showDialog(
                context: context,
                builder: (context) => CommonDialog(
                  isTwoButton: true,
                  buttonText1: "yes",
                  button1OnPress2: () {
                    Navigator.pop(context);
                  },
                  buttonText2: "No",
                  subTitle: "Are you sure ? You want to logout ?",
                  titleText: "Alert!",
                  button1OnPress: () {
                    pref.clear();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => IntroScreen()),
                        (route) => false);
                  },
                ),
              );
            },
            child: Container(
              height: 55,
              color: cWhite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Logout',
                    style: redTexStyle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget listTile(
    {required String textName,
    Function? onPress,
    IconData? icon,
    IconData? icon1,
    required String textName1}) {
  return ListTile(
    leading: Icon(icon1),
    minVerticalPadding: 0.0,
    contentPadding: EdgeInsets.only(left: 15, right: 15, bottom: 0.0, top: 0.0),
    title: Text(
      textName,
      style: normalTextStyle,
    ),
    trailing: Icon(
      Icons.arrow_forward_ios_rounded,
      color: cGray,
      size: 23,
    ),
    onTap: onPress as void Function()?,
  );
}

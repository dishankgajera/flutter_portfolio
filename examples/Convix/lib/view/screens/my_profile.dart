import 'package:covermeapp/config/colors.dart';
import 'package:covermeapp/config/text-style.dart';
import 'package:covermeapp/view/screens/more_screen.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cOffWhite,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: cMain,
        leading: InkWell(
          onTap: () {
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => MoreScreen(),
              ),
            );
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text(
          'My Profile',
          style: titleTextStyle,
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 15),
          Container(
            color: cWhite,
            child: Column(
              children: [
                listTile(
                  textName: 'Profile Photo',
                  isShowContainer: true,
                  icon: Icons.person,
                ),
                Divider(
                  indent: 15,
                  thickness: 0.2,
                  color: cBlack,
                ),
                listTile(textName: 'Name', textName1: 'jsavaliya'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget listTile(
    {required String textName,
    String? textName1,
    IconData? icon,
    Function? onPress,
    bool isShowContainer = false}) {
  return ListTile(
    title: Text(
      textName,
      style: normalTextStyle.copyWith(fontWeight: FontWeight.w400),
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        isShowContainer
            ? Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cMain.withOpacity(0.4),
                ),
                child: Icon(icon, color: cMain, size: 35),
              )
            : Container(),
        SizedBox(width: isShowContainer ? 0 : 7),
        Text(
          textName1 ?? " ",
          style: grayTextStyle.copyWith(fontWeight: FontWeight.w400, fontSize: 15),
        ),
        SizedBox(width:  isShowContainer ? 0 : 5),
        Icon(
          Icons.arrow_forward_ios_rounded,
          color: cGray,
          size: 23,
        ),
      ],
    ),
  );
}

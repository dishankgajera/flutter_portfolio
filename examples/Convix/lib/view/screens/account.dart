import 'package:covermeapp/config/colors.dart';
import 'package:covermeapp/config/data.dart';
import 'package:covermeapp/config/text-style.dart';
import 'package:covermeapp/view/screens/my_profile.dart';
import 'package:covermeapp/view/screens/more_screen.dart';
import 'package:flutter/material.dart';
class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
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
              MaterialPageRoute(builder: (context) => MoreScreen(),),
            );
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text(
          'My Account & Password',
          style: titleTextStyle,
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyProfile(),),
              );
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
                  'Hidder ID: ${User.profileId}',
                  style: normalTextStyle.copyWith(fontSize: 12, color: cGray),
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 23),
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            color: cWhite,
            child: Column(
              children: [
                listTile(
                  textName: 'Email',
                  textName1: User.email,
                  onPress: () {},
                ),
                Divider(
                  indent: 15,
                  thickness: 0.2,
                  color: cBlack,
                ),
                listTile(
                  textName: 'Mobile',
                  textName1: 'Not set',
                  onPress: () {},
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Container(
            color: cWhite,
            child: Column(
              children: [
                listTile(
                  textName: 'Change CoverMe Password',
                  onPress: () {},
                ),
                Divider(
                  indent: 15,
                  thickness: 0.2,
                  color: cBlack,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {},
            child: Container(
              height: 55,
              color: cWhite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Deactivate Account',
                    style: redTexStyle,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'All your personal information and content in CoverMe will be permanently deleted once you deactivate your account.',
              style: grayTextStyle.copyWith(fontWeight: FontWeight.w400, fontSize: 12),
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
    Function? onPress}) {
  return ListTile(
    title: Text(
      textName,
      style: normalTextStyle.copyWith(fontWeight: FontWeight.w400),
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: cRed),
        SizedBox(width: 7),
        Text(
          textName1 ?? " ",
          style: grayTextStyle.copyWith(fontWeight: FontWeight.w400),
        ),
        SizedBox(width: 5),
        Icon(
          Icons.arrow_forward_ios_rounded,
          color: cGray,
          size: 23,
        ),
      ],
    ),
  );
}

import 'package:covermeapp/config/colors.dart';
import 'package:covermeapp/config/data.dart';
import 'package:covermeapp/config/default_data.dart';
import 'package:covermeapp/config/text-style.dart';
import 'package:covermeapp/controller/chat_controller/chat_controller.dart';
import 'package:covermeapp/model/login_model.dart';
import 'package:covermeapp/repository/login_repository.dart';
import 'package:covermeapp/view/screens/dashboard/dashboard_screen.dart';
import 'package:covermeapp/view/widgets/common_widget/Toast/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordScreen extends StatefulWidget {
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();

  final chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cMain.withOpacity(0.6),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(height: 100),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  child: TextFormField(
                    style: titleTextStyle,
                    textAlign: TextAlign.center,
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      hintStyle: titleTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: cWhite.withOpacity(0.7),
                      ),
                      border: InputBorder.none,
                    ),
                    obscureText: true,
                    cursorColor: cWhite,
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () async {
                    if (passwordController.text.length == 0) {
                      showToastMessage(context: context, message: "Enter Password !");
                    } else {
                      login();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    width: MediaQuery.of(context).size.width - 270,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: cMain.withOpacity(0.5),
                      boxShadow: [
                        BoxShadow(
                          color: cBlack.withOpacity(0.2),
                          spreadRadius: 0.5,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Sign In',
                        style: titleTextStyle.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void login() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    LoginModel loginModel = await LoginRepo.login(
        context: context, email: sharedPreferences.getString(PrefString.email), password: passwordController.text);
    if (loginModel.status == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      User.email = loginModel.data!.email!;
      User.profileId = loginModel.data!.profileId!.toString();
      prefs.setString(PrefString.email, loginModel.data!.email!);
      prefs.setString(PrefString.password, passwordController.text.toString());
      prefs.setString(PrefString.token, loginModel.data!.token!);
      prefs.setString(User.id, loginModel.data!.id!);
      prefs.setString(PrefString.userId, loginModel.data!.id!);
      showToastMessage(context: context, message: loginModel.message);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DashboardScreen()), (route) => false);
    } else {
      showToastMessage(context: context, message: loginModel.message);
    }
  }
}

import 'package:covermeapp/config/colors.dart';
import 'package:covermeapp/config/data.dart';
import 'package:covermeapp/config/default_data.dart';
import 'package:covermeapp/config/text-style.dart';
import 'package:covermeapp/controller/chat_controller/chat_controller.dart';
import 'package:covermeapp/model/login_model.dart';
import 'package:covermeapp/repository/login_repository.dart';
import 'package:covermeapp/view/screens/dashboard/dashboard_screen.dart';
import 'package:covermeapp/view/screens/login_signup/signup_screen.dart';
import 'package:covermeapp/view/screens/login_signup/wrong_password_screen.dart';
import 'package:covermeapp/view/widgets/common_widget/Toast/toast_message.dart';
import 'package:covermeapp/view/widgets/common_widget/textformfield/common_textformfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  final bool? isBackArrowShow;

  LoginScreen({@required this.isBackArrowShow});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cOffWhite,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: widget.isBackArrowShow!,
        backgroundColor: cMain,
        centerTitle: true,
        title: Text("SigIn Your Account", style: titleTextStyle),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          shrinkWrap: true,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                    "* Please enter your Email address and the Hidder password:",
                    style: normalTextStyle.copyWith(
                        fontSize: 10, color: Colors.blueGrey))),
            gTextFormFieldContainer(
              hintText: "Enter Your Email ID",
              needValidation: true,
              isEmailValidator: true,
              validationMessage: "email",
              leadingIcon: Icons.email_outlined,
              controller: emailController,
            ),
            gTextFormFieldContainer(
              hintText: "Enter Your Password",
              needValidation: true,
              obscureText: true,
              validationMessage: "password",
              leadingIcon: Icons.lock_outline,
              controller: passwordController,
            ),
            SizedBox(
              height: 20,
            ),
            buttonView(
              context: context,
              buttonName: "Continue",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  login();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void login() async {
    LoginModel loginModel = await LoginRepo.login(
        context: context,
        email: emailController.text,
        password: passwordController.text);
    if (loginModel.status == 200) {
      print(
          "LOGIN FUNCTION PROFILE ID ::::: ${loginModel.data!.profileId!.toString()}");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      User.email = loginModel.data!.email!;
      User.profileId = loginModel.data!.profileId!.toString();
      prefs.setString(PrefString.email, loginModel.data!.email!);
      prefs.setString(PrefString.password, passwordController.text.toString());
      prefs.setString(PrefString.token, loginModel.data!.token!);
      prefs.setString(User.id, loginModel.data!.id!);
      prefs.setString(PrefString.userId, loginModel.data!.id!);
      prefs.setString(
          PrefString.profileId, loginModel.data!.profileId!.toString());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => WrongPassword()),
          (route) => true);
    }
  }
}

import 'package:covermeapp/config/colors.dart';
import 'package:covermeapp/config/data.dart';
import 'package:covermeapp/config/default_data.dart';
import 'package:covermeapp/config/text-style.dart';
import 'package:covermeapp/model/signup_model.dart';
import 'package:covermeapp/repository/signup_repository.dart';
import 'package:covermeapp/view/screens/dashboard/dashboard_screen.dart';
import 'package:covermeapp/view/widgets/common_widget/Toast/toast_message.dart';
import 'package:covermeapp/view/widgets/common_widget/textformfield/common_textformfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isVisible = true;
  bool isVisible2 = true;

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: cOffWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cMain,
        centerTitle: true,
        title: Text("Set Up Your Account", style: titleTextStyle),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 10),
          children: [
            gTextFormFieldContainer(
                hintText: "First Name",
                controller: firstName,
                needValidation: true,
                validationMessage: "firstName",
                leadingIcon: Icons.assignment_ind_outlined),
            gTextFormFieldContainer(
                hintText: "Last Name",
                controller: lastName,
                needValidation: true,
                validationMessage: "lastName",
                leadingIcon: Icons.assignment_ind_outlined),
            gTextFormFieldContainer(
              hintText: "Enter Your Email ID",
              needValidation: true,
              isEmailValidator: true,
              validationMessage: "email",
              leadingIcon: Icons.email_outlined,
              controller: email,
            ),
            gTextFormFieldContainer(
                hintText: "Enter 4-16 characters",
                obscureText: isVisible,
                needValidation: true,
                validationMessage: "passWord",
                controller: password,
                iconSuffix: isVisible ? Icons.visibility_off : Icons.visibility,
                onSuffixIconPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                leadingIcon: Icons.lock_outline),
            gTextFormFieldContainer(
                controller: confirmPassword,
                needValidation: true,
                validationMessage: "Confirm passWord",
                hintText: "Enter the password again",
                obscureText: isVisible2,
                leadingIcon: Icons.lock_outline),
            SizedBox(height: 20),
            buttonView(
              context: context,
              buttonName: "Continue",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (password.text.length < 4) {
                    showToastMessage(context: context, message: "Password must be 4 character !");
                  } else if (confirmPassword.text.length < 4) {
                    showToastMessage(context: context, message: "Confirm Password must be 4 character !");
                  } else if (password.text != confirmPassword.text) {
                    showToastMessage(context: context, message: "Password must be same");
                  } else if (password.text.length >= 4 &&
                      confirmPassword.text.length >= 4 &&
                      (password.text == confirmPassword.text)) {
                    signUp();
                  } else {
                    showToastMessage(context: context, message: "Something went wrong !");
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void signUp() async {
    SignUpModel signUpModel = await SignUpRepo.signUp(
        context: context, email: email.text, firstName: firstName.text, lastName: lastName.text, password: password.text);
    if (signUpModel.status == 200) {
      showToastMessage(context: context, message: signUpModel.message);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      User.email = signUpModel.data!.email!;
      User.profileId = signUpModel.data!.profileId!.toString();
      prefs.setString(PrefString.email, signUpModel.data!.email!);
      prefs.setString(PrefString.password, passwordController.text.toString());
      prefs.setString(PrefString.token, signUpModel.data!.token!);
      prefs.setString(User.id, signUpModel.data!.id!);
      prefs.setString(PrefString.userId, signUpModel.data!.id!);
      prefs.setString(
          PrefString.profileId, signUpModel.data!.profileId!.toString());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => DashboardScreen(

                  )),
          (route) => false);
    } else {
      showToastMessage(context: context, message: signUpModel.message);
    }
  }
}

Widget buttonView({
  @required BuildContext? context,
  Function()? onPressed,
  @required String? buttonName,
}) {
  return InkWell(
    child: Container(
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      margin: EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: cMain, borderRadius: BorderRadius.circular(25)),
      child: Center(
        child: Text(
          buttonName!,
          style: titleTextStyle.copyWith(fontSize: 18),
        ),
      ),
    ),
    onTap: onPressed,
  );
}

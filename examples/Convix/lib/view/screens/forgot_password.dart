import 'package:covermeapp/config/colors.dart';
import 'package:covermeapp/config/text-style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cOffWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cMain,
        centerTitle: true,
        title: Text("Forgot Password", style: titleTextStyle),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 14),
            child: Text('Next', style: titleTextStyle.copyWith(fontSize: 16)),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 15),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16),
                child:
                    Text("Please enter your contact's CoverMe ID", style: grayTextStyle),
              )),
          SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              color: cWhite,
            ),
            child: Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                    // contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintText: "Enter your email address",
                    hintStyle: grayTextStyle.copyWith(color: cGray.withOpacity(0.5)),
                    // prefixIcon: Icon(CupertinoIcons.search),
                    contentPadding: EdgeInsets.only(left: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

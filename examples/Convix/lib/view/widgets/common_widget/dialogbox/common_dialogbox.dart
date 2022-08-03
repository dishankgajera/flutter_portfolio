import 'package:covermeapp/config/colors.dart';
import 'package:covermeapp/config/text-style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CommonDialog extends StatelessWidget {
  final String? titleText;
  final String? subTitle;
  final String? buttonText1;
  final String? buttonText2;
  final  Function()? button1OnPress;
  final Function()? button1OnPress2;
  final bool isTwoButton;

  const CommonDialog({Key? key, this.titleText, this.subTitle, this.buttonText1, this.buttonText2, this.button1OnPress, this.button1OnPress2, this.isTwoButton = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhite.withOpacity(0.4),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: cMain,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  titleText!,
                  style: titleTextStyle,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Text(
                  subTitle!,
                  style: normalTextStyle.copyWith(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              isTwoButton ? Container(
                decoration: BoxDecoration(
                    color: cWhite,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: cMain,
                            borderRadius: BorderRadius.circular(5)),
                        child: InkWell(
                          onTap: button1OnPress!,
                          child: Text(
                            buttonText1!,
                            style: titleTextStyle,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: cMain,
                            borderRadius: BorderRadius.circular(5)),
                        child: InkWell(
                          onTap: button1OnPress2,
                          child: Text(buttonText2!,
                            style: titleTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ) : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: cMain,
                        borderRadius: BorderRadius.circular(5)),
                    child: InkWell(
                      onTap: button1OnPress,
                      child: Text(
                       buttonText1!,
                        style: titleTextStyle,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

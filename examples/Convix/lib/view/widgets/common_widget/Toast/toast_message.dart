import 'package:covermeapp/config/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToastMessage({
  @required BuildContext? context,
  String? message,
}) {
  Fluttertoast.showToast(
    msg: message!,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: cGray,
    textColor: cOffWhite,
  );
}

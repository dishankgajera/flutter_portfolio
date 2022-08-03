import 'package:covermeapp/config/colors.dart';
import 'package:flutter/material.dart';

void showLoadingDialog({
  @required BuildContext? context,
  Color? barrierColor,
}) {
  Future.delayed(Duration(seconds: 0), () {
    showDialog(
        context: context!,
        barrierColor: barrierColor ?? cWhite.withOpacity(0.5),
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: cMain.withOpacity(0.75), borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(cMain.withOpacity(0.5)),
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Loading ...",
                        style: TextStyle(color: Colors.black, fontSize: 18)),
                  ],
                ),
              ),
            ),
          );
        });
  });
}

void hideLoadingDialog({@required BuildContext? context}) {
  Navigator.pop(context!, false);
}

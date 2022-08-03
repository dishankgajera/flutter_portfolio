import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dialog_utils.dart';

class PermissionUtils {
  static void requestPermission(
    BuildContext context, {
    Function? permissionGrant,
    Function? permissionDenied,
    Function? permissionNotAskAgain,
    bool isOpenSettings = false,
    bool isShowMessage = false,
  }) async{
    print("PERMISSION GETTING START _+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+__");
    await [
      Permission.microphone,
      Permission.camera,
    ].request().then((statuses) {
      var allPermissionGranted = true;

      statuses.forEach((key, value) {
        allPermissionGranted =
            allPermissionGranted && (value == PermissionStatus.granted);
      });

      if (allPermissionGranted) {
        if (permissionGrant != null) {
          permissionGrant();
        }
      } else {
        if (permissionDenied != null) {
          permissionDenied();
        }
        if (isOpenSettings) {
          DialogUtils.showOkCancelAlertDialog(
            context: context,
            message: "Permission alert !",
            cancelButtonTitle: Platform.isAndroid
                ? "NO"
                : "CANCLE",
            okButtonTitle: Platform.isAndroid
                ? "YES"
                : "OK",
            cancelButtonAction: () {},
            okButtonAction: () async{
              await openAppSettings();
            },
          );
        } else if (isShowMessage) {
          DialogUtils.showAlertDialog(
              context, "ALERT FOR PERMISSIONS.");
        }
      }
    });
    print("PERMISSION GETTING END _+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+__");
  }
}

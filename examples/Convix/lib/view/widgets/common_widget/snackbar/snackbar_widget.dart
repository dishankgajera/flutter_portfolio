import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowSnackBar {
  static void error(String error) {
    Get.snackbar(
      'Error',
      '$error',
      duration: Duration(seconds: 4),
      backgroundColor: Colors.black,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      icon: Icon(
        Icons.error,
        color: Colors.red,
      ),
    );
  }

  static void success(String message) {
    Get.snackbar(
      'Success',
      '$message',
      duration: Duration(seconds: 4),
      backgroundColor: Colors.black,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      icon: Icon(
        Icons.check,
        color: Colors.green,
      ),
    );
  }
}

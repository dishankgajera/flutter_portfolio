import 'package:covermeapp/config/default_data.dart';
import 'package:covermeapp/model/signup_model.dart';
import 'package:covermeapp/utils/network_http.dart';
import 'package:covermeapp/view/widgets/common_widget/loader/loading_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class SignUpRepo {
  static Future? signUp({
    required BuildContext? context,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
  }) async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    var deviceToken = await firebaseMessaging.getToken().then((token) {
      return token;
    });
    showLoadingDialog(context: context);
    print("---------------phase 1--------------------");
    Map response = await HttpHandler.postHttpMethod(url: DefaultApiString.SignUp, data: {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "deviceToken": deviceToken
    });
    if (response["error_description"] == null) {
      hideLoadingDialog(context: context);
      return signUpModelFromJson(response['body']);
    } else if (response["error_description"] != null) {
      hideLoadingDialog(context: context);
      return signUpModelFromJson(response['body']);
    } else {
      hideLoadingDialog(context: context);
      return null;
    }
  }
}

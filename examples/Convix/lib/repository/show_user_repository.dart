import 'package:covermeapp/config/default_data.dart';
import 'package:covermeapp/model/show_user_model.dart';
import 'package:covermeapp/utils/network_http.dart';
import 'package:covermeapp/view/widgets/common_widget/loader/loading_dialog.dart';
import 'package:flutter/cupertino.dart';

class ShowUserRepo {
  static showUser({BuildContext? context}) async {
    showLoadingDialog(context: context);
    Map response = await HttpHandler.getHttpMethod(url: DefaultApiString.ShowUser);
    if (response["error_description"] == null) {
      hideLoadingDialog(context: context);
      return showUserModelFromJson(response['body']);
    } else if (response["error_description"] != null) {
      hideLoadingDialog(context: context);
      return showUserModelFromJson(response['body']);
    } else {
      hideLoadingDialog(context: context);
      return null;
    }
  }
}

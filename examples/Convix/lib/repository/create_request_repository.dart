import 'package:covermeapp/config/default_data.dart';
import 'package:covermeapp/model/create_request_model.dart';
import 'package:covermeapp/utils/network_http.dart';
import 'package:covermeapp/view/widgets/common_widget/loader/loading_dialog.dart';
import 'package:flutter/cupertino.dart';

class CreateRequestRepo {
  static Future createRequest({
    required BuildContext context,
    String? requestedId,
    String? userId,
  }) async {
    showLoadingDialog(context: context);
    Map response =
    await HttpHandler.postHttpMethod(url: DefaultApiString.createRequest, data: {
      "requestedId": requestedId,
      "userId": userId,

    });
    if (response["error_description"] == null) {
      hideLoadingDialog(context: context);
      return createRequestModelFromJson(response['body']);
    } else if (response["error_description"] != null) {
      hideLoadingDialog(context: context);
      return createRequestModelFromJson(response['body']);
    } else {
      hideLoadingDialog(context: context);
      return null;
    }
  }
}
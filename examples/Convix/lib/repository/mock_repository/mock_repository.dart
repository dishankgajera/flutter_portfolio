import 'package:covermeapp/config/default_data.dart';
import 'package:covermeapp/model/mock/mock_model.dart';
import 'package:covermeapp/utils/network_http.dart';
import 'package:covermeapp/view/widgets/common_widget/loader/loading_dialog.dart';
import 'package:flutter/material.dart';

class MockRepository{

  static Future mockRepo({
    required BuildContext context,
  }) async {

    showLoadingDialog(context: context);
    print("---------------phase 1--------------------}");
    Map response = await HttpHandler.getHttpMethod(url: DefaultApiString.mockApi,isMockUrl: true);
    if (response["error_description"] == null) {
      hideLoadingDialog(context: context);
      return mokFromJson(response['body']);
    } else if (response["error_description"] != null) {
      hideLoadingDialog(context: context);
      return mokFromJson(response['body']);
    } else {
      hideLoadingDialog(context: context);
      return null;
    }
  }

}
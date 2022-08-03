import 'package:covermeapp/config/default_data.dart';
import 'package:covermeapp/model/agora/agora_token_model.dart';
import 'package:covermeapp/utils/network_http.dart';
import 'package:covermeapp/view/widgets/common_widget/loader/loading_dialog.dart';
import 'package:flutter/material.dart';

class AgoraRepository {
  static Future generateAgoraToken({
    required BuildContext context,
    String? channelName,
  }) async {
    showLoadingDialog(context: context);
    print("---------------phase 1--------------------");
    Map response = await HttpHandler.getHttpMethod(url: "${DefaultApiString.agoraTokenGenerate}$channelName");
    if (response["error_description"] == null) {
      hideLoadingDialog(context: context);
      return agoraTokenModelFromJson(response['body']);
    } else if (response["error_description"] != null) {
      hideLoadingDialog(context: context);
      return agoraTokenModelFromJson(response['body']);
    } else {
      hideLoadingDialog(context: context);
      return null;
    }
  }
}

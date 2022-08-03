import 'package:covermeapp/config/default_data.dart';
import 'package:covermeapp/model/find_by_profile_id_model.dart';
import 'package:covermeapp/utils/network_http.dart';
import 'package:covermeapp/view/widgets/common_widget/loader/loading_dialog.dart';
import 'package:flutter/cupertino.dart';

class FindByProfileIdRepo {
  static Future findByProfileId({
    required BuildContext context,
    String? profileId,
    String? userId,
  }) async {
    showLoadingDialog(context: context);
    Map response =
    await HttpHandler.postHttpMethod(url: DefaultApiString.findByprofileId, data: {
      "profileId": profileId,
      "userId": userId,

    });
    if (response["error_description"] == null) {
      hideLoadingDialog(context: context);
      return findByProfileIdModelFromJson(response['body']);
    } else if (response["error_description"] != null) {
      hideLoadingDialog(context: context);
      return findByProfileIdModelFromJson(response['body']);
    } else {
      hideLoadingDialog(context: context);
      return null;
    }
  }
}
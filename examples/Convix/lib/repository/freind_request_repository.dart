import 'package:covermeapp/config/default_data.dart';
import 'package:covermeapp/model/friend_request/friend_request_model.dart';
import 'package:covermeapp/model/friend_request_model.dart';
import 'package:covermeapp/utils/network_http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendRequestRepository {
  static getAllFriendRequest({BuildContext? context, @required String? status}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map response = await HttpHandler.getHttpMethod(
        url: "${DefaultApiString.friendRequest}$status&userId=${sharedPreferences.getString(PrefString.userId)}");
    if (response["error_description"] == null) {
      return friendRequestModelFromJson(response['body']);
    } else if (response["error_description"] != null) {
      return FriendRequestModel();
    } else {
      return null;
    }
  }

  static changeFriendRequestStatus({BuildContext? context, String? requestId, @required String? status}) async {
    Map response = await HttpHandler.putHttpMethod(url: "${DefaultApiString.changeRequestStatus}$requestId", data: {
      "status": status,
    });
    if (response["error_description"] == null) {
      return requestAcceptRejectModelFromJson(response['body']);
    } else if (response["error_description"] != null) {
      return RequestAcceptRejectModel();
    } else {
      return null;
    }
  }
}

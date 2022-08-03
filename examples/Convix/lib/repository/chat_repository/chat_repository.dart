import 'dart:convert';

import 'package:covermeapp/config/default_data.dart';
import 'package:covermeapp/utils/network_http.dart';

class ChatRepository {
  static Future<String> createChatRoom(String personId, String entertainerId) async {
    try {
      Map<String, dynamic> data = {
        "participateIds": [int.parse(personId.toString()), int.parse(entertainerId.toString())]
      };
      final response = await HttpHandler.postHttpMethod(url: "${DefaultApiString.initializeChat}", data: data);
      if (response['error_description'] == null) {
        final data = json.decode(response['body']);
        if (data['status'] == 200 || data['status'] == '200') {
          print("Chat room id == ${data['data']['_id']}");
          return data['data']['_id'];
        } else {
          return "";
        }
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }
}

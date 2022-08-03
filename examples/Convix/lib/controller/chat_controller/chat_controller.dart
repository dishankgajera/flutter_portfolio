import 'dart:async';
import 'package:covermeapp/config/data.dart';
import 'package:covermeapp/config/default_data.dart';
import 'package:covermeapp/repository/chat_repository/chat_repository.dart';
import 'package:covermeapp/view/screens/dashboard/dashboard_screen.dart';
import 'package:covermeapp/view/widgets/common_widget/snackbar/snackbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {
  final RxList messageList = List.empty().obs;
  final ScrollController messageListController = ScrollController();
  final messageController = TextEditingController().obs;
  late IO.Socket chatSocket;

  String? userId;
  String? roomId;

  void initialChat(personId, entertainerId) async {
    try {
      final String? roomId = await ChatRepository.createChatRoom(personId, entertainerId);
      if (roomId != null) {
        this.roomId = roomId;
        chatSocket = IO.io(DefaultApiString.socketServerUrl,
            IO.OptionBuilder().setTransports(['websocket']).disableAutoConnect().enableForceNewConnection().build());
        if (!chatSocket.connected) {
          chatSocket.connect();
        }
        chatSocket.onConnect((data) {
          print("CHAT ON CONNECT _+_++_+_+_+_+_+_+_+_+_+_+_+_+_+_");
          userId = User.profileId;
          chatSocket.emit(DefaultApiString.initializeChatRoom, {"roomId": roomId});
        });
        chatSocket.onConnectError((data) {
          print("Error $data");
        });
        chatSocket.on(DefaultApiString.getMessageHistory, (data) {
          messageList.clear();
          print("History $data");
          messageList.addAll(data['chats']);
          if (messageList.length != 0) {
            Timer(
                Duration(milliseconds: 100), () => messageListController.jumpTo(messageListController.position.maxScrollExtent));
          }
        });
        chatSocket.on(DefaultApiString.sendMessage, (data) {
          print("Data == $data");
          messageList.add(data);
          Timer(Duration(milliseconds: 100), () => messageListController.jumpTo(messageListController.position.maxScrollExtent));
        });
        chatSocket.onError((data) {});
        chatSocket.onDisconnect((data) {
          print("Disconnect $data");
        });
      } else {
        ShowSnackBar.error("Please Try Again");
      }
    } catch (e) {}
  }

  void sendMessage() {
    chatSocket.emit(
        DefaultApiString.sendMessage, {"roomId": roomId, "message": messageController.value.text, "sender": User.profileId});
    messageController.value.clear();
  }

  @override
  void onClose({@required BuildContext? context}) {
    if (chatSocket.connected) {
      chatSocket.dispose();
      chatSocket.disconnect();
    }
    messageList.clear();
    FlutterRingtonePlayer.stop();
    Navigator.push(context!, MaterialPageRoute(builder: (_) => DashboardScreen()));
    super.onClose();
  }
}

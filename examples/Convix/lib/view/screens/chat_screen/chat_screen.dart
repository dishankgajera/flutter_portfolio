import 'dart:async';

import 'package:covermeapp/config/colors.dart';
import 'package:covermeapp/config/default_data.dart';
import 'package:covermeapp/config/text-style.dart';
import 'package:covermeapp/controller/agora/call_controller.dart';
import 'package:covermeapp/controller/chat_controller/chat_controller.dart';
import 'package:covermeapp/model/agora/agora_token_model.dart';
import 'package:covermeapp/model/agora/res_call_accept_model.dart';
import 'package:covermeapp/model/agora/res_call_request_model.dart';
import 'package:covermeapp/repository/agora/agora_repository.dart';
import 'package:covermeapp/utils/agora/permission_utils.dart';
import 'package:covermeapp/view/screens/agora_call/pickup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  final String? personId;
  final String? entertainerId;
  final String? senderName;
  final String? reciverName;

  const ChatScreen({
    this.personId,
    this.entertainerId,
    this.senderName,
    this.reciverName,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final chatController = Get.put(ChatController());
  final callController = Get.put(CallController());

  @override
  void initState() {
    print("START CHAT SCREEN INITSTATE >>>>>>>>>>>>>>>>>>>>>>");
    chatController.initialChat(widget.personId, widget.entertainerId);
    //setSocket();
    print("END CHAT SCREEN INITSTATE >>>>>>>>>>>>>>>>>>>>>>");
    super.initState();
  }

  @override
  void dispose() {
    chatController.chatSocket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.senderName.toString()),
        actions: [
          IconButton(
              onPressed: () async {
                DefaultApiString.isVideoCall = false;
                await generateToken(
                  channelName: widget.personId,
                  inComingPersonName: widget.senderName,
                  outgoingPersonName: widget.reciverName,
                );
              },
              icon: Icon(
                Icons.call,
                color: Colors.white,
                size: 22,
              )),
          IconButton(
              onPressed: () async {
                DefaultApiString.isVideoCall = true;
                await generateToken(
                  channelName: widget.personId,
                  inComingPersonName: widget.senderName,
                  outgoingPersonName: widget.reciverName,
                );
              },
              icon: Icon(
                Icons.videocam_rounded,
                color: Colors.white,
                size: 22,
              )),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 2),
          Expanded(
            child: Obx(() {
              if (chatController.messageList.length != 0) {
                return ListView.builder(
                  itemCount: chatController.messageList.length,
                  controller: chatController.messageListController,
                  reverse: false,
                  itemBuilder: (context, i) {
                    final data = chatController.messageList[i];
                    if (data['sender'] != null) {
                      DateTime sentTime = DateTime.parse(data['createdAt']).toLocal();
                      if (data['sender'] == chatController.userId) {
                        return RightChat(
                          message: data['message'],
                          time: DateFormat.yMd().add_jm().format(sentTime),
                          // profile: user.userData.value.data.profilePicture,
                        );
                      } else {
                        return LeftChat(
                          message: data['message'],
                          time: DateFormat.yMd().add_jm().format(sentTime),
                          name: widget.senderName,
                          // profile: customerProfilePic,
                          // name: customerName,
                        );
                      }
                    } else {
                      return Container();
                    }
                  },
                );
              } else {
                return Container();
              }
            }),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            height: 61,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35.0),
                      boxShadow: [BoxShadow(offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TextField(
                              onTap: () => Timer(
                                  Duration(milliseconds: 300),
                                  () => chatController.messageListController
                                      .jumpTo(chatController.messageListController.position.maxScrollExtent)),
                              controller: chatController.messageController.value,
                              decoration: InputDecoration(hintText: "Type Something...", border: InputBorder.none),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(color: cMain, shape: BoxShape.circle),
                  child: InkWell(
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onTap: () {
                        if ((chatController.messageController.value.text.isBlank == false) &&
                            chatController.messageController.value.text.length != 0) {
                          chatController.sendMessage();
                        }
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future generateToken({
    @required String? channelName,
    @required String? outgoingPersonName,
    @required String? inComingPersonName,
  }) async {
    AgoraTokenModel data = await AgoraRepository.generateAgoraToken(context: context, channelName: channelName!);
    if (data.status == 200) {
      callController.requestCall(
          channelName: data.data!.channelName, token: data.data!.token, otherId: widget.entertainerId);
    }
  }
}

class LeftChat extends StatelessWidget {
  final String? message;
  final String? time;
  final String? profile;
  final String? name;

  LeftChat({this.message, this.profile, this.time, this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5, bottom: 10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name!.split("@").first,
                style: blueTextStyle,
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                constraints: BoxConstraints(maxWidth: Get.size.width * .6),
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: cOffWhite,
                  boxShadow: [BoxShadow(offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Text(
                  "$message",
                  style: normalTextStyle,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(child: Text("$time", style: normalTextStyle.copyWith(fontSize: 12, color: cGray))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RightChat extends StatelessWidget {
  final String? message;
  final String? time;
  final String? profile;

  RightChat({this.message, this.profile, this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 5, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: Get.size.width * .6),
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: cMain,
                  boxShadow: [BoxShadow(offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
                child: Text("$message", style: normalTextStyle.copyWith(color: Colors.white)),
              ),
              SizedBox(
                height: 8,
              ),
              Text("$time", style: normalTextStyle.copyWith(fontSize: 12, color: cGray)),
            ],
          ),
        ],
      ),
    );
  }
}

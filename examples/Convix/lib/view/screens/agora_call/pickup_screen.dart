import 'dart:async';
import 'dart:ui';

import 'package:covermeapp/config/colors.dart';
import 'package:covermeapp/controller/agora/call_controller.dart';
import 'package:covermeapp/controller/chat_controller/chat_controller.dart';
import 'package:covermeapp/model/agora/res_call_accept_model.dart';
import 'package:covermeapp/model/agora/res_call_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:wakelock/wakelock.dart';

class PickUpScreen extends StatefulWidget {
  final bool isForOutGoing;
  final String outgoingPersonName;
  final String? otherId;
  final String? channelName;
  final String? token;
  final String inComingPersonName;

  PickUpScreen(
      {this.channelName,
      this.token,
      this.isForOutGoing = false,
      this.otherId,
      this.inComingPersonName = "",
      this.outgoingPersonName = ""});

  @override
  _PickUpScreenState createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  Timer? _timer;
  final chatController = Get.put(ChatController());
  final callController = Get.put(CallController());

  @override
  void initState() {
    super.initState();
    Wakelock.enable(); // Turn on wakelock feature till call is running
    FlutterRingtonePlayer.play(
        android: AndroidSounds.ringtone, ios: IosSounds.electronic, looping: true, volume: 0.5, asAlarm: false);
    _timer = Timer(const Duration(milliseconds: 60 * 1000), _endCall);
  }

  @override
  void dispose() {
    //To Stop Ringtone
    FlutterRingtonePlayer.stop();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // getScreenSize(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Spacer(),
            Text(
              !widget.isForOutGoing ? "Out going call" : "In coming call",
              style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.person_rounded,
              size: 200,
              color: cMain,
            ),
            Text(widget.isForOutGoing ? widget.outgoingPersonName : widget.inComingPersonName,
                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
            Spacer(),
            Row(
              mainAxisAlignment: widget.isForOutGoing ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
              children: <Widget>[
                _callingButtonWidget(context, false),
                widget.isForOutGoing ? _callingButtonWidget(context, true) : Container(),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  _callingButtonWidget(BuildContext context, bool isCall) => InkWell(
        onTap: () {
          if (isCall) {
            _timer?.cancel();
            pickUpCallPressed(context);
          } else {
            _endCall();
          }
        },
        child: Container(
          padding: EdgeInsets.all(20),
          child: Icon(isCall ? Icons.call : Icons.call_end, color: Colors.white, size: 30),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCall ? Colors.green : Colors.redAccent,
          ),
        ),
      );

  void pickUpCallPressed(BuildContext context) async {
    await Wakelock.enable(); //
    await FlutterRingtonePlayer.stop(); // To Stop Ringtone
    callController.acceptCall(channelName: widget.channelName, token: widget.token, otherId: widget.otherId);
  }

  _endCall() async {
    Wakelock.disable();
    callController.rejectCall(context,channelName: widget.channelName, token: widget.token, otherId: widget.otherId);
  }
}

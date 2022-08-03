
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:covermeapp/config/default_data.dart';
import 'package:covermeapp/view/screens/agora_call/pickup_screen.dart';
import 'package:covermeapp/view/screens/agora_call/video_call_screen.dart';
import 'package:covermeapp/view/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class CallController extends GetxController {
  late IO.Socket callSocket;
  RtcEngine? engine;

  void initialVideoCall(
      BuildContext context,{
      @required String? profileId,
      @required String? outgoingPersonName,
      @required String? inComingPersonName}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    callSocket = IO.io(DefaultApiString.socketServerUrl,
        IO.OptionBuilder().setTransports(['websocket']).disableAutoConnect().enableForceNewConnection().build());
    if (!callSocket.connected) {
      callSocket.connect();
    }
    callSocket.onConnect((data) {
      print("Data == Connect");
      callSocket.emit(DefaultApiString.eventConnect, {"profileId": profileId});
    });

    callSocket.onConnectError((data) {
      print("ON CONNECT ERROR :: $data");
    });

    callSocket.on(DefaultApiString.onCallRequest, (data) {
      print("""
      :: ON CALL REQUEST START :: ${DefaultApiString.onCallRequest} 
      :: DATA :: $data
      """);
      if (data != null &&
          data['otherId'] != null &&
          data['channelName'] != null &&
          data['token'] != null &&
          data["isForVideoCall"] != null) {
        DefaultApiString.isVideoCall = data["isForVideoCall"];
        print("Context == $context");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PickUpScreen(
              inComingPersonName: inComingPersonName!,
              outgoingPersonName: outgoingPersonName!,
              otherId: data["otherId"],
              channelName: data["channelName"],
              token: data["token"],
              isForOutGoing: data["channelName"] == sharedPreferences.getString(PrefString.profileId) ? true : false,
            ),
          ),
        );
      }
      print(":: ON CALL REQUEST END :: ${DefaultApiString.onCallRequest}");
    });
    callSocket.on(DefaultApiString.onAcceptCall, (data) {
      print("""
      :: ON ACCEPT CALL START :: ${DefaultApiString.onAcceptCall} 
      :: DATA :: $data
      """);
      if (data != null &&
          data['otherId'] != null &&
          data['channelName'] != null &&
          data['token'] != null &&
          data["isForVideoCall"] != null) {
        DefaultApiString.isVideoCall = data["isForVideoCall"];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VideoCallingScreen(
              channelName: data["channelName"],
              token: data["token"],
              otherId: data["otherId"],
              isForVideoCall: data["isForVideoCall"],
            ),
          ),
        );
        print(":: ON ACCEPT CALL END :: ${DefaultApiString.onAcceptCall} ");
      }
    });
    callSocket.on(DefaultApiString.onRejectCall, (data) {
      print(":: ON REJECT CALL START :: ${DefaultApiString.onRejectCall}");
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => DashboardScreen()), (route) => false);
      callSocket.dispose();
      callSocket.disconnect();

      FlutterRingtonePlayer.stop();

      print(":: ON REJECT CALL END :: ${DefaultApiString.onRejectCall}");
    });
    callSocket.onDisconnect((data) {
      print(":: ON SOCKET DISCONNECT START :: $data");
      print(":: ON SOCKET DISCONNECT END");
    });
  }

  void requestCall({
    @required String? channelName,
    @required String? token,
    @required String? otherId,
  }) {
    print("""
    :: REQUEST CALL START :: ${DefaultApiString.connectCall}
    :: DATA :: {
                  "channelName": $channelName,
                  "otherId": $otherId,
                  "isForVideoCall": ${DefaultApiString.isVideoCall},
                  "token": $token,
               }
    """);
    callSocket.emit(DefaultApiString.connectCall, {
      "channelName": channelName,
      "otherId": otherId,
      "isForVideoCall": DefaultApiString.isVideoCall,
      "token": token,
    });
    print(":: REQUEST CALL END :: ${DefaultApiString.connectCall}");
  }

  void acceptCall({
    @required String? channelName,
    @required String? token,
    @required String? otherId,
  }) {
    print("""
    :: ACCEPT CALL START :: ${DefaultApiString.acceptCall}
    :: DATA :: {
                  "channelName": $channelName,
                  "otherId": $otherId,
                  "isForVideoCall": ${DefaultApiString.isVideoCall},
                  "token": $token,
               }
    """);
    callSocket.emit(DefaultApiString.acceptCall, {
      "channelName": channelName,
      "otherId": otherId,
      "isForVideoCall": DefaultApiString.isVideoCall,
      "token": token,
    });
    print(":: ACCEPT CALL END :: ${DefaultApiString.acceptCall}");
  }

  void rejectCall(context,{
    @required String? channelName,
    @required String? token,
    @required String? otherId,
  }) {
    print("""
    :: REJECT CALL START :: ${DefaultApiString.rejectCall}
    :: DATA :: {
                  "channelName": $channelName,
                  "otherId": $otherId,
                  "isForVideoCall": ${DefaultApiString.isVideoCall},
                  "token": $token,
               }
    """);
    callSocket.emit(DefaultApiString.rejectCall, {
      "channelName": channelName,
      "otherId": otherId,
      "isForVideoCall": DefaultApiString.isVideoCall,
      "token": token,
    });
    print(":: REJECT CALL END :: ${DefaultApiString.rejectCall}");
  }

  @override
  void onClose({@required BuildContext? context}) {
    super.onClose();
  }
}

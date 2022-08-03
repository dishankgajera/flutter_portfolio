// import 'dart:convert';
//
// import 'package:covermeapp/config/default_data.dart';
// import 'package:covermeapp/model/agora/res_call_accept_model.dart';
// import 'package:covermeapp/model/agora/res_call_request_model.dart';
// import 'package:covermeapp/utils/agora/common_methods.dart';
// import 'package:covermeapp/view/screens/agora_call/pickup_screen.dart';
// import 'package:covermeapp/view/screens/agora_call/video_call_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:socket_io_client/socket_io_client.dart' as io;
//
// io.Socket? _socketInstance;
// BuildContext? buildContext;
// String? channelName;
// String? channelToken;
// ResCallAcceptModel? resCallAcceptModel;
//
// //Initialize Socket Connection
// dynamic initSocketManager(BuildContext context) {
//   buildContext = context;
//   if (_socketInstance != null) return;
//   _socketInstance = io.io(
//     "${DefaultApiString.socketUrl}",
//     <String, dynamic>{
//       DefaultApiString.transportsHeader: [DefaultApiString.webSocketOption, DefaultApiString.pollingOption],
//     },
//   );
//   _socketInstance!.connect();
//   socketGlobalListeners();
// }
//
// //Socket Global Listener Events
// dynamic socketGlobalListeners() {
//   _socketInstance?.on(DefaultApiString.eventConnect, onConnect);
//   _socketInstance?.on(DefaultApiString.eventDisconnect, onDisconnect);
//   _socketInstance?.on(DefaultApiString.onSocketError, onConnectError);
//   _socketInstance?.on(DefaultApiString.eventConnectTimeout, onConnectError);
//   _socketInstance?.on(DefaultApiString.onCallRequest, handleOnCallRequest);
//   _socketInstance?.on(DefaultApiString.onAcceptCall, handleOnAcceptCall);
//   _socketInstance?.on(DefaultApiString.onRejectCall, handleOnRejectCall);
// }
//
// //To Emit Event Into Socket
// bool? emit(String event, Map<String, dynamic> data) {
//   _socketInstance?.emit(event, jsonDecode(json.encode(data)));
//   printLog("===> Data ---- $event -- emit $data");
//   print("_socketInstance?.connected -- ${_socketInstance?.connected}");
//   return _socketInstance?.connected;
// }
//
// bool? onSocket(String event, Function(Map<String, dynamic>)? data) {
//   _socketInstance?.on(event, (v) {
//     printLog("DATA===> ON $v");
//     data!(v);
//   });
//
//   return _socketInstance?.connected;
// }
//
// //Get This Event After Successful Connection To Socket
// dynamic onConnect(_) {
//   printLog("===> connected socket....................");
// }
//
// //Get This Event After Connection Lost To Socket Due To Network Or Any Other Reason
// dynamic onDisconnect(_) {
//   printLog("===> Disconnected socket....................");
// }
//
// //Get This Event After Connection Error To Socket With Error
// dynamic onConnectError(error) {
//   printLog("===> ConnectError socket.................... $error");
// }
//
// //Get This Event When Someone Received Call From Other User
// void handleOnCallRequest(dynamic response,String outgoingPersonName,String inComingPersonName) {
//   if (response != null) {
//     final data = ResCallRequestModel.fromJson(response);
//     Navigator.push(
//         Get.context!,
//         MaterialPageRoute(
//             builder: (_) => PickUpScreen(
//                   resCallRequestModel: data,
//                   outgoingPersonName: outgoingPersonName,
//                   inComingPersonName: inComingPersonName,
//                   resCallAcceptModel: ResCallAcceptModel.fromJson({"channelName": data.channel, "token": data.token}),
//                   isForOutGoing: false,
//                 )));
//     // NavigationUtils.push(buildContext, RouteConstants.routePickUpScreen,
//     //     arguments: {
//     //       ArgParams.resCallAcceptModel: ResCallAcceptModel(),
//     //       ArgParams.resCallRequestModel: data,
//     //       ArgParams.isForOutGoing: false,
//     //     });
//   }
// }
//
// //Get This Event When Other User Accepts Your Call
// void handleOnAcceptCall(dynamic response) async {
//   if (response != null) {
//     final data = ResCallAcceptModel.fromJson(response);
//     resCallAcceptModel = data;
//     channelName = data.channel;
//     channelToken = data.token;
//     Navigator.pushReplacement(
//         Get.context!,
//         MaterialPageRoute(
//             builder: (_) => VideoCallingScreen(
//                   resCallRequestModel: ResCallRequestModel.fromJson(
//                     {"channelName": data.channel, "token": data.token},
//                   ),
//                   resCallAcceptModel: data,
//                   isForOutGoing: true,
//                 )));
//     // NavigationUtils.pushReplacement(buildContext, RouteConstants.routeVideoCall,
//     //     arguments: {
//     //       ArgParams.channelKey: data.channel,
//     //       ArgParams.channelTokenKey: data.token,
//     //       ArgParams.resCallAcceptModel: data,
//     //       ArgParams.resCallRequestModel: ResCallRequestModel(),
//     //       ArgParams.isForOutGoing: true,
//     //     });
//   }
// }
//
// //Get This Event When Someone Rejects Call
// void handleOnRejectCall(dynamic response) {
//   // NavigationUtils.pushAndRemoveUntil(
//   //   buildContext,
//   //   RouteConstants.routeCommon,
//   // );
//   print("HERE AFTER REJECT _______>>>>>>>");
// }

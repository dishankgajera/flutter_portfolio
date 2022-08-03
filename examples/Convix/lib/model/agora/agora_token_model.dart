// To parse this JSON data, do
//
//     final agoraTokenModel = agoraTokenModelFromJson(jsonString);

import 'dart:convert';

AgoraTokenModel agoraTokenModelFromJson(String str) => AgoraTokenModel.fromJson(json.decode(str));

String agoraTokenModelToJson(AgoraTokenModel data) => json.encode(data.toJson());

class AgoraTokenModel {
  AgoraTokenModel({
    this.data,
    this.message,
    this.status,
  });

  Data? data;
  String? message;
  int? status;

  factory AgoraTokenModel.fromJson(Map<String, dynamic> json) => AgoraTokenModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data!.toJson(),
    "message": message == null ? null : message,
    "status": status == null ? null : status,
  };
}

class Data {
  Data({
    this.token,
    this.channelName,
  });

  String? token;
  String? channelName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"] == null ? null : json["token"],
    channelName: json["channelName"] == null ? null : json["channelName"],
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? null : token,
    "channelName": channelName == null ? null : channelName,
  };
}

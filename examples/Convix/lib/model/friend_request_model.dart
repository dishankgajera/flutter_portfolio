// To parse this JSON data, do
//
//     final friendRequestModel = friendRequestModelFromJson(jsonString);

import 'dart:convert';

FriendRequestModel friendRequestModelFromJson(String str) => FriendRequestModel.fromJson(json.decode(str));

String friendRequestModelToJson(FriendRequestModel data) => json.encode(data.toJson());

class FriendRequestModel {
  FriendRequestModel({
    this.data,
    this.message,
    this.status,
  });

  List<Datum>? data;
  String? message;
  int? status;

  factory FriendRequestModel.fromJson(Map<String, dynamic> json) => FriendRequestModel(
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message == null ? null : message,
    "status": status == null ? null : status,
  };
}

class Datum {
  Datum({
    this.ids,
    this.lastMsg,
    this.status,
    this.updateby,
    this.id,
    this.requestedId,
    this.userId,
    this.createat,
    this.updateat,
    this.v,
  });

  List<String>? ids;
  List<LastMsg>? lastMsg;
  String? status;
  String? updateby;
  String? id;
  Id? requestedId;
  Id? userId;
  DateTime? createat;
  DateTime? updateat;
  int? v;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    ids: json["Ids"] == null ? null : List<String>.from(json["Ids"].map((x) => x)),
    lastMsg: json["lastMsg"] == null ? null : List<LastMsg>.from(json["lastMsg"].map((x) => LastMsg.fromJson(x))),
    status: json["status"] == null ? null : json["status"],
    updateby: json["updateby"] == null ? null : json["updateby"],
    id: json["_id"] == null ? null : json["_id"],
    requestedId: json["requestedId"] == null ? null : Id.fromJson(json["requestedId"]),
    userId: json["userId"] == null ? null : Id.fromJson(json["userId"]),
    createat: json["createat"] == null ? null : DateTime.parse(json["createat"]),
    updateat: json["updateat"] == null ? null : DateTime.parse(json["updateat"]),
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "Ids": ids == null ? null : List<dynamic>.from(ids!.map((x) => x)),
    "lastMsg": lastMsg == null ? null : List<dynamic>.from(lastMsg!.map((x) => x.toJson())),
    "status": status == null ? null : status,
    "updateby": updateby == null ? null : updateby,
    "_id": id == null ? null : id,
    "requestedId": requestedId == null ? null : requestedId!.toJson(),
    "userId": userId == null ? null : userId!.toJson(),
    "createat": createat == null ? null : createat!.toIso8601String(),
    "updateat": updateat == null ? null : updateat!.toIso8601String(),
    "__v": v == null ? null : v,
  };
}

class LastMsg {
  LastMsg({
    this.readBy,
    this.isActive,
    this.id,
    this.roomId,
    this.sender,
    this.message,
    this.createdAt,
    this.v,
  });

  List<dynamic>? readBy;
  bool? isActive;
  String? id;
  String? roomId;
  String? sender;
  String? message;
  DateTime? createdAt;
  int? v;

  factory LastMsg.fromJson(Map<String, dynamic> json) => LastMsg(
    readBy: json["readBy"] == null ? null : List<dynamic>.from(json["readBy"].map((x) => x)),
    isActive: json["isActive"] == null ? null : json["isActive"],
    id: json["_id"] == null ? null : json["_id"],
    roomId: json["roomId"] == null ? null : json["roomId"],
    sender: json["sender"] == null ? null : json["sender"],
    message: json["message"] == null ? null : json["message"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "readBy": readBy == null ? null : List<dynamic>.from(readBy!.map((x) => x)),
    "isActive": isActive == null ? null : isActive,
    "_id": id == null ? null : id,
    "roomId": roomId == null ? null : roomId,
    "sender": sender == null ? null : sender,
    "message": message == null ? null : message,
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "__v": v == null ? null : v,
  };
}

class Id {
  Id({
    this.id,
    this.profileId,
    this.email,
  });

  String? id;
  int? profileId;
  String? email;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
    id: json["_id"] == null ? null : json["_id"],
    profileId: json["profileId"] == null ? null : json["profileId"],
    email: json["email"] == null ? null : json["email"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "profileId": profileId == null ? null : profileId,
    "email": email == null ? null : email,
  };
}

// To parse this JSON data, do
//
//     final requestAcceptRejectModel = requestAcceptRejectModelFromJson(jsonString);

import 'dart:convert';

RequestAcceptRejectModel requestAcceptRejectModelFromJson(String str) => RequestAcceptRejectModel.fromJson(json.decode(str));

String requestAcceptRejectModelToJson(RequestAcceptRejectModel data) => json.encode(data.toJson());

class RequestAcceptRejectModel {
  RequestAcceptRejectModel({
    this.data,
    this.message,
    this.status,
  });

  Data ?data;
  String ?message;
  int ?status;

  factory RequestAcceptRejectModel.fromJson(Map<String, dynamic> json) => RequestAcceptRejectModel(
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
    this.ids,
    this.status,
    this.updateby,
    this.id,
    this.requestedId,
    this.userId,
    this.createat,
    this.updateat,
    this.v,
  });

  List<String> ?ids;
  String ?status;
  String ?updateby;
  String ?id;
  String ?requestedId;
  String ?userId;
  DateTime ?createat;
  DateTime ?updateat;
  int ?v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    ids: json["Ids"] == null ? null : List<String>.from(json["Ids"].map((x) => x)),
    status: json["status"] == null ? null : json["status"],
    updateby: json["updateby"] == null ? null : json["updateby"],
    id: json["_id"] == null ? null : json["_id"],
    requestedId: json["requestedId"] == null ? null : json["requestedId"],
    userId: json["userId"] == null ? null : json["userId"],
    createat: json["createat"] == null ? null : DateTime.parse(json["createat"]),
    updateat: json["updateat"] == null ? null : DateTime.parse(json["updateat"]),
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "Ids": ids == null ? null : List<dynamic>.from(ids!.map((x) => x)),
    "status": status == null ? null : status,
    "updateby": updateby == null ? null : updateby,
    "_id": id == null ? null : id,
    "requestedId": requestedId == null ? null : requestedId,
    "userId": userId == null ? null : userId,
    "createat": createat == null ? null : createat!.toIso8601String(),
    "updateat": updateat == null ? null : updateat!.toIso8601String(),
    "__v": v == null ? null : v,
  };
}

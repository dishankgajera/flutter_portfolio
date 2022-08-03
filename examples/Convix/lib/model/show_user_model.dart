// To parse this JSON data, do
//
//     final showUserModel = showUserModelFromJson(jsonString);

import 'dart:convert';

ShowUserModel showUserModelFromJson(String str) => ShowUserModel.fromJson(json.decode(str));

String showUserModelToJson(ShowUserModel data) => json.encode(data.toJson());

class ShowUserModel {
  ShowUserModel({
    this.data,
    this.message,
    this.status,
  });

  List<Datum>? data;
  String? message;
  int? status;

  factory ShowUserModel.fromJson(Map<String, dynamic> json) => ShowUserModel(
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
    this.createby,
    this.updateby,
    this.id,
    this.profileId,
    this.email,
    this.createat,
    this.updateat,
    this.v,
  });

  String? createby;
  String? updateby;
  String? id;
  int ?profileId;
  String ?email;
  DateTime? createat;
  DateTime ?updateat;
  int? v;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    createby: json["createby"] == null ? null : json["createby"],
    updateby: json["updateby"] == null ? null : json["updateby"],
    id: json["_id"] == null ? null : json["_id"],
    profileId: json["profileId"] == null ? null : json["profileId"],
    email: json["email"] == null ? null : json["email"],
    createat: json["createat"] == null ? null : DateTime.parse(json["createat"]),
    updateat: json["updateat"] == null ? null : DateTime.parse(json["updateat"]),
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "createby": createby == null ? null : createby,
    "updateby": updateby == null ? null : updateby,
    "_id": id == null ? null : id,
    "profileId": profileId == null ? null : profileId,
    "email": email == null ? null : email,
    "createat": createat == null ? null : createat!.toIso8601String(),
    "updateat": updateat == null ? null : updateat!.toIso8601String(),
    "__v": v == null ? null : v,
  };
}

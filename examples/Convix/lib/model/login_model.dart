// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.data,
    this.message,
    this.status,
  });

  Data ?data;
  String ?message;
  int ?status;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
    this.createby,
    this.updateby,
    this.otp,
    this.id,
    this.profileId,
    this.email,
    this.createat,
    this.updateat,
    this.v,
    this.token,
  });

  String ?createby;
  String ?updateby;
  dynamic otp;
  String ?id;
  int ?profileId;
  String ?email;
  DateTime ?createat;
  DateTime ?updateat;
  int ?v;
  String ?token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    createby: json["createby"] == null ? null : json["createby"],
    updateby: json["updateby"] == null ? null : json["updateby"],
    otp: json["otp"],
    id: json["_id"] == null ? null : json["_id"],
    profileId: json["profileId"] == null ? null : json["profileId"],
    email: json["email"] == null ? null : json["email"],
    createat: json["createat"] == null ? null : DateTime.parse(json["createat"]),
    updateat: json["updateat"] == null ? null : DateTime.parse(json["updateat"]),
    v: json["__v"] == null ? null : json["__v"],
    token: json["token"] == null ? null : json["token"],
  );

  Map<String, dynamic> toJson() => {
    "createby": createby == null ? null : createby,
    "updateby": updateby == null ? null : updateby,
    "otp": otp,
    "_id": id == null ? null : id,
    "profileId": profileId == null ? null : profileId,
    "email": email == null ? null : email,
    "createat": createat == null ? null : createat!.toIso8601String(),
    "updateat": updateat == null ? null : updateat!.toIso8601String(),
    "__v": v == null ? null : v,
    "token": token == null ? null : token,
  };
}

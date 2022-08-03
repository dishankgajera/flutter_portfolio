import 'dart:convert';
import 'package:covermeapp/config/default_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HttpHandler {
  static String endPointUrl = DefaultApiString.endPoint;

  static Future<Map<String, String>> _getHeaders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(PrefString.token);
    if (token != null) {
      print("Token -- '$token'");
      return {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
    } else {
      print("Token  null-- '$token'");
      return {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
    }
  }

  static Future<Map<String, dynamic>> getHttpMethod(
      {@required String? url, bool isMockUrl = false}) async {
    var header = await _getHeaders();

    print("Get URL -- '$endPointUrl$url'");
    print("Get Data -- 'null'");
    http.Response response = await http.get(
      Uri.parse(isMockUrl ? "$url" : "$endPointUrl$url"),
      headers: header,
    );
    print("Get Response Code -- '${response.statusCode}'");
    print("Get Response -- '${response.body}'");
    if (response.statusCode == 200) {
      print("In Get '200'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': null,
      };
      return data;
    } else if (response.statusCode == 400) {
      print("In Get '400'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': "400",
      };
      return data;
    } else if (response.statusCode == 401) {
      print("In Get '401'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': "401",
      };
      return data;
    } else if (response.statusCode == 403) {
      print("In Get '403'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': "403",
      };
      return data;
    } else if (response.statusCode == 404) {
      print("In Get '404'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': "404",
      };
      return data;
    } else if (response.statusCode == 500) {
      print("In Get '500'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': "500",
      };
      return data;
    } else {
      print("In Get 'else'");
      return {
        'body': null,
        'headers': null,
        'error_description': "Something Went Wrong",
      };
    }
  }

  static Future<Map<String, dynamic>> postHttpMethod(
      {@required String? url, Map<String, dynamic>? data}) async {
    var header = await _getHeaders();
    print("Post URL -- '$endPointUrl$url'");
    print("Post Data -- '$data'");
    http.Response response = await http.post(
      Uri.parse("$endPointUrl$url"),
      headers: header,
      body: data == null ? null : jsonEncode(data),
    );
    print("Post Response Code -- '${response.statusCode}'");
    print("Post Response -- '${response.body}'");
    if (response.statusCode == 200) {
      print("In Post '200'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': null,
      };
      return data;
    } else if (response.statusCode == 400) {
      print("In Post '400'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': "400",
      };
      return data;
    } else if (response.statusCode == 401) {
      print("In Post '401'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': "401",
      };
      return data;
    } else if (response.statusCode == 403) {
      print("In Post '403'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': "403",
      };
      return data;
    } else if (response.statusCode == 404) {
      print("In Post '404'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': "404",
      };
      return data;
    } else if (response.statusCode == 500) {
      print("In Post '500'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': "500",
      };
      return data;
    } else {
      print("In Post 'else'");
      return {
        'body': null,
        'headers': null,
        'error_description': "Something Went Wrong",
      };
    }
  }

  static Future<Map<String, dynamic>> patchHttpMethod(
      {@required String? url, Map<String, dynamic>? data}) async {
    var header = await _getHeaders();
    print("Patch URL -- '$endPointUrl$url'");
    print("Patch Data -- '$data'");
    http.Response response = await http.patch(
      Uri.parse("$endPointUrl$url"),
      headers: header,
      body: data == null ? null : jsonEncode(data),
    );
    print("Patch Response Code -- '${response.statusCode}'");
    print("Patch Response -- '${response.body}'");
    if (response.statusCode == 200) {
      print("In Patch '200'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': null,
      };
      return data;
    } else if (response.statusCode == 400) {
      print("In Patch '400'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': "400",
      };
      return data;
    } else if (response.statusCode == 401) {
      print("In Patch '401'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': "401",
      };
      return data;
    } else if (response.statusCode == 403) {
      print("In Patch '403'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': "403",
      };
      return data;
    } else if (response.statusCode == 404) {
      print("In Patch '404'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': "404",
      };
      return data;
    } else if (response.statusCode == 500) {
      print("In Patch '500'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': "500",
      };
      return data;
    } else {
      print("In Patch 'else'");
      return {
        'body': null,
        'headers': null,
        'error_description': "Something Went Wrong",
      };
    }
  }

  static Future<Map<String, dynamic>> putHttpMethod(
      {@required String? url, Map<String, dynamic>? data}) async {
    var header = await _getHeaders();
    print("Put URL -- '$endPointUrl$url'");
    print("PUT Data -- '$data'");
    http.Response response = await http.put(
      Uri.parse("$endPointUrl$url"),
      headers: header,
      body: data == null ? null : jsonEncode(data),
    );

    print("PUT Response code -- '${response.statusCode}'");
    print("PUT Response -- '${response.body}'");

    if (response.statusCode == 200) {
      print("In Put '200'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': null,
      };
      return data;
    } else if (response.statusCode == 400) {
      print("In Put '400'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': "400",
      };
      return data;
    } else if (response.statusCode == 401) {
      print("In Put '401'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': "401",
      };
      return data;
    } else if (response.statusCode == 403) {
      print("In Put '403'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': "403",
      };
      return data;
    } else if (response.statusCode == 404) {
      print("In Put '404'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': "404",
      };
      return data;
    } else if (response.statusCode == 500) {
      print("In Put '500'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': "500",
      };
      return data;
    } else {
      print("In Put 'else'");
      return {
        'body': null,
        'headers': null,
        'error_description': "Something Went Wrong",
      };
    }
  }

  static Future<Map<String, dynamic>> deleteHttpMethod(
      {@required String? url}) async {
    var header = await _getHeaders();
    print("Delete URL -- '$endPointUrl$url'");
    print("Delete Data -- 'null'");
    http.Response response = await http.delete(
      Uri.parse("$endPointUrl$url"),
      headers: header,
    );
    print("Delete Response Code -- '${response.statusCode}'");
    print("Delete Response -- '${response.body}'");
    if (response.statusCode == 200) {
      print("In Delete '200'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': null,
      };
      return data;
    } else if (response.statusCode == 400) {
      print("In Delete '400'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': "400",
      };
      return data;
    } else if (response.statusCode == 401) {
      print("In Delete '401'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': "401",
      };
      return data;
    } else if (response.statusCode == 403) {
      print("In Delete '403'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': "403",
      };
      return data;
    } else if (response.statusCode == 404) {
      print("In Delete '404'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': "404",
      };
      return data;
    } else if (response.statusCode == 500) {
      print("In Delete '500'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error_description': "500",
      };
      return data;
    } else {
      print("In Delete 'else'");
      return {
        'body': null,
        'headers': null,
        'error_description': "Something Went Wrong",
      };
    }
  }
}

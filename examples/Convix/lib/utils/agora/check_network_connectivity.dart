import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:covermeapp/config/default_data.dart';
import 'package:covermeapp/utils/agora/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


//Check Connectivity With Network
final Connectivity _connectivity = Connectivity();
String? _connectionStatus;
Future<bool> checkNetworkConnection(BuildContext context) async {
  String connectionStatus;

  try {
    connectionStatus = (await _connectivity.checkConnectivity()).toString();
  } on PlatformException catch (_) {
    connectionStatus = "Internet Connection failed !";
  }

  _connectionStatus = connectionStatus;
  if (_connectionStatus == DefaultApiString.mobileConnectionStatus ||
      _connectionStatus == DefaultApiString.wifiConnectionStatus) {
    return true;
  } else {
    DialogUtils.showAlertDialog(
        context, "INTERNET NOT CONNECTED !");
    return false;
  }
}

import 'dart:async';

import 'package:covermeapp/utils/agora/common_methods.dart';
import 'package:flutter/material.dart';

class TimerView extends StatefulWidget {
  final Function? updateTimerStatus;

  TimerView({
    Key? key,
    this.updateTimerStatus,
  }) : super(key: key);

  @override
  TimerViewState createState() => TimerViewState();
}

class TimerViewState extends State<TimerView> {
  Timer? _timer;
  int _counter = 0 * 60;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter++;
      });
    });
  }

  void cancelTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _getResendVerificationButton();
  }

  Widget _getResendVerificationButton() => Text('${getFormatDuration(Duration(seconds: _counter))}',
      style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold));
}

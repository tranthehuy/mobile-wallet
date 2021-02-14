import 'package:flutter/material.dart';

int convertDateTimeToSeconds(DateTime time) {
  var ms = time.millisecondsSinceEpoch;
  return (ms / 1000).round();
}

DateTime convertSecondsToDateTime(int time) {
  return DateTime.fromMillisecondsSinceEpoch(time * 1000);
}

void notifySuccess(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: Duration(seconds: 1),
    action: SnackBarAction(
      label: 'Đóng',
      onPressed: () { },
    ),
  ));
}

Future sleep(int sec) {
  return new Future.delayed(Duration(seconds: sec), () => true);
}
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatNumber (int value) {
  var f = new NumberFormat();
  return (f.format(value));
}

int parseInt (String str) {
  int number = 0;
  try {
    number = str == '' ? 0 : int.parse(str);
  } on Exception catch (_) {
    print(_);
  }
  return number;
}

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
      label: 'X',
      onPressed: () { },
    ),
  ));
}

Future sleep(int sec) {
  return new Future.delayed(Duration(seconds: sec), () => true);
}
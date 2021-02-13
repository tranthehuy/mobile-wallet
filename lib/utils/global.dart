int convertDateTimeToSeconds(DateTime time) {
  var ms = time.millisecondsSinceEpoch;
  return (ms / 1000).round();
}

DateTime convertSecondsToDateTime(int time) {
  return DateTime.fromMillisecondsSinceEpoch(time * 1000);
}
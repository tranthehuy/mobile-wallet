import 'package:flutter/material.dart';
import '../utils/global.dart';
import '../services/config.dart';

Container renderSumTransactionsRow(int sumIncome, int sumOutcome) {
  ConfigService config = ConfigService();
  return Container(
      child: Column(children: <Widget>[
    Text(
        config.translateAndReplace('Income: #1 Dong', formatNumber(sumIncome))),
    Text(config.translateAndReplace(
        'Outcome: #1 Dong', formatNumber(sumOutcome))),
    Text(config.translateAndReplace(
        'Sum: #1 Dong', formatNumber(sumIncome - sumOutcome))),
    Divider(),
  ]));
}

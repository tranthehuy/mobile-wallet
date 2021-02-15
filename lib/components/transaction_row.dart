import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/global.dart';
import '../services/config.dart';

Container renderTransactionRow(item) {
  ConfigService config = ConfigService();
  DateTime creationTime = convertSecondsToDateTime(item.creationTime);
  String time = DateFormat('yyyy-MM-dd').format(creationTime);
  String amount = formatNumber(item.amount);
  String minus = item.type == 'outcome' ? '-' : '';
  return Container(
      padding: const EdgeInsets.all(8),
      height: 50,
      color: item.type == 'outcome' ? Colors.pink[200] : Colors.green[200],
      child: Column(children: <Widget>[
        Center(child: Text('${item.name}: $minus$amount ' + config.translate('Dong'))),
        Center(child: Text(config.translateAndReplace('Created at: #1', time) )),
      ]));
}

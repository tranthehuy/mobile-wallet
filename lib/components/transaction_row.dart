import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/global.dart';
import '../services/config.dart';

Container renderTransactionRow(item) {
  ConfigService config = ConfigService();
  DateTime creationTime = convertSecondsToDateTime(item.creationTime);
  String time = DateFormat('yyyy-MM-dd').format(creationTime);
  String amount = formatNumber(item.amount);
  String minus = item.type == 'chi_tieu' ? '-' : '';
  return Container(
      padding: const EdgeInsets.all(8),
      height: 50,
      color: item.type == 'chi_tieu' ? Colors.pink[200] : Colors.green[200],
      child: Column(children: <Widget>[
        Center(child: Text('${item.name}: $minus$amount ' + config.translate('đồng'))),
        Center(child: Text(config.translateAndReplace('Ngày tạo: #1', time) )),
      ]));
}

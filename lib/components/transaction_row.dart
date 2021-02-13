import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/global.dart';

Container renderTransactionRow(item) {
  DateTime creationTime = convertSecondsToDateTime(item.creationTime);
  String time = DateFormat('yyyy-MM-dd').format(creationTime);
  return Container(
      padding: const EdgeInsets.all(8),
      height: 50,
      color: item.type == 'chi_tieu' ? Colors.pink[200] : Colors.green[200],
      child: Column(children: <Widget>[
        Center(child: Text('${item.name}: ${item.type == 'chi_tieu' ? '-' : ''}${item.amount} đồng')),
        Center(child: Text('Ngày tạo: $time')),
      ]));
}

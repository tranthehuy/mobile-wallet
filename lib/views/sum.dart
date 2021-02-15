import 'package:flutter/material.dart';
import '../services/transactions.dart';
import '../models/transactions.dart';
import '../components/transaction_row.dart';
import '../services/config.dart';
import '../utils/global.dart';
import '../components/text_row.dart';

class SumPage extends StatefulWidget {
  @override
  _SumPageState createState() => _SumPageState();
}

class _SumPageState extends State<SumPage> {
  List<Transactions> items = [];
  TransactionsService service;
  int sumIncome = 0;
  int sumOutcome = 0;

  void initDatabase() async {
    service = TransactionsService();
    List<Transactions> newItems = await service.list();
    int newSumIncome = 0;
    int newSumOutcome = 0;

    for (var i = 0; i < newItems.length; i++) {
      if (newItems[i].type == 'thu_nhap') {
        newSumIncome += newItems[i].amount;
      } else {
        newSumOutcome += newItems[i].amount;
      }
    }

    setState(() {
      items = newItems;
      sumIncome = newSumIncome;
      sumOutcome = newSumOutcome;
    });
  }

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  void showFilterBox() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Material Dialog"),
              content: new Text("Hey! I'm Coflutter!"),
              actions: <Widget>[
                TextButton(
                  child: Text('Close me!'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    ConfigService config = ConfigService();

    Widget content;
    if (items.length > 0) {
      content = ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(config.translateAndReplace(
                      'Thu nhập: #1 đồng', formatNumber(sumIncome))),
                  Text(config.translateAndReplace(
                      'Chi phí: #1 đồng', formatNumber(sumOutcome))),
                  Text(config.translateAndReplace(
                      'Tổng: #1 đồng', formatNumber(sumIncome - sumOutcome))),
                  Divider(),
                  renderTransactionRow(items[index])
                ]);
          }
          return renderTransactionRow(items[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );
    } else {
      content = renderTextRow('Danh sách rỗng', Colors.cyan[100]);
    }

    return new Scaffold(
        appBar: new AppBar(
          title: new Text(config.translate("Thống kê thu nhập")),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  showFilterBox();
                },
                child: Text(
                  config.translate('Lọc'),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
          ],
        ),
        body: content);
  }
}

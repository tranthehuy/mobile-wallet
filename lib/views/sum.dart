import 'package:flutter/material.dart';
import '../services/transactions.dart';
import '../models/transactions.dart';
import '../components/transaction_row.dart';
import '../services/config.dart';

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
    print(newItems);
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

  @override
  Widget build(BuildContext context) {
    ConfigService config = ConfigService();
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(config.translate("Thống kê thu nhập")),
          actions: <Widget>[
            TextButton(
                onPressed: () {},
                child: Text(
                  config.translate('Lọc'),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
          ],
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Column(children: <Widget>[
                Text(config.translateAndReplace('Chi phí: #1 đồng', sumOutcome.toString())),
                Text(config.translateAndReplace('Thu nhập: #1 đồng', sumIncome.toString())),
                Text(config.translateAndReplace('Tổng: #1 đồng', (sumIncome - sumOutcome).toString())),
                Divider(),
                renderTransactionRow(items[index])
              ]);
            }
            return renderTransactionRow(items[index]);
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ));
  }
}

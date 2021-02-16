import 'package:flutter/material.dart';
import '../services/transactions.dart';
import '../models/transactions.dart';
import '../components/transaction_row.dart';
import '../components/sum_transactions_row.dart';
import '../services/config.dart';
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
      if (newItems[i].type == 'income') {
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
    ConfigService config = ConfigService();

    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text(config.translate("Filter Box")),
              content: new Text(config.translate("Hell world")),
              actions: <Widget>[
                TextButton(
                  child: Text(config.translate('Apply')),
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
                children: <Widget>[
                  renderSumTransactionsRow(sumIncome, sumOutcome),
                  renderTransactionRow(items[index])
                ]);
          }
          return renderTransactionRow(items[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );
    } else {
      content = renderTextRow('There is no transaction to show', Colors.cyan[100]);
    }

    return new Scaffold(
        appBar: new AppBar(
          title: new Text(config.translate("Summarize profit")),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  showFilterBox();
                },
                child: Text(
                  config.translate('Filter'),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
          ],
        ),
        body: content);
  }
}

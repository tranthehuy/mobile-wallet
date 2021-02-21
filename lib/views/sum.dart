import 'package:flutter/material.dart';
import '../services/transactions.dart';
import '../models/transactions.dart';
import '../components/transaction_row.dart';
import '../components/sum_transactions_row.dart';
import '../services/config.dart';
import '../components/filter_modal.dart';
import '../components/text_row.dart';
import '../utils/global.dart';

class SumPage extends StatefulWidget {
  @override
  _SumPageState createState() => _SumPageState();
}

class _SumPageState extends State<SumPage> {
  List<Transactions> items = [];
  TransactionsService service;
  String filterType = 'all';
  int filterStartTime = -1;
  int filterEndTime = -1;
  int sumIncome = 0;
  int sumOutcome = 0;

  Future<List<Transactions>> fetchData() async {
    service = TransactionsService();
    List<Transactions> newItems =
        await service.list(filterType, filterStartTime, filterEndTime);
    return newItems;
  }

  void initDatabase() async {
    List<Transactions> newItems = await fetchData();
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
    showDialog(
        context: context,
        builder: (_) => FilterModal(
              onFormSubmit: (dynamic form) async {
                setState(() {
                  filterType = form.type;
                  filterStartTime = convertDateTimeToSeconds(form.startTime); // start of this day
                  filterEndTime = convertDateTimeToSeconds(form.endTime) + 86400; // end of this day
                });
                initDatabase();
              },
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
            return Column(children: <Widget>[
              renderSumTransactionsRow(sumIncome, sumOutcome),
              renderTransactionRow(items[index])
            ]);
          }
          return renderTransactionRow(items[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );
    } else {
      content =
          renderTextRow('There is no transaction to show', Colors.cyan[100]);
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

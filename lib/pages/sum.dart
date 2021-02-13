import 'package:flutter/material.dart';
import '../services/transactions.dart';
import '../models/transactions.dart';

class SumPage extends StatefulWidget {
  @override
  _SumPageState createState() => _SumPageState();
}

class _SumPageState extends State<SumPage> {
  List<Transactions> items = [];
  TransactionsService service;

  void initDatabase () async {
    service = TransactionsService();
    List<Transactions> newItems = await service.list();
    setState(() {
      items = newItems;
    });
  }

  List<Widget> getTextWidgets()
  {
    List<Widget> list = [];
    for(var i = 0; i < items.length; i++){
      list.add( 
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(items[i].name)
        )
      );
    }
    return list;
  }

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Thống kê thu nhập"),
        actions: <Widget>[
          TextButton(
            onPressed: () {},
            child: Text(
              'Lọc',
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            color: items[index].type == 'chi_tieu' ? Colors.pink[200] : Colors.green[200],
            child: Center(child: Text('${items[index].name}: ${items[index].amount} ĐỒNG')),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      )
    );
  }
}
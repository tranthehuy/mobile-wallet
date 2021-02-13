import 'package:flutter/material.dart';
import '../services/transactions.dart';

class SumPage extends StatelessWidget {
  @override
  Widget build (BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Thống kê thu nhập"),
      ),
      body: ListView(
      shrinkWrap: true,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () async {
                TransactionsService service = TransactionsService();
                await service.init();
                print(await service.list());
            },
            child: Text('Thống kê')
          ),
        ),
      ]
    ));
  }
}
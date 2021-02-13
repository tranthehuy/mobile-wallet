import 'package:flutter/material.dart';
import '../services/transactions.dart';
import '../components/config_form.dart';

class ConfigPage extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Thiết lập ứng dụng"),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ConfigForm(
                    onFormSubmit: (data) {
                      print(data);
                    }
                  ),
                  TextButton(
                      onPressed: () async {
                        TransactionsService service = TransactionsService();
                        await service.clear();
                      },
                      child: Text(
                        'Xoá hết các giao dịch',
                        style: TextStyle(
                            // color: Colors.white,
                            ),
                      )),
                ])));
  }
}
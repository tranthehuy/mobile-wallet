import 'package:flutter/material.dart';
import '../components/transaction_form.dart';
import '../services/transactions.dart';
import '../utils/global.dart';

class UpdatePage extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Thêm giao dịch"),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: TransactionForm(onFormSubmit: (transaction) async {
          TransactionsService service = TransactionsService();
          await service.insert(transaction);
          notifySuccess(context, 'Đã thêm vào bộ nhớ');
          Navigator.pop(context);
        }),
      ),
    );
  }
}

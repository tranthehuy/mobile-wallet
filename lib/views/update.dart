import 'package:flutter/material.dart';
import '../components/transaction_form.dart';
import '../services/transactions.dart';
import '../services/config.dart';
import '../utils/global.dart';

class UpdatePage extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    ConfigService config = ConfigService();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(config.translate("Thêm giao dịch mới")),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: TransactionForm(onFormSubmit: (transaction) async {
          TransactionsService service = TransactionsService();
          await service.insert(transaction);
          notifySuccess(context, config.translate('Đã thêm vào bộ nhớ'));
          Navigator.pop(context);
        }),
      ),
    );
  }
}

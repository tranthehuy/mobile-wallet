import 'package:flutter/material.dart';
import '../services/transactions.dart';
import '../services/config.dart';
import '../utils/global.dart';
import '../components/config_form.dart';

class ConfigPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String unit = ConfigService.getString('unit') ?? '1';
    String language = ConfigService.getString('language') ?? 'vn';

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
                    unit: unit,
                    language: language,
                    onFormSubmit: (data) {
                      String unit = data.unit;
                      String language = data.language;
                      ConfigService.setString('unit', unit);
                      ConfigService.setString('language', language);
                      notifySuccess(context, 'Đã cập nhật cài đặt mới');
                    }
                  ),
                  TextButton(
                      onPressed: () async {
                        TransactionsService service = TransactionsService();
                        await service.clear();
                        notifySuccess(context, 'Đã xoá');
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
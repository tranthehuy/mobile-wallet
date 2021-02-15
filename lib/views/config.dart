import 'package:flutter/material.dart';
import '../services/transactions.dart';
import '../services/config.dart';
import '../utils/global.dart';
import '../utils/const.dart';
import '../components/config_form.dart';

class ConfigPage extends StatelessWidget {
  final FormSubmitCallback refeshCallback;

  const ConfigPage({this.refeshCallback});

  @override
  Widget build(BuildContext context) {
    ConfigService config = ConfigService();
    String unit = ConfigService.getString('unit') ?? '1';
    String language = ConfigService.getString('language') ?? 'vn';

    return new Scaffold(
        appBar: new AppBar(
          title: new Text(config.translate("Application Settings")),
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
                      notifySuccess(context, config.translate('Updated new config'));
                      refeshCallback(true);
                    }
                  ),
                  TextButton(
                      onPressed: () async {
                        TransactionsService service = TransactionsService();
                        await service.clear();
                        notifySuccess(context, config.translate('Removed'));
                      },
                      child: Text(
                        config.translate('Remove all transaction'),
                        style: TextStyle(
                            // color: Colors.white,
                            ),
                      )),
                ])));
  }
}
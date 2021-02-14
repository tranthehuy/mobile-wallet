import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/config.dart';
import '../models/transactions.dart';
import '../utils/const.dart';
import '../utils/global.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({ this.onFormSubmit });

  final FormSubmitCallback onFormSubmit;

  @override
  TransactionFormState createState() {
    return TransactionFormState();
  }
}

class TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  String _type = 'chi_tieu';
  String _name = "Giao dịch mới";
  String _amount = "";
  DateTime _creationTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    ConfigService config = ConfigService();
    String unitStr = ConfigService.getString('unit');
    int convertedNumber = 0;

    int unit = unitStr == '1000' ? 1000 : 1;
    try {
      int amount = int.parse(_amount);
      if (amount != null) {
        convertedNumber = amount * unit;
      }
    } on Exception catch (_) {
      print(_);
    }

    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Text(config.translate("Loại giao dịch"))
          ),
          DropdownButton<String>(
            value: _type,
            onChanged: (String value) {
              setState(() {
                _type = value;
              });
            },
            items: <DropdownMenuItem<String>>[
              DropdownMenuItem<String>(
                value: 'chi_tieu',
                child: Container(
                  height: 50,
                  color: Colors.pink[100],
                  child: Center(child: Text(config.translate('Chi tiêu'))),
                )
              ),
              DropdownMenuItem<String>(
                value: 'thu_nhap',
                child: Container(
                  height: 50,
                  color: Colors.green[100],
                  child: Center(child: Text(config.translate('Thu nhập'))),
                )
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Text(config.translate("Tên giao dịch"))
          ),
          TextFormField(
            initialValue: config.translate(_name),
            onChanged: (String text) {
              setState(() {
                _name = text;
              });
            },
            validator: (value) {
              if (value.isEmpty) {
                return config.translate('Vui lòng không để trống');
              }
              return null;
            },
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Text(config.translate("Số tiền"))
          ),
          TextFormField(
            initialValue: _amount,
            onChanged: (String text) {
              setState(() {
                _amount = text;
              });
            },
            // decoration: new InputDecoration(labelText: "Enter your number"),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value.isEmpty) {
                return config.translate('Vui lòng không để trống');
              }
              return null;
            },
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Text(convertedNumber.toString() + ' ' + config.translate('đồng')),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: TextButton(
              onPressed: () async {
                DateTime selectedDate = DateTime.now();
                final DateTime picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2025),
                );
                if (picked != null) {
                  setState(() {
                    _creationTime = picked;
                  });
                }
              },
              child: Text(
                config.translateAndReplace('Thời gian: #1', DateFormat('yyyy-MM-dd').format(_creationTime))
              )
            ),
          ),
          Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          height: 30.0,
          child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
                      var transaction = Transactions(
                        name: _name,
                        amount: int.parse(_amount),
                        type: _type,
                        creationTime: convertDateTimeToSeconds(_creationTime)
                      );
                      widget.onFormSubmit(transaction);
                    }
                  },
                  child: Text(config.translate('Lưu'))
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(" ")
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    config.translate('Huỷ'),
                    style: TextStyle(
                    // color: Colors.white,
                    ),
                  )
                ),
              ]
            )
          )
        ],
      ),
    );
  }
}


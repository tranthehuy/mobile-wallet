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
  String _type = 'outcome';
  String _name = "New Transaction";
  String _amount = "";
  DateTime _creationTime = DateTime.now();

  int getConvertedNumber() {
    int convertedNumber = 0;
    String unitStr = ConfigService.getString('unit');
    int unit = unitStr == '1000' ? 1000 : 1;
    int amount = parseInt(_amount);
    convertedNumber = amount * unit;
    return convertedNumber;
  }

  @override
  Widget build(BuildContext context) {
    ConfigService config = ConfigService();
    int convertedNumber = getConvertedNumber();

    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Text(config.translate("Transaction type"))
          ),
          DropdownButton<String>(
            isExpanded: true,
            value: _type,
            onChanged: (String value) {
              setState(() {
                _type = value;
              });
            },
            items: <DropdownMenuItem<String>>[
              DropdownMenuItem<String>(
                value: 'outcome',
                child: Container(
                  height: 50,
                  color: Colors.pink[100],
                  child: Center(child: Text(config.translate('Outcome'))),
                )
              ),
              DropdownMenuItem<String>(
                value: 'income',
                child: Container(
                  height: 50,
                  color: Colors.green[100],
                  child: Center(child: Text(config.translate('Income'))),
                )
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Text(config.translate("Transaction name"))
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
            child: Text(config.translate("Amount"))
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
            child: Text(formatNumber(convertedNumber) + ' ' + config.translate('Dong')),
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
                config.translateAndReplace('Created at #1', DateFormat('yyyy-MM-dd').format(_creationTime))
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
                        amount: getConvertedNumber(),
                        type: _type,
                        creationTime: convertDateTimeToSeconds(_creationTime)
                      );
                      widget.onFormSubmit(transaction);
                    }
                  },
                  child: Text(config.translate('Save'))
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
                    config.translate('Cancel'),
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


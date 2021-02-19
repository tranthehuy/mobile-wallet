import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../models/filter_condition.dart';
import '../services/config.dart';
import '../models/transactions.dart';
import '../utils/const.dart';
import '../utils/global.dart';

class FilterModal extends StatefulWidget {
  const FilterModal({this.onFormSubmit});

  final FormSubmitCallback onFormSubmit;

  @override
  FilterModalState createState() {
    return FilterModalState();
  }
}

class FilterModalState extends State<FilterModal> {
  final _formKey = GlobalKey<FormState>();
  String _type = 'all';
  DateTime _startTime = DateTime.now();
  DateTime _endTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    ConfigService config = ConfigService();
    Color color = Theme.of(context).primaryColor;

    return AlertDialog(
      title: Text(config.translate("Filter Box")),
      content: Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Text(config.translate("Transaction type"))),
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
                      value: 'all',
                      child: Container(
                        height: 50,
                        color: Colors.blue[100],
                        child: Center(child: Text(config.translate('All'))),
                      )),
                  DropdownMenuItem<String>(
                      value: 'outcome',
                      child: Container(
                        height: 50,
                        color: Colors.pink[100],
                        child: Center(child: Text(config.translate('Outcome'))),
                      )),
                  DropdownMenuItem<String>(
                      value: 'income',
                      child: Container(
                        height: 50,
                        color: Colors.green[100],
                        child: Center(child: Text(config.translate('Income'))),
                      ))
                ],
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(config.translate("Time range"))),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: InkWell(
                    onTap: () async {
                      DateTime selectedDate = DateTime.now();
                      final DateTime picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2025),
                      );
                      if (picked != null) {
                        setState(() {
                          _startTime = picked;
                        });
                      }
                    },
                    child: Text(
                      config.translateAndReplace('From #1',
                          DateFormat('yyyy-MM-dd').format(_startTime)),
                      style: TextStyle(color: color),
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: InkWell(
                    onTap: () async {
                      DateTime selectedDate = DateTime.now();
                      final DateTime picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2025),
                      );
                      if (picked != null) {
                        setState(() {
                          _endTime = picked;
                        });
                      }
                    },
                    child: Text(
                      config.translateAndReplace(
                          'To #1', DateFormat('yyyy-MM-dd').format(_endTime)),
                      style: TextStyle(color: color),
                    )),
              ),
            ]),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(config.translate('Apply')),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              var condition = FilterCondition(_type, _startTime, _endTime);
              widget.onFormSubmit(condition);
            }
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}

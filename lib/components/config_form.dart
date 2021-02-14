import 'package:flutter/material.dart';
import '../models/config.dart';
import '../utils/const.dart';

class ConfigForm extends StatefulWidget {
  const ConfigForm({ this.onFormSubmit, this.unit, this.language });

  final FormSubmitCallback onFormSubmit;
  final String unit;
  final String language;

  @override
  _ConfigFormState createState() {
    return _ConfigFormState();
  }
}

class _ConfigFormState extends State<ConfigForm> {
  final _formKey = GlobalKey<FormState>();
  String _unit = '1';
  String _language = "vn";

  @override
  void initState() {
    super.initState();
    _unit = widget.unit;
    _language = widget.language;
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Text("Đơn vị nhập")
          ),
          DropdownButton<String>(
            value: _unit,
            onChanged: (String value) {
              setState(() {
                _unit = value;
              });
            },
            items: <DropdownMenuItem<String>>[
              DropdownMenuItem<String>(
                value: '1',
                child: Container(
                  height: 50,
                  color: Colors.blue[100],
                  child: Center(child: Text('Đồng')),
                )
              ),
              DropdownMenuItem<String>(
                value: '1000',
                child: Container(
                  height: 50,
                  color: Colors.blue[200],
                  child: Center(child: Text('Ngàn Đồng')),
                )
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Text("Ngôn ngữ")
          ),
          DropdownButton<String>(
            value: _language,
            onChanged: (String value) {
              setState(() {
                _language = value;
              });
            },
            items: <DropdownMenuItem<String>>[
              DropdownMenuItem<String>(
                value: 'vn',
                child: Container(
                  height: 50,
                  child: Center(child: Text('Tiếng Việt')),
                )
              ),
              DropdownMenuItem<String>(
                value: 'en',
                child: Container(
                  height: 50,
                  child: Center(child: Text('Tiếng Anh')),
                )
              )
            ],
          ),
          Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          height: 30.0,
          child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    widget.onFormSubmit(Config(
                      _unit, _language
                    ));
                  },
                  child: Text('Lưu')
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
                    'Huỷ',
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


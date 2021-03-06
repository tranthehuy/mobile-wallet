import 'package:flutter/material.dart';
import '../models/config.dart';
import '../services/config.dart';
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
  bool _updated = false;

  @override
  void initState() {
    super.initState();
    _unit = widget.unit;
    _language = widget.language;
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    ConfigService config = ConfigService();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Text(config.translate("Unit"))
          ),
          DropdownButton<String>(
            isExpanded: true,
            value: _unit,
            onChanged: (String value) {
              setState(() {
                _unit = value;
                _updated = true;
              });
            },
            items: <DropdownMenuItem<String>>[
              DropdownMenuItem<String>(
                value: '1',
                child: Container(
                  height: 50,
                  color: Colors.blue[100],
                  child: Center(child: Text(config.translate("Dong"))),
                )
              ),
              DropdownMenuItem<String>(
                value: '1000',
                child: Container(
                  height: 50,
                  color: Colors.blue[200],
                  child: Center(child: Text(config.translate("Thousand Dong"))),
                )
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Text(config.translate("Language"))
          ),
          DropdownButton<String>(
            isExpanded: true,
            value: _language,
            onChanged: (String value) {
              setState(() {
                _language = value;
                _updated = true;
              });
            },
            items: <DropdownMenuItem<String>>[
              DropdownMenuItem<String>(
                value: 'vn',
                child: Container(
                  height: 50,
                  child: Center(child: Text(config.translate('Vietnamese'))),
                )
              ),
              DropdownMenuItem<String>(
                value: 'en',
                child: Container(
                  height: 50,
                  child: Center(child: Text(config.translate('English'))),
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
                  onPressed: _updated == false ? null : () async {
                    setState(() {
                      _updated = false;
                    });
                    widget.onFormSubmit(Config(
                      _unit, _language
                    ));
                  },
                  child: Text(config.translate('Save'))
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(" ")
                ),
                TextButton(
                  onPressed: _updated == false ? null : () {
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


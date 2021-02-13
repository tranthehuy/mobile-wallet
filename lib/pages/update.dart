import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/transactions.dart';
import '../services/transactions.dart';

class UpdatePage extends StatelessWidget {
  @override
  Widget build (BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Thêm giao dịch"),
        // actions: <Widget>[
        //   TextButton(
        //     onPressed: () {},
        //     child: Text(
        //       'Lưu',
        //       style: TextStyle(
        //         color: Colors.white,
        //       ),
        //     )
        //   ),
        // ],
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  String _type = 'chi_tieu';
  String _name = "Giao dịch mới";
  String _amount = "0";

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
            child: Text("Loại giao dịch")
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
                  child: Center(child: Text('Chi tiêu')),
                )
              ),
              DropdownMenuItem<String>(
                value: 'thu_nhap',
                child: Container(
                  height: 50,
                  color: Colors.green[100],
                  child: Center(child: Text('Thu nhập')),
                )
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Text("Tên giao dịch")
          ),
          TextFormField(
            initialValue: _name,
            onChanged: (String text) {
              setState(() {
                _name = text;
              });
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Vui lòng không để trống';
              }
              return null;
            },
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Text("Số tiền")
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
                return 'Vui lòng không để trống';
              }
              return null;
            },
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
                      
                      TransactionsService service = TransactionsService();
                      await service.init();
                      var transaction = Transactions(
                        name: _name,
                        amount: int.parse(_amount),
                        type: _type,
                      );
                      await service.insert(transaction);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text('Đã thêm vào bộ nhớ'),
                        duration: const Duration(seconds: 1),
                        action: SnackBarAction(
                          label: 'ACTION',
                          onPressed: () { },
                        ),
                      ));
                      Navigator.pop(context);
                    }
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


import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build (BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Hỗ trợ"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: new Text("Liên hệ: tranthehuythesecond@gmail.com"),
      )
    );
  }
}
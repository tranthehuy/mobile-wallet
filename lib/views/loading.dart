import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build (BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(""),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: new Text("Loading..."),
      )
    );
  }
}
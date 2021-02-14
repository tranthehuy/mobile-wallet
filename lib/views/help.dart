import 'package:flutter/material.dart';
import '../services/config.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    ConfigService config = ConfigService();

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(config.translate("Hỗ trợ")),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: new Text(config.translate("Liên hệ: tranthehuythesecond@gmail.com")),
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/update.dart';
import 'pages/sum.dart';
import 'pages/help.dart';
import 'pages/config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sổ chi tiêu',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MenuHomePage(title: 'Sổ chi tiêu'),
        '/update': (context) => UpdatePage(),
        '/sum': (context) => SumPage(),
        '/help': (context) => HelpPage(),
        '/config': (context) => ConfigPage(),
      },
    );
  }
}

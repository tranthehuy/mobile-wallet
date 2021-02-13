import 'package:flutter/material.dart';
import 'services/transactions.dart';
import 'views/home.dart';
import 'views/update.dart';
import 'views/sum.dart';
import 'views/help.dart';
import 'views/config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  TransactionsService.init();
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

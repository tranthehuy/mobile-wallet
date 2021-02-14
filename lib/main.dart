import 'package:flutter/material.dart';
import 'views/home.dart';
import 'views/update.dart';
import 'views/sum.dart';
import 'views/help.dart';
import 'views/config.dart';
import 'views/loading.dart';
import 'services/transactions.dart';
import 'services/config.dart';
import 'utils/global.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool ready = false;
  int version = 0;

  void initAppConfig() async {
    WidgetsFlutterBinding.ensureInitialized();
    await TransactionsService.init();
    await ConfigService.init();
    await sleep(3);
    setState(() {
      ready = true;
    });
  }

  @override
  void initState() {
    super.initState();
    initAppConfig();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ready ? MenuHomePage() : LoadingPage(),
        '/update': (context) => UpdatePage(),
        '/sum': (context) => SumPage(),
        '/help': (context) => HelpPage(),
        '/config': (context) => ConfigPage(refeshCallback: (data) {
          setState(() {
            version = version + 1;
          });
        }),
        '/loading': (context) => LoadingPage(),
      },
    );
  }
}

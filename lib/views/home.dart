import 'package:flutter/material.dart';
import '../components/main_menu.dart';
import '../utils/const.dart';

class MenuHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sổ chi tiêu'),
      ),
      body: MainMenu(
        onMenuTap: (MainMenuActions id) {
          if (id == MainMenuActions.update) {
            Navigator.pushNamed(context, '/update');
          }
          if (id == MainMenuActions.summarize) {
            Navigator.pushNamed(context, '/sum');
          }
          if (id == MainMenuActions.help) {
            Navigator.pushNamed(context, '/help');
          }
          if (id == MainMenuActions.config) {
            Navigator.pushNamed(context, '/config');
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/update');
        },
        tooltip: 'Thêm giao dịch mới',
        child: Icon(Icons.add),
      ),
    );
  }
}

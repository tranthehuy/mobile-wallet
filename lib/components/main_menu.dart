import 'package:flutter/material.dart';
import '../utils/const.dart';
import '../services/config.dart';

typedef MenuTapCallback = void Function(MainMenuActions id);

class MainMenu extends StatelessWidget {
  const MainMenu({ this.onMenuTap });

  final MenuTapCallback onMenuTap;

  @override
  Widget build(BuildContext context) {
    ConfigService config = ConfigService();

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.edit),
          title: Text(config.translate('Update wallet')),
          onTap: () {
            onMenuTap(MainMenuActions.update);
          },
        ),
        ListTile(
          leading: Icon(Icons.photo_album),
          title: Text(config.translate('Summarize')),
          onTap: () {
            onMenuTap(MainMenuActions.summarize);
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text(config.translate('Application Settings')), //
          onTap: () {
            onMenuTap(MainMenuActions.config);
          },
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text(config.translate('Support')),
          onTap: () {
            onMenuTap(MainMenuActions.help);
          },
        ),
      ],
    );
  }
}

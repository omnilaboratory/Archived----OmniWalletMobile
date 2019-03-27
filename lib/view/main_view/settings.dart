/// Settings page.
/// [author] Kevin Zhang
/// [time] 2019-3-25

import 'package:flutter/material.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';

class Settings extends StatefulWidget {
  static String tag = "Settings";

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(WalletLocalizations.of(context).settingsPageTitle),
      ),

      body: SafeArea(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(WalletLocalizations.of(context).settingsPageItem_1_Title),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'English',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 15),
                  Icon(Icons.keyboard_arrow_right),
                ],
              ),

              onTap: () {
                // TODO: show next page.
                // Navigator.of(context).pushNamed(route);
              },
            ),

            // Item 2
            ListTile(
              title: Text(WalletLocalizations.of(context).settingsPageItem_2_Title),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'CNY',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 15),
                  Icon(Icons.keyboard_arrow_right),
                ],
              ),

              onTap: () {
                // TODO: show next page.
                // Navigator.of(context).pushNamed(route);
              },
            )

            
          ],
        ),
      ),
    );
  }
}
/// Settings page.
/// [author] Kevin Zhang
/// [time] 2019-3-25

import 'package:flutter/material.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';
import 'package:wallet_app/tools/app_data_setting.dart';
import 'package:wallet_app/view/welcome/select_language.dart';
import 'package:wallet_app/view_model/state_lib.dart';

class Settings extends StatefulWidget {
  static String tag = "Settings";

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  String _selectLanguage;

  @override
  Widget build(BuildContext context) {

    // Set value by model.
    final langModel = MainStateModel().of(context);
    _selectLanguage = langModel.getSelectedLanguage;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(WalletLocalizations.of(context).settingsPageTitle),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 10),
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: _buildMenuList(),
          ),
        ),
      ),
    );
  }

  // Build menu list
  List<Widget> _buildMenuList() {
    // list tile
    List<Widget> _list = List();

    // titles
    List<String> titles = <String> [
      WalletLocalizations.of(context).settingsPageItem_1_Title,
      WalletLocalizations.of(context).settingsPageItem_2_Title,
      WalletLocalizations.of(context).settingsPageItem_3_Title,
    ];

    // item content
    List<String> values = <String> [
      _selectLanguage, 'CNY', 'Light'
    ];

    // Page routes
    List<String> routes = <String> [
      SelectLanguage.tag, '', ''
    ];

    for (int i = 0; i < titles.length; i++) {
      _list.add(_menuItem(titles[i], values[i], routes[i]));
      _list.add(Divider(height: 0, indent: 15));
    }

    return _list;
  }

  //
  Widget _menuItem(String strTitle, String strValue, String route) {
    return Ink(
      color: AppCustomColor.themeBackgroudColor,
      child: ListTile(
        title: Text(strTitle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              strValue,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(width: 15),
            Icon(Icons.keyboard_arrow_right),
          ],
        ),

        onTap: () { Navigator.of(context).pushNamed(route); },
      ),
    );
  }
}
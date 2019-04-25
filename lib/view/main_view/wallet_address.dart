/// Wallet Addresses List page.
/// [author] Kevin Zhang
/// [time] 2019-4-25

import 'package:flutter/material.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';
import 'package:wallet_app/tools/app_data_setting.dart';
import 'package:wallet_app/view/welcome/select_language.dart';
import 'package:wallet_app/view_model/state_lib.dart';

class WalletAddress extends StatefulWidget {
  static String tag = "WalletAddress";

  @override
  _WalletAddressState createState() => _WalletAddressState();
}

class _WalletAddressState extends State<WalletAddress> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(WalletLocalizations.of(context).walletAddressPageAppBarTitle),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 10),
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: _addressList(),
          ),
        ),
      ),
    );
  }

  /// wallet address list
  List<Widget> _addressList() {
    // list tile
    List<Widget> _list = List();

    // addressName
    List<String> addressName = <String> [
      WalletLocalizations.of(context).settingsPageItem_1_Title,
      WalletLocalizations.of(context).settingsPageItem_2_Title,
      WalletLocalizations.of(context).settingsPageItem_3_Title,
    ];

    // address string
    List<String> address = <String> [
      SelectLanguage.tag, '11', '22'
    ];

    for (int i = 0; i < addressName.length; i++) {
      _list.add(_menuItem(addressName[i], address[i]));
      _list.add(Divider(height: 0, indent: 15));
    }

    return _list;
  }

  ///
  Widget _menuItem(String strAddressName, String strAddress) {
    return Ink(
      color: AppCustomColor.themeBackgroudColor,
      child: ListTile(
        title: Text(strAddressName),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              strAddress,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(width: 15),
            Icon(Icons.keyboard_arrow_right),
          ],
        ),

        onTap: () { Navigator.of(context).pushNamed('route'); },
      ),
    );
  }
}
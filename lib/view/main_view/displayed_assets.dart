/// Displayed Assets page.
/// [author] Kevin Zhang
/// [time] 2019-4-25

import 'package:flutter/material.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';
import 'package:wallet_app/tools/app_data_setting.dart';
import 'package:wallet_app/view/welcome/select_language.dart';
import 'package:wallet_app/view_model/state_lib.dart';

class DisplayedAssets extends StatefulWidget {
  static String tag = "DisplayedAssets";

  @override
  _DisplayedAssetsState createState() => _DisplayedAssetsState();
}

class _DisplayedAssetsState extends State<DisplayedAssets> {
  @override
  Widget build(BuildContext context) {

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
            // children: _buildMenuList(),
          ),
        ),
      ),
    );
  }
}
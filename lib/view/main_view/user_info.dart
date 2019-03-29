/// User Info page.
/// [author] Kevin Zhang
/// [time] 2019-3-29

import 'package:flutter/material.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';

class UserInfo extends StatelessWidget {

  static String tag = "UserInfo";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(WalletLocalizations.of(context).userInfoPageAppBarTitle),
        elevation: 0,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text('test'),
              ListView(
                
              )
            ],
          ),
        ),
      )
    );
  }
}
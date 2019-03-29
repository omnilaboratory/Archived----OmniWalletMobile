/// User Info page.
/// [author] Kevin Zhang
/// [time] 2019-3-29

import 'package:flutter/material.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';

class UserInfo extends StatefulWidget {
  static String tag = "UserInfo";
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(WalletLocalizations.of(context).userInfoPageAppBarTitle),
      ),

      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 15),
            Container(
              // color: Colors.white,
              child: ListTile(  // Item 1
                title: Text(WalletLocalizations.of(context).userInfoPageItem_1_Title),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset('assets/logo-png.png', width: 35, height: 35),
                    SizedBox(width: 15),
                    Icon(Icons.keyboard_arrow_right),
                  ],
                ),

                onTap: () {
                  // TODO: show next page.
                  // Navigator.of(context).pushNamed(route);
                },
              ),
            ),
            
            Divider(height: 2, indent: 15),

            Container(
              color: Colors.white,
              child: ListTile(  // Item 2
                title: Text(WalletLocalizations.of(context).userInfoPageItem_2_Title),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'user name',
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
            )
            
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:wallet_app/view_model/state_lib.dart';

class FPFrinedList extends StatefulWidget {
  static String tag = "FPFrinedList";
  @override
  _FPFrinedListState createState() => _FPFrinedListState();
}

class _FPFrinedListState extends State<FPFrinedList> {
  @override
  Widget build(BuildContext context) {


    return SafeArea(child: Scaffold(
      backgroundColor: AppCustomColor.themeBackgroudColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(WalletLocalizations.of(context).flashPayMainPageFriends),
      ),
      body: Center(child: Text("body"),),
    ));
  }
}

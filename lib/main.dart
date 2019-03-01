import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wallet_app/backupwallet/backup_wallet_index.dart';

import 'start.dart';
import 'welcome_page_1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    debugPaintSizeEnabled = true;

    return MaterialApp(
      title: 'LunarX_Omni Wallet',
      // home: StartPage(),
      home: BackupWalletIndex(),
//      home: WelcomePageOne(),
    );
  }
}
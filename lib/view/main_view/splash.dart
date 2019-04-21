/// Splash page.
/// [author] Kevin Zhang
/// [time] 2019-4-4

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_app/main.dart';
import 'package:wallet_app/model/global_model.dart';
import 'package:wallet_app/tools/key_config.dart';
import 'package:wallet_app/tools/net_config.dart';
import 'package:wallet_app/view/backupwallet/backup_wallet_index.dart';
import 'package:wallet_app/view/main_view/main_page.dart';
import 'package:wallet_app/view/welcome/welcome_page_1.dart';
import 'package:wallet_app/view_model/main_model.dart';

class Splash extends StatefulWidget {
  static String tag = "Splash";

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(
      Duration(seconds: 2), 
      () {
        _processData();
      }
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.asset('assets/logo-png.png', width: 180, height: 180),
        ),
      )
    );
  }

  //
  void _processData() {

    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    prefs.then((share) {
      // Check login status
      String val = share.getString(KeyConfig.user_mnemonic_md5);
      if ( val != null && val != '') { // has login
        print('==> has login');

        // get user info from server - FINAL CODE
        _getUserInfo(share);

        // TEST CODE
        // Navigator.of(context).pushAndRemoveUntil(
        //   MaterialPageRoute(builder: (context) => WelcomePageOne()), 
        //   (route) => route == null,
        // );

      } else { // new user or logout (delete id)
        print('==> new user or logout (delete id)');
        // show welcome page
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => WelcomePageOne()), 
          (route) => route == null,
        );
      }

      // check language
      _checkLanguage(share);
    });
  }

  // 
  void _getUserInfo(SharedPreferences share) {

    Future data = NetConfig.get(NetConfig.getUserInfo);

    data.then((data) {
      if (data != null) {
        GlobalInfo.userInfo.userId = NetConfig.userMD5Id;
        GlobalInfo.userInfo.mnemonic = share.get(KeyConfig.user_mnemonic);
        GlobalInfo.userInfo.pinCode = share.get(KeyConfig.user_pinCode_md5);
        GlobalInfo.userInfo.nickname = data['nickname'];
        GlobalInfo.userInfo.faceUrl = data['faceUrl'];

        // check if has finished to back up mnimonic.
        _hasBackup(share);
      }
    });
  }

  // 
  void _hasBackup(SharedPreferences share) {

    bool bVal = share.getBool(KeyConfig.is_backup);

    if (bVal == true) { // has backup
      print('==> has backup');

      // show wallet main page
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MainPage()),
            (route) => route == null,
      );
    } else { // no backup
      print('==> no backup');
      // show mnimonic back up page
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => BackupWalletIndex()),
            (route) => route == null,
      );
    }
  }

  // get app set language
  void _checkLanguage(SharedPreferences share) {

    Locale locale = Localizations.localeOf(context);
    String languageCode = locale.languageCode;
    print('languageCode = $languageCode');

    String setLanguage = share.getString(KeyConfig.set_language);
    print('saved setLanguage = $setLanguage');

    if (setLanguage == 'English') {
      locale = Locale('en',"US");
    } else if (setLanguage == '简体中文') {
      locale = Locale('zh',"CH");
    } else { // No select before
      if (languageCode == 'zh') {
        setLanguage = '简体中文';
      } else if (languageCode == 'en') {
        setLanguage = 'English';
      } else {
        setLanguage = 'English';
      }
    }

    MyApp.setLocale(context, locale);

    // Set value by model.
    final langModel = MainStateModel().of(context);
    langModel.setSelectedLanguage(setLanguage);
  }
}
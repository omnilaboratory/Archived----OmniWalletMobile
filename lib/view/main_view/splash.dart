/// Splash page.
/// [author] Kevin Zhang
/// [time] 2019-4-4

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_app/main.dart';
import 'package:wallet_app/model/global_model.dart';
import 'package:wallet_app/tools/Tools.dart';
import 'package:wallet_app/tools/key_config.dart';
import 'package:wallet_app/tools/net_config.dart';
import 'package:wallet_app/view/backupwallet/backup_wallet_index.dart';
import 'package:wallet_app/view/main_view/main_page.dart';
import 'package:wallet_app/view/welcome/welcome_page_1.dart';
import 'package:wallet_app/view_model/main_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';
import 'package:wallet_app/view_model/state_lib.dart';

class Splash extends StatefulWidget {
  static String tag = "Splash";

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  Timer _timer;

  @override
  void initState() {
    _timer = Timer(
      Duration(seconds: 0), 
      () {
        _checkVersion();
      }
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _timer = null;
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // It will hide status bar and notch.
    SystemChrome.setEnabledSystemUIOverlays([]);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.asset('assets/logo-png.png', width: 229, height: 180),
        ),
      )
    );
  }

  /// Check if has a newer version
  _checkVersion() async {

    // Invoke api.
    var data = await NetConfig.get(context,NetConfig.getNewestVersion);

    if (data != null) {
      int code = data['code'];

      /// Check if has a newer version.
      if (data['code'] > GlobalInfo.currVersionCode) {
        var share = await SharedPreferences.getInstance();
        int codeOld = share.getInt('version_later_state');

        // If has a newer version and not click the 'Later' button yet.
        // Then show dialog.
        if (codeOld == null || (codeOld !=null && codeOld != code)) {
          showDialog(
              context: context,
              barrierDismissible: false,  // user must tap button!
              builder:  (BuildContext context) {
                return AlertDialog(
                  title: Text(WalletLocalizations.of(context).appVersionTitle),
                  content: Text(WalletLocalizations.of(context).appVersionContent1),
                  actions: _actions(data),
                );
              }
          );

        } else { // Already clicked the 'Later' button, then ignore newer version.
          _processData();
        }

      } else { // If has not a newer, continue process data.
        _processData();
      }

    } else { // data is null
      _processData();
    }
  }

  /// Actions for update version
  List<Widget> _actions(data) {

    bool isForce = data['isForce'];
    int code = data['code'];

    List<Widget> btns = [];

    // The version can be ignored.
    if (isForce == false) {
      // Later button
      btns.add(FlatButton(
        child: Text(WalletLocalizations.of(context).appVersionBtn1),
        onPressed: () {
          Future<SharedPreferences> prefs = SharedPreferences.getInstance();
          prefs.then((share){
            share.setInt('version_later_state', code);
          });
          Navigator.of(context).pop();
          _processData(); // go to next logic
        },
      ));
    }

    // OK button - The version must be upgraded.
    btns.add(FlatButton(
      child: Text(WalletLocalizations.of(context).appVersionBtn2),
      onPressed: () {
        _upgradeNewerVersion(data);
      },
    ));

    return btns;
  }

  /// Upgrade to newer version
  void _upgradeNewerVersion(data) async {

    // APK install file download url for Android.
    var url = NetConfig.imageHost + data['path'];

    // Go to App Store for iOS.
    if (Platform.isIOS) {
      url = 'https://www.baidu.com/'; // temp code
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
       Tools.showToast('Could not launch $url');
    }
  }

  /// Check if will be locked.
  _willBeLocked() {
    
    // Tools.showToast(
    //   GlobalInfo.fromWhere.toString(),
    //   toastLength: Toast.LENGTH_LONG
    // );

    if (GlobalInfo.fromWhere == null) { // Will be locked.
      GlobalInfo.fromWhere = 0; // from reload
      GlobalInfo.isInputPIN = true;
      MyApp.restartApp(context);
      return true;
    }

    return false;
  }

  ///
  void _processData() async {

    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    prefs.then((share) {
      // Check login status
      String val = share.getString(KeyConfig.user_login_token);

      if ( val != null && val != '') { // has login
        print('==> has logged in | ${DateTime.now()}');

        GlobalInfo.userInfo.loginToken = val;
        GlobalInfo.userInfo.pinCode = share.get(KeyConfig.user_pinCode_md5);
        GlobalInfo.userInfo.userId = share.getString(KeyConfig.user_mnemonic_md5);
        
        // check lock
        if( !_willBeLocked() ) {  // No lock
          // get user info from server
          _getUserInfo(share);

          // check language, currency unit, theme.
          _getSettings(share);
        }

      } else { // new user or logout (delete id)
        print('==> new user or logout (delete id)');
        // show welcome page
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => WelcomePageOne()), 
          (route) => route == null,
        );

        // check language, currency unit, theme.
        _getSettings(share);
      }
    });
  }

  // 
  void _getUserInfo(SharedPreferences share) {

    Future data = NetConfig.get(context,NetConfig.getUserInfo);
    // Tools.loadingAnimation(context);
    data.then((data) {
      if (data != null) {
        // print('==> --. DATA | ${DateTime.now()}');
        String user_mnemonic = share.get(KeyConfig.user_mnemonic);
        var words = user_mnemonic.split(' ');
        if(words.length!=12){
          user_mnemonic = Tools.decryptAes(user_mnemonic);
        }
        GlobalInfo.userInfo.mnemonic = user_mnemonic;

        GlobalInfo.userInfo.nickname = data['nickname'];
        GlobalInfo.userInfo.faceUrl = data['faceUrl'];
        GlobalInfo.userInfo.init(context,null);
        // print('==> GET DATA | ${DateTime.now()}');
        // check if has finished to back up mnimonic.
        _hasBackup(share);
      }
    });
  }

  // 
  void _hasBackup(SharedPreferences share) {

    bool bVal = share.getBool(KeyConfig.is_backup);

    if (bVal == true) { // has backup
      print('==> has backup | ${DateTime.now()}');

      // show wallet main page
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MainPage()),
            (route) => route == null,
      );
    } else { // no backup
      print('==> no backup | ${DateTime.now()}');
      // show mnimonic back up page
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => BackupWalletIndex()),
            (route) => route == null,
      );
    }
  }

  /// get app settings
  void _getSettings(SharedPreferences share) {

    Locale locale = Localizations.localeOf(context);
    String languageCode = locale.languageCode;
    print('languageCode = $languageCode');

    String setLanguage     = share.getString(KeyConfig.set_language);
    String setCurrencyUnit = share.getString(KeyConfig.set_currency_unit);
    String setTheme        = share.getString(KeyConfig.set_theme);
    print('saved setLanguage     = $setLanguage');
    print('saved setCurrencyUnit = $setCurrencyUnit');
    print('saved setTheme        = $setTheme');

    // for language
    if (setLanguage == KeyConfig.languageEn) {
      locale = Locale('en',"US");
    } else if (setLanguage == KeyConfig.languageCn) {
      locale = Locale('zh',"CH");
    } else { // No select before
      if (languageCode == 'zh') {
        setLanguage = KeyConfig.languageCn;
      } else if (languageCode == 'en') {
        setLanguage = KeyConfig.languageEn;
      } else {
        setLanguage = KeyConfig.languageEn;
      }
    }

    // for currency unit
    if (setCurrencyUnit == null) {
      if (languageCode == 'zh') {
        setCurrencyUnit = KeyConfig.cny;
      } else if (languageCode == 'en') {
        setCurrencyUnit = KeyConfig.usd;
      } else {
        setCurrencyUnit = KeyConfig.usd;
      }
    }

    // for color theme
    if (setTheme == null) {
      setTheme = KeyConfig.light;
    }

    MyApp.setLocale(context, locale);

    // Set value by model.
    final model = MainStateModel().of(context);
    model.setSelectedLanguage(setLanguage);
    model.setCurrencyUnit(setCurrencyUnit);
    model.setTheme(setTheme);
  }
}
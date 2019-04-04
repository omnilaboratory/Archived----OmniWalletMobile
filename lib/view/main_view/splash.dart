/// Splash page.
/// [author] Kevin Zhang
/// [time] 2019-4-4

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_app/main.dart';
import 'package:wallet_app/view/welcome/welcome_page_1.dart';

class Splash extends StatefulWidget {
  static String tag = "Splash";

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: _content(),
    );
  }

  // show splash content
  Widget _content() {
    _setLocale();
    return Container(
      color: Colors.red,
      child: Image.asset('assets/logo-png.png'),
    );
  }

  //
  void _setLocale() {
    Locale locale;
    Future<String> setLanguage = _getSelectedLanguage();
    setLanguage.then(
      (String setLanguage) {
        print('saved setLanguage = $setLanguage');
    
        if (setLanguage == 'English') {
          print('English');
          locale = Locale('en',"US");
        } else if (setLanguage == '简体中文') {
          print('简体中文');
          locale = Locale('zh',"CH");
        }
    
        MyApp.setLocale(context, locale);
        
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => WelcomePageOne()), 
          (route) => route == null,
        );
      }
    );
  }

  // get app set language
  Future<String> _getSelectedLanguage() async {
    var set_language;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    set_language = prefs.getString('set_language');
    return set_language;
  }
}
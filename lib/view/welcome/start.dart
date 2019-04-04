/// Switch language display of app page.
/// [author] Kevin Zhang
/// [time] 2019-3-5

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';
import 'package:wallet_app/main.dart';
import 'package:wallet_app/tools/app_data_setting.dart';
import 'package:wallet_app/view/welcome/create_account.dart';
import 'package:wallet_app/view/welcome/select_language.dart';
import 'package:wallet_app/view_model/main_model.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(WalletLocalizations.of(context).startPageAppBarTitle),
      ),

      body: SafeArea(
        child: Column(
          children: <Widget>[
            _showSwiper(),            
            _showContent(),
            _selectLanguage(context),
          ],
        ),
      )
    );
  }

  // Swiper
  Widget _showSwiper() {
    return Container(
      height: 260,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network("http://via.placeholder.com/350x150",fit: BoxFit.fill,);
        },
        itemCount: 4,
        pagination: SwiperPagination(),
        control: SwiperControl(),
      ),
    );
  }

  // Swiper
  Widget _showContent() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Button - Get Started
          RaisedButton(
            child: Text(WalletLocalizations.of(context).startPageButtonFirst),
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () {
              // TODO: Show the create new wallet page.
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => CreateAccount()
                ) 
              );
            },
          ),

          // Button - Restore wallet
          SizedBox(height: 20),
          RaisedButton(
            child: Text(WalletLocalizations.of(context).startPageButtonSecond),
            onPressed: () {
              // TODO: Show the restore wallet page.
            },
          ),
        ],
      ),
    ); 
  }

  // Select language bar.
  Widget _selectLanguage(BuildContext context) {

    // Set value by model.
    final langModel = MainStateModel().of(context);
    // String setLanguage = langModel.getSelectedLanguage;

    // get device currently language
    // Locale myLocale = Localizations.localeOf(context);
    // String strLocale =  myLocale.toString();

    

    // if (setLanguage == '') {
    //   String systemLanguage;

    //   if (strLocale == 'zh_Hans_US') {
    //     systemLanguage = '简体中文';
    //   } else {
    //     systemLanguage = 'English';
    //   }

    //   langModel.setSelectedLanguage(systemLanguage);

    // } else {
    //   langModel.setSelectedLanguage(setLanguage.toString());

    //   // Set language.
    //   Locale locale =  Localizations.localeOf(context);
    //   if (setLanguage == 'English') {
    //     locale = Locale('en',"US");
    //   } else {
    //     locale = Locale('zh',"CH");
    //   }

    //   MyApp.setLocale(context, locale);
    // }
    
    return InkWell(
      // splashColor: Colors.blue[100],
      // highlightColor: Colors.blue[100],
      
      onTap: () {
        // Show the select language page.
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => SelectLanguage(),
          ), 
        );
      },
          
      child: Ink(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        color: AppCustomColor.themeFrontColor,
        
        child: Row(
          children: <Widget>[
            Icon(Icons.language),
            SizedBox(width: 15),
            Text(WalletLocalizations.of(context).startPageLanguageBarTitle),
            
            Expanded(
              child: Text(
                // Get value by model.
                langModel.getSelectedLanguage,
                // currentLanguage,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),

            SizedBox(width: 15),

            Icon(
              Icons.keyboard_arrow_right, 
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
/// Switch language display of app page.
/// [author] Kevin Zhang
/// [time] 2019-3-5

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';
import 'package:wallet_app/tools/Tools.dart';
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _showSwiper(),  
              _showButtons(),
            ],
          ),
        ),
      )
    );
  }

  // Swiper
  Widget _showSwiper() {
    return Container(
      height: 230,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          // return Image.network("http://via.placeholder.com/350x150",fit: BoxFit.fill,);
          return Image.asset('assets/swiper-1.png', fit: BoxFit.fill,);
        },
        itemCount: 4,
        pagination: SwiperPagination(),
        control: SwiperControl(),
      ),
    );
  }

  // buttons
  Widget _showButtons() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(height: 30),
        _getStartedButton(),
        _restoreWalletButton(),
        SizedBox(height: 50),
        _selectLanguage(),
      ],
    );
  }

  //  button
  Widget _getStartedButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: Row(
        children: <Widget>[
          Expanded(
            child: RaisedButton(
              child: Text(
                WalletLocalizations.of(context).startPageButtonFirst,
              ),

              color: AppCustomColor.btnConfirm,
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 15),
              elevation: 0,
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => CreateAccount()
                  ) 
                );
              },
            ),
          ),
        ],
      ),
    );
  } 
  
  //  button
  Widget _restoreWalletButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Row(
        children: <Widget>[
          Expanded(
            child: RaisedButton(
              child: Text(
                WalletLocalizations.of(context).startPageButtonSecond,
              ),

              color: AppCustomColor.btnCancel,
              textColor: Colors.blue,
              padding: EdgeInsets.symmetric(vertical: 15),
              elevation: 0,
              onPressed: () {
                // TODO: restore wallet
              },
            ),
          ),
        ],
      ),
    );
  } 

  //
  Widget _selectLanguage() {

    // Set value by model.
    final langModel = MainStateModel().of(context);

    return InkWell(
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
        // color: AppCustomColor.themeBackgroudColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _iconLanguage(langModel.getSelectedLanguage),
            SizedBox(width: 15),
            Text(
              // Get selected language by user before
              langModel.getSelectedLanguage,
              // style: TextStyle(
              //   color: Colors.grey,
              // ),
            ),
            SizedBox(width: 20),
            Icon(
              Icons.keyboard_arrow_right, 
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  //
  Widget _iconLanguage(String strLang) {
    if (strLang == 'English') {
      return Image.asset(Tools.imagePath('icon_english'), width: 24, height: 24);
    } else {
      return Image.asset(Tools.imagePath('icon_chinese'), width: 24, height: 24);
    }
  }
}
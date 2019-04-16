import 'package:flutter/material.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';
import 'package:wallet_app/tools/Tools.dart';
import 'package:wallet_app/tools/app_data_setting.dart';

import 'package:wallet_app/view/welcome/welcome_page_3.dart';
import 'package:wallet_app/view/widgets/custom_raise_button_widget.dart';

class WelcomePageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Colors.transparent,
          // brightness: Theme.of(context).brightness == 
          //   Brightness.dark ? Brightness.light : Brightness.dark,
        ),
        preferredSize: Size.fromHeight(0),
      ),

      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          children: <Widget>[
            _childColumn(context),
          ],
        ),
      )
    );
  }

  // Child content.
  Widget _childColumn(BuildContext context) {
    return Column(
      children: <Widget>[
        // Title
        Text(
          WalletLocalizations.of(context).welcomePageTwoTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Introduction content.
        SizedBox(height: 30),
        Text(
          WalletLocalizations.of(context).welcomePageTwoContentOne,
          style: TextStyle(
            color: AppCustomColor.fontGreyColor,
            height: 1.3,
          ),
        ),

        // List content.
        SizedBox(height: 30),
        _listContent(Tools.imagePath('icon_wel1'), WalletLocalizations.of(context).welcomePageTwoContentTwo),

        SizedBox(height: 20),
        _listContent(Tools.imagePath('icon_wel2'), WalletLocalizations.of(context).welcomePageTwoContentThree),

        SizedBox(height: 20),
        _listContent(Tools.imagePath('icon_wel3'), WalletLocalizations.of(context).welcomePageTwoContentFour),

        SizedBox(height: 20),
        _listContent(Tools.imagePath('icon_wel4'), WalletLocalizations.of(context).welcomePageTwoContentFive),

        SizedBox(height: 30),
        _bottomButton(context),
      ],
    );
  }

  //
  Widget _listContent(String img, String txt) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(img, width: 24, height: 28),
        SizedBox(width: 30),
        Expanded(
          child: Text(
            txt,
            style: TextStyle(
              color: AppCustomColor.fontGreyColor,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }

  // Buttons
  Widget _bottomButton(BuildContext context) {
    return Row(
      children: <Widget>[
        CustomRaiseButton( // Back button.
          context: context,
          flex: 1,
          title: WalletLocalizations.of(context).welcomePageTwoButtonBack,
          leftIconName: 'icon_back',
          callback: () {
            Navigator.pop(context);
          },
        ),

        SizedBox(width: 20),
        CustomRaiseButton( // Next button.
          context: context,
          flex: 2,
          title: WalletLocalizations.of(context).welcomePageTwoButtonNext,
          titleColor: Colors.white,
          rightIconName: 'icon_next',
          color: AppCustomColor.btnConfirm,
          callback: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => WelcomePageThree()));
          },
        ),
      ],
    );
  }
}
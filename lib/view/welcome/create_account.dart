///  Create a New Account.
/// [author] Kevin Zhang
/// [time] 2019-3-5

import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:wallet_app/tools/Tools.dart';
import 'package:wallet_app/tools/app_data_setting.dart';
import 'package:wallet_app/view/backupwallet/backup_wallet_index.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';
import 'package:wallet_app/view/widgets/custom_raise_button_widget.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  //
  FocusNode _nodeText1 = FocusNode();
  FocusNode _nodeText2 = FocusNode();
  FocusNode _nodeText3 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppCustomColor.themeBackgroudColor,

      appBar: AppBar(
        elevation: 0,
        title: Text(WalletLocalizations.of(context).createAccountPageAppBarTitle),
      ),

      body: FormKeyboardActions(
        actions: _keyboardActions(),
        child: SafeArea(
          child: _content(),
        ),
      ),
    );
  }

  // Keyboard Actions
  List<KeyboardAction> _keyboardActions() {

    List<KeyboardAction> actions = <KeyboardAction> [
      KeyboardAction(
        focusNode: _nodeText1,
        closeWidget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.close),
        )
      ),

      KeyboardAction(
        focusNode: _nodeText2,
        closeWidget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.close),
        )
      ),

      KeyboardAction(
        focusNode: _nodeText3,
        closeWidget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.close),
        )
      ),
    ];

    return actions;
  }
  
  // TextField - Account Name
  Widget _inputAccountName() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        children: <Widget>[
          Image.asset(Tools.imagePath('icon_name'), width: 17, height: 16),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true, 
                fillColor: AppCustomColor.themeBackgroudColor,
                hintText: WalletLocalizations.of(context).createAccountPageTooltip_1,
              ),

              focusNode: _nodeText1,
            ),
          ),
        ],
      ),
    );
  }

  // TextField - Password
  Widget _inputPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        children: <Widget>[
          Image.asset(Tools.imagePath('icon_password'), width: 16, height: 18),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true, 
                fillColor: AppCustomColor.themeBackgroudColor,
                hintText: WalletLocalizations.of(context).createAccountPageTooltip_2,
              ),

              focusNode: _nodeText2,
            ),
          ),
        ],
      ),
    );
  }

  // TextField - Repeat Password
  Widget _inputRepeatPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        children: <Widget>[
          Image.asset(Tools.imagePath('icon_confirm'), width: 16, height: 18),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true, 
                fillColor: AppCustomColor.themeBackgroudColor,
                hintText: WalletLocalizations.of(context).createAccountPageTooltip_3,
              ),

              focusNode: _nodeText3,
            ),
          ),
        ],
      ),
    );
  }

  //
  Widget _content() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30, bottom: 50),
            child: Image.asset(Tools.imagePath('image_account'), width: 68, height: 62)
          ),

          _inputAccountName(),
          Divider(height: 0, indent: 25),
          _inputPassword(),
          Divider(height: 0, indent: 25),
          _inputRepeatPassword(),
          Divider(height: 0, indent: 25),

          SizedBox(height: 80),
          _createButton(),
        ],
      ),
    );
  }

  // Create button
  Widget _createButton() {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 50),
      child: CustomRaiseButton(
        context: context,
        hasRow: false,
        title: WalletLocalizations.of(context).createAccountPageButton,
        titleColor: Colors.white,
        color: AppCustomColor.btnConfirm,
        callback: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return BackupWalletIndex(param: 1,);
              }
            ),
              
            (route) => route == null,
          );
        },
      ),
    );
  }
}
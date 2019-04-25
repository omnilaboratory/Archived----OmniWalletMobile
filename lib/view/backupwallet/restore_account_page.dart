import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:wallet_app/view/main_view/main_page.dart';
import 'package:wallet_app/view/widgets/custom_raise_button_widget.dart';
import 'package:wallet_app/view_model/state_lib.dart';

class RestoreAccount extends StatefulWidget {
  static String tag = "Restore Account";
  @override
  _RestoreAccountState createState() => _RestoreAccountState();
}

class _RestoreAccountState extends State<RestoreAccount> {
  FocusNode _nodeText1 = FocusNode();
  FocusNode _nodeText2 = FocusNode();
  FocusNode _nodeText3 = FocusNode();
  TextEditingController controller;
  TextEditingController controller1;
  TextEditingController controller2;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller1 = TextEditingController();
    controller2 = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppCustomColor.themeBackgroudColor,
      appBar: AppBar(title: Text(WalletLocalizations.of(context).restore_account_title),),
      body: Builder(
        builder: (BuildContext context){
            return FormKeyboardActions(
                actions: _keyboardActions(),
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(left: 20,right: 20,top: 10),
                    child:  this.buildBody(context)
                )
            );
        },
      ),
    );
  }
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

  Widget buildBody(BuildContext context){
    /// tips Area
    var tips = Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 20),
            child: AutoSizeText(
              WalletLocalizations.of(context).restore_account_tips,
              style: TextStyle(color: Colors.red,height: 1.3),
              textAlign: TextAlign.center,
              minFontSize: 9,
            ),
          ),
        );
    /// phrase Area
    var inputArea = TextField( // content
          controller: controller,
          decoration: InputDecoration(
            labelText: WalletLocalizations.of(context).restore_account_phrase_title,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6)
            ),
            fillColor: Colors.grey[100],
            filled: true,
          ),
          maxLines: null,
          focusNode: _nodeText1,
          onChanged: (val){
            setState(() {
              this.clickBtn(context);
            });
          },
        );
    ///input pin
    var inputPin = TextField( // content
          controller: controller1,
          decoration: InputDecoration(
            labelText: WalletLocalizations.of(context).restore_account_tip_pin,
            border: InputBorder.none,
            fillColor: AppCustomColor.themeBackgroudColor,
            filled: true,
          ),
          maxLines: 1,
          obscureText:true,
          focusNode: _nodeText2,
        );
    /**
     * PIN confirm
     */
    var inputConfirmPin = TextField( // content
          controller: controller2,
          decoration: InputDecoration(
            labelText: WalletLocalizations.of(context).restore_account_tip_confirmPin,
            border: InputBorder.none,
            fillColor: AppCustomColor.themeBackgroudColor,
            filled: true,
          ),
          maxLines: 1,
          obscureText:true,
          focusNode: _nodeText3,
        );
    var body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        tips,
        inputArea,
        Padding(
          padding: const EdgeInsets.only(top: 30,bottom: 12),
          child: Text(WalletLocalizations.of(context).restore_account_resetPIN),
        ),
        inputPin,
        Divider(height: 0,),
        inputConfirmPin,
        Divider(height: 0,),
        SizedBox(height: 20,),
        CustomRaiseButton( // Next button.
          context: context,
          hasRow: false,
          title: WalletLocalizations.of(context).restore_account_btn_restore,
          titleColor: Colors.white,
          color: AppCustomColor.btnConfirm,
          callback: clickBtn(context),
        ),
        SizedBox(height: 40,),
      ],
    );
    return body;
  }

  Function clickBtn(BuildContext context) {
    String text = this.controller.text;
    var split = text.split(' ');
    split.removeWhere((item) {
      return item == ' ' || item.length == 0;
    });

    if (split.length == 12) {
      return () {
        String pin = this.controller1.text;
        String pin2 = this.controller2.text;
        if(pin.isEmpty||pin.isEmpty||pin != pin2){
          Tools.showToast(WalletLocalizations.of(context).restore_account_tip_error);
          return null;
        }
        var _mnemonic= split.join(' ');
        print(_mnemonic);
        var  userId = Tools.convertMD5Str(_mnemonic);
        print(userId);
        Future result = NetConfig.post(NetConfig.restoreUser, {'userId':userId});
        result.then((data){
          if(data!=null){
            GlobalInfo.userInfo.faceUrl = data['faceUrl'];
            GlobalInfo.userInfo.nickname = data['nickname'];

            Tools.saveStringKeyValue(KeyConfig.user_mnemonic, _mnemonic);
            GlobalInfo.userInfo.mnemonic = _mnemonic;

            Tools.saveStringKeyValue(KeyConfig.user_mnemonic_md5, userId);
            GlobalInfo.userInfo.userId = userId;

            String _pinCode_md5 =  Tools.convertMD5Str(pin);
            Tools.saveStringKeyValue(KeyConfig.user_pinCode_md5, _pinCode_md5);
            GlobalInfo.userInfo.pinCode = _pinCode_md5;

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => MainPage()), (
                route) => route == null
            );
          }
        });
      };
    }
    return null;
  }

}
/// Flash Pay Payment Method page.
/// [author] Kevin Zhang
/// [time] 2019-6-13

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';
import 'package:wallet_app/main.dart';
import 'package:wallet_app/tools/Tools.dart';
import 'package:wallet_app/tools/app_data_setting.dart';
import 'package:wallet_app/view_model/main_model.dart';
import 'package:wallet_app/view_model/state_lib.dart';

class FlashPayPaymentMethod extends StatefulWidget {
  static String tag = "FlashPayPaymentMethod";
  @override
  _FlashPayPaymentMethodState createState() => _FlashPayPaymentMethodState();
}

class _FlashPayPaymentMethodState extends State<FlashPayPaymentMethod> {
  
  String strClickItem = '';
  
  @override
  Widget build(BuildContext context) {
    //
    final model = MainStateModel().of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(WalletLocalizations.of(context).flashPayPaymentMethodPageAppBarTitle),
        actions: <Widget>[
          FlatButton(  // records button
            child: Text(WalletLocalizations.of(context).flashPayMainPageAppBarAction),
            textColor: Colors.blue,
            onPressed: () {
              // _actionSaveButton(model, context);
            },
          ),
        ],
      ),

      body: SafeArea(
        child: ListView(
          children: _walletPaymentMethodList(model),
        ),
      )
    );
  }

  ///-----------
  /// 6-14 New Add
  
  ///
  Widget _title_1() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 20, bottom: 10),
      child: Text(
        WalletLocalizations.of(context).flashPayPaymentMethodPageMethod_1,
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
  
  ///
  Widget _title_2() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 50, bottom: 10),
      child: Text(
        WalletLocalizations.of(context).flashPayPaymentMethodPageMethod_2,
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  ///
  Widget _thirdPartPaymentMethod() {
    return Ink(
      color: AppCustomColor.themeBackgroudColor,
      child: ListTile(
        // leading: CircleAvatar( // Icon
        //   backgroundImage: AssetImage(Tools.imagePath('icon_chinese')),
        // ),

        title: Text(WalletLocalizations.of(context).flashPayPaymentMethodPageThirdPart),
        trailing: Icon(Icons.keyboard_arrow_right),

        // onTap: () { Navigator.of(context).pushNamed(AddressManage.tag); },
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FlashPayPaymentMethod(),
            ),
          );
        },
      ),
    );
  }

  /// Build list data.
  /// [item] is list tile content.
  /// [setPaymentMethod] is currently selected language.
  Widget _oneWalletPaymentMethod(BuildContext context, String item, String setPaymentMethod) {

    bool isSelected;
    if (item == setPaymentMethod) {
      isSelected = true;
    } else {
      isSelected = false;
    }

    return Ink(
      color: AppCustomColor.themeBackgroudColor,
      child: ListTile(
        // leading: CircleAvatar( // Icon
        //   backgroundImage: AssetImage(Tools.imagePath('icon_chinese')),
        // ),

        title: Text( // address name
          'Address A',
        ),

        subtitle: Text( // address
          '12dfsdf...ereYEjfr',
          style: TextStyle(
            color: Colors.grey,
            // fontSize: 12,
          ),
        ),

        trailing: Row( // address
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '0.0001 USDT',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            SizedBox(width: 15),
            
            Icon(
              isSelected ? Icons.check : null,
              color: Colors.blue,
            ),
          ],
        ),

        // onTap: () { Navigator.of(context).pushNamed(AddressManage.tag); },
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => AddressManage(data: walletData),
          //   ),
          // );
        },
      ),
    );
  }

  // 
  void _actionSaveButton(MainStateModel model, BuildContext context) {
    print('strClickItem = $strClickItem');
    if (strClickItem != '') {
      model.setSelectedLanguage(strClickItem);
    
      // change app language.
      Locale locale;
      if (strClickItem == KeyConfig.languageEn) {
        locale = Locale('en',"US");
      } else {
        locale = Locale('zh',"CH");
      }
    
      MyApp.setLocale(context, locale);
    
      // save selected value to local storage
      _saveSelectedLanguage(strClickItem);
    }
                 
    Navigator.pop(context);
  }

  /// Build list data.
  /// [item] is list tile content.
  /// [setLanguage] is currently selected language.
  Widget _oneItem(BuildContext context, String item, String setLanguage) {

    bool isSelected;
    if (item == setLanguage) {
      isSelected = true;
    } else {
      isSelected = false;
    }

    return Ink(
      color: AppCustomColor.themeBackgroudColor,
      child: ListTile(
        leading: _iconLanguage(item),
        title: Text(
          item,
          // style: TextStyle(
          //   fontSize: 14,
          // ),
        ),
        trailing: Icon(
          isSelected ? Icons.check : null,
          color: Colors.blue,
        ),
        onTap: () { 
          setState(() {
            strClickItem = item;
          });
        },
      ),
    );
  }

  // Build language list
  List<Widget> _walletPaymentMethodList(MainStateModel model) {
    
    String setLanguage = model.getSelectedLanguage;
    
    // List content.
    List<Widget> _list = List();
    List<String> items = <String> [
      KeyConfig.languageEn, KeyConfig.languageCn,
    ];

    if (strClickItem != '') {
      setLanguage = strClickItem;
    }

    // Wallet payment method.
    _list.add(_title_1());

    for (int i = 0; i < items.length; i++) {
      _list.add(_oneWalletPaymentMethod(context, items[i], setLanguage));
      _list.add(Divider(height: 0, indent: 15));
    }

    // Third-Part Payment method.
    _list.add(_title_2());
    _list.add(_thirdPartPaymentMethod());

    return _list;
  }

  //
  void _saveSelectedLanguage(String value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(KeyConfig.set_language, value);
  }

  //
  Widget _iconLanguage(String item) {
    if (item == 'English') {
      return Image.asset(Tools.imagePath('icon_english'), width: 24, height: 24);
    } else {
      return Image.asset(Tools.imagePath('icon_chinese'), width: 24, height: 24);
    }
  }
}
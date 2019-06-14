/// FlashPayDeposit page.
/// [author] Kevin Zhang
/// [time] 2019-6-12

import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';
import 'package:wallet_app/tools/app_data_setting.dart';
import 'package:wallet_app/view/flash_pay/flash_pay_payment_method.dart';
import 'package:wallet_app/view/widgets/custom_raise_button_widget.dart';
import 'package:wallet_app/view_model/state_lib.dart';
import 'package:auto_size_text/auto_size_text.dart';

class FlashPayDeposit extends StatefulWidget {
  static String tag = "FlashPayDeposit";

  @override
  _FlashPayDepositState createState() => _FlashPayDepositState();
}

class _FlashPayDepositState extends State<FlashPayDeposit> {

  /// form define
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _pinCodeController = TextEditingController();
  FocusNode _nodePin = FocusNode();
  bool _hasClearIcon = false;

  @override
  void initState() {
    _nodePin.addListener(_listener);
    super.initState();
  }

  /// textfield listener
  void _listener() {
    if (_nodePin.hasFocus) { // get focus
      if (_pinCodeController.text.trim().length == 0) {
        _hasClearIcon = false;
      } else {
        _hasClearIcon = true;
      }
    } else {
      _hasClearIcon = false;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _pinCodeController.dispose();
    _nodePin.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppCustomColor.themeBackgroudColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(WalletLocalizations.of(context).flashPayMainPageDeposit),
        actions: <Widget>[
          FlatButton(
            child: Text(WalletLocalizations.of(context).flashPayMainPageAppBarAction),
            textColor: Colors.blue,
            onPressed: () {
              // Navigator.of(context).pop();
            },
          ),
        ],
      ),

      body: FormKeyboardActions(
        actions: _actions(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _defalutDepositMethod(),
                _inputAmount(),
                _remark(),
                _confirmDeposit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  List<KeyboardAction> _actions() {
    List<KeyboardAction> _actions = <KeyboardAction> [
      KeyboardAction(
        focusNode: _nodePin,
        closeWidget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.close),
        )
      )
    ];

    return _actions;
  }

  ///
  Widget _defalutDepositMethod() {
    return Ink(
      // color: AppCustomColor.themeBackgroudColor,
      child: ListTile(
        // leading: Image.asset(Tools.imagePath('icon_chinese'), width: 24, height: 24),
        // leading: Icon(Icons.account_balance_wallet),
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
            Icon(Icons.keyboard_arrow_right),
          ],
        ),

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

  ///
  Widget _inputAmount() {
    return Form(
      key: _formKey,
      // autovalidate: true,
      onChanged: () {
        if (_pinCodeController.text.trim().length == 0) {
          _hasClearIcon = false;
        } else {
          _hasClearIcon = true;
        }
        setState(() {});
      },
      
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        child: TextFormField(
          // enableInteractiveSelection: false,  // disable copy / paste text .
          controller:  _pinCodeController,
          focusNode:   _nodePin,
          // autofocus: true,
          // maxLength: 6,
          validator: (val) => _validatePIN(val),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: WalletLocalizations.of(context).flashPayDepositPageInputTitle,
            // hintStyle: TextStyle(fontSize: 14), 
            suffixIcon: _hasClearIcon ? 
              IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(Icons.highlight_off, color: Colors.grey),
                onPressed: () { _pinCodeController.clear(); },
              ) : null,
          ),
        ),
      ),
    );
  }

  ///
  Widget _remark() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text( // miner fee
            WalletLocalizations.of(context).flashPayDepositPageRemark_1 + '0.00001 BTC',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          Text( // remark about time
            WalletLocalizations.of(context).flashPayDepositPageRemark_2,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  /// Confirm Deposit button
  Widget _confirmDeposit() {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: CustomRaiseButton(
        context: context,
        hasRow: false,
        title: WalletLocalizations.of(context).common_btn_confirm,
        titleColor: Colors.white,
        color: AppCustomColor.btnConfirm,
        callback: () {
          // _checkVersion();
        },
      ),
    );
  }

  /// validate pin
  _validatePIN(String val) {
    if (Tools.convertMD5Str(val) != GlobalInfo.userInfo.pinCode) {
      return WalletLocalizations.of(context).unlockPageAppTips;
    }
    return null;
  }
}
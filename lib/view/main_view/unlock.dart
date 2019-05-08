import 'dart:async';

/// Unlock app.
/// [author] Kevin Zhang
/// [time] 2019-5-8

import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';
import 'package:wallet_app/main.dart';
import 'package:wallet_app/tools/Tools.dart';
import 'package:wallet_app/tools/app_data_setting.dart';
import 'package:wallet_app/view/widgets/custom_raise_button_widget.dart';
import 'package:wallet_app/view_model/main_model.dart';
import 'package:wallet_app/view_model/state_lib.dart';

class Unlock extends StatefulWidget {
  static String tag = "Unlock";
  @override
  _UnlockState createState() => _UnlockState();
}

class _UnlockState extends State<Unlock> {
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
    _nodePin.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(WalletLocalizations.of(context).unlockPageAppBarTitle),
      ),

      body: FormKeyboardActions(
        actions: _actions(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _inputPIN(),
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
  Widget _inputPIN() {

    return Form(
      key: _formKey,
      autovalidate: true,
      onChanged: () {
        // print('==> VAL --> ${_nameController.text}');
        if (_pinCodeController.text.trim().length == 0) {
          _hasClearIcon = false;
        } else {
          _hasClearIcon = true;
          if (_pinCodeController.text.trim().length == 6) {
            _unlockApp();
          }
        }
        setState(() { });
      },
      
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: TextFormField(
          controller:  _pinCodeController,
          focusNode:   _nodePin,
          autofocus: true,
          maxLength: 6,
          // validator: (val) => _validate(val),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: WalletLocalizations.of(context).createAccountPageTooltip_2,
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
  
  /// validate pin
  // String _validate(String val) {
  //   if (val == null || val.trim().length == 0) {
  //     return WalletLocalizations.of(context).createAccountPageErrMsgEmpty;
  //   } else if (val.trim().length < 6) {
  //     return WalletLocalizations.of(context).createAccountPageErrMsgLength;
  //   } else {
  //     return null;
  //   }
  // }

  /// Unlock app.
  void _unlockApp() {
    // Unlock app
    // TODO: check pin is correct
    GlobalInfo.isInputPIN = false;
    MyApp.restartApp(context);
  }

}
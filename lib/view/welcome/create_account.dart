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

  // form define
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _strAccountName, _strPinCode, _strRepeatPinCode;

  TextEditingController _accountNameController = TextEditingController();
  TextEditingController _pinCodeController = TextEditingController();
  TextEditingController _repeatPinCodeController = TextEditingController();

  //
  FocusNode _nodeText1 = FocusNode();
  FocusNode _nodeText2 = FocusNode();
  FocusNode _nodeText3 = FocusNode();

  // 
  bool _accountNameHasFocus = false;
  bool _pinCodeHasFocus = false;
  bool _repeatPinCodeHasFocus = false;

  //
  bool _autoValidate = false;

  // add textfield listener
  @override
  void initState() {

    _nodeText1.addListener(() {
      if (_nodeText1.hasFocus) { // get focus
        _accountNameHasFocus = true;
      } else {
        _accountNameHasFocus = false;
      }
      setState(() {});
    });

    _nodeText2.addListener(() {
      if (_nodeText2.hasFocus) { // get focus
        _pinCodeHasFocus = true;
      } else {
        _pinCodeHasFocus = false;
      }
      setState(() {});
    });

    _nodeText3.addListener(() {
      if (_nodeText3.hasFocus) { // get focus
        _repeatPinCodeHasFocus = true;
      } else {
        _repeatPinCodeHasFocus = false;
      }
      setState(() {});
    });

    super.initState();
  }

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
  
  //
  Widget _content() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30, bottom: 50),
              child: Image.asset(Tools.imagePath('image_account'), width: 68, height: 62)
            ),

            // _accountName(),
            // Divider(height: 0, indent: 25),
            // _pinCode(),
            // Divider(height: 0, indent: 25),
            // _repeatPinCode(),
            // Divider(height: 0, indent: 25),

            //
            _pinCode_TEST(_accountNameController, _nodeText1, _strAccountName, 'icon_name', 
              WalletLocalizations.of(context).createAccountPageTooltip_1, 
              _accountNameHasFocus, null, 1),
            
            Divider(height: 0, indent: 25),

            _pinCode_TEST(_pinCodeController, _nodeText2, _strPinCode, 'icon_password', 
              WalletLocalizations.of(context).createAccountPageTooltip_2, 
              _pinCodeHasFocus, WalletLocalizations.of(context).createAccountPageTooltip_4, 2),

              Divider(height: 0, indent: 25),

            _pinCode_TEST(_repeatPinCodeController, _nodeText3, _strRepeatPinCode, 'icon_confirm', 
              WalletLocalizations.of(context).createAccountPageTooltip_3, 
              _repeatPinCodeHasFocus, WalletLocalizations.of(context).createAccountPageTooltip_4, 3),

            Divider(height: 0, indent: 25),

            SizedBox(height: 80),
            _btnCreate(),
          ],
        ),
      ),
    );
  }
  
  // TextField - Account Name
  /*
  Widget _accountName() {
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
  }*/

  // TESTING...
  Widget _pinCode_TEST(TextEditingController _controller, FocusNode _node, 
        String _strSave, String _iconName, String _hintText, 
        bool _hasFocus, String _helperText, int _textField) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: TextFormField(
        controller: _controller,
        focusNode:  _node,
        decoration: _inputDecoration_TEST(_iconName, _hintText, 
          _hasFocus, _helperText, _controller),

        onSaved: (String val) {
          print('_strSave = $val');
          _strSave = val;
        },
        validator: (val) => _validate(val, _textField),
      ),
    );
  }

  // TextField - PIN code
  /*
  Widget _pinCode() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: TextFormField(
        controller: _pinCodeController,
        focusNode: _nodeText2,
        decoration: _inputDecoration(),

        onSaved: (String val) {
          print('_strPinCode = $val');
          _strPinCode = val;
        },
        validator: (val) => _validatePinCode(val),
      ),
    );
  }*/

  //
  InputDecoration _inputDecoration_TEST(String _iconName, String _hintText, 
          bool _hasFocus, String _helperText, TextEditingController _controller) {

    return InputDecoration(
      icon: Image.asset(Tools.imagePath(_iconName), width: 16, height: 18),
      border: InputBorder.none,
      filled: true, 
      fillColor: AppCustomColor.themeBackgroudColor,
      // hintText: WalletLocalizations.of(context).createAccountPageTooltip_2,
      hintText: _hintText,
      helperText: _hasFocus ? _helperText : null,
      suffixIcon: _hasFocus ? 
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            _controller.clear();
          },
        ) : null,
    );
  }

  /*
  //
  InputDecoration _inputDecoration() {
    return InputDecoration(
      icon: Image.asset(Tools.imagePath('icon_password'), width: 16, height: 18),
      border: InputBorder.none,
      filled: true, 
      fillColor: AppCustomColor.themeBackgroudColor,
      hintText: WalletLocalizations.of(context).createAccountPageTooltip_2,
      helperText: _txtPinCodeHasFocus ? 
        WalletLocalizations.of(context).createAccountPageTooltip_4 : null,
      suffixIcon: _txtPinCodeHasFocus ? 
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            _pinCodeController.clear();
          },
        ) : null,
    );
  }*/

  String _validate(String val, int _textField) {
    switch (_textField) {
      case 1:
        return _validateAccountName(val);
      case 2:
        return _validatePinCode(val);
      case 3:
        return _validateRepeatPinCode(val);
      default:
        return null;
    }
  }

  //
  String _validateAccountName(String val) {
    if (val == null || val.trim().length == 0) {
      return 'AccountName is empty';
    } else if (val.trim().length < 4) {
      return 'length is enough';
    } else {
      return null;
    }
  }
  
  //
  String _validatePinCode(String val) {
    if (val == null || val.trim().length == 0) {
      return '_strPinCode is empty';
    } else if (val.trim().length < 8) {
      return 'length is enough';
    } else {
      return null;
    }
  }

  //
  String _validateRepeatPinCode(String val) {
    if (val == null || val.trim().length == 0) {
      return '_strRepeatPinCode is empty';
    } else if (val.trim().length < 8) {
      return 'length is enough';
    } else {
      return null;
    }
  }

  // TextField - Repeat PIN Code
  /*
  Widget _repeatPinCode() {
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
  }*/

  // Create button
  Widget _btnCreate() {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 50),
      child: CustomRaiseButton(
        context: context,
        hasRow: false,
        title: WalletLocalizations.of(context).createAccountPageButton,
        titleColor: Colors.white,
        color: AppCustomColor.btnConfirm,
        callback: () {
          _onSubmit();
        },
      ),
    );
  }

  // form submit
  void _onSubmit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return BackupWalletIndex(param: 1,);
          }
        ),
          
        (route) => route == null,
      );
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
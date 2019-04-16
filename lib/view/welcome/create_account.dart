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

  /// should save data.
  String _strAccountName, _strPinCode, _strRepeatPinCode;

  TextEditingController _accountNameController   = TextEditingController();
  TextEditingController _pinCodeController       = TextEditingController();
  TextEditingController _repeatPinCodeController = TextEditingController();

  //
  FocusNode _nodeText1 = FocusNode();
  FocusNode _nodeText2 = FocusNode();
  FocusNode _nodeText3 = FocusNode();

  /// textFormField focus 
  bool _accountNameHasFocus   = false;
  bool _pinCodeHasFocus       = false;
  bool _repeatPinCodeHasFocus = false;

  //
  bool _autoValidate = false;

  /// add textfield listener
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
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: Column(
                children: _content(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Keyboard Actions
  List<KeyboardAction> _keyboardActions() {
    List<KeyboardAction> _actions = List();
    List<FocusNode> _nodes = <FocusNode> [
      _nodeText1, _nodeText2, _nodeText3
    ];

    for (int i = 0; i < _nodes.length; i++) {
      _actions.add(_keyAc(_nodes[i]));
    }

    return _actions;
  }
  
  ///
  KeyboardAction _keyAc(FocusNode _node) {
    return KeyboardAction(
      focusNode: _node,
      closeWidget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.close),
      )
    );
  }

  /// build children list 
  List<Widget> _content() {

    List<Widget> _list = List();

    List<TextEditingController> _controllers = <TextEditingController> [
      _accountNameController, _pinCodeController, _repeatPinCodeController
    ];

    List<FocusNode> _nodes = <FocusNode> [
      _nodeText1, _nodeText2, _nodeText3
    ];

    List<String> _saveData = <String> [
      _strAccountName, _strPinCode, _strRepeatPinCode
    ];

    List<String> _icons = <String> [
      'icon_name', 'icon_password', 'icon_confirm'
    ];
    
    List<String> _hintText = <String> [
      WalletLocalizations.of(context).createAccountPageTooltip_1, 
      WalletLocalizations.of(context).createAccountPageTooltip_2, 
      WalletLocalizations.of(context).createAccountPageTooltip_3
    ];
    
    List<bool> _hasFocus = <bool> [
      _accountNameHasFocus, _pinCodeHasFocus, _repeatPinCodeHasFocus
    ];

    List<String> _helperText = <String> [
      null, 
      WalletLocalizations.of(context).createAccountPageTooltip_4, 
      WalletLocalizations.of(context).createAccountPageTooltip_4
    ];

    List<int> _textFields = <int> [
      1, 2, 3
    ];

    _list.add(_titleImage());

    for (int i = 0; i < _nodes.length; i++) {
      _list.add( _textFormField(
        _controllers[i], _nodes[i], _saveData[i], _icons[i], 
        _hintText[i], _hasFocus[i], _helperText[i], _textFields[i]) );

      _list.add(Divider(height: 0, indent: 25));
    }

    _list.add(SizedBox(height: 80));
    _list.add(_btnCreate());

    return _list;
  }

  // 
  Widget _titleImage() {
    return Padding(
      padding: EdgeInsets.only(top: 30, bottom: 50),
      child: Image.asset(Tools.imagePath('image_account'), width: 68, height: 62)
    );
  }

  // 
  Widget _textFormField(TextEditingController _controller, FocusNode _node, 
        String _strSave, String _iconName, String _hintText, 
        bool _hasFocus, String _helperText, int _textField) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: TextFormField(
        controller:  _controller,
        focusNode:   _node,
        decoration: _inputDecoration(_iconName, _hintText, 
          _hasFocus, _helperText, _controller),

        onSaved: (String val) {
          print('_strSave = $val');
          _strSave = val;
        },

        validator: (val) => _validate(val, _textField),
      ),
    );
  }

  //
  InputDecoration _inputDecoration(String _iconName, String _hintText, 
          bool _hasFocus, String _helperText, TextEditingController _controller) {

    return InputDecoration(
      icon: Image.asset(Tools.imagePath(_iconName), width: 16, height: 18),
      border: InputBorder.none,
      filled: true, 
      fillColor: AppCustomColor.themeBackgroudColor,
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

  //
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

  ///
  String _validateAccountName(String val) {
    if (val == null || val.trim().length == 0) {
      return 'AccountName is empty';
    } else if (val.trim().length < 4) {
      return 'length is enough';
    } else {
      return null;
    }
  }
  
  ///
  String _validatePinCode(String val) {
    if (val == null || val.trim().length == 0) {
      return '_strPinCode is empty';
    } else if (val.trim().length < 8) {
      return 'length is enough';
    } else {
      return null;
    }
  }

  ///
  String _validateRepeatPinCode(String val) {
    if (val == null || val.trim().length == 0) {
      return '_strRepeatPinCode is empty';
    } else if (val.trim().length < 8) {
      return 'length is enough';
    } else {
      return null;
    }
  }

  /// Create button
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

  /// form submit
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
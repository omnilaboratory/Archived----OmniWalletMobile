/// Update Nick Name page.
/// [author] Kevin Zhang
/// [time] 2019-5-5

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:wallet_app/view/widgets/custom_raise_button_widget.dart';
import 'package:wallet_app/view_model/state_lib.dart';

class UpdateNickName extends StatefulWidget {
  static String tag = 'UpdateNickName';
  @override
  _UpdateNickNameState createState() => _UpdateNickNameState();
}

class _UpdateNickNameState extends State<UpdateNickName> {

  bool _hasClearIcon = false;
  FocusNode _nodeNickName = FocusNode();
  TextEditingController _nickNameController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nodeNickName.addListener(() {
      if (_nodeNickName.hasFocus) { // get focus
        if (_nickNameController.text.trim().length == 0) {
          _hasClearIcon = false;
        } else {
          _hasClearIcon = true;
        }
      } else {
        _hasClearIcon = false;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppCustomColor.themeBackgroudColor,
      appBar: AppBar(
        title: Text(WalletLocalizations.of(context).updateNickNamePageAppBarTitle),
      ),

      body: FormKeyboardActions(
        actions: _actions(),
        child: SafeArea(
          child: Column(

          ),
        ),
      ),
    );
  }
  
  ///
  Widget _inputNewNickName() {
    return Form(
      key: _formKey,
      autovalidate: true,
      onChanged: () {
        // print('==> VAL --> ${_nameController.text}');
        if (_nickNameController.text.trim().length == 0) {
          _hasClearIcon = false;
        } else {
          _hasClearIcon = true;
        }
        setState(() { });
      },
      
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextFormField(
          controller:  _nickNameController,
          focusNode:   _nodeNickName,
          autofocus: true,
          validator: (val) => _validate(val),
          decoration: InputDecoration(
            hintText: WalletLocalizations.of(context).addressManagePageEditTips,
            hintStyle: TextStyle(fontSize: 14),
            suffixIcon: _hasClearIcon ? 
              IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(Icons.highlight_off, color: Colors.grey),
                onPressed: () { _nickNameController.clear(); },
              ) : null,
          ),
        ),
      ),
    );
  }
  
  /// validate new nick name
  String _validate(String val) {
    if (val == null || val.trim().length == 0) {
      return WalletLocalizations.of(context).createAccountPageErrMsgEmpty;
    } else {
      return null;
    }
  }

  /// update nick name
  void _onSubmit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      // Tools.loadingAnimation(context);
      /// submit new nick name to server
      Future response = NetConfig.post(NetConfig.changeAddressName, {
        'address': widget.data.address,
        'addressName': _nameController.text.trim(),
      });

      response.then((val) {
        if (val != null) {
          setState(() {
            // widget.data.name = _nickNameController.text.trim(); // change locally data.
            Navigator.of(context).pop();
          });
        }
      });
    } 
  }
}

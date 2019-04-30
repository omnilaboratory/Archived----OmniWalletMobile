import 'dart:async';

/// Addresses Management page.
/// [author] Kevin Zhang
/// [time] 2019-4-25

import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';
import 'package:wallet_app/tools/app_data_setting.dart';
import 'package:wallet_app/view/main_view/displayed_assets.dart';
import 'package:wallet_app/view_model/state_lib.dart';

class AddressManage extends StatefulWidget {
  static String tag = "AddressManage";

  /// Holds data of an address
  final WalletInfo data;

  // In the constructor, require a WalletInfo
  AddressManage({Key key, @required this.data}) : super(key: key);

  @override
  _AddressManageState createState() => _AddressManageState();
}

class _AddressManageState extends State<AddressManage> {

  bool _isEditing = false;
  bool _isAddressDisplay;

  FocusNode _nodeText = FocusNode();
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(WalletLocalizations.of(context).addressManagePageAppBarTitle),
      ),

      body: FormKeyboardActions(
        actions: _actions(),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 10),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: _content(),
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
        focusNode: _nodeText,
        closeWidget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.close),
        )
      )
    ];

    return _actions;
  }

  /// body content
  List<Widget> _content() {

    // list tile
    List<Widget> _list = List();

    _list.add(_bodyTitle());
    _list.add(_btnEditAddressName());
    _list.add(SizedBox(height: 10));
    _list.add(_switchAddressDisplay());

    // if (_isAddressDisplay) {
      _list.add(_assetListTitle());
      _list.add(
        Column(
          children: _assetList(),
        )
      );
    // }

    return _list;
  }

  ///
  Widget _bodyTitle() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        widget.data.address
      ),
    );
  }

  ///
  Widget _btnEditAddressName() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      color: AppCustomColor.themeBackgroudColor,
      child: Row(
        children: <Widget>[
          _isEditing ? _inputNewName() : _newNameText(),
          SizedBox(width: 20),
          RaisedButton(
            // padding: EdgeInsets.symmetric(vertical: 12),
            elevation: 0,
            color: AppCustomColor.btnConfirm,
            child: _isEditing ? Text(
                WalletLocalizations.of(context).addressManagePageDoneButton,
                style: TextStyle(color: Colors.white),
              ) : 
              Text(
                WalletLocalizations.of(context).addressManagePageEditButton,
                style: TextStyle(color: Colors.white),
              ),

            onPressed: () {
              if (_isEditing) {
                _isEditing = false;
                _onSubmit();
              } else {
                _isEditing = true;
              }
              setState(() { });
            },
          ),
        ],
      ),
    );
  }

  /// update address name
  void _onSubmit() {
    // return Expanded(
    //   child: Text(widget.data.name)
    // );
  }

  ///
  Widget _newNameText() {
    return Expanded(
      child: Text(widget.data.name)
    );
  }

  ///
  Widget _inputNewName() {
    return Expanded(
      child: TextFormField(
        controller:  _nameController,
        focusNode:   _nodeText,
        // keyboardType: TextInputType.emailAddress,

        // onSaved: (String val) {
        //   print('_strSave = $val');
        //   _strSave = val;
        // },

        validator: (val) => _validate(val),

        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          labelText: WalletLocalizations.of(context).addressManagePageEditTips,
          labelStyle: TextStyle(fontSize: 13),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5)
          ),
          // fillColor: Colors.grey[100],
          // filled: true,
        ),
      ),
    );
  }

  /// validate new name
  String _validate(String val) {
    if (val == null || val.trim().length == 0) {
      return WalletLocalizations.of(context).createAccountPageErrMsgEmpty;
    }

    return null;
  }

  ///
  Widget _switchAddressDisplay() {
    
    _isAddressDisplay = widget.data.visible;

    return Container(
      color: AppCustomColor.themeBackgroudColor,
      child: ListTile(
        title: Text(WalletLocalizations.of(context).addressManagePageAddressDisplay),
        trailing: Switch(
          value: _isAddressDisplay, 
          onChanged: (bool value) {
            _isAddressDisplay = !_isAddressDisplay;
            print('==> _isAddressDisplay = $_isAddressDisplay');

            Future response = NetConfig.post(NetConfig.setAddressVisible, {
              'address': widget.data.address, 
              'visible': _isAddressDisplay.toString(),
            });

            response.then((val) {
              if (val != null) {
                widget.data.visible = _isAddressDisplay;
                setState(() { });
              }
            });
          }
        ),
      ),
    );
  }

  ///
  Widget _assetListTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              WalletLocalizations.of(context).addressManagePageAssetsDisplay,
              style: TextStyle(color: Colors.grey),
            ),
          ),

          Padding( // manage displayed assets.
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: Icon(Icons.add_circle),
              color: Colors.blue,
              disabledColor: Colors.grey[300],
              onPressed: !_isAddressDisplay ? null : 
                () { Navigator.of(context).pushNamed(DisplayedAssets.tag); },
            ),
          )
        ],
      ),
    );
  }

  /// asset list
  List<Widget> _assetList() {
    int assetAmount = widget.data.accountInfoes.length;
    print('==> asset amount = $assetAmount');

    // list tile
    List<Widget> _list = List();

    for (int i = 0; i < assetAmount; i++) {
      _list.add(_assetItem(widget.data.accountInfoes[i], i));
      _list.add(Divider(height: 0, indent: 15));
    }

    return _list;
  }

  /// every asset
  Widget _assetItem(AccountInfo assetData, int index) {

    print('==> asset visible = ${assetData.visible}');

    return Container(
      color: AppCustomColor.themeBackgroudColor,
      child: ListTile(
        enabled: _isAddressDisplay ? true : false,
        // leading: Image.asset(assetData.iconUrl),
        title: Text(assetData.name),
        trailing: Switch(
          value: assetData.visible,
          onChanged: !_isAddressDisplay ? null : (bool value) {
            bool flag  = !assetData.visible;

            print('==> address = ${widget.data.address}');
            print('==> assetId = ${assetData.propertyId}');

            Future response = NetConfig.post(NetConfig.setAssetVisible, {
              'address': widget.data.address,
              'assetId': assetData.propertyId.toString(),
              'visible': flag.toString(),
            });

            response.then((val) {
              if (val != null) {
                assetData.visible = !assetData.visible;
                setState(() { });
              }
            });
          },
        ),
      ),
    );
  }
}
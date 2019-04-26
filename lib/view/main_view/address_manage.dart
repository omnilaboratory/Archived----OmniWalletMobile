/// Addresses Management page.
/// [author] Kevin Zhang
/// [time] 2019-4-25

import 'package:flutter/material.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';
import 'package:wallet_app/tools/app_data_setting.dart';
import 'package:wallet_app/view/welcome/select_language.dart';
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

  bool isEditing = false;
  bool isAddressDisplay = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(WalletLocalizations.of(context).addressManagePageAppBarTitle),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 10),
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: _content(),
          ),
        ),
      ),
    );
  }

  /// asset list
  List<Widget> _content() {

    // list tile
    List<Widget> _list = List();

    _list.add(_bodyTitle());
    _list.add(_editAddressName());
    _list.add(SizedBox(height: 10));
    _list.add(_switchAddressDisplay());

    _list.add(_assetListTitle());
    _list.add(
      Column(
        children: _assetList(),
      )
    );

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
  // Widget _editAddressNameTitle() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 15, top: 30, bottom: 10),
  //     child: Text(
  //       WalletLocalizations.of(context).addressManagePageAssetsDisplay,
  //       style: TextStyle(color: Colors.grey),
  //     ),
  //   );
  // }

  ///
  Widget _editAddressName() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      color: AppCustomColor.themeBackgroudColor,
      child: Row(
        children: <Widget>[
          isEditing ? _newName() : _newNameText(),
          SizedBox(width: 20),
          RaisedButton(
            // padding: EdgeInsets.symmetric(vertical: 12),
            elevation: 0,
            color: AppCustomColor.btnConfirm,
            child: isEditing ? Text(
                WalletLocalizations.of(context).addressManagePageDoneButton,
                style: TextStyle(color: Colors.white),
              ) : 
              Text(
                WalletLocalizations.of(context).addressManagePageEditButton,
                style: TextStyle(color: Colors.white),
              ),

            onPressed: () {
              if (isEditing) {
                isEditing = false;
              } else {
                isEditing = true;
              }

              setState(() {
                
              });
            },
          ),
        ],
      ),
    );
  }

  ///
  Widget _newNameText() {
    return Expanded(
      child: Text(widget.data.name)
    );
  }

  ///
  Widget _newName() {
    return Expanded(
      child: TextField(
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

        // enabled: isEditing ? true : false,

        // focusNode: _nodeText3,
        // keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  ///
  Widget _switchAddressDisplay() {
    return Container(
      color: AppCustomColor.themeBackgroudColor,
      child: ListTile(
        title: Text(WalletLocalizations.of(context).addressManagePageAddressDisplay),
        trailing: Switch(
          value: isAddressDisplay, 
          onChanged: (bool value) {
            setState(() {
              isAddressDisplay = !isAddressDisplay;
            });
          },
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

          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: Icon(Icons.add_circle),
              color: Colors.grey,
              onPressed: () {},
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
      _list.add(_assetItem(widget.data.accountInfoes[i]));
      _list.add(Divider(height: 0, indent: 15));
    }

    return _list;
  }

  ///
  Widget _assetItem(AccountInfo assetData) {
    return Container(
      color: AppCustomColor.themeBackgroudColor,
      child: ListTile(
        // leading: Image.asset(assetData.iconUrl),
        title: Text(assetData.name),
        trailing: Switch(
          value: isAddressDisplay, 
          onChanged: (bool value) {
            setState(() {
              isAddressDisplay = !isAddressDisplay;
            });
          },
        ),
      ),
    );
  }
}